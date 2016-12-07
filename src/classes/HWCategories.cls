public with sharing class HWCategories extends HWSObjectDomain	implements HWICategories{
	
	public static HWICategories newInstance(List<Apttus_Config2__ClassificationName__c> sObjectList){
		return (HWICategories) HWApplication.Domain.newInstance(sObjectList);
	}
	
	public HWCategories(List<Apttus_Config2__ClassificationName__c> sObjectList){
		super(sObjectList);
	}
	
	public void updateCategoriesType(HWServiceUnitOfWork uow){		
		for(Apttus_Config2__ClassificationName__c pcat : (List<Apttus_Config2__ClassificationName__c>) Records){
			//do some change here...
			uow.registerDirty(pcat);
		}
	}

	public class Constructor implements HWSObjectDomain.IConstructable{
		public HWSObjectDomain construct(List<SObject> sObjectList){
			return new HWCategories(sObjectList);
		}
	}
}