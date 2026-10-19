public with sharing class Carro {
    //atributos do carro
    public String modelo {get;set;}
    public String cor {get;set;}
    public Boolean ligado {get;set;}
    public Integer velocidadeCarro {get;set;}
    public Boolean estadoPorta {get;set;}
    public Boolean temGasolina {get;set;} // get e set, um define e outro permite buscar o valor

    //DESAFIO: No carro criar um método Acelerar que receba a velocidade e retorne a velocidade atualizada. Só deve ser possível acelerar se o carro estiver ligado.
    //DESAFIO: Verificar se o carro tem ou não gasolina para poder acelerar
    public Boolean acelerar (Integer velocidade){
        Boolean continua = true;
        if(this.ligado == null || this.temGasolina == null){
            continua = false;
        }
        else{
            continua = this.ligado && this.temGasolina;
        }
        return velocidade > 0 && velocidade != null && continua ? true : false;
    }
    /*public Boolean ligarCarro(Boolean ligarCarro){
        Boolean carroLigado = ligarCarro ? true : false;
        if(ligarCarro == true){
            system.debug('ligou o carro');
        }else{
            system.debug('desligou o carro');
        }
        return carroLigado;
    }
    public Boolean ligarFarois (Boolean ligarFarois){
        Boolean ligouFarol1 = ligarFarois ? true : false;
        if(ligarFarois){
            system.debug('ligou os farois');
        }else{
            system.debug('desligou os farois');
        }
        return ligouFarol;
    }
        public Boolean ligarSeta (Boolean ligarSeta){
        Boolean ligouSeta = ligarSeta ? true : false;
        if(ligarSeta){
            system.debug('ligou as setas');
        }else{
            system.debug('desligou as setas');
        }
        return ligouSeta;
    }*/
}