public with sharing class HWConfigurationController {

	@RemoteAction
	public static List<HWConfigurationDomainHelper.Category> categoriesOfPriceList(ID priceListId) {        
       
        HWDebugInstrumentation.push('HWConfigurationController.categoriesOfPriceList');

        List<HWConfigurationDomainHelper.Category> result;

        try{
			result = HWConfigurationService.categoriesOfPriceList(priceListId);
        }catch(Exception ex){
    		HWDebugInstrumentation.debugException(ex, HWConstants.ERR_GC);
        }finally{        	
        }
        
        HWDebugInstrumentation.pop();
        
        //Set<ID> idSet = new Set<ID>{'a1u0Y000000PrM8'};
        //List<Apttus_Config2__ClassificationName__c> dd = HWConfigurationService.categoriesById(idSet);
       
        return result;
	}

	@RemoteAction
	public static List<HWConfigurationDomainHelper.Product> productsOfPriceListAndCategory(ID priceListId, ID categoryId) {
	        
	    HWDebugInstrumentation.push('HWConfigurationController.productsOfPriceListAndCategory');

		List<HWConfigurationDomainHelper.Product> result;

        try{
			result = HWConfigurationService.productsOfPriceListAndCategory(priceListId, categoryId);
			if(result == null || result.size() == 0){
				throw new HWDebugInstrumentation.CustomException('Product not found', HWConstants.ERR_GP);
			}
        }catch(HWDebugInstrumentation.CustomException rnfe){
    		HWDebugInstrumentation.debugException(rnfe);
        }catch(Exception ex){
    		HWDebugInstrumentation.debugException(ex, HWConstants.ERR_GP);
        }finally{
        }

		HWDebugInstrumentation.pop();

        return result;
	}

	@RemoteAction
	public static List<Apttus_Config2__LineItem__c> addProductToCartWith(ID priceListId, Integer quantity, ID productId, String quoteNumber) {
		final ID cartId = HWConfigurationService.addProductToCartWith(priceListId, quantity, productId, quoteNumber);
		return HWConfigurationService.lineItemsOfCart(cartId);
	}

	@RemoteAction
	public static List<Apttus_Config2__LineItem__c> cartItemsOfQuote(String quoteNumber) {
		//return HWConfigurationService.lineItemsOfCart(cartId);
		return new List<Apttus_Config2__LineItem__c>();
	}


	//@RemoteAction
	//public static List<HWConfigurationDomainHelper.Category> categoriesOfPriceList2(ID priceListId) {        
       
 //       HWDebugInstrumentation.push('HWConfigurationController.categoriesOfPriceList2');

 //       List<HWConfigurationDomainHelper.Category> result;

 //       try{
	//		result = HWConfigurationService.categoriesOfPriceList2(priceListId);
 //       }catch(Exception ex){
 //   		HWDebugInstrumentation.debugException(ex, HWConstants.ERR_GC);
 //       }finally{        	
 //       }
        
 //       HWDebugInstrumentation.pop();

 //       return result;
	//}
}