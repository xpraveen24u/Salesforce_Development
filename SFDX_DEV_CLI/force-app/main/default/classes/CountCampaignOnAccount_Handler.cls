

/*8.	Create following fields on account – 

a. Number of campaign members
b. Number of campaigns
Standard Relationship - Campaign Member -> Contact -> Account.
Campaign Member - Standard fields -> ContactId, CampaignId.
Whenever a campaign member is created, update the count on account level
*/

public with sharing class CountCampaignOnAccount_Handler {
   
  public Static void CampaignOnAccount(list<CampaignMember> camp,list<CampaignMember> cap)
    {
       /* set<Id> cid = new set<Id>();
        Map<id,Account> amap = new Map<id,Account>();
        list<Account> updateacclist = new list<Account>();
        for(CampaignMember cm : trigger.isDelete? cap:camp)
        {
            cid.add(cm.ContactId);
        }
        list<Account> acclist =[Select id From Account];
         for(Account a : acclist)
        {
           // amap.put(a.ContactId,a);
        }*/  
       list<Account> acclist=new list<Account>();
        set<id> setid=new set<id>();
        if(trigger.isafter)
        {
            if(trigger.isinsert || trigger.isupdate)
            {
                for(CampaignMember cam:camp)
                {
                    setid.add(cam.ContactId);
                }
            }
        }
        if(trigger.isafter)
        {
            if(trigger.isdelete)
            {
                for(CampaignMember cam:cap)
                {
                    setid.add(cam.ContactId);
                }
            }
        }
        //Number_of_campaign_members__c
        for(AggregateResult aggr:[SELECT ContactId,Count(Id)amt, Count(CampaignId)amt1 FROM CampaignMember WHERE ContactId=:setid GROUP BY ContactId])
        {
            acclist.add(new Account(Id = (Id)aggr.get('AccountId'), Number_of_campaigns__c = (Decimal)aggr.get('amt')));
            acclist.add(new Account(Id = (Id)aggr.get('AccountId'), Number_of_campaign_members__c = (Decimal)aggr.get('amt1')));
            
        }
        update acclist;
       
    }
    
}