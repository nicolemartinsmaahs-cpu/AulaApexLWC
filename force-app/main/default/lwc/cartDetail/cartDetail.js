import { LightningElement, wire, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent, registerListener } from 'c/pubsub';

export default class CartDetail extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    @track accountId = null;
    @track products = [];
    @track amountTotal = 0;
    @track opportunityName = null;
    @track opportunityDate = null;
    @track isShowModal = false;

    connectedCallback(){
        registerListener('selectedProduct', this.handleProductSelected, this);
        registerListener('selectedAccount', this.getAccount, this);
    }
    
    getAccount(account) {
        this.accountId = account;
    }

    get getAccountId() {
        return this.accountId;
    }

    handleProductSelected(product){
        console.log('Capturou o produto', product);
        let newProduct = {...JSON.parse(product)}
        console.log('Aqui está o produto parseado', newProduct);
        console.log('Aqui está o preço', newProduct.preco);

        if(!this.hasProductInList(newProduct)){
            this.products.push({...newProduct, quantidade:1});
        }else{
            this.getProductFromList(newProduct).quantidade++;
        }

        this.calculateTotal();
    }

    //verifica se a coleção contém um produto selecionado
    hasProductInList(product){
        return this.products.filter((prodParam) => prodParam.id === product.id).length > 0;
    }

    getProductFromList(product){
        return this.products.find((prodParam) => prodParam.id === product.id);
    }

    calculateTotal(){
        this.amountTotal = this.products.reduce((total, prodParam) => (total += prodParam.quantidade * prodParam.preco), 0);
    }

    handleProductPrice(event){
        let selectedItem = event.currentTarget.ariaRowIndex;
        this.products[selectedItem].preco = event.currentTarget.value;
        this.calculateTotal();
    }

    handleQuantityPrice(event){
        let selectedItem = event.currentTarget.ariaRowIndex;
        this.products[selectedItem].quantidade = event.currentTarget.value;
        this.calculateTotal();
    }

    handleOppName(event){
        this.opportunityName = event.currentTarget.value;
    }

    handleOppDate(event){
        this.opportunityDate = event.currentTarget.value;
    }

    get getIsEnabledSave() {
        return this.opportunityDate != null && this.opportunityName != null && this.accountId != null;
    }  

    openModal(){
        this.isShowModal = true;
    }

    get getOpenModal(){
        return this.isShowModal;
    }
}