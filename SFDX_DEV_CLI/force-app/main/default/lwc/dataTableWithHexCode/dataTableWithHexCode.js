import { LightningElement, track,wire } from 'lwc';
import accountRecordData from '@salesforce/apex/accountData.accountRecordData';
export default class DataTableWithHexCode extends LightningElement {
    @track accountList;

    @wire(accountRecordData) wiredAccounts({ data, error }) {
        if (data) {
            data = data.map((item) => ({
                ...item,
                successCircle   :item.Ongoing_Status__c === "Condition Expected to produce future high cost claims",
                processingCircle   :item.Ongoing_Status__c === "Conditioned to be monitored future claims cost dependent on presence of complications",
                errorCircle   :item.Ongoing_Status__c === "Condition not expected to produce future high cost claims",
              }));
            console.log(data);
            this.accountList = data;
        } else if (error) {
            console.log(error);
        }
    }
}