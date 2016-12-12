@isTest
private class APTS_CategoriesSelectorTest{

	@IsTest
	private static void testSelectById(){
		
		//Given
		final Integer numberOfCategories = 4;
		final List<Apttus_Config2__ClassificationName__c> categoriesTmp = APTS_ConfigurationServiceTestUtil.createCategories(numberOfCategories);

		//When
		final Set<ID> catIds = new Set<ID>();
		for(Apttus_Config2__ClassificationName__c cat : categoriesTmp){
			catIds.add(cat.Id);
		}

		final List<Apttus_Config2__ClassificationName__c> categories = new APTS_CategoriesSelector().selectById(catIds);
			
		//Then
		System.assertEquals(categoriesTmp.size(), categories.size(), 'Categories mismatches');
		System.assertEquals(categories.size(), numberOfCategories, 'Expected ' + numberOfCategories + ' categories, but received ' + categories.size());		
	}

}