public class ContactHistSnapshotExt {
	public Contact con											{ get;set; }
	public String jsonResp										{ get;set; }
	public boolean errorFound									{ get;set; }
	public ContactHistoryWrapper jsonToApexObj					{ get;set; }
	
    public ContactHistSnapshotExt(ApexPages.StandardController controller) {
		//acc = (Account) controller.getRecord();
		con = [Select Id, Name, Email From Contact Where Id =: controller.getId()];
		
    }
    
    public void doHTTPCalltoContactology()
    {
    	try{
			Httprequest req = new Httprequest();
			//buildQueryString();
			IntegrationSettings__c intSettings = IntegrationSettings__c.getInstance('Contactology_getContact');
			req.setEndpoint(intSettings.Endpoint__c+'&key='+intSettings.API_Key__c+'&method=Contact_Get_History&email='+con.Email);
			req.setMethod('GET');
			
			Http ht = new Http();
			HttpResponse response = ht.send(req);
			//jsonResp = String.valueOf(response);
			jsonResp = response.getBody();
			
			jsonToApexObj = ContactHistoryWrapper.parse(jsonResp);
			
			system.debug(response);
			system.debug('JSON Obj>>>>>>>>>>>>>>'+jsonToApexObj);
			system.debug('Send History Size>>>>>>>>>>>>>>'+jsonToApexObj.sendHistory.size());
			system.debug('Subscription History Size>>>>>>>>>>>>>>'+jsonToApexObj.subscriptionHistory.size());
		
		}catch(system.CallOutException ce)
		{
			system.debug(ce);
			errorFound = true;
		}
    }
    
    /*public void buildQueryString(String methodName)
    {
    	
    }*/
    
    

	
}