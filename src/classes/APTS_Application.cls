public class APTS_Application{

	public static final APTS_ApplicationFactory.UnitOfWorkFactory UnitOfWork = new APTS_ApplicationFactory.UnitOfWorkFactory(); 

    private static final APTS_ApplicationFactory.ServiceFactory Service = 
        new APTS_ApplicationFactory.ServiceFactory(
            new Map<Type, Type> {
                    APTS_ICategoryService.class => APTS_CategoryServiceImpl.class,
                    APTS_ICartService.class => APTS_CartServiceImpl.class,
                    APTS_ILineItemService.class => APTS_LineItemServiceImpl.class
                });

	public static final APTS_ApplicationFactory.DomainFactory Domain = 
		new APTS_ApplicationFactory.DomainFactory(
			APTS_Application.Selector,
			new Map<SObjectType, Type> {
					Apttus_Config2__ClassificationName__c.SObjectType => APTS_Categories.Constructor.class});

	public static final APTS_ApplicationFactory.SelectorFactory Selector = 
		new APTS_ApplicationFactory.SelectorFactory(
			new Map<SObjectType, Type> {
					Apttus_Config2__ClassificationName__c.SObjectType => APTS_CategoriesSelector.class
					});

    public class ServiceProducer{
    	
    	public APTS_ICategoryService categoryService(){
        	return (APTS_ICategoryService)Service.newInstance(APTS_ICategoryService.class);
    	}

    	public APTS_ICartService cartService(){
        	return (APTS_ICartService)Service.newInstance(APTS_ICartService.class);
    	}    	

    	public APTS_ILineItemService lineItemService(){
        	return (APTS_ILineItemService)Service.newInstance(APTS_ILineItemService.class);
    	}
    }
}
