// DESAFIO: Criar uma API que consulta as contas, onde posso pesquisar uma conta pelo nome. Na mesma classe de API criar um POST que receba os dados básicos e inclua a conta, podendo retornar apenas um OK no JSON
//** Post recebe um whapper com os campos em português

@RestResource(urlMapping='/AulaDeApex/Accounts/*')
global with sharing class AccountAPI {

    // GET - Consulta contas pelo nome
    @HttpGet
    global static List<Account> getAccounts() {
        List<Account> accountList = new List<Account> ();
        String asParamStr = RestContext.request.requestURI.substring (RestContext.request.requestURI.lastIndexOf('/')+1); // aqui eu vejo se a URI do ger tem parametro
        String nomeConta = String.isNotBlank(asParamStr) ? RestContext.request.params.get('name') : '';
        
        if(String.isNotBlank(nomeConta)){
            String likeValue = '%' + nomeConta + '%';
            accountList = [SELECT Id, Name FROM Account WHERE Name LIKE: likeValue];
        }else{
            accountList = [SELECT Id, Name FROM Account];
        }
        system.debug('nomeConta' +nomeConta);

        return accountList;
    }

    @HttpPost
    global static List<String> createAccount(List<Account> accountList){

        List<String> returnList = new List<String>{'Ok'};
        List<Account> insertList = new List<Account>();

        for(Account cTemp : accountList){
            Account acctObj = new Account();
            acctObj.Name = cTemp.Name;

            insertList.add(acctObj);
        }

        if(insertList.size() > 0){
            insert insertList;
        }

        return returnList;
    }
}