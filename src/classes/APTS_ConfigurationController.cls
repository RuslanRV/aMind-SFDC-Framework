public with sharing class APTS_ConfigurationController {

	@RemoteAction
	public static List<APTS_ConfigurationDomainHelper.Category> categoriesOfPriceList(ID priceListId) {        
       
        APTS_DebugInstrumentation.push('APTS_ConfigurationController.categoriesOfPriceList');

        List<APTS_ConfigurationDomainHelper.Category> result;

        try{
			result = APTS_ConfigurationService.categoriesOfPriceList(priceListId);
        }catch(Exception ex){
    		APTS_DebugInstrumentation.debugException(ex, APTS_Constants.ERR_GC);
        }finally{        	
        }
        
        APTS_DebugInstrumentation.pop();
        
        //Set<ID> idSet = new Set<ID>{'a1u0Y000000PrM8'};
        //List<Apttus_Config2__ClassificationName__c> dd = APTS_ConfigurationService.categoriesById(idSet);
       
        return result;
	}

	@RemoteAction
	public static List<APTS_ConfigurationDomainHelper.Product> productsOfPriceListAndCategory(ID priceListId, ID categoryId) {
	        
	    APTS_DebugInstrumentation.push('APTS_ConfigurationController.productsOfPriceListAndCategory');

		List<APTS_ConfigurationDomainHelper.Product> result;

        try{
			result = APTS_ConfigurationService.productsOfPriceListAndCategory(priceListId, categoryId);
			if(result == null || result.size() == 0){
				throw new APTS_DebugInstrumentation.CustomException('Product not found', APTS_Constants.ERR_GP);
			}
        }catch(APTS_DebugInstrumentation.CustomException rnfe){
    		APTS_DebugInstrumentation.debugException(rnfe);
        }catch(Exception ex){
    		APTS_DebugInstrumentation.debugException(ex, APTS_Constants.ERR_GP);
        }finally{
        }

		APTS_DebugInstrumentation.pop();

        return result;
	}

	@RemoteAction
	public static List<Apttus_Config2__LineItem__c> addProductToCartWith(ID priceListId, Integer quantity, ID productId, String quoteNumber) {
		final ID cartId = APTS_ConfigurationService.addProductToCartWith(priceListId, quantity, productId, quoteNumber);
		return APTS_ConfigurationService.lineItemsOfCart(cartId);
	}

	@RemoteAction
	public static List<Apttus_Config2__LineItem__c> cartItemsOfQuote(String quoteNumber) {
		//return APTS_ConfigurationService.lineItemsOfCart(cartId);
		return new List<Apttus_Config2__LineItem__c>();
	}


	//@RemoteAction
	//public static List<APTS_ConfigurationDomainHelper.Category> categoriesOfPriceList2(ID priceListId) {        
       
 //       APTS_DebugInstrumentation.push('APTS_ConfigurationController.categoriesOfPriceList2');

 //       List<APTS_ConfigurationDomainHelper.Category> result;

 //       try{
	//		result = APTS_ConfigurationService.categoriesOfPriceList2(priceListId);
 //       }catch(Exception ex){
 //   		APTS_DebugInstrumentation.debugException(ex, APTS_Constants.ERR_GC);
 //       }finally{        	
 //       }
        
 //       APTS_DebugInstrumentation.pop();

 //       return result;
	//}
}