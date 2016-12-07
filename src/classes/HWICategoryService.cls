public interface HWICategoryService {
	List<HWConfigurationDomainHelper.Category> categoriesOfPriceList(ID priceListId);
	List<HWConfigurationDomainHelper.Product> productsOfPriceListAndCategory(ID priceListId, ID categoryId);
	HWICategories categoriesById(Set<ID> idSet);
}