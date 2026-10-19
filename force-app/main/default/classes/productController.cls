public with sharing class productController {

    //Ele vai listar todos os produtos
    //Retornar o total de produtos listados
    //Poder buscar pelo nome do produto
    //Buscar pela página que estamos
    @AuraEnabled(cacheable=true)
    public static pageResultWrapper getProducts(String filter, Integer pageNumber) {

        Integer pageSize = 9;
        String whereClausule = '';
        Integer offSet = (pageNumber-1)*pageSize;

        //List<PricebookEntry> pbrList = [SELECT Product2Id FROM PricebookEntry WHERE Pricebook2.IsStandard = true];
        //whereClausule = ' WHERE Id IN :pbeList ';
        whereClausule = ' WHERE Pricebook2.IsStandard = true';

        if(String.IsNotBlank(filter)){
            whereClausule += ' AND Product2.Name LIKE \'%' + filter + '%\'';
        }

        PageResultWrapper result = new PageResultWrapper();
        result.tamanhoDaPagina = pageSize;
        result.totalItems = Database.countQuery('SELECT count() FROM PricebookEntry '+ whereClausule);
        result.allDatas = Database.query('SELECT Product2.Id, Product2.Name, Product2.DisplayUrl, UnitPrice FROM PricebookEntry' + whereClausule + ' LIMIT :pageSize OFFSET :offset');

        return result;
    }
}