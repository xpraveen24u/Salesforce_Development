/*
	 * Test Class of Sf object 
	 *  
	 */

	@IsTest
	public class ProductTestClass {

		public static testMethod void testclass1(){
			Id standard = Test.getStandardPricebookId();
		
			
			Product2 p = new Product2(Name = 'Test',isActive = true, ProductCode = '123',Price__c=123.00 );
			insert p;
		
			PricebookEntry pricebook = new PricebookEntry();
			pricebook.pricebook2Id = standard;
			pricebook.product2id = p.id;
			pricebook.unitprice = 1249.0;
			pricebook.isactive = true;
			insert pricebook;
			
		}
		
	}