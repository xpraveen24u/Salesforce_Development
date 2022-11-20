import { LightningElement, wire,api  } from 'lwc';
import getOpportunity from '@salesforce/apex/opportunityTabular.getOpportunity'; 
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const COLS = [
    {
        label: 'Opportunity Name',
        fieldName: 'Name',
        editable: false
    },
    {
        label: 'Account Name',
        fieldName: 'accountName',
        editable: false
    },
    {
        label: 'Primary Contact',
        fieldName: 'contactName',
        editable: false
    },
    {
        label: 'List Price',
        fieldName: 'List_Price',
        type: 'currency',
        editable: false
    },
    {
        label: 'Discount %',
        fieldName: 'Discount',
        type: 'number',
        editable: true
    },
    {
        label: 'Discount Amount',
        fieldName: 'Discount_Amount',
        type: 'currency',
        editable: false
    },
    {
        label: 'Total Amount',
        fieldName: 'Total_Amount',
        type: 'currency',
        editable: false
    },

];
export default class OpportunityTabular extends LightningElement {
    @api recordId;
    columns = COLS;
    draftValues = [];
    data = [];
    prepareData = {};
    

    @wire(getOpportunity) oppRecords({ data, error }) {
        if (data) {
            console.log(data);
            // console.log(data.Name);
            data.forEach(item => {
                // console.log(item);
                // console.log(item.Name);
                // console.log(item.Account);
           
            let prepareData = {
                    Name: item.Name,
                    accountName: item.Account.Name,
                    contactName: item.OpportunityContactRoles[0].Contact.Name,
                    List_Price: item.OpportunityLineItems[0].TotalPrice,
                    Discount: item.Discount__c,
                    Discount_Amount: item.OpportunityLineItems[0].TotalPrice * (item.Discount__c / 100),
                    Total_Amount: (item.OpportunityLineItems[0].TotalPrice) - (item.OpportunityLineItems[0].TotalPrice * (item.Discount__c / 100))

                }
                console.log(prepareData);
                
               
            
            });
            console.log(prepareData);
            this.data = prepareData;
        } else if (error) {
            
        }
    };
         
    
    async handleSave(event) {
        // Convert datatable draft values into record objects
        const records = event.detail.draftValues.slice().map((draftValue) => {
            const fields = Object.assign({}, draftValue);
            return { fields };
        });

        // Clear all datatable draft values
        this.draftValues = [];

        try {
            // Update all records in parallel thanks to the UI API
            const recordUpdatePromises = records.map((record) =>
                updateRecord(record)
            );
            await Promise.all(recordUpdatePromises);

            // Report success with a toast
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Opportunity updated',
                    variant: 'success'
                })
            );

            // Display fresh data in the datatable
            await refreshApex(this.oppRecords);
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or reloading opportunity',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
    }
  

}