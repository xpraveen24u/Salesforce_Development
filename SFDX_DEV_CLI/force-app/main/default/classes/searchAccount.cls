public with sharing class searchAccount {
    @AuraEnabled(Cacheable = true)
    public static List<Account> getAccountWithName(String searchTerm){
        try {
        //    if(searchName!=NULL){
            System.debug('searchName' +searchTerm);
            List<Account> accList = [ SELECT Id,Name, (SELECT Id,Name FROM Contacts) FROM Account WHERE Name = :searchTerm WITH SECURITY_ENFORCED];
            return accList;
        //    } 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}