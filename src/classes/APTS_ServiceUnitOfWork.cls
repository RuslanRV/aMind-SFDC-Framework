public virtual class APTS_ServiceUnitOfWork implements APTS_IServiceUnitOfWork{

	private List<Schema.SObjectType> m_sObjectTypes = new List<Schema.SObjectType>();	
	private Map<String, List<SObject>> m_newListByType = new Map<String, List<SObject>>();	
	private Map<String, Map<Id, SObject>> m_dirtyMapByType = new Map<String, Map<Id, SObject>>();
	private List<IDoWork> m_workList = new List<IDoWork>();	
	private IDML m_dml;
	
	/**
	 * Interface describes work to be performed during the commitWork method
	 **/
	public interface IDoWork{
		void doWork();
	}

	public interface IDML{
		void dmlInsert(List<SObject> objList);
		void dmlUpdate(List<SObject> objList);
	}
	
	public class SimpleDML implements IDML{
		public void dmlInsert(List<SObject> objList){
			insert objList;
		}
		public void dmlUpdate(List<SObject> objList){
			update objList;
		}
	}
	/**
	 * Constructs a new UnitOfWork to support work against the given object list
	 *
	 * @param sObjectList A list of objects given in dependency order (least dependent first)
	 */
	public APTS_ServiceUnitOfWork(List<Schema.SObjectType> sObjectTypes){
		this(sObjectTypes, new SimpleDML());
	}

	public APTS_ServiceUnitOfWork(List<Schema.SObjectType> sObjectTypes, IDML dml){
		m_sObjectTypes = sObjectTypes.clone();
			
		for(Schema.SObjectType sObjectType : m_sObjectTypes){
			handleRegisterType(sObjectType);
		}		
		m_dml = dml;
	}

	// default implementations for commitWork events
	public virtual void onRegisterType(Schema.SObjectType sObjectType) {}
	public virtual void onCommitWorkStarting() {}
	public virtual void onDMLStarting() {}
	public virtual void onDMLFinished() {}
	public virtual void onDoWorkStarting() {}
	public virtual void onDoWorkFinished() {}
	public virtual void onCommitWorkFinishing() {}
	public virtual void onCommitWorkFinished(Boolean wasSuccessful) {}

	/**
	 * Registers the type to be used for DML operations
	 *
	 * @param sObjectType - The type to register
	 *
	 */
	private void handleRegisterType(Schema.SObjectType sObjectType){
		// add type to dml operation tracking
		m_newListByType.put(sObjectType.getDescribe().getName(), new List<SObject>());
		m_dirtyMapByType.put(sObjectType.getDescribe().getName(), new Map<Id, SObject>());
		// give derived class opportunity to register the type
		onRegisterType(sObjectType);		
	}
	
	/**
	 * Register a generic peace of work to be invoked during the commitWork phase
	 **/
	public void registerWork(IDoWork work){
		m_workList.add(work);
	}
	

	/**
	 * Register a list of newly created SObject instances to be inserted when commitWork is called
	 *
	 * @param records A list of newly created SObject instances to be inserted during commitWork
	 **/
	public void registerNew(List<SObject> records){
		for(SObject record : records){
			registerNew(record);
		}
	}

	/**
	 * Register a newly created SObject instance to be inserted when commitWork is called, 
	 *   you may also provide a reference to the parent record instance (should also be registered as new separatly)
	 *
	 * @param record A newly created SObject instance to be inserted during commitWork
	 **/
	public void registerNew(SObject record){
		if(record.Id != null){
			throw new UnitOfWorkException('Only new records can be registered as new');
		}
		String sObjectType = record.getSObjectType().getDescribe().getName();			
		if(!m_newListByType.containsKey(sObjectType)){
			throw new UnitOfWorkException(String.format('SObject type {0} is not supported by this unit of work', new String[] { sObjectType }));
		}
		m_newListByType.get(sObjectType).add(record);
	}

	/**
	 * Register an existing record to be updated during the commitWork method
	 *
	 * @param record An existing record
	 **/
	public void registerDirty(SObject record){
		if(record.Id == null){
			throw new UnitOfWorkException('New records cannot be registered as dirty');
		}
		String sObjectType = record.getSObjectType().getDescribe().getName();			
		if(!m_dirtyMapByType.containsKey(sObjectType)){
			throw new UnitOfWorkException(String.format('SObject type {0} is not supported by this unit of work', new String[] { sObjectType }));
		}
		m_dirtyMapByType.get(sObjectType).put(record.Id, record);		
	}

	/**
	 * Register a list of existing records to be updated during the commitWork method
	 *
	 * @param records A list of existing records
	 **/
	public void registerDirty(List<SObject> records){
		for(SObject record : records){
			this.registerDirty(record);
		}
	}
	
	/**
	 * Takes all the work that has been registered with the UnitOfWork and commits it to the database
	 **/
	public void commitWork(){
		// notify we're starting the commit work
		onCommitWorkStarting();

		// Wrap the work in its own transaction 
		Savepoint sp = Database.setSavePoint();
		Boolean wasSuccessful = false;	
		try{		
			// notify we're starting the DML operations
			onDMLStarting();
			// Insert by type
			for(Schema.SObjectType sObjectType : m_sObjectTypes){
				//m_relationships.get(sObjectType.getDescribe().getName()).resolve();
				m_dml.dmlInsert(m_newListByType.get(sObjectType.getDescribe().getName()));
			}					
			// Update by type
			for(Schema.SObjectType sObjectType : m_sObjectTypes){
				m_dml.dmlUpdate(m_dirtyMapByType.get(sObjectType.getDescribe().getName()).values());		
			}
			
			// notify we're done with DML
			onDMLFinished();

			// notify we're starting to process registered work
			onDoWorkStarting();
			// Generic work
			for(IDoWork work : m_workList){
				work.doWork();
			}
			// notify we've completed processing registered work
			onDoWorkFinished();

			// notify we've completed all steps and are in the final stage of completing
			onCommitWorkFinishing();

			// mark tracker to indicate success
			wasSuccessful = true;
		}catch (Exception e){
			// Rollback
			Database.rollback(sp);
			// Throw exception on to caller
			throw e;
		}finally{			
			// notify we're done with commit work
			onCommitWorkFinished(wasSuccessful);
		}
	}

	/**
	 * UnitOfWork Exception
	 **/
	public class UnitOfWorkException extends Exception {}

}
