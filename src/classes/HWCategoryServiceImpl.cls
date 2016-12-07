public class HWCategoryServiceImpl implements HWICategoryService{

	public List<HWConfigurationDomainHelper.Product> productsOfPriceListAndCategory(ID priceListId, ID categoryId){

        final List<HWConfigurationDomainHelper.Product> products = new List<HWConfigurationDomainHelper.Product>();

        final Apttus_CPQApi.CPQ.ProductSearchResultDO psrDO = Apttus_CPQApi.CPQWebService.getProductsForPriceListCategory(priceListId, categoryId);

        for (Apttus_CPQApi.CPQ.ProductDO pDO : psrDO.Products) {
            products.add(new HWConfigurationDomainHelper.Product(pDO));
        }

        return products;        
    }
	
    public List<HWConfigurationDomainHelper.Category> categoriesOfPriceList(final ID priceListId){
		
		final List<HWConfigurationDomainHelper.Category> categories = new List<HWConfigurationDomainHelper.Category>();
		
		final Apttus_CPQApi.CPQ.CategorySearchResultDO csrDO = Apttus_CPQApi.CPQWebService.getCategoriesForPriceList(priceListId);

        for (Apttus_CPQApi.CPQ.CategoryDO cDO1 : csrDO.Categories) {
           categories.add(new HWConfigurationDomainHelper.Category(cDO1));

            if (cDO1.HasChildCategories) {

                for (Apttus_CPQApi.CPQ.CategoryDO cDO2 : cDO1.ChildCategories) {
                    categories.add(new HWConfigurationDomainHelper.Category(cDO2));

                    if (cDO2.HasChildCategories) {

                        for (Apttus_CPQApi.CPQ.CategoryDO cDO3 : cDO2.ChildCategories) {
                            categories.add(new HWConfigurationDomainHelper.Category(cDO3));
                        }
                    }
                }
            }
        }
        return categories;
	}

 	//domain object and selector example
    public HWICategories categoriesById(final Set<ID> idSet){
        return HWCategories.newInstance(HWCategoriesSelector.newInstance().selectSObjectsById(idSet));
	}
}