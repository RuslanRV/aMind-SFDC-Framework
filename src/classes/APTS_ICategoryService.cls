public interface APTS_ICategoryService {
	List<APTS_ConfigurationDomainHelper.Category> categoriesOfPriceList(ID priceListId);
	List<APTS_ConfigurationDomainHelper.Product> productsOfPriceListAndCategory(ID priceListId, ID categoryId);
	APTS_ICategories categoriesById(Set<ID> idSet);
}