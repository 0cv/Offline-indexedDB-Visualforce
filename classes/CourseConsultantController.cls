public with sharing class CourseConsultantController {
	public Integer clientNumbers{get;set;}
	public CourseConsultantController() {
		clientNumbers = [select count() from Client__c];
	}

	@RemoteAction
	public static Boolean loginHandler(String userName, String password) {
		return [select Password__c 
				from User 
				where 
					Employee_Code__c =: userName AND
					Password__c =: password].size()>0;
	}
 
	@RemoteAction
	public static List<Client__c> getClients(String Id){
		return [SELECT Name, English_Name__c, Birth_Date__c, Telephone__c, Email__c, 
					Gender__c, Course_Consultant_Name__c, Course_Consultant_Cell__c, WSE_Center__c
				FROM Client__c 
				WHERE Id>: Id
				limit 20000];
	}

	@RemoteAction
	public static Map<Object, Object> saveClients(List<Client__c> clients){
		Map<Object, Object> result = new Map<Object, Object>();
		try {
			update clients;
			result.put('success', true);
		}
		catch(Exception e) {
			result.put('success', false);
			result.put('errMsg', e.getMessage());

		}

		return result;
	}

}