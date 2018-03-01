/**
 * Created by alcardosor on 09/02/18.
 */

var metier = function (nom,prenom) {

    var adresseList = function (numero,nomAdd) {
        var liste = [numero,nomAdd];
        return liste;
    };

    var personne = function (nom,prenom) {
        var personne = [nom,prenom];
        return personne;
    };

    var myRegexTestMethod = function (chaine) {
        return ( typeof chaine === "string" ) && /^[a−z]*$/i.test(chaine);
    };

    var publicInterface = {
        getAddresseList: function () {
            return adresseList();
        },

        getpersonne: function () {
            return personne();
        },

        setPersonne: function (nom, prenom) {
            if (myRegexTestMethod(nom) && myRegexTestMethod(prenom)) {
                 personne(nom,prenom);
            } else {
                throw{
                    name: "IllegalArgumentException",
                    message: "Le nom ou prenom est invalide."
                };
            }
        },

        setAddresse: function (numero, nomAdd) {
            if (myRegexTestMethod(numero) && nomAdd) {
                addresseList(numero,nomAdd);
            } else {
                throw{
                    name: "IllegalArgumentException",
                    message: "Le numero ou l'adresse est invalide."
                };
            }
        }
    }
};

var vue = {
    getHTML: function () {
        codeHTML= "<br/>" + metier.getPersonne().nom + " " + metier.getPersonne().prenom +" : <br/> ";
        document.getElementById("paraPersonne").innerHTML = codeHTML;
    }
}



vue.getHTML();