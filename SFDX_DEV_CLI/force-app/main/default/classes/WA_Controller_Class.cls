public class WA_Controller_Class {

    @AuraEnabled (cacheable=true)
    public static Boolean sendWhatsappMessage(String contactId){
        try {
            // Contact[] contact = (Contact[])System.JSON.deserialize(contactJson, Contact[].class);
            Contact contact = [ Select Id,Phone,MobilePhone From Contact Where Id =: contactId];
            // Meta API End Point URL
            String EndPointUrl = 'https://graph.facebook.com/v13.0/108856261834252/messages';

            // if(!contact.isEmpty()){
               // for(Contact con : contact){
                    Http h = new Http();
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(EndPointUrl);
                    req.setHeader('Content-Type', 'application/json');
                    req.setMethod('POST');
    
                    JSONgenerator gen = JSON.createGenerator(false);
                    gen.writeStartObject();
                    gen.writeStringField('messaging_product','whatsapp');
                    gen.writeStringField('to',contact.MobilePhone);
                    gen.writeStringField('type','template');
                    gen.writeFieldName('template');
                        gen.writeStartObject();
                        gen.writeStringField('name', 'hello_world');
                        gen.writeFieldName('language');
                            gen.writeStartObject();
                            gen.writeStringField('code', 'en_US');
                            gen.writeEndObject();
                        gen.writeEndObject();
                    gen.writeEndObject();
    
                    String body = gen.getAsString();
                    system.debug('body' + body);
                    req.setBody(body);
    
                   String apiKEY= 'EABIZC6OO6kS0BAG4JZCN1fN7UifFPUvgZANjDwdZAKJVKUSepz3Y6d4n8wknU2BlyF3kyBBYvdKkCnDdyf7Rj44j1oZCJbBAlrcfG2Pt4jZBYggqj0rZBSG5GHC8SEeRIOTPSfDkkDIcMR94fxOvbpRPC3kGFZCt2RirCrlSlpOdBehQP8KNfPf6duo72EfhQCgpPx12LKFZCZAAZDZD';
    
                   req.setHeader('Authorization', 'Bearer '+apiKEY);
        
                 // Send the request, and return a response
                    HttpResponse res = h.send(req);
                    if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
                        System.debug('Success Message Result'+res.getBody());
                        return true;
                    }
                    else {
                        System.debug('Error Message Result'+res.getBody());
                        return false; 
                    }
                   
               // }
                
            //}
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
            //return false;
        }
    }

    /*
    public static void sendWhatsappMessage(String contactJson) {

        Contact[] contact = (Contact[])System.JSON.deserialize(contactJson, Contact[].class);
        if(!contact.isEmpty()){
            for(Contact con : contact){
                    try {

        Http h = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://graph.facebook.com/v13.0/108856261834252/messages');
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');

    JSONgenerator gen = JSON.createGenerator(false);
    gen.writeStartObject();
    gen.writeStringField('messaging_product','whatsapp');
    gen.writeStringField('to',con.MobilePhone);
    gen.writeStringField('type','template');
    gen.writeFieldName('template');
       gen.writeStartObject();
       gen.writeStringField('name', 'hello_world');
       gen.writeFieldName('language');
           gen.writeStartObject();
           gen.writeStringField('code', 'en_US');
           gen.writeEndObject();
       gen.writeEndObject();
    gen.writeEndObject();

    String body = gen.getAsString();
     system.debug('body' + body);
    req.setBody(body);

     String apiKEY= 'EABIZC6OO6kS0BAKAuDlQ4OdsRFwPCX2l3ASUiSGJdZCWnC956n0BxKdBM3YrZBZCyX1cgrQwKF7946VaNjxPkAU5v7ZAOj2Y4dyC5oNFRVJ10jvgA7CCJFVZCkyKr5ZAvWCNsj6vkd8cmZBColtZAIiOkOT1hA0oCpx7WCMQIgtfUVnrZCVJxoQeWDKZAPwgZC4iqunZAJOCF3OoAtwZDZD';

     req.setHeader('Authorization', 'Bearer '+apiKEY);
    
 // Send the request, and return a response
 HttpResponse res = h.send(req);

 System.debug('Message Result'+res.getBody());
    
     } catch (Exception e) {
         system.debug(e.getMessage());
        // throw new AuraHandledException(e.getMessage());
     }
            }
            
        }
    }

 */

}