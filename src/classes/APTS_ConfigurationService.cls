global with sharing class APTS_ConfigurationService{
    
    private static APTS_Application.ServiceProducer serviceProducer(){     
        return new APTS_Application.ServiceProducer();
    }

    private static final APTS_ICategoryService categoryService = serviceProducer().categoryService();
    private static final APTS_ILineItemService lineItemService = serviceProducer().lineItemService();
    private static final APTS_ICartService cartService = serviceProducer().cartService();

    global static List<APTS_ConfigurationDomainHelper.Category> categoriesOfPriceList(ID priceListId){
        return categoryService.categoriesOfPriceList(priceListId);
    }

    global static List<Apttus_Config2__ClassificationName__c> categoriesById(Set<ID> idSet){
        final APTS_ICategories plc = categoryService.categoriesById(idSet);
        return (List<Apttus_Config2__ClassificationName__c>)plc.getRecords();
    }

    global static List<APTS_ConfigurationDomainHelper.Product> productsOfPriceListAndCategory(ID priceListId, ID categoryId){
        return categoryService.productsOfPriceListAndCategory(priceListId, categoryId);
    }

    global static List<Apttus_Config2__LineItem__c> lineItemsOfCart(ID cartId){
        return lineItemService.lineItemsOfCart(cartId);
    }

    global static ID addProductToCartWith(ID priceListId, Integer quantity, ID productId, String quoteNumber){
        return cartService.addProductToCartWith(priceListId, quantity, productId, quoteNumber);
    }
}