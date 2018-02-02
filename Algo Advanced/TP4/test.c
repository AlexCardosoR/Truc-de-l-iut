#include "bin.h"


void testArbreBin(){
	ArbreBin a;
	
	a=creerArbreBin();
	a=inserer(a,11);
	a=inserer(a,7);
	a=inserer(a,4);
	a=inserer(a,10);
	a=inserer(a,8);
	a=inserer(a,9);
	a=inserer(a,15);
	a=inserer(a,13);
	a=inserer(a,20);
	a=inserer(a,17);
	a=inserer(a,25);
	affichageCroissant(a);
	printf("\n");
	affichageDecroissant(a);
	printf("\n");
	detruire(a);

}


int main (void){
	
	testArbreBin();
	
	return (0);
}
