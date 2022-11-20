trigger checkAccountContact on Contact (after insert) {
    List<Id> conIDs = new List <Id>();
    List<Contact> consList =  new List<Contact>();
    List<String> conLastName = new List <String>();
    for(Contact con:trigger.new){
      conIDs.add(con.Id);
        if(con.AccountId == NULL){
         conLastName.add(con.LastName);   
        }
        
    }
    
     if(!conLastName.isEmpty()){
     List<Account> accRecord = [SELECT Id, Name FROM Account WHERE Name In :(conLastName)]; 
        if(!accRecord.isEmpty()){
            for(Account ac :accRecord){
                Contact conta = new Contact();
           conta.Id = conIDs[0];
           conta.AccountId = ac.Id; 
            consList.add(conta); 
            }
            update  consList;
    }
    } 
   
}