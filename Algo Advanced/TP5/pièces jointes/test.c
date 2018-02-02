#include "reseau.h"



void testReseau(){
	
Reseau R=creerReseauVide();
int n;
Boolean rep;
n=ajouterNoeud(&R,1);
n=ajouterNoeud(&R,2);
n=ajouterNoeud(&R,3);
n=ajouterNoeud(&R,4);
n=ajouterConnexion(R,1,2);
n=ajouterConnexion(R,2,3);
n=ajouterConnexion(R,1,3);
n=ajouterConnexion(R,2,4);
n=ajouterConnexion(R,3,4);

rep=existenceChemin(R,1,4);
if(rep==OUI) printf("Chemin existant entre 1 et 4\n");
else printf("Chemin inexistant entre 1 et 4\n");

rep=existenceChemin(R,4,1);
if(rep==OUI) printf("Chemin existant entre 4 et 1\n");
else printf("Chemin inexistant entre 4 et 1\n");

printf("\n");
noeudAtteignable(R,1);
printf("\n");
noeudAtteignable(R,2);


printf("\nALEX EST UN GROS FDP\n\n\n");

}





int main (void){
	
	testReseau();
	
	return (0);
}
