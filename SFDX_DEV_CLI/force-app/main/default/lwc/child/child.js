import { LightningElement } from 'lwc';

export default class Child extends LightningElement {
    handleChange(event){
        event.preventDefault();
        const name = event.target.value;
        const selectEvent = new CustomEvent('mycustomevent',{detail:name});
        this.dispatchEvent(selectEvent);
    }
}