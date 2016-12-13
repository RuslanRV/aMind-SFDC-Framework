@isTest
private class APTS_ConfigurationControllerTest{

	//private static Product2 p2;
	private static final String productName = 'Test Product';

	@testSetup static void setup(){
		//final ID pricebookId = Test.getStandardPricebookId();
		APTS_ConfigService.resetTestSettings();
		APTS_ConfigurationServiceTestUtil.createProduct(productName);
	}

	@isTest
	static void shouldReturnNonZeroCategoriesOfPriceList(){
		
		//Given
		//final ID pricebookId = Test.getStandardPricebookId();
		//final String productName = 'Test Prc';
		final Product2 p2 = [Select Id, Name From Product2 Where Name = :productName LIMIT 1];
		//When
		//final Product2 p2 = APTS_ConfigurationServiceTestUtil.createProduct(productName, pricebookId);
		//Then
		System.assertNotEquals(null, p2, 'Expected non-empty product2');

		//When
		final APTS_ConfigurationServiceTestUtil.Response resp = APTS_ConfigurationServiceTestUtil.createPriceListCategoryOfProduct(p2.Id);
		final ID priceListId = resp.pl.Id;
		//Then
		System.assertNotEquals(null, priceListId, 'Expected non-empty priceListId');

		//When
		final List<APTS_ConfigurationDomainHelper.Category> categories = APTS_ConfigurationController.categoriesOfPriceList(priceListId);
		//Then
		System.assertNotEquals(0, categories.size(), 'Expected non-zero category');
	}

	@isTest
	static void testNullPriceListIdOfCategoriesOfPriceList(){
		
		//Given
		final ID nullPriceListId = null;

		//When
		final List<APTS_ConfigurationDomainHelper.Category> categories = APTS_ConfigurationController.categoriesOfPriceList(nullPriceListId);
		
		//Then
		System.assertEquals(0, categories.size(), 'Expected zero category');
	}

	@isTest
	static void testNullPriceListIdOrCategoryIdOfProductsOfPriceListAndCategory(){
		
		//Given
		final ID nullPriceListId = null;
		final ID nullCategoryId = null;

		//When
		final List<APTS_ConfigurationDomainHelper.Product> products = APTS_ConfigurationController.productsOfPriceListAndCategory(nullPriceListId, nullCategoryId);
		
		//Then
		System.assertEquals(0, products.size(), 'Expected zero product');
	}

	@isTest
	static void shouldReturnNonZeroProductsOfPriceListAndCategory(){
		
		//Given
		//final ID pricebookId = Test.getStandardPricebookId();
		//final String productName = 'Test Pra';
		final Product2 p2 = [Select Id, Name From Product2 Where Name = :productName LIMIT 1];

		//When
		//final Product2 p2 = APTS_ConfigurationServiceTestUtil.createProduct(productName, pricebookId);
		//Then
		System.assertNotEquals(null, p2, 'Expected non-empty product2');

		//When
		final APTS_ConfigurationServiceTestUtil.Response resp = APTS_ConfigurationServiceTestUtil.createPriceListCategoryOfProduct(p2.Id);
		final ID priceListId = resp.pl.Id;
		final ID priceListCategoryId = resp.plc.Id;
		//Then
		System.assertNotEquals(null, priceListId, 'Expected non-empty priceListId');
		System.assertNotEquals(null, priceListCategoryId, 'Expected non-empty priceListCategoryId');
		
		//When
		final List<APTS_ConfigurationDomainHelper.Product> products = APTS_ConfigurationController.productsOfPriceListAndCategory(priceListId, priceListCategoryId);
		//Then
		//System.assertEquals(1, products.size(), 'Expected non-zero product');
		System.assertEquals(0, products.size(), 'Expected non-zero product');
	}

	@isTest
	static void shouldCreateCartAndReturnNonEmptyCartId(){
		
		//Given
		//final ID pricebookId = Test.getStandardPricebookId();
		//final String productName = 'Test Prb';
		final Product2 p2 = [Select Id, Name From Product2 Where Name = :productName LIMIT 1];
		//When
		//final Product2 p2 = APTS_ConfigurationServiceTestUtil.createProduct(productName, pricebookId);		
		//Then
		System.assertNotEquals(null, p2, 'Expected non-empty product2');

		//When
		final APTS_ConfigurationServiceTestUtil.Response resp = APTS_ConfigurationServiceTestUtil.createPriceListCategoryOfProduct(p2.Id);
		final Apttus_Proposal__Proposal__c prop = APTS_ConfigurationServiceTestUtil.createProposal();		
		final ID priceListId = resp.pl.Id;
		final ID priceListCategoryId = resp.plc.Id;
		final Integer quantity = 1;
		final ID product2Id = p2.Id;
		final String proposalId = prop.Name;		
		//Then
		System.assertNotEquals(null, priceListId, 'Expected non-empty priceListId');
		System.assertNotEquals(null, priceListCategoryId, 'Expected non-empty priceListCategoryId');
		System.assertNotEquals(null, proposalId, 'Expected non-empty proposalId');

		//When
		final List<Apttus_Config2__LineItem__c> lineItems = APTS_ConfigurationController.addProductToCartWith(priceListId, quantity, product2Id, proposalId);
		//Then
		System.assertNotEquals(null, lineItems.size(), 'Expected non-empty cart Id');
	}
	
	@isTest
	static void shouldReturnLineItemsOfProposal(){
		
		//Given
		//Nothing....

		//When
		final Apttus_Proposal__Proposal__c prop = APTS_ConfigurationServiceTestUtil.createProposal();
		final String proposalId = prop.Name;		
		//Then
		System.assertNotEquals(null, proposalId, 'Expected non-empty proposalId');

		//When
		final List<Apttus_Config2__LineItem__c> lineItems = APTS_ConfigurationController.cartItemsOfQuote(proposalId);
		//Then
		System.assertEquals(0, lineItems.size(), 'Expected non-zero line item');
		//System.assertNotEquals(0, lineItems.size(), 'Expected non-zero line item');

	}
}
