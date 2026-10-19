import { LightningElement, track } from 'lwc';
import getOpportunities from '@salesforce/apex/OpportunitySummary.getOpportunities';//chama o nosso método do Apex
import {NavigationMixin} from 'lightning/navigation';

//monta uma constante com as colunas da tabela
const columns = [
                    {
                        label: 'ID da Oportunidade',
                        fieldName: 'Id',
                        type: 'text',
                        shorable: false
                    },
                    {
                        label: 'Nome da Oportunidade',
                        fieldName: 'Name',
                        type: 'text',
                        shorable: true
                    },
                ]

//Aqui é a nossa classe do JavaScript
export default class opportunitySummary extends NavigationMixin (LightningElement) {

    //aqui montamos as variáveis
    @track columns = columns; // colunas que vão aparecer na tabela
    @track data = []; // dados que vão aparecer na tabela
    @track rowOffset = 0;

    //toda vez que carregamos o componente ele executa automaticamente o que está dentro deste método
    connectedCallback(){
        this.findOpportunities();
    }
    //cria um método que irá chamar obackend e trazer as oportunidades para cá
    findOpportunities(){
        //aqui ele chama o método do Apex, e carrega os valores retornados
        getOpportunities({}).then((response)=>{
            console.log('response',response);
            this.data = response;
        })
    }

    //método de quando clica no botão
    executeNewSale(){
        console.log("clicou no botão");
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes:{
                apiName: 'Carrinho'
            }
        });
    }
}