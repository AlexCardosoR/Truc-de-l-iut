#include "bin.h"


ArbreBin creerArbreBin (){
	return NULL;
}

Boolean estArbreVide(ArbreBin a){
	return (a==NULL);
}


ArbreBin inserer (ArbreBin a,int val){
	Noeud *tmp;
	
	if(estArbreVide(a)){
		tmp=(Noeud*)malloc(sizeof(Noeud));
		if (tmp==NULL){
			printf("pb mallooc");
			return a;
		}
		tmp->val=val;
		tmp->fg=NULL;
		tmp->fd=NULL;
		return tmp;
	}
	
	
	if(a->val>=val){
		a->fg = inserer(a->fg, val);
	}
	else {
		a->fd = inserer(a->fd, val);
	}	
	
	return a;				
	
}


void affichagePostFixe(ArbreBin a){
	if(a==NULL)return;
	affichagePostFixe(a->fg);
	affichagePostFixe(a->fd);
	printf("%d-",a->val);
}


void affichageCroissant(ArbreBin a){
	if (estArbreVide(a))return;
	affichageCroissant(a->fg);
	printf("%d-",a->val);
	affichageCroissant(a->fd);
}

void affichageDecroissant(ArbreBin a){
	if (estArbreVide(a))return;
	affichageDecroissant(a->fd);
	printf("%d-",a->val);
	affichageDecroissant(a->fg);
}

void detruire (ArbreBin a){
	if(estArbreVide(a))return;
	detruire(a->fg);
	detruire(a->fd);
	free(a);
}
