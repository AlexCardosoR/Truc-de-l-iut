#include "reseau.h"

Reseau creerReseauVide(){
	return(NULL);
}

CellNoeud* rechercheNoeud(Reseau R,int val){
	CellNoeud *tmp=R;
	while (tmp!=NULL){
		if (tmp->val==val){
			return tmp;
		}
		tmp = tmp->suiv;
	}
	return tmp;
}

int ajouterNoeud(Reseau* R,int val){
	CellNoeud * tmp;
	if (rechercheNoeud(*R,val)!=NULL){
		return PB_NOEUD_DEJA_EXISTANT;
	}
	tmp=(CellNoeud*)malloc(sizeof(CellNoeud));
	if (tmp==NULL)return PB_ALLOCATION_MEMOIRE;
	tmp->val=val;
	tmp->listConnexion=NULL;
	tmp->suiv=*R;
	tmp->marque = 0;
	*R=tmp;
	return OK;
}

int existenceConnexionPointe (CellNoeud* dep,CellNoeud* fin){
	CellConnexion* tmp;
	tmp=dep->listConnexion;
	while(tmp!=NULL){
		if(tmp->extremite==fin){return OUI;}
		tmp=tmp->suiv;
	}
	return NON;
}

int existenceConnexion (Reseau R, int dep, int fin){
	CellNoeud* ptd,*pta;
	ptd=rechercheNoeud(R,dep);
	if(ptd==NULL)return PB_NOEUD_DEB_NON_EXISTANT;
	pta=rechercheNoeud(R,fin);
	if (pta==NULL)return PB_NOEUD_FIN_NON_EXISTANT;
	return existenceConnexionPointe(ptd,pta);
}


int ajouterConnexion (Reseau R,int dep,int arr){
	CellNoeud *pa, *pb;
	CellConnexion *tmp;

	pa = rechercheNoeud(R, dep);
	if (pa == NULL) return PB_NOEUD_DEB_NON_EXISTANT;
	pb = rechercheNoeud(R, arr);
	if (pb == NULL) return PB_NOEUD_FIN_NON_EXISTANT;
	if (existenceConnexionPointe(pa, pb) == OUI) return PB_CONNEXION_EXISTANTE;

	tmp = (CellConnexion*)malloc(sizeof(CellConnexion));
	if (tmp == NULL) return PB_ALLOCATION_MEMOIRE;
	tmp->extremite = pb;
	tmp->suiv = pa->listConnexion;
	pa->listConnexion = tmp;
	return OK;
}


int destructionConnexionPointe(CellNoeud* dep,CellNoeud* fin){
	CellConnexion *tmp, *tmpav;
	
	if (existenceConnexionPointe(dep,fin)==NON) return PB_CONNEXION_INEXISTANTE;
	tmp = dep->listConnexion;
	
	if (tmp->extremite == fin)
		dep->listConnexion = tmp->suiv;
	else {
		while (tmp->extremite != fin) {
			tmpav = tmp;
			tmp = tmp->suiv;
		}
		tmpav->suiv = tmp->suiv;
	}
	tmp->extremite = NULL;
	free(tmp);
	return OK;
}


int destructionConnexion(Reseau R,int dep,int arr){
	CellNoeud *pa, *pb;
	pa = rechercheNoeud(R, dep);
	if (pa == NULL) return PB_NOEUD_DEB_NON_EXISTANT;
	pb = rechercheNoeud(R, arr);
	if (pb == NULL) return PB_NOEUD_FIN_NON_EXISTANT;

	return destructionConnexionPointe(pa, pb);	
}

int destructionNoeud(Reseau *pr, int num) {
	CellNoeud *ptn, *pt2;
	CellConnexion * tmpa;

	ptn = rechercheNoeud(*pr, num);
	if (ptn == NULL) return PB_NOEUD_INEXISTANT;
	while (ptn->listConnexion != NULL) {
		tmpa = ptn->listConnexion;
		ptn->listConnexion = tmpa->suiv;
		free(tmpa);
	}

	pt2 = *pr;
	while (pt2 != NULL) {
		destructionConnexionPointe(pt2, ptn);
		pt2 = pt2->suiv;
	}
	
	if (ptn == *pr)
		*pr = (*pr)->suiv;
	else {
		
		pt2 = *pr;
		while (pt2->suiv != ptn)
			pt2 = pt2->suiv;
			pt2->suiv = ptn->suiv;
	}
	free(ptn);
	return OK;
}

Boolean visiterExistenceChemin(CellNoeud* nd,CellNoeud* na){
	CellConnexion* tmpc;
	Boolean rep;
	nd->marque=1;
	if (nd==na) return OUI;
	tmpc=nd->listConnexion;
	while(tmpc!=NULL){
		if(tmpc->extremite->marque==0){
			rep=visiterExistenceChemin(tmpc->extremite,na);
			if (rep==OUI)return OUI;
		}
		tmpc=tmpc->suiv;		
	}
	return NON;
}



void toutmettreaZero(Reseau R){
	CellNoeud *tmp=R;
	while(tmp!=NULL){
		tmp->marque=0;
		tmp=tmp->suiv;
	}
}

Boolean existenceChemin (Reseau R, int n1,int n2){
	CellNoeud *nd, *na;
	nd=rechercheNoeud(R,n1);
	if (nd == NULL) return PB_NOEUD_DEB_NON_EXISTANT;
	na = rechercheNoeud(R, n2);
	if (na == NULL) return PB_NOEUD_FIN_NON_EXISTANT;

	toutmettreaZero(R);
	return visiterExistenceChemin(nd,na);
}

void visiterNoeudAtteignable(CellNoeud* n1){
	CellConnexion* tmpc;
	Boolean rep;
	n1->marque=1;
	tmpc=n1->listConnexion;
	while(tmpc!=NULL){
		if(tmpc->extremite->marque==0){
			visiterNoeudAtteignable(tmpc->extremite);
			if (tmpc->extremite!=NULL)printf("chemin entre %d et %d \n",n1->val,tmpc->extremite->val);
		}
		tmpc=tmpc->suiv;		
	}
}


void noeudAtteignable(Reseau R, int n){
	CellNoeud *n1;
	n1=rechercheNoeud(R,n);
	if (n1 == NULL){
		 printf("noeud inexistant");
		 return;
	}
	toutmettreaZero(R);
	visiterNoeudAtteignable(n1);

}


