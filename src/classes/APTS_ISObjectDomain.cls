public interface APTS_ISObjectDomain{
    /**
     * Returns the SObjectType this Domain class represents
     **/	
	Schema.SObjectType sObjectType();

    /**
     * Alternative to the Records property, provided to support mocking of Domain classes
     **/	
	List<SObject> getRecords();
}