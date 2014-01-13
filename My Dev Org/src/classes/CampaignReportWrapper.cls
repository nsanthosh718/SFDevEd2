public class CampaignReportWrapper{
	public String TotalSent					{ get;private set; }	//16
	public String TotalUnsubscribed;	//0
	public String TotalFailed				{ get;private set; }	//16
	public String TotalOpened				{ get;private set; }	//0
	public String PercentFailed				{ get;private set; }	//100.000
	public String TotalDelivered			{ get;private set; }	//0
	public String PercentOpened				{ get;private set; }	//0.000
	public String PercentUnsubscribed;	//0.000
	public String TotalClickedThru;	//0
	public String TotalHTMLClickedThru;	//0
	public String TotalTextClickedThru;	//0
	public String TotalUniqueClickedThru;	//0
	public String TotalUniqueHTMLClickedThru;	//0
	public String TotalUniqueTextClickedThru;	//0
	public String TotalUniqueOpened;	//0
	public String PercentClickedThru;	//0.000
	public String TotalReplied				{ get;private set; }	//0
	public String TotalUniqueReplied;	//0
	public String PercentReplied			{ get;private set; }	//0.000
	public String TotalSubscribed;	//0
	public String TotalForwarded;	//0
	public cls_ClickThrus[] ClickThrus;
	public String TotalHardBounce			{ get;private set; }	//5
	public String TotalSoftBounce			{ get;private set; }	//11
	public String TotalSpam;	//0
	public String PossibleSpam;	//0
	public String PercentSpam;	//0.000
	public String TotalUnopened;	//0
	public String PercentUnopened;	//0.000
	public String TotalUnsent				{ get;private set; }	//0
	public String PercentHardBounce			{ get;private set; }	//31.250
	public String PercentSoftBounce			{ get;private set; }	//68.750
	public String TotalNoClickedThru;	//0
	public String PercentNoClickedThru;	//100.000
	public String PercentClickOpenRatio;	//0.000
	public String TotalSocialShareViews;	//0
	public String TotalSocialShareShares;	//0
	public cls_SocialShareClicksByService SocialShareClicksByService;
	public String Created					{ get;private set; }	//2013-12-31 19:10:46
	public String Modified					{ get;private set; }	//2014-01-03 13:12:24
	public String Name;	//First Recurring Campaign
	public String Description;	//
	public String StartTime;	//2013-12-31 19:10:46
	public String Subject;	//This is first recurring Campaign{EC:TitleTag}
	public String SenderEmail;	//snellutla@acumensolutions.com
	public String SenderAlias;	//Personal : {Id}
	public String Timezone;	//US/Eastern
	public String HTML;	
	public String RawText;	//
	public cls_Lists[] Lists;
	class cls_ClickThrus {
	}
	class cls_SocialShareClicksByService {
	}
	class cls_Lists {
		public String list_name;	//Search Results
	}
	public static CampaignReportWrapper parse(String json){
		return (CampaignReportWrapper) System.JSON.deserialize(json, CampaignReportWrapper.class);
	}

	
}