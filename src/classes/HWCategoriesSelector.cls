/**
 * This is a basic selector for price list categories
 **/
public class HWCategoriesSelector extends HWSObjectSelector implements HWICategoriesSelector{
	
	public static HWICategoriesSelector newInstance(){
		return (HWICategoriesSelector)HWApplication.Selector.newInstance(Apttus_Config2__ClassificationName__c.SObjectType);
	}
	
	public Set<String> getSObjectFieldList(){
		return new Set<String> {
			'Name',
			'(SELECT Name FROM Apttus_Config2__PriceLists__r)'
		};
	}

	public Schema.SObjectType getSObjectType(){
		return Apttus_Config2__ClassificationName__c.sObjectType;
	}

	public List<Apttus_Config2__ClassificationName__c> selectById(Set<ID> idSet){
		return (List<Apttus_Config2__ClassificationName__c>) selectSObjectsById(idSet);
	}
}
