//NOME DA CLASSE
public with sharing class ClasseDemonstraEstrutura {//INÍCIO DA CLASSE
    
    // MÉTODO DA CLASSE, UMA CLASSE PODE TER VÁRIOS MÉTODOS
    public static boolean nomeDoMetodo(){//INÍCIO DO MÉTODO

        // TIPO VARIAVEL | NOME VARIAVEL | VALOR VARIAVEL
        Boolean bTrue = true;
        Boolean bFalse = false;
        Boolean bExemple;
        String exemploString = 'texto 123456';
        Integer exemplointeiro = 1;
        Decimal exemploDecimal = 1.02;
        Double exemploDouble = 1.02554;
        
        //coleções
        List<String> exemploLista = new List<String>();
        //[0] - Edgar
        //[1] - João Paulo
        //[2] - Arnaldo
        //[3] - Guilherme
        exemploLista.add('Edgar');
        exemploLista.add('João Paulo');
        exemploLista.add('Arnaldo');
        exemploLista.add('Guilherme');
        system.debug('exemploLista = '+exemploLista);
        system.debug('exemploLista posição 2= '+exemploLista.get(2));
        system.debug('exemploLista tamanho = '+exemploLista.size());
        
        List<Integer> exemploListaInteger = new List<Integer> ();
        exemploListaInteger.add(null);
        exemploListaInteger.add(1);
        exemploListaInteger.add(2);
        exemploListaInteger.add(3);
        system.debug('exemploListaInteger = ' +exemploListaInteger);

        //coleção set
        Set<String> exemploSet = new Set<String>();
        exemploSet.add('Edgar');
        exemploSet.add('João Paulo');
        exemploSet.add('Arnaldo'); 
        exemploSet.add('Guilherme'); 
        exemploSet.add('Guilherme'); 
        exemploSet.add('Guilherme'); 
        exemploSet.add('Guilherme');
        system.debug('exemploSet = '+exemploSet);
        system.debug('exemploSet tamanho = '+exemploSet.size());

        List<Opportunity> opportunityList = new List<Opportunity> ([SELECT Id, Name FROM Opportunity]);
        system.debug('opportunityList = '+opportunityList);
        system.debug('opportunityList posição 2 = '+opportunityList.get(2));
        system.debug('opportunityList posição 2 = '+opportunityList.get(2).Name);

        Account contaObjeto = new Account();
        contaObjeto.Name = 'Teste';
        system.debug('contaObjeto ' +contaObjeto);

        return bFalse;
    }//FIM DO MÉTODO

    //ESTRUTURA DO SOQL
    //SELECT
    //campos
    //FROM
    //nome do objeto
    //WHERE
    //condição de busca
    private static List<Account> getAccounts()
    {
        List<Account> accountList = new List<Account>([SELECT Id, Name FROM Account WHERE Id != '']);
        return accountList;
    }
 
    //classe sem retorno
    public static void metodoSemRetorno (){
    }

    public static void getAccountPrivate(){
        system.debug(ClasseDemonstraEstrutura.getAccounts());
    }

    //DESAFIO - Criar um método que busque e retorne uma lista com todas as oportunidades com a faze igual a Closed Won
    public static List<Opportunity> getOpportunitiesClosedWon()
    {
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, Name FROM Opportunity WHERE StageName = 'Closed Won']);
        system.debug(oppList);
        system.debug('tamanho = '+oppList.size());
        return oppList;
    }

    public static List<Opportunity> getOpportunitiesClosedWon2()
    {
        return [SELECT Id, Name FROM Opportunity WHERE StageName = 'Closed Won'];
    }

    public static Integer exemploParametros(Integer pInt, Integer pDiv){
        Integer intTest = (10 + pInt)/pDiv;
        system.debug('o valor de intTest é: '+intTest);
        return intTest;
    }

    //DESAFIO: Criar um método que recebe o nome de uma pessoa, e imprime com o system debug 'Ola NOME'
    public static void helloName(String nome, String sobrenome){
        system.debug('Ola '+nome + ' ' + sobrenome);
    }

    public static String helloName2(String nome, String sobrenome){
        return 'Ola '+nome + ' ' + sobrenome;
    }

    public static void callMethods(){
        //exemplo chamando void
        ClasseDemonstraEstrutura.helloName('Nicole', 'Maahs');

        //exemplo chamando um método sem void e com retorno
        system.debug('O retorno do método helloName2 é: '+ClasseDemonstraEstrutura.helloName2('Nicole', 'Maahs'));
    }

    //EXECUÇÃO DML - insert, update, delete, upsert
    public static Account dmlAccountInsert (String name){
        Account accountObject = new Account();
        accountObject.Name = name;
        insert accountObject;
        return accountObject;
    }

    public static Account dmlAccountUpdate (String name, String idDaConta){
        List<Account> accountList = new List<Account>([SELECT Id, Name FROM Account WHERE Id = :idDaConta]); // primeiro buscamos as informações
        Account accountObject = new Account();
        if (accountList.size() > 0)
        {
            accountObject = accountList.get(0); //depois pegamos a unica linha que retorna e colocamos no objeto Account
            accountObject.Name = name;
            update accountObject;
        }
        return accountObject;
    }

    public static void dmlAccountDelete (String idDaConta){
        List<Account> accountList = [SELECT Id FROM Account WHERE Id =:idDaConta];
        delete accountList;
    }

    //DESAFIO - Receber o sobrenome e o nome da empresa e inserir um Lead, o método deve retornar o ID do Lead inserido
    public static Id insertLead (String lastName, String companyName){
        Lead leadObj = new Lead();
        leadObj.LastName = lastname;
        leadObj.Company = companyName;
        insert leadObj;
        return leadObj.Id;
    }

    //estruturas de condição

    public static Boolean demonstraEstruturaCondicao (Integer idade){
        Boolean bmaiorDeIdade;
        //quero retornar true se a pessoa foi maior de idade, senao retorna false
        if (idade < 18){
            system.debug ('Menor de idade');
            bmaiorDeIdade = false;
        }else{
            system.debug ('Maior de idade');
            bmaiorDeIdade = true;
        }
        return bmaiorDeIdade;
    }

    public static void demonstraEstruturaCondicao2 (Integer idade){
        if (idade < 0 || idade == null){
            system.debug('idade invalida');
        }
        else
        {
            if (idade > 13){
            system.debug('crianca');
            }
            else if ((idade >= 13) && (idade <= 21)){
                system.debug('adolescente');
            }
            else if ((idade >= 21) && (idade <= 65)){
                system.debug('adulto');
            }
            else{
                system.debug('idoso');
            }
        }
    }

    //DESAFIO - Construir um método que receba dois parâmetros do tipo Inteiro e retorne a soma destes dois parametros. Se o parametro 1 for maior do que 5 deve somar mais 2 neste resultado.

    public static Integer somaDoisValoresComIf (Integer p1, Integer p2){
        Integer resultado = p1 + p2;
        if (p1 > 5){
            resultado = resultado + 2;
        }
        system.debug('resultado = '+resultado);
        return resultado;
    }

    public static Integer somaDoisValoresComIf2 (Integer p1, Integer p2){
        return p1 > 5? p1 + p2 + 2: p1 + p2;
    }

    //estruturas de repetição
    public static Decimal getOpportunitiesTotal(){
        Decimal total = 0;
        List<Opportunity> opportunityList = new List<Opportunity> ([SELECT Amount FROM Opportunity]);
        for(Opportunity vTemp : opportunityList){
            total = total + vtemp.Amount;
        }
        system.debug('valor total das oportunidades = '+total);
        return total;
    } 

    public static Decimal getOpportunitiesTotal2(){
        Decimal total = 0;
        for(Opportunity vTemp : [SELECT Amount FROM Opportunity]){
            total += vtemp.Amount;
        }
        system.debug('valor total das oportunidades = '+total);
        return total;
    }

    // DESAFIOS
    // 1 - Buscar e retornar o valor total das oportunidades que as fases nao sejam 'CLosed Won' e 'Closed Lost';
    // 2 - Criar 10 Contas com o nome 'Conta 1', 'Conta 2', ...

    public static Decimal getOpportunitiesTotal3(){
        Decimal total = 0;
        for(Opportunity vTemp : [SELECT Amount FROM Opportunity WHERE StageName != 'Closed Won' AND StageName != 'Closed Lost']){
            total += vtemp.Amount;
        }
        system.debug('valor total das oportunidades = '+total);
        return total;
    }
    public static Decimal getOpportunitiesTotal4(){
        Decimal total = 0;
        for(Opportunity vTemp : [SELECT Amount FROM Opportunity WHERE StageName NOT IN ('Closed Won', 'Closed Lost')]){
            total += vtemp.Amount;
        }
        system.debug('valor total das oportunidades = '+total);
        return total;
    }

    public static void insertAccount (){
        List<Account> accountList = new List<Account>();
        for (Integer cont = 0; cont < 10; cont++){
            Account accountObj = new Account();
            accountObj.Name = 'Conta ' + cont;
            accountList.add(accountObj);
        }
        insert accountList;
    }

    // DESAFIO - Receber um numero no parâmetro e criar as contas conforme este número. Se ja houver uma conta com este nome, nao cria-la novamente
    public static void insertAccountsDesafio (Integer quantidadeDeCOntas){
        List <Account> accountList = new List<Account>();
        for(Integer itemp = 1; itemp <= quantidadeDeCOntas; itemp++){
            Account accountObj = new Account();
            accountObj.Name = 'Conta DESAFIO ' +itemp;
            accountList.add(accountObj);
        }
        if (accountList.size() > 0){
            insert accountList;
        }
    }    
    
    public static void insertAccountDesafioSemMap (Integer quantidade){
        List<Account> accountList = new List<Account>();
        for (Integer cont = 0; cont < quantidade; cont++){
            String nameAccount = 'Conta DESAFIO ' + cont;
            List<Account> accountListsCons = new List<Account> ([SELECT Id, Name FROM Account WHERE Name =: nameAccount]);
            if(accountListsCons.size() == 0){
                Account accountObj = new Account();
                accountObj.Name = 'Conta ' + cont;
                accountList.add(accountObj);
            }
            if(accountList.size() > 0){
                insert accountList;
            }
        }
    }

    public static void insertAccountDesafiocomMap (Integer quantidade){
        List<Account> accountList = new List<Account>();
        Map <String, Account> accountMap = new Map <String, Account>();
        for (Account vtemp : [SELECT Id, Name FROM Account]){
            accountMap.put(vtemp.Name, vtemp);
        }
        for (Integer cont = 0; cont < quantidade; cont++){
            String nameAccount = 'Conta DESAFIO ' + cont;
            if(!accountMap.containsKey(nameAccount)){
                Account accountObj = new Account();
                accountObj.Name = nameAccount;
                accountList.add(accountObj);
            }
            if(accountList.size() > 0){
                insert accountList;
            }
        }
    }

    // MAPS
    public static void demonstraMap (){
        List <Opportunity> opportunityList = new List <Opportunity>([SELECT Id, Name FROM Opportunity]);
        system.debug('opportunityList '+opportunityList);
        for (Opportunity vtemp : opportunityList){
            if (vtemp.Id == '006bm00000XRa6VAAT'){

            }
        }
        Map <Id, Opportunity> opportunityMap = new Map <Id, Opportunity>([SELECT Id, Name FROM Opportunity]);
        system.debug('opportunityMap' + opportunityMap);
        if(opportunityMap.containsKey('006bm00000XRa6VAAT')){
            system.debug('Contém o ID');
        }else{
            system.debug ('Não contém o ID');
        }
    }
    public static void demonstraMap2 (){
        Map <String, Account> contasComCPF = new Map <String, Account>();
        for (Account vtemp : [SELECT Id, Name, CPF_CNPJ__c FROM Account WHERE CPF_CNPJ__c != '']){
            system.debug('vtemp '+vtemp);
            contasComCPF.put(vtemp.CPF_CNPJ__c, vTemp);
        }
        system.debug('contasComCPF' + contasComCPF);
        if(contasComCPF.containsKey('56875327066')){
            system.debug('Contem o CPF ');
        }else{
            system.debug('Não contem o CPF ');
        }
    }

}//FIM DA CLASSE