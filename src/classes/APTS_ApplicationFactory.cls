public class APTS_ApplicationFactory{
	
	/**
	 * Simple Service Factory implementaiton
	 **/
	public class ServiceFactory{

		private Map<Type, Type> sitbsit;

		public ServiceFactory(Map<Type, Type> a_sitbsit){
			sitbsit = a_sitbsit;
		}

		public Object newInstance(Type a_sit){
			Type serviceImpl = sitbsit.get(a_sit);			
			if(serviceImpl == null){
				throw new DeveloperException('No implementation registered for service interface ' + a_sit.getName());	
			}
			return serviceImpl.newInstance();
		}
	}

	/**
	 * Class implements a Unit of Work factory
	 **/
	public class UnitOfWorkFactory{

		private List<SObjectType> m_objectTypes;

		public UnitOfWorkFactory(){
			m_objectTypes = new List<SObjectType>();
		}

		public UnitOfWorkFactory(List<SObjectType> objectTypes){
			m_objectTypes = objectTypes.clone();
		}

		public APTS_IServiceUnitOfWork newInstance(){
			return new APTS_ServiceUnitOfWork(m_objectTypes);
		}

		public APTS_IServiceUnitOfWork newInstance(List<SObjectType> objectTypes){
			return new APTS_ServiceUnitOfWork(objectTypes);
		}
	}

	/**
	 * Class implements a Domain class factory
	 **/
	public class DomainFactory{
		private APTS_ApplicationFactory.SelectorFactory m_selectorFactory;
		private Map<SObjectType, Type> m_sObjectByDomainConstructorType;

		public DomainFactory(APTS_ApplicationFactory.SelectorFactory selectorFactory,	Map<SObjectType, Type> sObjectByDomainConstructorType){
			m_selectorFactory = selectorFactory;
			m_sObjectByDomainConstructorType = sObjectByDomainConstructorType;
		}			

		public APTS_ISObjectDomain newInstance(Set<Id> recordIds){
			return newInstance(m_selectorFactory.selectById(recordIds));

		}	

		public APTS_ISObjectDomain newInstance(List<SObject> records){
			SObjectType domainSObjectType = records.getSObjectType();
			if(domainSObjectType == null){
				throw new DeveloperException('Unable to determine SObjectType');
			}

			// Determine SObjectType and Apex classes for Domain class
			Type domainConstructorClass = m_sObjectByDomainConstructorType.get(domainSObjectType);
			if(domainConstructorClass == null){
				throw new DeveloperException('Domain constructor class not found for SObjectType ' + domainSObjectType);
			}

			// Construct Domain class passing in the queried records
			HWSObjectDomain.IConstructable domainConstructor = (HWSObjectDomain.IConstructable) domainConstructorClass.newInstance();		
			return (HWISObjectDomain) domainConstructor.construct(records);
		}	

		public HWISObjectDomain newInstance(List<SObject> records, SObjectType domainSObjectType){
			if(domainSObjectType == null){
				throw new DeveloperException('Must specify sObjectType');
			}

			// Determine SObjectType and Apex classes for Domain class
			Type domainConstructorClass = m_sObjectByDomainConstructorType.get(domainSObjectType);
			if(domainConstructorClass == null){
				throw new DeveloperException('Domain constructor class not found for SObjectType ' + domainSObjectType);
			}

			// Construct Domain class passing in the queried records
			HWSObjectDomain.IConstructable2 domainConstructor = (HWSObjectDomain.IConstructable2) domainConstructorClass.newInstance();
			return (HWISObjectDomain) domainConstructor.construct(records, domainSObjectType);
		}
	}


	/**
	 * Class implements a Selector class factory
	 **/
	public class SelectorFactory{
		private Map<SObjectType, Type> m_sObjectBySelectorType;

		public SelectorFactory(Map<SObjectType, Type> sObjectBySelectorType){
			m_sObjectBySelectorType = sObjectBySelectorType;	
		}

		public HWISObjectSelector newInstance(SObjectType sObjectType){			
			// Determine Apex class for Selector class			
			Type selectorClass = m_sObjectBySelectorType.get(sObjectType);
			if(selectorClass == null){
				throw new DeveloperException('Selector class not found for SObjectType ' + sObjectType);
			}

			// Construct Selector class and query by Id for the records
			return (HWISObjectSelector) selectorClass.newInstance();			
		}
	
		public List<SObject> selectById(Set<Id> recordIds){
			// No point creating an empty Domain class, nor can we determine the SObjectType anyway
			if(recordIds == null || recordIds.size() == 0){
				throw new DeveloperException('Invalid record Id\'s set');	
			}

			// Determine SObjectType
			SObjectType domainSObjectType = new List<Id>(recordIds)[0].getSObjectType();
			for(Id recordId : recordIds){
				if(recordId.getSobjectType() != domainSObjectType){
					throw new DeveloperException('Unable to determine SObjectType, Set contains Id\'s from different SObject types');	
				}
			}

			// Construct Selector class and query by Id for the records
			return newInstance(domainSObjectType).selectSObjectsById(recordIds);
		}

		public List<SObject> selectByRelationship(List<SObject> relatedRecords, SObjectField relationshipField){
			Set<Id> relatedIds = new Set<Id>();
			for(SObject relatedRecord : relatedRecords){
				Id relatedId = (Id) relatedRecord.get(relationshipField);
				if(relatedId!=null){
					relatedIds.add(relatedId);
				}
			}
			return selectById(relatedIds);
		}
	}
	
	public class ApplicationException extends Exception { }			

	/**
	 * Exception representing a developer coding error, not intended for end user eyes
	 **/
	public class DeveloperException extends Exception { } 
}
