import { LightningElement, api } from 'lwc';

export default class productListItemsCard extends LightningElement {
    _product;

    @api
    get product() {
        return this._product;
    }

    set product(value) {
        if (!value || !value.Product2) {
            this._product = undefined;
            return;
        }

        const image = value.Product2.DisplayUrl
            ? value.Product2.DisplayUrl
            : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/330px-No_image_available.svg.png';

        this._product = {
            id: value.Product2.Id,
            nome: value.Product2.Name,
            preco: value.UnitPrice,
            imagem: image
        };
    }
    handleProductSelected(){
        const productSelected = new CustomEvent("selected", {
            detail: JSON.stringify(this._product),
        });
        console.log('Esta disparando o evento no componente filho');
        this.dispatchEvent(productSelected);
    }
}
