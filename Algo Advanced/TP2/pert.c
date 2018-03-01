#include "pert.h"


void afficherTache(Tache t[],int n){
	int i;
	for(i=0;i<n;i++){
	printf("Date:%d, Duree:%d, nbSucc:%d, nbPred:%d\n",t[i].date,t[i].duree,t[i].nbSucc,t[i].nbPred);

	}
	
}


Tache*  saisieTaches (){
	int n=0;
	int y;
	int d=0;
	Tache*t;
	printf("saisir nombre de taches\n");
	scanf("%d",&n);
	
	t=(Tache*)malloc(n*sizeof(Tache));
	if (t==NULL)return 0;
	
	for (y=0;y<n;y++){
		printf("saisir la duree\n");
		scanf("%d",&d);
		t[y].duree=d;
		t[y].date=0;
		t[y].succ=(int*)malloc((n-1)*sizeof(int));
		if (t[y].succ==NULL)return 0;
		t[y].nbSucc=0;
		t[y].nbPred=0;		
	}
	return t;
}


void saisieContraintes (Tache*t){
	int tp,ts;
	printf("Saisir un couple de la façon suivante : x1,x2\n");
	printf("Saisir un couple négatif pour stopper la saisie\n");
	scanf("%d,%d",&tp,&ts);
	
	while (tp>=0 && ts>=0){
		t[tp].succ[t[tp].nbSucc]=ts;
		t[ts].nbPred++;
		t[tp].nbSucc++;
	
		printf("Saisir un nouveau couple de la façon suivante : x1,x2\n");
		scanf("%d,%d",&tp,&ts);
	}
}


void traiterTaches (Tache*t){
	
	
	
}


