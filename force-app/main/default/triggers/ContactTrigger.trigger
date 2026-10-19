//Toda vez que inserirmos um contato novo,enviar um email de aviso informando o mesmo
trigger ContactTrigger on Contact (after insert) {
    if(Trigger.isInsert && Trigger.isAfter){

        List <Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

        //Vamos enviar para contatos que tenham uma conta vinculada e tenham o email, enviar para o email da conta
        set<Id> idsContasSet = new set<Id>();
        for (Contact cTemp: Trigger.New){
            idsContasSet.add(ctemp.AccountId);
        }

        //exemplo usando List
        List<Account> accountList = new List<Account>([SELECT Id, Email FROM Account WHERE Id IN:IdsContasSet]);
        String emailCliente = null;
    
        //exemplo do Map
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Email FROM Account WHERE Id IN:IdsContasSet]);  

        for(Contact cTemp:Trigger.new){
            /*if(accountList.size()>0){
                for(Account aTemp:accountList){
                    if(ctemp.AccountId == aTemp.Id){
                        emailCliente = aTemp.Email;
                    }
                }
            }*/

            emailCliente = accountMap.containsKey(cTemp.AccountId) ? accountMap.get(cTemp.AccountId.Email) : null;

            /*if(accountMap.containsKey(cTemp.AccountId)){
                emailCliente = accountMap.get((cTemp.AccountId).Email);
            }*/

            if(String.isNotBlank(emailCliente)){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                string[] toAdress = new String []{emailCliente};

                //Coleção parecida com a anterior
                //List<String> toAdressList = new List<String>();
                //toAdressList.add('nicole.martins.maahs@gmail.com');

                String nomeContato = String.isNotBlank(ctemp.FirstName) ? ctemp.FirstName : '';

                email.saveAsActivity = false;
                email.setTargetObjectId(UserInfo.getUserId());
                email.setToAddresses(toAdress);
                email.setSubject('Novo contato adicionado');
                email.setPlainTextBody('Foi criado o contato com o seguinte nome: '+ nomeContato + ' ' + ctemp.LastName + ' - ' + ctemp.Id);

                emailList.add(email);
                //Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email} );
            }


        }
        if(emailList.size()>0){
             Messaging.sendEmail(emailList);
        }
    }
}