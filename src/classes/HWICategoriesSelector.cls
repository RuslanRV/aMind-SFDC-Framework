public interface HWICategoriesSelector extends HWISObjectSelector{
	List<Apttus_Config2__ClassificationName__c> selectById(Set<ID> idSet);
}