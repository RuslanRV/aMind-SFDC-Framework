public class APTS_ConfigurationServiceTestUtil {

	private APTS_ConfigurationServiceTestUtil(){}
	
	@testVisible
	private static void createProduct(final String productName){
		
		final Product2 p2 = new Product2(
			Name = productName, 
			Apttus_Config2__Uom__c = 'Each', 
			Apttus_Config2__Version__c = 1.00,
			Apttus_Config2__ConfigurationType__c = 'Standalone',
			isActive = true);
		Insert p2;

		final Id pricebookId = Test.getStandardPricebookId();

		final PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = p2.Id, UnitPrice=1000, isActive = true);
		Insert pbe;
	}

	@testVisible
	private static Response createPriceListCategoryOfProduct(final ID product2Id){
		final Apttus_Config2__PriceList__c pl = createPriceList();
		final Apttus_Config2__ClassificationName__c cn = createCategory();
		final Apttus_Config2__ClassificationHierarchy__c ch = createCategoryHierarchy(cn.Name, cn.Id);
		final Apttus_Config2__ClassificationHierarchy__c chSub = createSubCategoryHierarchy(cn.Name, cn.Id, ch.Id);
		final Apttus_Config2__ProductClassification__c pclass = createProductClassification(product2Id, ch.Id);
		final Apttus_Config2__PriceListCategory__c plc = createPriceListCategory(pl.Id, cn.Id);
		final Apttus_Config2__PriceListItem__c pli = createPriceListItem(pl.Id, product2Id);
		return new Response(pl, cn, ch, pclass, plc, pli);
	}

	@testVisible
	private static Apttus_Config2__ClassificationName__c createCategory(){
		final Apttus_Config2__ClassificationName__c cn = new Apttus_Config2__ClassificationName__c(
			Name = 'Test Category',
			Apttus_Config2__HierarchyLabel__c = 'Test Category APTS',
			Apttus_Config2__Active__c = true,
			Apttus_Config2__Type__c = 'Offering');
		Insert cn;
		return cn;
	}

	@testVisible
	private static Apttus_Config2__ClassificationName__c createCategoryOfName(final String categoryName){
		final Apttus_Config2__ClassificationName__c cn = new Apttus_Config2__ClassificationName__c(
			Name = categoryName,
			Apttus_Config2__HierarchyLabel__c = categoryName + ' APTS',
			Apttus_Config2__Active__c = true,
			Apttus_Config2__Type__c = 'Offering');
		Insert cn;
		return cn;
	}

	@testVisible
	private static List<Apttus_Config2__ClassificationName__c> createCategories(final Integer numberOfCategories){
		
		final List<Apttus_Config2__ClassificationName__c> categories = new List<Apttus_Config2__ClassificationName__c>();
		
		for(Integer index=1; index <= numberOfCategories; index++){
			final Apttus_Config2__ClassificationName__c cn = new Apttus_Config2__ClassificationName__c(
				Name = 'Test Category ' + index,
				Apttus_Config2__HierarchyLabel__c = 'Test Category APTS ' + index,
				Apttus_Config2__Active__c = true,
				Apttus_Config2__Type__c = 'Offering');
			categories.add(cn);
		}
		Insert categories;
		return categories;
	}

	@testVisible
	private static List<Apttus_Config2__ClassificationName__c> createCategoriesWithoutCommit(final String name, final Integer numberOfCategories){
		
		final List<Apttus_Config2__ClassificationName__c> categories = new List<Apttus_Config2__ClassificationName__c>();
		
		for(Integer index=1; index <= numberOfCategories; index++){
			final Apttus_Config2__ClassificationName__c cn = new Apttus_Config2__ClassificationName__c(
				Name = name + ' ' + index,
				Apttus_Config2__HierarchyLabel__c = 'Test Category APTS ' + index,
				Apttus_Config2__Active__c = true,
				Apttus_Config2__Type__c = 'Offering');
			categories.add(cn);
		}
		return categories;
	}

	@testVisible
	private static List<Opportunity> createOpportunitiesWithoutCommit(final String name, final Integer numberOfOppties){
		final List<Opportunity> oppties = new List<Opportunity>();		
		for(Integer index=1; index <= numberOfOppties; index++){
			final Opportunity opp = new Opportunity(
			    Name = name + ' ' + index,
			    CloseDate = System.today(),
			    StageName = 'Prospecting',
			    Probability = 10);
			oppties.add(opp);
		}
		return oppties;
	}

	@testVisible
	private static Apttus_Proposal__Proposal__c createProposal(){

		final String propName = 'Test Proposal';
		final Apttus_Config2__PriceList__c priceList = createPriceList();
		
		final Account acc = new Account(Name = 'Test Account');
		Insert acc;

		final Opportunity opp = new Opportunity(
		    AccountId = acc.Id,
		    Name = 'Test Oppty',
		    CloseDate = System.today(),
		    StageName = 'Prospecting',
		    Probability = 10);
		Insert opp;

		final Apttus_Proposal__Proposal__c prop = new Apttus_Proposal__Proposal__c(
			Apttus_Proposal__Proposal_Name__c = propName,
			Apttus_Proposal__Opportunity__c = opp.Id,
			Apttus_QPConfig__PriceListId__c = priceList.Id,
			Apttus_Proposal__Primary__c = true,
			Apttus_Proposal__Approval_Stage__c = 'Draft',
			Apttus_Proposal__Proposal_Category__c = 'Proposal',
			Apttus_Proposal__ReadyToGenerate__c = true,
			Apttus_Proposal__ReadyToPresent__c = true);
		Insert prop;

		final Apttus_Proposal__Proposal__c propResult = [Select Name From Apttus_Proposal__Proposal__c Where Apttus_Proposal__Proposal_Name__c = :propName Limit 1];

		return propResult;
	}

	private static Apttus_Config2__ClassificationHierarchy__c createCategoryHierarchy(final String categoryName, final ID categoryId){
		final Apttus_Config2__ClassificationHierarchy__c ch = new Apttus_Config2__ClassificationHierarchy__c(
			Name = categoryName,
			Apttus_Config2__Label__c = categoryName,
			Apttus_Config2__Left__c = 1,
			Apttus_Config2__Right__c = 4,
			Apttus_Config2__Level__c = 0,
			Apttus_Config2__HierarchyId__c = categoryId,
			Apttus_Config2__Modifiable__c = true,
			Apttus_Config2__MinOptions__c = 1.00000,
			Apttus_Config2__MaxOptions__c = 1.00000,
			Apttus_Config2__IncludeInTotalsView__c = true);
		Insert ch;
		return ch;
	}

	private static Apttus_Config2__ClassificationHierarchy__c createSubCategoryHierarchy(final String categoryName, final ID categoryId, final ID categoryHierarchyId){
		final Apttus_Config2__ClassificationHierarchy__c ch = new Apttus_Config2__ClassificationHierarchy__c(
			Name = categoryName + ' Sub',
			Apttus_Config2__Label__c = categoryName + ' Sub',
			Apttus_Config2__Left__c = 2,
			Apttus_Config2__Right__c = 3,
			Apttus_Config2__Level__c = 1,
			Apttus_Config2__HierarchyId__c = categoryId,
			Apttus_Config2__PrimordialId__c = categoryHierarchyId,
			Apttus_Config2__AncestorId__c = categoryHierarchyId,
			Apttus_Config2__Modifiable__c = true,
			Apttus_Config2__MinOptions__c = 1.00000,
			Apttus_Config2__MaxOptions__c = 1.00000,
			Apttus_Config2__IncludeInTotalsView__c = true);
		Insert ch;
		return ch;
	}

	private static Apttus_Config2__ProductClassification__c createProductClassification(final ID product2Id, final ID categoryHierarchyId){
		final Apttus_Config2__ProductClassification__c pcass = new Apttus_Config2__ProductClassification__c(
			Apttus_Config2__ClassificationId__c = categoryHierarchyId,
			Apttus_Config2__ProductId__c = product2Id,
			Apttus_Config2__Modifiable__c = true,
			Apttus_Config2__MinQuantity__c = 0,
			Apttus_Config2__MaxQuantity__c = 1.00000,
			Apttus_Config2__DefaultQuantity__c = 1.00000);
		Insert pcass;
		return pcass;
	}

	private static Apttus_Config2__PriceListCategory__c createPriceListCategory(final ID priceListId, final ID categoryId){	
		final Apttus_Config2__PriceListCategory__c plc = new Apttus_Config2__PriceListCategory__c(
			Apttus_Config2__PriceListId__c = priceListId,
			Apttus_Config2__HierarchyId__c = categoryId,
			Apttus_Config2__Sequence__c = 1
			);
		Insert plc;
		return plc;
	}

	private static Apttus_Config2__PriceListItem__c createPriceListItem(final ID priceListId, final ID product2Id){
		final Apttus_Config2__PriceListItem__c pli = new Apttus_Config2__PriceListItem__c(
			Apttus_Config2__ProductId__c = product2Id,
			Apttus_Config2__PriceListId__c = priceListId,
			Apttus_Config2__ChargeType__c = 'Standard Price',
			Apttus_Config2__PriceType__c = 'One Time',
			Apttus_Config2__PriceUom__c = 'Each',
			Apttus_Config2__ListPrice__c = 1000,
			Apttus_Config2__PriceMethod__c = 'Per Unit',
			Apttus_Config2__Active__c = true);
		Insert pli;
		return pli;
	}


	private static Apttus_Config2__PriceList__c createPriceList(){
		final Apttus_Config2__PriceList__c pl = new Apttus_Config2__PriceList__c(Name = 'Base Price List APTS', Apttus_Config2__Active__c = true);
		Insert pl;
		return pl;
	}
	
	public class Response{
		public Apttus_Config2__PriceList__c pl { get; private set;}
		public Apttus_Config2__ClassificationName__c cn { get; private set;}
		public Apttus_Config2__ClassificationHierarchy__c ch { get; private set;}
		public Apttus_Config2__ProductClassification__c pclass { get; private set;}
		public Apttus_Config2__PriceListCategory__c plc { get; private set;}
		public Apttus_Config2__PriceListItem__c pli { get; private set;}

		public Response(
			Apttus_Config2__PriceList__c pl, 
			Apttus_Config2__ClassificationName__c cn, 
			Apttus_Config2__ClassificationHierarchy__c ch,
			Apttus_Config2__ProductClassification__c pclass,
			Apttus_Config2__PriceListCategory__c plc, 
			Apttus_Config2__PriceListItem__c pli){			
			this.pl = pl;
			this.cn = cn;
			this.ch = ch;
			this.pclass = pclass;
			this.plc = plc;
			this.pli = pli;
		}

	}
}
