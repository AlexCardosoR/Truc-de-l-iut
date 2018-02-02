
// Trois lignes utiles à mettre au début de chaque script :
xdel(winsid());                 // ferme toutes les fenetres a chaque nouvel appel du script
clear;                          // nettoie toutes les variables a chaque nouvel appel du script
mode(0);                        // pour afficher toutes les lignes ne terminant pas par ;


// Charge les fonctions du TP
exec("patinage_vitesse_2002.sce", -1);
exec("tp3_fonctions.sci", -1);


// **************** Exercice 1 ******************
if %t then
    //1)
    N=23;
    delta=temps(:,2)-temps(:,1);
    ax=[-5:1:5];
    f=(my_histc(ax,delta)/N);
    plot(ax,f);
    
    
    //2)
    idx=find(delta>0);
    interieur=length(idx)
    exterieur=23-interieur
    moyenneempirique=(exterieur/N)*100
    
    //3)
    //Si la piste n'est pas biaisée m=0.
    
    //4)
    mN=sum(delta)/N
    
    varianceN=(sum(delta.^2)/N)-mN.^2
    
    //5)
    confiance=(1+0.95)/2;
    Z=cdfnor("X",0,1,confiance,1-confiance)
    
    
    //6)
    m1=(mN-Z*(varianceN/sqrt(N)))
    m2=(mN+Z*(varianceN/sqrt(N)))
    
    //7) Couloir intérieure est avantagé.
   
    //8) m n'est pas égale à 0 et la variance n'est pas de 1.
    
    //9)
    P=(1+0.95)/2;
    Q=1-P;
    T=cdft("T",N-1,P,Q)
    
    t1=(mN-T*(varianceN/sqrt(N)))
    t2=(mN+T*(varianceN/sqrt(N)))
    
    //10) Le couloir intérieur est toujours avantagé.
    
   
end

