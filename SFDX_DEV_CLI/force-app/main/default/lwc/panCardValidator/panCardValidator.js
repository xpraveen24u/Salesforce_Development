import { LightningElement } from 'lwc';
const api_URL = "https://pan-card-verification1.p.rapidapi.com/v3/tasks/sync/verify_with_source/ind_pan";
const api_HOST = "pan-card-verification1.p.rapidapi.com";
export default class PanCardValidator extends LightningElement {
    pancard;
    user = {};
    panCardNumber(event) {
        this.pancard = event.target.value;
    }

    get userPopulated() {
        return this.user && this.user.pancardNumber;
    }

    getPanCardDetails() {
        if (this.pancard) {
            const options = {
                method: 'POST',
                headers: {
                    'content-type': 'application/json',
                    'X-RapidAPI-Key': '62ee7f99f9msh725188ad41303d6p12f54cjsncffa77c40ab6',
                    'X-RapidAPI-Host': api_HOST
                },
                body: '{"task_id":"74f4c926-250c-43ca-9c53-453e87ceacd1","group_id":"8e16424a-58fc-4ba4-ab20-5bc8e7c3c41e","data":{"id_number":"'+this.pancard+'"}}'
            };
           
            fetch(api_URL, options)
                .then(response => {
                    if (response.status == "completed") {
                        console.log(response);
                        return response.json();  
                    } else {
                        throw Error(response);
                  }
                })
                .then(panCardData => {
                    console.log(panCardData.result.source_output.id_number);
                    this.user = {
                        pancardNumber: panCardData.result.source_output.id_number,
                        nameOnCard: panCardData.result.source_output.name_on_card,
                        firstName: panCardData.result.source_output.first_name,
                        lastName: panCardData.result.source_output.last_name,
                        status: panCardData.result.source_output.status,
                        aadharSeed: panCardData.result.source_output.aadhaar_seeding_status
                    };
                })
                .catch(error => console.log(error));  
        } else {
            alert("Please specify a Pan Card number");
        }
        
    }
}