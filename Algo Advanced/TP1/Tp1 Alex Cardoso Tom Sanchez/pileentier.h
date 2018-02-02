
typedef struct cellule{
	int val;
	struct cellule *suiv;
}Cellule,*Pile;

typedef enum{FAUX,VRAI} boolean;





Pile creerPileVide ();
boolean estPileVide (Pile p);
Pile empiler (Pile p, int val);

// la pile doit ne pas etre vide !!!
Pile depiler (Pile p,int *val);


int sommetPile (Pile p);
int hauteurPile (Pile p);
Pile viderPile (Pile p);
void afficherPile (Pile p);
