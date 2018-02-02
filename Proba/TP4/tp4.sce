// Trois lignes utiles à mettre au début de chaque script :
xdel(winsid());                 // ferme toutes les fenetres a chaque nouvel appel du script
clear;                          // nettoie toutes les variables a chaque nouvel appel du script
mode(0);                        // pour afficher toutes les lignes ne terminant pas par ;

// Charge les fonctions du TP
exec("tp3_fonctions.sci", -1);

// **************** Exercice 1 ******************

if %f then                      // (Passer le booléen à %f pour sauter cet exercice)
    
    n=50 ; // indice pour la convergence du TCL.
    N=100000 ; // nombre de réalisations pour tracer l’histogramme.
    X=grand(N,n,"unf",0,1);
    w=sum(X,2);
    
    z=(w-(n/2))/sqrt(n/12);

    ax=linspace(-3,3,25);
    
    fz=(my_histc(ax,z)/N);
    figure();
    plot(ax,fz,'yellow');
    
    R = grand(1,N, "nor", 0, 1);
    fr=(my_histc(ax,R)/N);
    plot(ax,fr,'red');
    
    
    disp ("Plus le nombre d''essai est grand plus la courbe est normalisée.")
    
end



// **************** Exercice 1 ******************

if %t then                      // (Passer le booléen à %f pour sauter cet exercice)
        disp(" 1/ c  doit être égale à 1. Il en resulte une loi uniforme discrete.")
        N=100000 ; // nombre de réalisations pour tracer l’histogramme.
        X=grand(1,N,"uin",0,60);
        M=mean(X)
        Ec=nanstdev(X)
        
        ax=[1:0.1:60];
        
        fd=(my_histc(ax,X)/N);
        figure();
        plot(ax,fd);
        
        Fd=cumsum(fd);
        figure();
        plot(ax,Fd);
        
        p=find(ax<=20);
        disp("Pourcentage d''attente de moins de 20 secondes :")
        disp(sum(Fd(p)));
    
        
end

