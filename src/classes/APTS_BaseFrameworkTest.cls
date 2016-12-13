@isTest
private class APTS_BaseFrameworkTest{

	@testSetup static void setup(){
		APTS_ConfigService.resetTestSettings();
	}

	@IsTest
	private static void testAPTS_ConfigService(){
		System.assertNotEquals(null, APTS_ConfigService.namespacePrefix);
		System.assertNotEquals(null, APTS_ConfigService.namespace);
		System.assertEquals(true, APTS_ConfigService.licensedUser);
		System.assertNotEquals(null, APTS_ConfigService.keyPrefixByObject);
		System.assertNotEquals(null, APTS_ConfigService.objectByKeyPrefix);
		System.assertEquals(null, APTS_ConfigService.debugInfoEmails);
		System.assertEquals(false, APTS_ConfigService.emailDebugInfoEnabled);
		System.assertEquals(null, APTS_ConfigService.debugInfoMaxAge);
		System.assertEquals(null, APTS_ConfigService.debugInfoMaxNum);
		System.assertNotEquals(null, APTS_ConfigService.packageVersion);
		System.assertEquals(null, APTS_ConfigService.orgId);
		System.assertEquals(null, APTS_ConfigService.orgName);
	}

	@IsTest
	private static void testAPTS_SObjectDescribe(){

		//Given
		Account acc = new Account(Name = 'Test Account SOD');

		//When
		final APTS_SObjectDescribe sod1 = APTS_SObjectDescribe.getDescribe(acc);
		final Schema.SObjectField sod3 = sod1.getField('Name');
		final Schema.SObjectField sod4 = sod1.getNameField();
		final Schema.DescribeSObjectResult sod5 = sod1.getDescribe();
		final Schema.SObjectType sod6 = sod1.getSObjectType();
		final APTS_SObjectDescribe sod8 = APTS_SObjectDescribe.getDescribe('Account');
		final Map<String,Schema.SObjectField> sod9 = sod8.getFieldsMap();
		final APTS_SObjectDescribe.FieldsMap sod10 = sod8.getFields();
		final Map<String,Schema.FieldSet> sod11 = sod8.getFieldSetsMap();
		APTS_SObjectDescribe.flushCache();
		final Map<String,SObjectType> sod12 = APTS_SObjectDescribe.getRawGlobalDescribe();
		final APTS_SObjectDescribe.GlobalDescribeMap sod13 = APTS_SObjectDescribe.getGlobalDescribe();
		//Then
		System.assertNotEquals(null, sod1);		
		System.assertNotEquals(null, sod3);
		System.assertNotEquals(null, sod4);
		System.assertNotEquals(null, sod5);
		System.assertNotEquals(null, sod6);
		System.assertNotEquals(null, sod8);
		System.assertNotEquals(null, sod9);
		System.assertNotEquals(null, sod10);
		System.assertNotEquals(null, sod11);
		System.assertNotEquals(null, sod12);
		System.assertNotEquals(null, sod13);

		//When
		acc = null;
		final APTS_SObjectDescribe sodn1 = APTS_SObjectDescribe.getDescribe(acc);
		//Then
		System.assertEquals(null, sodn1);

		//When
		final APTS_SObjectDescribe sod77 = APTS_SObjectDescribe.getDescribe(Account.sObjectType.getDescribe());
		//Then
		System.assertNotEquals(null, sod77);

		//When//XXX
		final APTS_SObjectDescribe.FieldsMap fm = new APTS_SObjectDescribe.FieldsMap(sod9);
		final Schema.SObjectField sof = fm.get('Name');
		final Schema.SObjectField sof2 = fm.get('Name', false);
		final List<Schema.SObjectField> values = fm.values();

		final Map<String, Schema.SObjectType> sssot = new Map<String, Schema.SObjectType>();
		sssot.put('Account', sod6);
		final APTS_SObjectDescribe.GlobalDescribeMap gdm = new APTS_SObjectDescribe.GlobalDescribeMap(sssot);
		final Schema.SObjectType stype = gdm.get('Account');
		final Schema.SObjectType stype2 = gdm.get('Account', false);
		final List<Schema.SObjectType> values2 = gdm.values();
		//Then
		System.assertNotEquals(null, fm);
		System.assertNotEquals(null, sof);
		System.assertNotEquals(null, sof2);
		System.assertNotEquals(null, values);

		System.assertNotEquals(null, gdm);
		System.assertEquals(null, stype);
		System.assertEquals(null, stype2);
		System.assertNotEquals(null, values2);
	}

	@IsTest
	private static void testAPTS_ServiceUnitOfWork(){

		//Given
		final Integer numberOfCategories = 10;
		final String name = 'Test Cat SUOW';

		//When
		final List<Apttus_Config2__ClassificationName__c> cns = APTS_ConfigurationServiceTestUtil.createCategoriesWithoutCommit(name, numberOfCategories);
		final APTS_IServiceUnitOfWork uow = APTS_Application.UnitOfWork.newInstance(new List<Schema.sObjectType>{Apttus_Config2__ClassificationName__c.getSObjectType()});
		for(Apttus_Config2__ClassificationName__c cn : cns){
			uow.registerNew(cn);
		}
		uow.commitWork();

		//Then		
		final Integer cnCount = [Select count() From Apttus_Config2__ClassificationName__c Where Name Like 'Test Cat SUOW%'];
		System.assertEquals(numberOfCategories, cnCount);
	}

	@IsTest
	private static void testAPTS_SObjectDomain(){

		//Given
		final Integer numberOfOppties = 4;
		final String opptyName = 'Test Oppty';
		final List<Opportunity> oppties = APTS_ConfigurationServiceTestUtil.createOpportunitiesWithoutCommit(opptyName, numberOfOppties);


		//When
		Insert oppties;

		final APTS_SObjectDomain sod = new APTS_SObjectDomain(oppties);
		final SObjectType sodType = sod.getSObjectType();
		final SObjectType sodType2 = sod.sObjectType();
		final List<SObject> oppties2 = sod.getRecords();

		//Then		
		System.assertNotEquals(null, sod);
		System.assertEquals(Opportunity.getSObjectType(), sodType);
		System.assertEquals(Opportunity.getSObjectType(), sodType2);
		System.assertEquals(oppties.size(), oppties2.size());
	}
}
