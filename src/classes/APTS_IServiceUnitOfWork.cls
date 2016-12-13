/**
 * @see APTS_ServiceUnitOfWork
 **/
public interface APTS_IServiceUnitOfWork{
	/**
	 * Register a newly created SObject instance to be inserted when commitWork is called
	 *
	 * @param record A newly created SObject instance to be inserted during commitWork
	 **/
	void registerNew(SObject record);
	/**
	 * Register a list of newly created SObject instances to be inserted when commitWork is called
	 *
	 * @param records A list of newly created SObject instances to be inserted during commitWork
	 **/
	void registerNew(List<SObject> records);
	/**
	 * Register an existing record to be updated during the commitWork method
	 *
	 * @param record An existing record
	 **/
	void registerDirty(SObject record);
	/**
	 * Register a list of existing records to be updated during the commitWork method
	 *
	 * @param records A list of existing records
	 **/
	void registerDirty(List<SObject> records);
	/**
	 * Takes all the work that has been registered with the UnitOfWork and commits it to the database
	 **/
	void commitWork();
	/**
	 * Register a generic peace of work to be invoked during the commitWork phase
	 *
	 * @param work Work to be registered
	 **/
	void registerWork(APTS_ServiceUnitOfWork.IDoWork work);
}
