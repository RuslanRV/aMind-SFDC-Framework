@isTest
private class APTS_CategoriesSelectorTest{

	@testSetup static void setup(){
		APTS_ConfigService.resetTestSettings();
	}

	@IsTest
	private static void shouldReturnCategoriesMatchesCategoriesSize(){
		
		//Given
		final Integer numberOfCategories = 4;
		final List<Apttus_Config2__ClassificationName__c> categoriesTmp = APTS_ConfigurationServiceTestUtil.createCategories(numberOfCategories);

		//When
		final Set<ID> catIds = new Set<ID>();
		for(Apttus_Config2__ClassificationName__c cat : categoriesTmp){
			catIds.add(cat.Id);
		}
		final APTS_ICategoriesSelector ics = new APTS_CategoriesSelector();
		final List<Apttus_Config2__ClassificationName__c> categories = ics.selectById(catIds);
			
		//Then
		System.assertEquals(Apttus_Config2__ClassificationName__c.getSObjectType(), ics.sObjectType(), 'Expected Apttus_Config2__ClassificationName__c sObjectType');
		System.assertEquals(categoriesTmp.size(), categories.size(), 'Categories mismatches');
		System.assertEquals(categories.size(), numberOfCategories, 'Expected ' + numberOfCategories + ' categories, but received ' + categories.size());
	}

}
