trigger LeadTrigger on Lead (before insert, after insert, before update, after update) {
    //temos que incluir uma tarefa e associar ao lead
    if(Trigger.isInsert && Trigger.isAfter){
        List <task> taskList = new List <Task> ();
        for (lead lTemp : Trigger.New){
            Task taskObj = new Task ();
            taskObj.Subject = 'Entrar em contato com o lead';
            taskObj.ActivityDate = System.today();
            taskObj.WhoId = ltemp.Id;
            taskList.add(taskObj);
        }
        if (taskList.size() > 0){
            insert taskList;
        }
    }
}