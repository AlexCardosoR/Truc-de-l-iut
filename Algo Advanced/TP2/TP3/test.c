#include "files.h"
#include "pert.h"


void testPile(){
	File f;
	int i = 10,k = 0,elt = 0;
	f = creerFileVide();

	while (i!=0){
		k = enfiler(&f, i);
		if (k == 0) printf("problème malloc\n");
		i--;
	}
	
	afficherFile(f);

	while (i!= 5){
		k = defiler(&f, &elt);
		if (k == 0) printf("File vide\n");
		printf("Element %d enleve\n", elt);
		i++;
	}

	afficherFile(f);

	viderFile(&f);

}


void testTache(){
	Tache *t;
	int nbtache;
	t=saisieTaches(&nbtache);
	saisieContraintes(t);
	traiterTaches(t, nbtache);
	afficherTache(t,nbtache);
}


int main (void){
	//testPile();
	testTache();
	return (0);
}
