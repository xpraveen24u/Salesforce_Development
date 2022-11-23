/*public with sharing class opportunityTabular {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunity(){
        try {
       
        List<Opportunity>  oppData = [SELECT Id,Status__c, Name,Discount__c,Calculate_Discount_Amount__c,Calculate_Total_Amount__c, account.name, (SELECT Contact.Name, ContactId FROM OpportunityContactRoles WHERE IsPrimary = TRUE),(SELECT Quantity, UnitPrice, TotalPrice, 
           PricebookEntry.Name FROM 
           OpportunityLineItems) FROM Opportunity WHERE Status__c = 'In progress'];
           
           return   oppData   ; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string dataMethod(Integer dic){
        try {
            return Null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}*/

public with sharing class opportunityTabular {
    @AuraEnabled(cacheable=true)
  public static List<Opportunity> getOpportunity(){
      try {
     
      List<Opportunity>  oppData = [SELECT Id, Name, Account.Name,(SELECT Contact.Name FROM OpportunityContactRoles WHERE IsPrimary = TRUE), List_Price__c	, Discount__c, Calculate_Discount_Amount__c, Calculate_Total_Amount__c 
      FROM Opportunity where Status__c= 'In Progress'  WITH SECURITY_ENFORCED];
         
         return   oppData   ; 
      } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
      }
  }
  @AuraEnabled (cacheable=false)
  public static string updateDiscountValue(Id recordOppId, Integer discount){
      try {
        if(recordOppId !=NULL && discount !=0){
            Opportunity opp = new Opportunity();
            opp.Id =  recordOppId;
            opp.Discount__c = discount;
            update opp;
            
        }
        return null;
      } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
      }
  }
}