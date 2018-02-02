
// Trois lignes utiles à mettre au début de chaque script :
xdel(winsid());                 // ferme toutes les fenetres a chaque nouvel appel du script
clear;                          // nettoie toutes les variables a chaque nouvel appel du script
mode(0);                        // pour afficher toutes les lignes ne terminant pas par ;


// Charge les fonctions du TP
exec("tp3_fonctions.sci", -1);



// **************** Exercice 1 ******************

if %f then                      // (Passer le booléen à %f pour sauter cet exercice)
    D=[1,10000];
    i=1;
    
    while i <= 10000
     D(i)=debit_routeur();
     i = i+1;
    end
    
    ax=[1:0.1:100];
    
    fd=(my_histc(ax,D)/10000);
    figure();
    plot(ax,fd);
    
    Fd=cumsum(fd);
    figure();
    plot(ax,Fd);
    
    q=find(Fd>=0.5,1);
    disp("Médiane =")
    disp(ax(q))
    
    p=find(ax>=5,1);
    disp("Pourcentage d''échec :")
    disp(Fd(p)*100)
    
end



// **************** Exercice 2 ******************

if %f then
    i=1;
    
    function C = debit_chaine(N)
        i=1;
        while i <= N
         R(i)=debit_routeur();
         i = i+1;
        end
        C=min(R)
        endfunction
                      // (Passer le booléen à %f pour sauter cet exercice)
    disp("1)")
    D=debit_chaine(5);
    disp("Le débit minimum est de :")
    disp(D)
    
    
    while i<=10000
        C(i)=debit_chaine(5);
        i=i+1;
    end
    
    ax=[1:0.1:70];
    
    fc=(my_histc(ax,C)/10000);
    figure();
    plot(ax,fc);
    
    Fc=cumsum(fc);
    figure();
    plot(ax,Fc);
    
    disp("3)")
    q=find(Fc>=0.5,1);
    disp("Médiane =")
    disp(ax(q))
    
    p=find(ax>=5,1);
    disp("Pourcentage d''échec :")
    disp(Fc(p)*100)
    
    
end



// **************** Exercice 3 ******************

if %t then                      // (Passer le booléen à %f pour sauter cet exercice)
    
    routeur=(grand(1,10000,"bin",118,0.01));
    
    ax=[1:1:10];
    
    fr=(my_histc(ax,routeur)/10000);
    figure();
    plot(ax,fr);
    
    Fr=cumsum(fr);
    figure();
    plot(ax,Fr);
    
    disp("P suit la loi binomial ")
end
