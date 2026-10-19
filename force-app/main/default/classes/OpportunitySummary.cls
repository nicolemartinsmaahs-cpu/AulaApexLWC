//Essa classe devolve todas as oportunidades para mostrar na lista
public with sharing class OpportunitySummary {
    @AuraEnabled
    public static List<Opportunity> getOpportunities (){
        return [SELECT  Id, Name FROM Opportunity];
    }
}