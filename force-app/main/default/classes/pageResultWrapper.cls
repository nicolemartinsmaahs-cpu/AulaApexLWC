public class pageResultWrapper {

    @AuraEnabled
    public Integer tamanhoDaPagina {get; set;}

    @AuraEnabled
    public Integer totalItems {get; set;}

    @AuraEnabled
    public Object[] allDatas {get; set;}
}