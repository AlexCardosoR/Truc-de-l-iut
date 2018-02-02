#ifndef RESEAU_H
#define RESEAU_H
#include <stdio.h>
#include <stdlib.h>
#include "reseau.h"

#define PB_NOEUD_INEXISTANT -3
#define PB_NOEUD_DEJA_EXISTANT -1
#define PB_ALLOCATION_MEMOIRE -2
#define OK 1
#define OUI 1 
#define NON 0
#define PB_NOEUD_DEB_NON_EXISTANT -4
#define PB_NOEUD_FIN_NON_EXISTANT -5
#define PB_CONNEXION_EXISTANTE -6
#define PB_CONNEXION_INEXISTANTE -7


typedef struct cellNoeud{
	int val;
	int marque;
	struct cellConnexion *listConnexion;
	struct cellNoeud *suiv;
}CellNoeud;

typedef struct cellConnexion{
	CellNoeud *extremite;
	struct cellConnexion *suiv;
}CellConnexion;

typedef CellNoeud *Reseau;

typedef enum {FAUX,VRAI} Boolean;

Reseau creerReseauVide();
CellNoeud* rechercheNoeud(Reseau R,int val);
int ajouterNoeud(Reseau* R,int val);
int existenceConnexion (Reseau R, int dep, int arr);
int ajouterConnexion (Reseau R,int dep,int arr);
int destructionConnexion(Reseau R,int dep,int arr);
int destructionNoeud(Reseau *pr, int num);
Boolean existenceChemin (Reseau R, int n1,int n2);
void noeudAtteignable(Reseau R, int n);
#endif
