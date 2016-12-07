public class HWApplication{

	public static final HWApplicationFactory.UnitOfWorkFactory UnitOfWork = new HWApplicationFactory.UnitOfWorkFactory(); 

    private static final HWApplicationFactory.ServiceFactory Service = 
        new HWApplicationFactory.ServiceFactory(
            new Map<Type, Type> {
                    HWICategoryService.class => HWCategoryServiceImpl.class,
                    HWICartService.class => HWCartServiceImpl.class,
                    HWILineItemService.class => HWLineItemServiceImpl.class
                });

	public static final HWApplicationFactory.DomainFactory Domain = 
		new HWApplicationFactory.DomainFactory(
			HWApplication.Selector,
			new Map<SObjectType, Type> {
					Apttus_Config2__ClassificationName__c.SObjectType => HWCategories.Constructor.class});

	public static final HWApplicationFactory.SelectorFactory Selector = 
		new HWApplicationFactory.SelectorFactory(
			new Map<SObjectType, Type> {
					Apttus_Config2__ClassificationName__c.SObjectType => HWCategoriesSelector.class
					});

    public class ServiceProducer{
    	
    	public HWICategoryService categoryService(){
        	return (HWICategoryService)Service.newInstance(HWICategoryService.class);
    	}

    	public HWICartService cartService(){
        	return (HWICartService)Service.newInstance(HWICartService.class);
    	}    	

    	public HWILineItemService lineItemService(){
        	return (HWILineItemService)Service.newInstance(HWILineItemService.class);
    	}
    }
}