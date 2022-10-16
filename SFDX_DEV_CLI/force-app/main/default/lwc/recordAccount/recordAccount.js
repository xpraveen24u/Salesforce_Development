import { LightningElement ,wire,track} from 'lwc';
import countAccount from  '@salesforce/apex/countRecordAccount.countAccount';
export default class RecordAccount extends LightningElement {
    @track countAcc;
    @track error;
   

    handleload() {
        countAccount()
            .then(result => {
                console.log(result);
                this.countAcc = result;
            })
            .catch(error => {
                console.log(error);
                this.error = error;
        })
    }

   
}