trigger oppRecord on Opportunity (after insert) {
    List<Id> oppAccIds = new List<Id> ();
    List<Id> oppIds = new List<Id> ();
    List<Account> accUpdate = new List<Account> ();
    for(Opportunity opp : trigger.new){
         oppAccIds.add(opp.AccountId);  
         oppIds.add(opp.Id);
    }
    
    List<Account> acc = [SELECT Id,Name, Total_Amount__c,Total_Opportunity__c FROM Account WHERE Id In:(oppAccIds)];
    Decimal totalOpp = [SELECT count() FROM Opportunity];
    List<Opportunity> totalOppAmount = [SELECT Id,Amount FROM Opportunity];
    Decimal Sum = 0;
    for(Opportunity opt : totalOppAmount){
       sum = sum + opt.Amount; 
    }
    
    
    if(totalOpp != null && Sum!= null){
       for (Account ac : acc)  {
            Account acct = new Account();
            acct.Id = ac.Id;
            acct.Total_Amount__c = Sum;
            acct.Total_Opportunity__c = totalOpp;
            
            accUpdate.add(acct);     
        } 
        
        update accUpdate ;
    }
       
    
}