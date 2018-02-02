#ifndef FILES_H
#define FILES_H
#include <stdio.h>
#include <stdlib.h>


typedef struct cellule{
	int val;
	struct cellule *suiv;
}Cellule; 


typedef struct {Cellule *tete, *queue;} File;

typedef enum {FAUX,VRAI} Boolean;


File creerFileVide (void);
Boolean estFileVide (File f);
int enfiler (File *f,int val);
int defiler (File *f,int *val);
int longueurFile (File f);
int teteFile (File f,int *elt);
void viderFile (File *f);
void afficherFile (File f);


#endif


