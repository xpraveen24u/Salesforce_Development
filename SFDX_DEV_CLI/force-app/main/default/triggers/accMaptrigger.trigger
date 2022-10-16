trigger accMaptrigger on Account (after insert,after update) {
    List<Id> accountIds = new List<Id> ();
    Map<Id,List<Contact>> acMap = new Map<Id,List<Contact>>();
for (Account acc : Trigger.new) {
    accountIds.add(acc.Id);
}
if(!accountIds.isEmpty()){
    // List<Contact> conList = [SELECT Id ,FirstName FROM Contact WHERE AccountId In:accountIds];
 List<Account> accList =   [SELECT Id, (SELECT Id, Name FROM Contacts) FROM Account where Id In :accountIds];
    if(!accList.isEmpty()){
        for (Account act : accList) {
            acMap.put(act.Id,new List<Contact> {act.Contacts});
           
        }
     System.debug('acMap' +acMap);
    }
}
}