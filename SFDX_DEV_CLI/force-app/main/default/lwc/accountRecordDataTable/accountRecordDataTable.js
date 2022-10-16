import { LightningElement, track, wire } from 'lwc';
import accountRecordData from '@salesforce/apex/accountData.accountRecordData';

export default class AccountRecordDataTable extends LightningElement {
    @track columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Id', fieldName: 'Id' },
        { label: 'CreatedDate', fieldName: 'CreatedDate' }
             
    ];
    @track accountList;

    @wire(accountRecordData) wiredAccounts({ data, error }) {
        if (data) {
            console.log(data);
            this.accountList = data;
        } else if (error) {
            console.log(error);
        }
    }
}