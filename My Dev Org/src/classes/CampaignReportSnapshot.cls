/**
Header...
**/
public with sharing class CampaignReportSnapshot {
	public Campaign camp										{ get;set; } 
	public String jsonResp										{ get;set; }
	public boolean errorFound									{ get;set; }
	public CampaignReportWrapper crWrap							{ get;set; }
	
    public CampaignReportSnapshot(ApexPages.StandardController controller) {
    	errorFound = false;
		camp = [Select Id, Name, CampaignId__c From Campaign Where Id =: controller.getId()];
    }
	
	public void doHTTPCalltoContactology()
    {
    	try{
			Httprequest req = new Httprequest();
			//buildQueryString();
			IntegrationSettings__c intSettings = IntegrationSettings__c.getInstance('Contactology_getContact');
			req.setEndpoint(intSettings.Endpoint__c+'&key='+intSettings.API_Key__c+'&method=Campaign_Report&campaignId='+camp.CampaignId__c);
			req.setMethod('GET');
			
			Http ht = new Http();
			HttpResponse response = ht.send(req);
			//jsonResp = String.valueOf(response);
			jsonResp = response.getBody();
			
			crWrap = CampaignReportWrapper.parse(jsonResp);
		
		}catch(system.CallOutException ce)
		{
			system.debug(ce);
			errorFound = true;
		}
    }

}