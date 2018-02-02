#include "files.h"
#ifndef PERT_H
#define PERT_H


typedef struct tache{
	int date;
	int duree;
	int *succ;
	int nbSucc;
	int nbPred;
}Tache; 


void afficherTache(Tache t[],int n);
Tache* saisieTaches (int *nbtache);
void saisieContraintes (Tache*t);
void traiterTaches (Tache*t, int nbtache);




#endif
