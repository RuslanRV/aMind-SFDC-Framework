public interface APTS_ICategoriesSelector extends APTS_ISObjectSelector{
	List<Apttus_Config2__ClassificationName__c> selectById(Set<ID> idSet);
}