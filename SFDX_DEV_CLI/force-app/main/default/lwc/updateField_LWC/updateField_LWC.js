import { LightningElement, wire } from 'lwc';
import fieldRecordUpdate from '@salesforce/apex/FieldUpdater_handler.fieldRecordUpdate';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class UpdateField_LWC extends LightningElement {
    name; 

    handle_Submit(event){
        // Refering to first method and passwing parameters.
       
        fieldRecordUpdate({ 
            record : this.name
        })
        .then(result => {
            const event = new ShowToastEvent({
                title: 'Account updated',
                message: ' Account Field Record Name '+ this.name +'  updated.',
                variant: 'success'
            });
            this.dispatchEvent(event);
        })
        .catch(error => {
            const event = new ShowToastEvent({
                title : 'Error',
                message : 'Error updating account. Please Contact System Admin',
                variant : 'error'
            });
            this.dispatchEvent(event);
        });
    }

}