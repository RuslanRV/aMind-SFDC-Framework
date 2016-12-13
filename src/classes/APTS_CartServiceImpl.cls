public class APTS_CartServiceImpl implements APTS_ICartService{

	public ID addProductToCartWith(final ID priceListId, final Integer quantity, final Id productId, final String quoteNumber){

		final APTS_IServiceUnitOfWork uow = APTS_Application.UnitOfWork.newInstance();
		final CartWork cw = new CartWork(priceListId, quantity, productId, quoteNumber);
		final MultiProductsWork ppw = new MultiProductsWork(cw);
		
		// register your works
		uow.registerWork(cw);
		uow.registerWork(ppw);
						
		//commit your works
		uow.commitWork();
	
		return cw.ccrDO.cartId;
	}

	private class CartWork implements APTS_ServiceUnitOfWork.IDoWork{
				
		final ID priceListId;
		final Integer quantity;
		final Id productId;
		final String quoteNumber;

		public Apttus_CPQApi.CPQ.CreateCartResponseDO ccrDO { get; set; }
		public List<Apttus_CPQApi.CPQ.SelectedProductDO> selectedProdDOList  { get; set; }

		public CartWork(final ID a_priceListId, final Integer a_quantity, final Id a_productId, final String a_quoteNumber){
			this.priceListId = a_priceListId;
			this.quantity = a_quantity;
			this.productId = a_productId;
			this.quoteNumber = a_quoteNumber;
		}

		public void doWork(){

			this.selectedProdDOList = new List <Apttus_CPQApi.CPQ.SelectedProductDO>();
			final Apttus_CPQApi.CPQ.SelectedProductDO selProdDO = new Apttus_CPQApi.CPQ.SelectedProductDO();
			selProdDO.ProductID = this.productId;
			selProdDO.Quantity = this.quantity;
			selProdDO.SellingTerm = 12;
			selProdDO.StartDate = Date.Today();
			selProdDO.EndDate = Date.Today() + 12;
			selProdDO.Comments = 'Added by Code';
			this.selectedProdDOList.add(selProdDO);

			if (this.selectedProdDOList.size() > 0) {
				final Apttus_CPQApi.CPQ.CreateCartRequestDO request = new Apttus_CPQApi.CPQ.CreateCartRequestDO();
				final List<Apttus_Proposal__Proposal__c> listQuote = [Select Id from Apttus_Proposal__Proposal__c where Name = :this.quoteNumber LIMIT 1];

				if (listQuote != null && listQuote.size() > 0){
					Apttus_Proposal__Proposal__c quote = listQuote.get(0);
					request.QuoteId = quote.Id;
					this.ccrDO = Apttus_CPQApi.CPQWebService.createCart(request);
				}

				if(this.ccrDO == null || this.ccrDO.cartId == null){
					throw new APTS_DebugInstrumentation.CustomException('Could not create a cart');
				}
			}
		}
	}


	private class MultiProductsWork implements APTS_ServiceUnitOfWork.IDoWork{
				
		final CartWork cw;
		public Apttus_CPQApi.CPQ.AddMultiProductResponseDO amprDO { get; set; }
		
		public MultiProductsWork(final CartWork a_cw){
			this.cw = a_cw;
		}

		public void doWork(){
			final Apttus_CPQApi.CPQ.AddMultiProductRequestDO request = new Apttus_CPQApi.CPQ.AddMultiProductRequestDO();
			request.CartId = this.cw.ccrDO.cartId;
			request.SelectedProducts = this.cw.selectedProdDOList;
			this.amprDO = Apttus_CPQApi.CPQWebService.addMultiProducts(request);
	
			if(this.amprDO == null){
				throw new APTS_DebugInstrumentation.CustomException('Could not add a product to the cart');
			}
		}
	}
}
