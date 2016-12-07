global with sharing class HWConfigurationService{
    
    private static HWApplication.ServiceProducer serviceProducer(){     
        return new HWApplication.ServiceProducer();
    }

    private static final HWICategoryService categoryService = serviceProducer().categoryService();
    private static final HWILineItemService lineItemService = serviceProducer().lineItemService();
    private static final HWICartService cartService = serviceProducer().cartService();

    global static List<HWConfigurationDomainHelper.Category> categoriesOfPriceList(ID priceListId){
        return categoryService.categoriesOfPriceList(priceListId);
    }

    global static List<Apttus_Config2__ClassificationName__c> categoriesById(Set<ID> idSet){
        final HWICategories plc = categoryService.categoriesById(idSet);
        return (List<Apttus_Config2__ClassificationName__c>)plc.getRecords();
    }

    global static List<HWConfigurationDomainHelper.Product> productsOfPriceListAndCategory(ID priceListId, ID categoryId){
        return categoryService.productsOfPriceListAndCategory(priceListId, categoryId);
    }

    global static List<Apttus_Config2__LineItem__c> lineItemsOfCart(ID cartId){
        return lineItemService.lineItemsOfCart(cartId);
    }

    global static ID addProductToCartWith(ID priceListId, Integer quantity, ID productId, String quoteNumber){
        return cartService.addProductToCartWith(priceListId, quantity, productId, quoteNumber);
    }
}