trigger ageContact on Contact (after insert) {
// My preference for aggregating related record Ids is to use a Set<Id>
//    instead of a List<Id>. This will make it easier to remove nulls.
Set<Id> accountIds = new Set<Id>();
List<Account> accountsToUpdate = new List<Account>();

for(Contact con :Trigger.new){
    accountIds.add(con.AccountId);
}

// It will cause issues later (when we update) if we have a null in this set. 
// This ensures we will not have a null value in the set.
// This can be accomplished in other ways (such as using an `if` block in the loop above), 
//    but I believe this to be the fastest.
accountIds.remove(null);

for(AggregateResult ar :[SELECT AccountId, MAX(contactAgeScore__c) maxScore
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId]){

    // We can set the Id of an sObject if we pass it into that sObject's constructor.
    // This is a common pattern used for updating records of related sObjects,
    //    and saves us from needing to write another query
    accountsToUpdate.add(new Account(
        Id = (Id)ar.get('AccountId'),
        // When fetching an aggregated field, it comes back as an instance of Object.
        // Thus, it's required to cast the result. Number field type = Decimal
        ageScore__c = (Decimal)ar.get('maxScore')
    ));
}

update accountsToUpdate;
}