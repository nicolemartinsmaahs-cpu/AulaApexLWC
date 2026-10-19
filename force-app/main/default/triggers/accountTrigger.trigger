//DESAFIO: Toda vez que criar uma nova conta com o campo Propriedade = Private, voce deve criar uma tarefa para o proprietário da conta para verificar os dados cadastrais da mesma. 

trigger accountTrigger on Account (after insert) {

    if(Trigger.isInsert && Trigger.isAfter){

        List<Task> taskList = new List<Task>();

        for(Account aTemp : Trigger.New){

            if(aTemp.Ownership == 'Private'){
                Task taskObj = new Task();
                taskObj.Subject = 'Verificar dados cadastrais';
                taskObj.ActivityDate = system.today();
                taskObj.WhatId = aTemp.Id;
                taskObj.OwnerId = aTemp.OwnerId;
                taskList.add(taskObj);
            }
        }

        if(taskList.size() > 0){
            insert taskList;
        }
    }
}