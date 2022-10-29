public with sharing class countRecordAccount {
    @AuraEnabled(cacheable = false)
    public static Integer countAccount(){
        try {
          Integer acc = [SELECT COUNT() FROM Account]  ;
            system.debug('acc' +acc);
          return acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}