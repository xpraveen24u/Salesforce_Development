trigger TotalEstimatePrice on Contact (after insert,after update,after delete) 
{
    list<Account> acclist=new list<Account>();
	set<id> setid=new set<id>();

	if(trigger.isafter)
	{
	   if(trigger.isinsert || trigger.isupdate)
		{
			for(Contact con:trigger.new)
			{
				setid.add(con.AccountId);
			}
		}
	}
		if(trigger.isafter)
		{
			if(trigger.isdelete)
			{
				for(Contact con:trigger.old)
				{
					setid.add(con.AccountId);
				}
			}
		}

	list<Account> aclist=[Select id,Total_Price_c,(Select id,Estimated_Price_c from Contacts)from Account where id=:setid];
	for(Account a:aclist)
	{
		Decimal TotalPrice=0;
		list<Contact> cont=a.contacts;
		list<Double> db=new list<Double>();

		for(Contact co:cont)
		{
			TotalPrice=TotalPrice+co.Estimated_Price__c;
			db.add(co.Estimated_Price__c);
		}
		db.sort();
		a.Total_Price__c=TotalPrice;
	}
 	update acclist;
}