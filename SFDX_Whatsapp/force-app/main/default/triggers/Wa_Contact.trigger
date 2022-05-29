trigger Wa_Contact on Contact (after insert) {
    // List<Id> contactIds = new List<Id>();
    List<Contact> contact = new List<Contact>();


        // Contact[] cons = [SELECT Id,Name FROM Contact WHERE Id IN :Trigger.new];

        for(Contact cont : Trigger.New){
           contact.add(cont);
         }
        String contactjson = JSON.serialize(contact);

      //  WA_Controller_Class.sendWhatsappMessage(contactjson);              

    
}