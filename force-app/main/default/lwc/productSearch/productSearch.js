import { LightningElement, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import {fireEvent, registerListener} from 'c/pubsub';

export default class productSearch extends LightningElement {

    @track accountId = null;
    @wire(CurrentPageReference) pageRef;

    connectedCallback(){
        //this.getAccount();
        registerListener('selectedAccount', this.getAccount, this);
    }

    getAccount(account){
        this.accountId = account;
        console.log('Selecionou o ID no componente dos produtos',this.accountId);
    }

    get getAccountID(){
        return this.accountId;
    }

    handleSearch(event){
        let filter = event.target.value;
        fireEvent(this.pageRef, 'filterChangeSearch', filter);
    }
}

