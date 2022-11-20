public with sharing class opportunityTabular {
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
}
