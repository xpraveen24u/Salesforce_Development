import { LightningElement, track } from 'lwc';
import convertToBase64 from '@salesforce/apex/ExchangeController.convertToBase64';

export default class Upiqrcode extends LightningElement {
    @track
    srcData="";
    @track
    amount=""
    
    @track
    upiId=""
    @track
    validateBtnState=true;
    connectedCallback(){
        this.handleCLick();
         this.convert();
    }
    
    handleAmountChange(event) {
        // console.log('event' +event);
        this.amount=event.target.value;
        this.updateButtonState();
    }
    handleUPIIDChange(event){
        this.upiId=event.target.value;
        this.updateButtonState();
    }
    updateButtonState(){ 
        // alert(this.upiId);
        this.validateBtnState=! ( (this.amount.length>0) && (this.upiId.length>0) ) ;
    }
    convert(myData){
        convertToBase64({ss: myData}).then((data) => {
            //alert('BASE64: ' + data);
            console.log(JSON.stringify(data));
            this.srcData="data:image/svg+xml;base64,"+data;
            // base64Data=JSON.stringify(data);
        }).catch((error) => {
            alert('BASE64: errrr' + error.message);
        });
    }
    handleCLick(){
        // fetch("https://upiqr.in/api/qr?name=SantanuSinha&vpa="+this.upiId+ "&amount="+this.amount)
        //  .then(response => {
        //      console.log(response);
        //     return response.text();
        // })
        //  .then(svg => {
        //     // alert(svg);
        //     this.convert(svg);
        // }).catch((errr)=>{
        //     alert(errr);
        // })
        var myHeaders = new Headers();
myHeaders.append("Authorization", "Bearer {{User-Access-Token}}");

var requestOptions = {
  method: 'GET',
  headers: myHeaders,
  redirect: 'follow'
};

fetch("https://upiqr.in/api/qr?name=Praveen Prajapati&vpa=9559138563@paytm", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));


    }

}