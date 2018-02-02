
// Trois lignes utiles à mettre au début de chaque script :
xdel(winsid());                 // ferme toutes les fenetres a chaque nouvel appel du script
clear;                          // nettoie toutes les variables a chaque nouvel appel du script
mode(0);                        // pour afficher toutes les lignes ne terminant pas par ;

exec("tp3_fonctions.sci", -1);
// Charge les fonctions du TP

// **************** Exercice 3 **********************
if %t then
    N=10000;
    p=10^-3;
    Y=grand(1,N,"bin",N,p);
    //1)
    [Vx,Ex]=variance(Y)
    
    //2)
    figure();
    ax=[0:1:max(Y)];
    f=(my_histc(ax,Y)/N);
    plot(ax,f);
    
    F=cumsum(f);
    plot(ax,F,'red');
     
    p=find(Y==2);
    length(p)/N
    
    p1=find(ax>=2,1);
    disp(1-(F(p1)));
end
