#ifndef BIN_H
#define BIN_H
#include <stdio.h>
#include <stdlib.h>
#include "bin.h"


typedef struct noeud{
	int val;
	struct noeud *fg,*fd;
}Noeud;

typedef Noeud *ArbreBin;

typedef enum {FAUX,VRAI} Boolean;

Boolean estArbreVide(ArbreBin a);
ArbreBin creerArbreBin ();
ArbreBin inserer (ArbreBin a,int val);
void affichagePostFixe(ArbreBin a);
void affichageCroissant(ArbreBin a);
void affichageDecroissant(ArbreBin a);
void detruire (ArbreBin a);

#endif
