public with sharing class countRecordAccount {
    @AuraEnabled(cacheable = false)
    public static Integer countAccount(){
        try {
          Integer acc = [SELECT count() FROM Account]  ;
          return acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}