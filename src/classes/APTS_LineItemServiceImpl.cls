public class APTS_LineItemServiceImpl implements APTS_ILineItemService{

	public List<Apttus_Config2__LineItem__c> lineItemsOfCart(final ID cartId) {

        final List<Apttus_Config2__LineItem__c> lineItems = [select Id, Name,
                                          Apttus_Config2__Description__c,
                                          Apttus_Config2__Quantity__c, Apttus_Config2__ListPrice__c, Apttus_Config2__NetPrice__c,
                                          Apttus_Config2__LineNumber__c from Apttus_Config2__LineItem__c where Apttus_Config2__ConfigurationId__c = :cartId];
        return lineItems;
    }
}