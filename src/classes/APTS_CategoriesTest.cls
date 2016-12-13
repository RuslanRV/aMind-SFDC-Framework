@isTest
private class APTS_CategoriesTest{

	@testSetup static void setup(){
		APTS_ConfigService.resetTestSettings();
	}

	@IsTest
	private static void shouldUpdateCategoriesType(){
		
		//Given
		final String categoryName = 'Test Category G';

		//When
		final Apttus_Config2__ClassificationName__c category = APTS_ConfigurationServiceTestUtil.createCategoryOfName(categoryName);
		//Then
		System.assertEquals('Offering', category.Apttus_Config2__Type__c, 'Expected \'Offering\' category type');

		//When
		final List<Apttus_Config2__ClassificationName__c> categories = new List<Apttus_Config2__ClassificationName__c>{category};
		final APTS_ICategories icategories = new APTS_Categories(categories);
		final List<Schema.sObjectType> types = new List<Schema.sObjectType>{Apttus_Config2__ClassificationName__c.getSObjectType()};
		final APTS_IServiceUnitOfWork uow = APTS_Application.UnitOfWork.newInstance(types);
		icategories.updateCategoriesType(uow);		
		//Then
		final Apttus_Config2__ClassificationName__c cn = [Select Name, Apttus_Config2__Type__c From Apttus_Config2__ClassificationName__c Where Name = :categoryName Limit 1];
		System.assertEquals('Both', cn.Apttus_Config2__Type__c, 'Expected \'Both\' category type');	
	}
}
