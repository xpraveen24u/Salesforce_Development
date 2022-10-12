public with sharing class FieldUpdater_handler {
    @AuraEnabled(cacheable=false)
    public static void fieldRecordUpdate(String record){
    String  acId = '001DE00002zKvlPYAS';
    List<Account> listAccount = new List<Account>();
     try {
       List<Account> accLists = [SELECT Id, Name, Record_String__c FROM Account WHERE Id =:acId];
        if(!accLists.isEmpty()){
         for(Account ac:accLists){
            ac.Record_String__c = record;
            listAccount.add(ac);
         } 
        }  
         update listAccount;
     } catch (Exception e) {
         throw new AuraHandledException(e.getMessage());
     }
    }
 }