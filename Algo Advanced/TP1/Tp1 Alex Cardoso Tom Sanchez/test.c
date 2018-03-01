#include <stdio.h>
#include <stdlib.h>
#include "bataille.h"

void testPile(){

	Pile p, j1, j2, ta1, ta2;
	j1 = creerPileVide();
	j2= creerPileVide();
	ta1= creerPileVide();
	ta2 = creerPileVide();

	p=initJeudeCarte();
	afficherPile(p);
	distCartes(&j1,&j2,&p);
	jouerUnCoup(&j1, &j2, &ta1, &ta2);
}

int main (void){
	testPile();
	return (0);
}

