/**
 * Created by alcardosor on 26/01/18.
 */

var metier = {

    personne : {
        "Nom" : "Duchantier",
        "Prenom" : "Henry",
        tab : new Array(),
        
        addAdresse : function (adresse) {
            this.tab.push(adresse);
        },

        getTab : function () {
            return this.tab[0];
        }
    },

    adresse :{
        "libelle": "Cezeaux Pellez",
    },

    getPersonne : function () {
        return this.personne;
    },

    getLibelle : function(){
        return this.adresse;
    }

}

var vue = {
    getHTML : function(){
        document.getElementById("paraPersonne").innerHTML = metier.getPersonne().Nom;
        document.getElementById("paraAdresse").innerHTML = metier.getTab();
    }
}

metier.personne.addAdresse(" yolo town");
vue.getHTML();
