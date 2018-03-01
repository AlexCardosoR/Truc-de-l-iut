#include "files.h"


File creerFileVide (void){
	File f;
	
	f.tete=NULL;
	f.queue=NULL;
	
	return f;
}

Boolean estFileVide (File f){
	return(f.tete==NULL);
}

int enfiler (File *f,int elt){					 //0 pas fait , 1 fait 
	Cellule *tmp=(Cellule*)malloc(sizeof(Cellule));
	if (tmp==NULL)return 0;
	tmp->val=elt;
	tmp->suiv=NULL;
	if (!estFileVide(*f)){
		f->queue->suiv=tmp;
	}
	else {
		f->tete=tmp;
	}
	f->queue=tmp;
	return 1;
}


int defiler (File *f,int *elt){
	Cellule *tmp;
	if (estFileVide(*f))return 0;
	*elt=f->tete->val;
	tmp=f->tete;
	if (f->tete==f->queue){
		f->queue=NULL;
	}
	f->tete=tmp->suiv;
	free(tmp);
	return 1;
}

int longueurFile (File f){
	Cellule*tmp;
	int cpt = 0;
	if (estFileVide(f))return (0);
	tmp=f.tete;
	while(tmp!=NULL){
		cpt ++;
		tmp=tmp->suiv;
	}
	return cpt;
}

int teteFile (File f, int *elt){
	if(f.tete==NULL){
		printf("f est vide\n");
		return(0);
	}
	*elt=f.tete->val;
	return 1;
}

void viderFile (File *f){
	int elt;
	if (estFileVide(*f)) {
		printf("La file est vide\n");
		return;
	}
	defiler(f,&elt);
	viderFile(f);
	
}

void afficherFile (File f){
	Cellule *tmp;
	 if (estFileVide(f)){
		 printf("f est vide\n");
		 return;
	 }
	 printf("------File------\n");
	 tmp=f.tete;
	while(tmp!=NULL){
		printf("%d\n",tmp->val);
		tmp=tmp->suiv;
	}
	 
}
