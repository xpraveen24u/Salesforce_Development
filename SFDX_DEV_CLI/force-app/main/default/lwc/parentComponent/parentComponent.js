import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    handleChangeEvent(event){
        this.template.querySelector('c-child-Component').changeMessage(event.target.value);
    }
}