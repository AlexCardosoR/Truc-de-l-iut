/** @description Code JavaScript du Tp1
 * @param {Object} metier - Objet avec des classes personnes et adresses imbriqués
 *
 **/

var metier = {

    adresse: {
        numero: "numéro",
        libelle: "adresse"
    },

    personne: {
        nom: "nom",
        prenom: "prenom",
        tabAdresse: new Array(),

        addAdresse: function (numero, libelle ) {
            this.tabAdresse.push(numero,libelle);
        }
    },

    getPersonne: function () {
        return this.personne;
    },

    getAdresse: function () {
        return this.adresse;
    }
}

var vue = {
    getHTML: function () {
        codeHTML= "<br/>" + metier.getPersonne().nom + " " + metier.getPersonne().prenom +" : <br/> ";
        for (var i=0 ; i<metier.personne.tabAdresse.length ; i+=2){
            codeHTML += metier.personne.tabAdresse[i];
            codeHTML += metier.personne.tabAdresse[i+1]+"<br/>";

        }
        document.getElementById("paraPersonne").innerHTML = codeHTML;
    }
}



metier.personne.addAdresse("1 ","rue de la Botte");
metier.personne.addAdresse("2 ","rue de la Bottinne");
metier.personne.addAdresse("3 ","rue de la Bottette");
metier.personne.addAdresse("4 ","rue de la Bottinounette");

vue.getHTML();