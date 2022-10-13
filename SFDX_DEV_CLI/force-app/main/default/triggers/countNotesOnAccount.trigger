trigger countNotesOnAccount on Account (before insert,before update) {
    List<Id> accIds = new List<Id> ();
    List<Account> accList = Trigger.New;
    Map<Id,Integer> mapN = new Map<Id,Integer> ();
    for (Account acc : Trigger.New) {
        accIds.add(acc.Id);
    }
    if(!accIds.isEmpty() && accIds.size()>0){
        List<ContentDocumentLink> cdls = [SELECT LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId In :accIds];
        Integer ad = 0;
        for (ContentDocumentLink cd : cdls) {
            ad = ad+1;
            mapN.put(cd.LinkedEntityId, ad);
        }   
        for (Id abc : mapN.keySet()) {    
            Trigger.newMap.get(abc).Attachement_Count__c = mapN.get(abc);
        }

    }
}