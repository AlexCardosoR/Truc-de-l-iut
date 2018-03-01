#include "bataille.h"
#include <stdio.h>
#include <stdlib.h>



Pile initJeudeCarte (){
	Pile p;
	p = creerPileVide();
	p = empiler(p, 8);
	p = empiler(p, 8);
	p = empiler(p, 9);
	p = empiler(p, 7);
	p = empiler(p, 10);
	p = empiler(p, 12);
	p = empiler(p, 11);
	p = empiler(p, 8);
	p = empiler(p, 12);
	p = empiler(p, 13);
	return p;
}

void distCartes (Pile *j1,Pile *j2,Pile *p){
	int val;
	while (!estPileVide(*p)){
		*p = depiler(*p, &val);
		*j1 = empiler(*j1, val);
		*p = depiler(*p, &val);
		*j2 = empiler(*j2, val);
	}
	printf("--------Pile--------\n");
	afficherPile(*j1);
	printf("--------Pile--------\n");
	afficherPile(*j2);
}
// retourne la carte tirée ou -1 si plus de carte
int tirerCarte (Pile *tas, Pile *talon){
	int val;
	Pile tmp;
	if (estPileVide(*tas)){
		tmp = *tas;
		*tas=*talon;
		*talon = tmp;
	}
	if(estPileVide(*tas))
		return -1;   // plus de carte
	*tas=depiler(*tas,&val);
	return val;
}


// VOIR CORRECTION

void jouerUnCoupR(Pile *tas1,Pile *tas2,Pile *talon1,Pile *talon2,Pile *pli){
	int val;
	int C1, C2;
	C1 = tirerCarte(tas1, talon1);
	printf("Carte tiré joueur 1: %d\n",C1);
	C2 = tirerCarte(tas2, talon2);
	printf("Carte tiré joueur 2: %d\n", C2);

	if (C1 == C2) {
		*pli = empiler(*pli, C1);
		*pli = empiler(*pli, C2);
		printf("-----Pli-----\n");
		afficherPile(*pli);
		jouerUnCoupR(tas1, tas2, talon1, talon2, pli);
	}
	else if (C1 > C2) {
		while (!estPileVide(*pli)) {
			*pli = depiler(*pli, &val);
			*talon1 = empiler(*talon1, val);
		}
		*talon1 = empiler(*talon1, C1);
		*talon1 = empiler(*talon1, C2);
		printf("le joueur 1 gagne\n------Talon Joueur1-----\n");
		afficherPile(*talon1);
	}
	else {//if (C2 > C1) {
		while (!estPileVide(*pli)) {
			*pli = depiler(*pli, &val);
			*talon2 = empiler(*talon2, val);
		}
		*talon2 = empiler(*talon2, C1);
		*talon2 = empiler(*talon2, C2);
		printf("le joueur 2 gagne\n------Talon Joueur2-----\n");
		afficherPile(*talon2);
	}
}

void jouerUnCoup(Pile *tas1,Pile *tas2,Pile *talon1,Pile *talon2){
	Pile pli = creerPileVide();
	jouerUnCoupR(tas1,tas2,talon1,talon2,&pli);
}

	


