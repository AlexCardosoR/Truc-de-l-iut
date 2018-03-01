#include <stdio.h>
#include <stdlib.h>
#include "pileentier.h"



Pile creerPileVide (){
	return NULL;
}

boolean estPileVide (Pile p){
	return (p==NULL);
}

Pile empiler (Pile p, int val){
	Cellule *tmp;
	tmp=(Cellule*)malloc(sizeof(Cellule));
	if (tmp==NULL){
		printf("pb alloc\n");
		exit(1);
	}
	tmp->val=val;
	tmp->suiv=p;
	p=tmp;
	return p;
}


Pile depiler (Pile p,int *val){
	Cellule *tmp;
	if(estPileVide(p)){
		printf("impossible pile vide\n");
		exit(1);
	}
	tmp=p;
	*val=tmp->val;
	p=tmp->suiv;
	free(tmp);
	return p;
}
	
int sommetPile (Pile p){
	if (p==NULL){
		printf("p est vide\n");
		exit(1);
	}
	return p->val;
}

int hauteurPile (Pile p){
	if (estPileVide(p))return(0);
	return 1+hauteurPile(p->suiv);
}

Pile viderPile (Pile p){
	int elt;
	if (estPileVide(p))return p;
	p= depiler(p,&elt);
	return (viderPile(p));
}
	
void afficherPile (Pile p){
	if (p==NULL){
		return;
	}
	printf("%d\n", p->val);
	afficherPile(p->suiv);	
}
