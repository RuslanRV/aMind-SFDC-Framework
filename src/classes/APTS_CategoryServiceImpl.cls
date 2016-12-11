public class APTS_CategoryServiceImpl implements APTS_ICategoryService{

	public List<APTS_ConfigurationDomainHelper.Product> productsOfPriceListAndCategory(ID priceListId, ID categoryId){

        final List<APTS_ConfigurationDomainHelper.Product> products = new List<APTS_ConfigurationDomainHelper.Product>();

        final Apttus_CPQApi.CPQ.ProductSearchResultDO psrDO = Apttus_CPQApi.CPQWebService.getProductsForPriceListCategory(priceListId, categoryId);

        for (Apttus_CPQApi.CPQ.ProductDO pDO : psrDO.Products) {
            products.add(new APTS_ConfigurationDomainHelper.Product(pDO));
        }

        return products;        
    }
	
    public List<APTS_ConfigurationDomainHelper.Category> categoriesOfPriceList(final ID priceListId){
		
		final List<APTS_ConfigurationDomainHelper.Category> categories = new List<APTS_ConfigurationDomainHelper.Category>();
		
		final Apttus_CPQApi.CPQ.CategorySearchResultDO csrDO = Apttus_CPQApi.CPQWebService.getCategoriesForPriceList(priceListId);

        for (Apttus_CPQApi.CPQ.CategoryDO cDO1 : csrDO.Categories) {
           categories.add(new APTS_ConfigurationDomainHelper.Category(cDO1));

            if (cDO1.HasChildCategories) {

                for (Apttus_CPQApi.CPQ.CategoryDO cDO2 : cDO1.ChildCategories) {
                    categories.add(new APTS_ConfigurationDomainHelper.Category(cDO2));

                    if (cDO2.HasChildCategories) {

                        for (Apttus_CPQApi.CPQ.CategoryDO cDO3 : cDO2.ChildCategories) {
                            categories.add(new APTS_ConfigurationDomainHelper.Category(cDO3));
                        }
                    }
                }
            }
        }
        return categories;
	}

 	//domain object and selector example
    public APTS_ICategories categoriesById(final Set<ID> idSet){
        return APTS_Categories.newInstance(APTS_CategoriesSelector.newInstance().selectSObjectsById(idSet));
	}
}