public virtual with sharing class APTS_SObjectDomain implements APTS_ISObjectDomain{
	/**
	 * Provides access to the data represented by this domain class
	 **/
	public List<SObject> Records { get; private set;}
	
	/**
	 * Derived from the records provided during construction, provides the native describe for the standard or custom object
	 **/
	public Schema.DescribeSObjectResult SObjectDescribe {get; private set;}
			
	/**
	 * Constructs the domain class with the data on which to apply the behaviour implemented within
	 *
	 * @param sObjectList A concreate list (e.g. List<Account> vs List<SObject>) of records

	 **/
	public APTS_SObjectDomain(List<SObject> sObjectList)
	{
		this(sObjectList, sObjectList.getSObjectType());
	}

	/**
	 * Constructs the domain class with the data and type on which to apply the behaviour implemented within
	 *
	 * @param sObjectList A list (e.g. List<Opportunity>, List<Account>, etc.) of records
	 * @param sObjectType The Schema.SObjectType of the records contained in the list
	 *
	 * @remark Will support List<SObject> but all records in the list will be assumed to be of
	 *         the type specified in sObjectType
	 **/
	public APTS_SObjectDomain(List<SObject> sObjectList, SObjectType sObjectType)
	{
		// Ensure the domain class has its own copy of the data
		Records = sObjectList.clone(); 
		// Capture SObjectType describe for this domain class
		SObjectDescribe = sObjectType != null ? sObjectType.getDescribe() : null;	
	}
	       
    /**
     * Returns the SObjectType this Domain class represents
     **/
    public SObjectType getSObjectType()
    {
    	return SObjectDescribe.getSObjectType();
    }

    /**
     * Returns the SObjectType this Domain class represents
     **/
    public SObjectType sObjectType()
    {
    	return getSObjectType();
    }

    /**
     * Alternative to the Records property, provided to support mocking of Domain classes
     **/
    public List<SObject> getRecords()
    {
    	return Records;
    }
    
	/**
	 * Interface used to aid the triggerHandler in constructing instances of Domain classes
	 **/
	public interface IConstructable
	{
		APTS_SObjectDomain construct(List<SObject> sObjectList);
	}

	/**
	 * Interface used to aid the triggerHandler in constructing instances of Domain classes
	 **/
	public interface IConstructable2 extends IConstructable
	{
		APTS_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType);
	}	
	
	/**
	 * General exception class for the domain layer
	 **/
	public class DomainException extends Exception
	{
	}
}
