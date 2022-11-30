import { LightningElement,api,track } from 'lwc';

export default class ContactDependUponAccountChild extends LightningElement {
    @track contactName;
    @track phoneNumber;
    @api
    changeContact(contactData) {
         this.phoneNumber = contactData.phoneNumber;
         this.contactName = contactData.contactName;
    } 
}