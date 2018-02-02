#include "pert.h"


void afficherTache(Tache t[], int n){
	int i;
	int k;
	if (t == NULL) { printf("Tache vide"); return; }
	for(i = 0; i < n; i++) {
		printf("Tache n° %d\n", i);
		printf("Date au + tot:%d, Duree:%d, nbSucc:%d, nbPred:%d\n",t[i].date,t[i].duree,t[i].nbSucc,t[i].nbPred);
		if( t[i].nbSucc != 0)
		{
			printf("Successeur(s):\n");
			for (k = 0; k < t[i].nbSucc; k++) {
				printf("%d\n", t[i].succ[k]);
			}
		}
	}	
	printf("\n Projet fini en %d jours\n", t[n - 1].date + t[n - 1].duree);
}


Tache*  saisieTaches (int *nbtache){
	int n=0;
	int y;
	int d=0;
	Tache*t;
	printf("saisir nombre de taches\n");
	scanf("%d",&n);
	*nbtache =n;
	
	t=(Tache*)malloc(n*sizeof(Tache));
	if (t==NULL)return 0;
	
	for (y=0;y<n;y++){
		printf("saisir la duree pour la tache n° %d\n",y);
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
	if (t == NULL) { printf("Tache vide"); return; }
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






void traiterTaches (Tache*t, int nbtache){
	int i;
	int res;
	int k;
	int successeur;
	int datefin;
	int max = 0;
	File f = creerFileVide();
	if (t == NULL) { printf("Tache vide"); return; }

	for (i = 0; i < nbtache; i++) {
		datefin = t[i].date + t[i].duree;

		// si pas de prédecesseur
		if (t[i].nbPred == 0) {
			res = enfiler(&f, i);
			if (res == 0) { printf("Probleme enfiler\n"); return; }
			
			//mise a jour des dates des successeurs
			for (k = 0; k < t[i].nbSucc; k++) {
				successeur = t[i].succ[k];
				t[successeur].date = datefin;			
				res = enfiler(&f, successeur);
				if (res == 0) { printf("Probleme enfiler\n"); return; }
			}
		}
		else
		{	//on enfile le successeur
			for (k = 0; k < t[i].nbSucc; k++) {
				successeur = t[i].succ[k];

				//si successeur a + de 1 predeccesseur on prend la date de fin la plus tardive
				if (t[successeur].nbPred > 1) {										
					if ( datefin > max) max = datefin;
				}								

				if ( t[successeur].nbPred <= 1 )  t[successeur].date = datefin; 

				else t[successeur].date = max; 


				if (t[i].nbPred > 1) max = 0;								
				
				//on verif si déja dans la file
				if (successeur != f.queue->val) { 
					res = enfiler(&f, successeur); 
					if (res == 0) { printf("Probleme enfiler\n"); return; }
				}
				else  printf("Tache n° %d deja dans file\n", f.queue->val); 


				
			}
		}	
	}
	afficherFile(f);
}


