import { LightningElement ,wire,api,track} from 'lwc';
import getAccountWithName  from '@salesforce/apex/searchAccount.getAccountWithName';
export default class ContactDependUponAccount extends LightningElement {
    accountName;
    accountData;
    contact;
    phone;
    contactRecord = {};

    handleAccount(event){
        this.accountName = event.target.value;
    }

    @wire (getAccountWithName,{searchTerm: '$accountName'})
    retrieveAccount({data,error}){
        if(data){
            this.accountData = data;
        }

    }

    handleContact(event){
     this.contact = event.target.value;
    }

    handlePhone(event){
        this.phone = event.target.value;
    }

    handleSubmit(event) {
        this.contactRecord = {
            contactName: this.contact,
            phoneNumber : this.phone
        }
        this.template.querySelector('c-contact-Depend-Upon-Account-Child').changeContact(this.contactRecord);
    }
    
}