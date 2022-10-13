trigger opportunityAccountCheck on Opportunity(after insert, after update){
    List<Id> accId = new List<Id>();
    List <Opportunity> oppAcc = new List<Opportunity> ();
    for (Opportunity opp : Trigger.New) {
        accId.add(opp.AccountId);
    }
    if(!accId.isEmpty()){
      oppAcc = [SELECT Id,Name FROM Opportunity  WHERE AccountId In:accId];
      if(!oppAcc.isEmpty() && oppAcc.size()>=5){
        Trigger.New[0].addError('Opportunity will not created with account more than 5 opportunities');
      }
    }
}