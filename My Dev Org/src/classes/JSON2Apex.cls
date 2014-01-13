public class JSON2Apex {
	public List<StatusHistory> statusHistory					{ get;private set; }
	public List<ClickHistory> clickHistory						{ get;private set; }
	public List<OpenHistory> openHistory						{ get;private set; }
	public List<SendHistory> sendHistory						{ get;private set; }
	public List<SubscriptionHistory> subscriptionHistory		{ get;private set; }
	public List<CustomFieldHistory> customFieldHistory			{ get;private set; }
	public List<BounceHistory> bounceHistory					{ get;private set; }
	
	public class StatusHistory {
		public String shDate			{ get;private set; }//2013-12-31 19:10:47	
		public String historyType		{ get;private set; }	//status
		public String address_id		{ get;private set; }	//2
		public String email				{ get;private set; }	//rose@edge.co	
		public String previous_value	{ get;private set; }	//Active
		public String new_value			{ get;private set; }	//Bounced
	}
	
	public class CustomFieldHistory
	{
		
	}
	
	public class OpenHistory
	{
		
	}
	
	public class ClickHistory
	{
		
	}
	
	public class SubscriptionHistory {
		public String subHDate					{ get;private set; }
		public String historyType				{ get;private set; }
		public String address_id				{ get;private set; }	
		public String email						{ get;private set; }
		public String list_id					{ get;private set; }
		public String list_name					{ get;private set; }
		public String subscription_action		{ get;private set; }
		public String group_id					{ get;private set; }
		public String group_name				{ get;private set; }
	}

	public class SendHistory {
		public String sendHDate			{ get;private set; }
		public String historyType		{ get;private set; }
		public String address_id;
		public String email				{ get;private set; }
		public String campaign_id;
		public String campaign_name		{ get;private set; }
	}
	
	public class BounceHistory {
		public String bDate				{ get;private set; }	//2013-12-31 19:10:47
		public String historyType		{ get;private set; }	//bounce
		public String address_id;	//2
		public String email				{ get;private set; }	//rose@edge.com
		public String campaign_id;	//12
		public String campaign_name		{ get;private set; }	//First Recurring Campaign
	}

	
	public static JSON2Apex parse(String json) {
		return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
	}
	
	/*@isTest
	static void testParse() {
		String json = '{\"statusHistory\":[],\"clickHistory\":[],\"openHistory\":[],\"sendHistory\":[{\"date\":\"2014-01-01 19:10:22\",\"historyType\":\"send\",\"address_id\":\"12\",\"email\":\"barr_tim@grandhotels.com\",\"campaign_id\":\"16\",\"campaign_name\":\"First Recurring Campaign\"},{\"date\":\"2013-12-31 19:10:46\",\"historyType\":\"send\",\"address_id\":\"12\",\"email\":\"barr_tim@grandhotels.com\",\"campaign_id\":\"12\",\"campaign_name\":\"First Recurring Campaign\"}],\"subscriptionHistory\":[{\"date\":\"2013-12-18 15:52:18\",\"historyType\":\"subscription\",\"address_id\":\"12\",\"email\":\"barr_tim@grandhotels.com\",\"list_id\":\"6\",\"list_name\":\"My SF Org Contacts\",\"subscription_action\":\"SUBSCRIBED\"},{\"date\":\"2013-12-18 15:52:18\",\"historyType\":\"subscription\",\"address_id\":\"12\",\"email\":\"barr_tim@grandhotels.com\",\"group_id\":\"4\",\"group_name\":\"SF Users Only\",\"subscription_action\":\"Added to \"}],\"customFieldHistory\":[],\"bounceHistory\":[]}';
		JSON2Apex obj = parse(json);
		System.assert(obj != null);
	}*/
}