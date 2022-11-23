/* import { LightningElement, wire,api ,track } from 'lwc';
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
    @track oppData =[];
    

    @wire(getOpportunity) oppRecords({ data, error }) {
        if (data) {
            let opportunityArray = [];
            data.forEach(item => {
            let item_price =    item.hasOwnProperty('OpportunityLineItems') ?  item.OpportunityLineItems[0].TotalPrice : 0
            let  oppReadyData  = 
                  {
                    "Name": item.Name,
                    "accountName": item.Account.Name,
                    "contactName": item.hasOwnProperty('OpportunityContactRoles') ? item.OpportunityContactRoles[0].Contact.Name : '',
                    "List_Price": item_price,
                    "Discount": item.Discount__c,
                    "Discount_Amount": (item.Discount__c) ? item_price * (item.Discount__c / 100) : 0,
                    "Total_Amount":(item_price * (item.Discount__c / 100) )? (item_price) - (item_price * (item.Discount__c / 100)) : item_price

                };
                opportunityArray.push(oppReadyData);   
            });
             this.oppData = opportunityArray;
        } else if (error) {
            console.log(error);
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
            await refreshApex(this.oppData);
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
  

}*/

import { LightningElement,wire, api, track } from 'lwc';
import getOpportunity from '@salesforce/apex/opportunityTabular.getOpportunity'; 
import updateDiscountValue from '@salesforce/apex/opportunityTabular.updateDiscountValue'; 
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class DataTableTabular extends LightningElement {
    @api recordOppId;
    @api accountId;
    @api OpportunityContactRoles;
    @track opportunities;
    @track error;
    @track discount;
    @track discountAmount;
    @track totalAmount;
    objectOpportunity={'sObjecttype': 'Opportunity'}

    updateDiscount(event){
        let  oppIdData = event.target.id;
        let OppId = oppIdData.split("-");
        this.recordOppId = OppId[0];
        this.discount = event.target.value;
    }
    connectedCallback(){
        this.loadData();
    }

    @api
    loadData() {
       
        getOpportunity({
            
            accountId: this.accountId,
            OpportunityContactRoles: this.OpportunityContactRoles
        })
        .then(result => {
            this.opportunities = result;
        })
        .catch(error => {
            this.error = error.message;
        })
    }
  

     handleSubmit(event){
        updateDiscountValue({ 

            recordOppId : this.recordOppId,
            discount :   this.discount
          
        })
        .then(result => {
            const event = new ShowToastEvent({
                  title: 'Success',
                    message: 'Opportunity updated',
                    variant: 'success'
                
            });
            this.dispatchEvent(event);
            window.location.reload();
        })
        .catch(error => {
            const event = new ShowToastEvent({
                title: 'Error updating or reloading opportunity',
                message: error.body.message,
                variant: 'error'
            });
            this.dispatchEvent(event);
        });
    }

     /* handleDiscount(event){
          this.discount = event.target.value;
          this.discountAmount = (this.discount/100) * this.opportunities.TotalPrice;
          this.totalAmount = this.opportunities.TotalPrice - this.discountAmount;
        //   this.objectOpportunity.Discount__c = this.template.querySelector('Lightning-Input[data-formfield="Discount"]').value;
        //   console.log('Input----'+this.objectOpportunity.Discount__c);
        //   dataMethod({dic:this.objectOpportunity,Name:this.opportunities})
        //   .then(result=> {
            
        //   })
        //   .catch(error=>{

        //   })
          
      }*/



    /*async handleSave(event) {
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
            await refreshApex(this.opportunities);
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or reloading opportunity',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
    }*/
}