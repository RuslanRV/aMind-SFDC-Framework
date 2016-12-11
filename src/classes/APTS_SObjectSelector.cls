/**
 * Class providing common database query support for abstracting and encapsulating query logic
 **/
public abstract with sharing class APTS_SObjectSelector implements APTS_ISObjectSelector{
  
   	private APTS_SObjectDescribe describeWrapper {
   		get {
   			if(describeWrapper == null)
   				describeWrapper = APTS_SObjectDescribe.getDescribe(getSObjectType());
   			return describeWrapper;
   		}
   		set;
   	}
   
    abstract Schema.SObjectType getSObjectType();

    //abstract List<Schema.SObjectField> getSObjectFieldList();
    abstract Set<String> getSObjectFieldList();

    public APTS_SObjectSelector() {
    }
 
    public String getSObjectName(){
        return describeWrapper.getDescribe().getName();
    }
  
    public List<SObject> selectSObjectsById(Set<Id> idSet){
        return Database.query(toSOQL(idSet));
    }

    private String toSOQL(final Set<Id> idSet){
        
        String soql = 'SELECT ';
        soql += String.join(new List<String>(getSObjectFieldList()), ',');    
        soql += ' FROM ' + getSObjectName();
        
        if(idSet == null || idSet.size() == 0) { return soql; }

        final List<String> idStrs = (List<String>)JSON.deserialize(JSON.serialize(idSet), List<String>.class);
        soql += ' WHERE Id in(';
        soql += '\'' + String.join(idStrs, '\',\'') + '\'';
        soql += ')';
        return soql;
    }

    public Database.QueryLocator queryLocatorById(Set<Id> idSet){
        return Database.getQueryLocator(toSOQL(idSet));
    }

    public List<SObject> databaseQuery(String a_soql){
        return Database.query(a_soql);
    }

    public SObjectType sObjectType(){
        return getSObjectType();
    }
}