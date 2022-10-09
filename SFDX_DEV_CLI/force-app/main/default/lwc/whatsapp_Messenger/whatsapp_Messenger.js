import { LightningElement, api } from 'lwc';
import sendWhatsappMessage from '@salesforce/apex/WA_Controller_Class.sendWhatsappMessage';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Whatsapp_Messenger extends LightningElement {

    @api recordId; //it contains current contact record id

    onSendTextTemplate() {
        //call apex method to send template message in whatsapp
        sendWhatsappMessage({ contactId: this.recordId })
            .then(result => {
                console.log("res:>" + JSON.stringify(result))

                //display toast message
                if (result == true) {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Sent',
                            message: 'Message Delivered On Contact WhatsApp',
                            variant: 'success',
                        }),
                    );

                } else {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error ',
                            message: 'Message Failed To Deliver',
                            variant: 'error',
                        }),
                    );

                }
            })
            .catch(error => {
                console.error("error:" + JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error ',
                        message: 'Message Failed To Deliver',
                        variant: 'error',
                    }),
                );
            })

    }
}