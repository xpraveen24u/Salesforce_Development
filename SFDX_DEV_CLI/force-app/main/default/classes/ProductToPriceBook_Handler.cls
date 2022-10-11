public class ProductToPriceBook_Handler 
{
    public static void  getmethod(list<Product2> pduct)
    {
    // Pricebook2 prb=[Select Id from Pricebook2 Where IsStandard = true];
   
    for(Product2 prod:pduct)
    {
          Pricebook2 StandardPricebook;
            Id StandardPricebookId;
            if(Test.isRunningTest()){
                StandardPricebookId = Test.getStandardPricebookId();
            }
            else{
                StandardPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = true Limit 1];
                StandardPricebookId = StandardPricebook.Id;
            }
            List<PricebookEntry> productPrice = [SELECT UnitPrice,Product2Id FROM PricebookEntry WHERE Product2Id = :prod.Id
                                                 And Pricebook2Id  =: StandardPricebookId]; 
            
            System.debug('ProductPrice ' +productPrice);
        if(prod.Price__c!=Null)
        {
           	PricebookEntry pricebook=new PricebookEntry();
        	pricebook.Product2Id=prod.Id;
            pricebook.pricebook2Id=StandardPricebookId;
      	    pricebook.unitprice=prod.Price__c;
            pricebook.IsActive=true;
       		//pricelist.add(pricebook);  
        }
    }
    }
   // update pricelist;

}