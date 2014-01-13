public with sharing class ContactologyIntCntrl 
{
	public list<Contact> conList	{ get;set; }
	public boolean contactsFound	{ get;set; }
	public Integer numContactsFound	{ get;set; }
	public String apiMethod;
	public String jsonResp			{ get;set; }
	public boolean errorFound		{ get;set; }
	
	public ContactologyIntCntrl()
	{
		conList = new list<Contact>();
		//this.apiMethod = apiMethod;
		errorFound = false;
	}
	
	public void doHttpCall()
	{
		try{
			Httprequest req = new Httprequest();
			IntegrationSettings__c intSettings = IntegrationSettings__c.getInstance('Contactology_getContact');
			req.setEndpoint(intSettings.Endpoint__c+'&key='+intSettings.API_Key__c);
			req.setMethod('GET');
			
			Http ht = new Http();
			HttpResponse response = ht.send(req);
			//jsonResp = String.valueOf(response);
			jsonResp = response.getBody();
			system.debug(response);
			
			if(response <> null)
			{
				//contactsFound = (List<Contact>) JSON.deserialize(String.valueOf(response), List<Contact>.class);
			}
		}catch(system.CallOutException ce)
		{
			system.debug(ce);
			errorFound = true;
		}
	}

}