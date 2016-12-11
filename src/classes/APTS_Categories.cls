public with sharing class APTS_Categories extends APTS_SObjectDomain	implements APTS_ICategories{
	
	public static APTS_ICategories newInstance(List<Apttus_Config2__ClassificationName__c> sObjectList){
		return (APTS_ICategories) APTS_Application.Domain.newInstance(sObjectList);
	}
	
	public APTS_Categories(List<Apttus_Config2__ClassificationName__c> sObjectList){
		super(sObjectList);
	}
	
	public void updateCategoriesType(APTS_ServiceUnitOfWork uow){		
		for(Apttus_Config2__ClassificationName__c pcat : (List<Apttus_Config2__ClassificationName__c>) Records){
			//do some change here...
			uow.registerDirty(pcat);
		}
	}

	public class Constructor implements APTS_SObjectDomain.IConstructable{
		public APTS_SObjectDomain construct(List<SObject> sObjectList){
			return new APTS_Categories(sObjectList);
		}
	}
}