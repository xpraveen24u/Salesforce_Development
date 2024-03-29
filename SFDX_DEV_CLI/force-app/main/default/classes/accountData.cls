public with sharing class accountData {
    @AuraEnabled(cacheable=true)
    public static List<Account> accountRecordData(){
        try {
            List<Account> accData = [SELECT Id,Name,CreatedDate,Ongoing_Status__c  FROM Account];
            return accData; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
}