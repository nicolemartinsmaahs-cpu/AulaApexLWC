@isTest
public class AccountTriggerTest {
    // Teste 1 - criar uma conta com tarefa
    @isTest
    static void AccountTriggerTest(){
        Account accountObj = new Account();
        accountObj.Name = 'Teste 1';
        accountObj.Ownership = 'Private';
        accountObj.Phone = '123456789';
        insert (accountObj);
        List<Task> listTasks = new List <Task>([SELECT Id FROM Task WHERE WhatID = :accountObj.Id AND Subject = 'Verificar dados cadastrais']);
        System.assertEquals(listTasks.size(), 1);
    }

    // Teste 2 - criar uma conta sem tarefa
    @isTest
    static void ContaSemTarefa(){

        Account accountObj = new Account();
        accountObj.Name = 'Teste 2';
        accountObj.Ownership = '';
        accountObj.Phone = '123456789';

        insert accountObj;

        List<Task> taskList = new List<Task>([SELECT Id FROM Task WHERE WhatId = :accountObj.Id AND Subject = 'Verificar dados cadastrais']);
        System.assertEquals(taskList.size(), 0);
    }

    // Teste 3 - Massa de dados grande
    @isTest
    static void ContaMassaDados(){
        List <Account> accountList = new List <Account>(); 
        for(Integer i = 1; i <= 100; i++){
            Account accObj = new Account();
            accObj.Name = 'Conta '+ i;
            accObj.Ownership = 'Private';
            accObj.Phone = '123456789';
            accountList.add(accObj);
        }
        insert accountList;
        List <Task> taskList = new List <Task> ([SELECT Id FROM Task WHERE WhatID IN : accountList AND Subject = 'Verificar dados cadastrais']);
        System.assertEquals(taskList.size(), 100);
    }
}