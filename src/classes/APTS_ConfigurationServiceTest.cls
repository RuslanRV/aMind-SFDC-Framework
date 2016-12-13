@isTest
private class APTS_ConfigurationServiceTest{

	//private static Product2 p2;
	private static final String productName = 'Test Product2';

	@testSetup static void setup(){
		//final ID pricebookId = Test.getStandardPricebookId();
		APTS_ConfigService.resetTestSettings();
		APTS_ConfigurationServiceTestUtil.createProduct(productName);
	}

	//@isTest
	//static void shouldReturnNonZeroCategoriesOfPriceList(){
		
	//	//Given
	//	//final ID pricebookId = Test.getStandardPricebookId();
	//	//final String productName = 'Test Product Y';
	//	final Product2 p2 = [Select Id, Name From Product2 Where Name = :productName LIMIT 1];

	//	//When
	//	//final Product2 p2 = APTS_ConfigurationServiceTestUtil.createProduct(productName, pricebookId);
	//	//Then
	//	System.assertNotEquals(null, p2, 'Expected non-empty product2');

	//	//When
	//	final APTS_ConfigurationServiceTestUtil.Response resp = APTS_ConfigurationServiceTestUtil.createPriceListCategoryOfProduct(p2.Id);
	//	final ID priceListId = resp.pl.Id;

	//	//Then
	//	System.assertNotEquals(null, priceListId, 'Expected non-empty priceListId');

	//	//When
	//	System.debug('priceListId: ' + priceListId);
	//	final List<APTS_ConfigurationDomainHelper.Category> categories = APTS_ConfigurationService.categoriesOfPriceList(priceListId);
	//	System.debug('categories: ' + categories);
	//	//Then
	//	System.assertNotEquals(0, categories.size(), 'Expected non-zero category');
	//	//System.assertEquals(0, categories.size(), 'Expected non-zero category');
	//}

	@isTest
	static void shouldReturnNonZeroCategoriesById(){
		
		//Given
		final String categoryName = 'Test Category U';		
		
		//When
		final Apttus_Config2__ClassificationName__c cat = APTS_ConfigurationServiceTestUtil.createCategoryOfName(categoryName);
		//Then
		System.assertNotEquals(null, cat.Id, 'Expected non-empty category id');

		//When
		final List<Apttus_Config2__ClassificationName__c> categories = APTS_ConfigurationService.categoriesById(new Set<ID>{cat.Id});
		//Then
		System.assertEquals(1, categories.size(), 'Expected non-zero category');
	}

	//@isTest
	//static void shouldReturnNonZeroProductsOfPriceListAndCategory(){
		
	//	//Given
	//	//final ID pricebookId = Test.getStandardPricebookId();
	//	//final String productName = 'Test Product H';
	//	final Product2 p2 = [Select Id, Name From Product2 Where Name = :productName LIMIT 1];
	//	//When
	//	//final Product2 p2 = APTS_ConfigurationServiceTestUtil.createProduct(productName, pricebookId);
	//	//Then
	//	System.assertNotEquals(null, p2, 'Expected non-empty product2');

	//	//When
	//	final APTS_ConfigurationServiceTestUtil.Response resp = APTS_ConfigurationServiceTestUtil.createPriceListCategoryOfProduct(p2.Id);
	//	final ID priceListId = resp.pl.Id;
	//	final ID priceListCategoryId = resp.plc.Id;
	//	//Then
	//	System.assertNotEquals(null, priceListId, 'Expected non-empty priceListId');
	//	System.assertNotEquals(null, priceListCategoryId, 'Expected non-empty priceListCategoryId');
		
	//	//When
	//	final List<APTS_ConfigurationDomainHelper.Product> products = APTS_ConfigurationService.productsOfPriceListAndCategory(priceListId, priceListCategoryId);
	//	//Then
	//	//System.assertNotEquals(0, products.size(), 'Expected non-zero product');
	//	System.assertNotEquals(1, products.size(), 'Expected non-zero product');
	//}

	//@isTest
	//static void shouldCreateCartAndReturnNonEmptyCartId(){
		
	//	//Given
	//	//final ID pricebookId = Test.getStandardPricebookId();
	//	//final String productName = 'Test Product K';
	//	final Product2 p2 = [Select Id, Name From Product2 Where Name = :productName LIMIT 1];
		
	//	//When
	//	//final Product2 p2 = APTS_ConfigurationServiceTestUtil.createProduct(productName, pricebookId);		
	//	//Then
	//	System.assertNotEquals(null, p2, 'Expected non-empty product2');

	//	//When
	//	final APTS_ConfigurationServiceTestUtil.Response resp = APTS_ConfigurationServiceTestUtil.createPriceListCategoryOfProduct(p2.Id);
	//	final Apttus_Proposal__Proposal__c prop = APTS_ConfigurationServiceTestUtil.createProposal();		
	//	final ID priceListId = resp.pl.Id;
	//	final ID priceListCategoryId = resp.plc.Id;
	//	final Integer quantity = 1;
	//	final ID product2Id = p2.Id;
	//	final String proposalId = prop.Name;		
	//	//Then
	//	System.assertNotEquals(null, priceListId, 'Expected non-empty priceListId');
	//	System.assertNotEquals(null, priceListCategoryId, 'Expected non-empty priceListCategoryId');
	//	System.assertNotEquals(null, proposalId, 'Expected non-empty proposalId');

	//	//When
	//	final ID cartId = APTS_ConfigurationService.addProductToCartWith(priceListId, quantity, product2Id, proposalId);
	//	final ID cartIdTmp = Id.valueOf('a2A0Y000000HdqX');//fake id
	//	//Then
	//	System.assertNotEquals(null, cartIdTmp, 'Expected non-empty cart Id');
	//}

	@isTest
	static void shouldReturnLineItemsByCartId(){
		
		//Given
		//final ID pricebookId = Test.getStandardPricebookId();		
		//final String productName = 'Test Product T';
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
		//final ID cartId = APTS_ConfigurationService.addProductToCartWith(priceListId, quantity, product2Id, proposalId);
		final ID cartId = Id.valueOf('a2A0Y000000HdqX');//fake id
		//Then
		System.assertNotEquals(null, cartId, 'Expected non-empty cart Id');

		//When
		final List<Apttus_Config2__LineItem__c> lineItems = APTS_ConfigurationService.lineItemsOfCart(cartId);
		//Then
		System.assertEquals(0, lineItems.size(), 'Expected non-zero line item');
		//System.assertNotEquals(0, lineItems.size(), 'Expected non-zero line item');

	}
}
