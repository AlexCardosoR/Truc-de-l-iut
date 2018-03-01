
// Deux lignes utiles à mettre au début de chaque script :
xdel(winsid());                 // ferme toutes les fenetres a chaque nouvel appel du script
clear;                          // nettoie toutes les variables a chaque nouvel appel du script
mode(0);                        // pour que le script se comporte comme une console (pas de point virgule => affichage du résultat) 


// **************** Exercice 1 ******************
if %f then

D=grand(5,1,"uin",1,6)
[p]=tabul(D)
disp("2)La fonction tabul donne le nombre de fois que les chiffres apparaissent sur plusieurs lancers de dés")
disp("3)Pour savoir qu''il y a un carré on regarde la deuxième colonne de p si on a le chiffre 4 c''est un carré, si il a 3 et2 c'' est un full et si la première colonne a 1,2,3,4,5 c''est une petite suite.")
end
// **************** Exercice 2 ******************
if %f then

    j=0;
    for i= 1:100000
       D2=grand(5,1,"uin",1,6);
      [p2]=tabul(D2);
       c=find(p2(:,2)==4);
       if c>0 then j=j+1; end
    end

disp('carré',j,'il y a')
disp('de faire un carré',j/100000,'il y a une probabilités de')
disp("1)b) il y a une probabilité théoriques de 6*5*5/6⁵= 0.01929") 
end

if %f then

    j=0;
    for i= 1:100000
       D3=grand(5,1,"uin",1,6);
      [p3]=tabul(D3);
       f=gsort(p3(:,2));
       if f(1)==3 & f(2)==2 then j=j+1; end
    end

disp('full',j,'il y a')
disp('de faire un full',j/100000,'il y a une probabilités de')
disp("1)b) il y a une probabilité théoriques de 6*5*10/6⁵= 0.0385") 
end


if %t then

    j=0;
    for i= 1:100000
       D4=grand(5,1,"uin",1,6);
      [p4]=tabul(D4);
       f=gsort(p4(:,2));
       if f(1)==3 & f(2)==1 then j=j+1; end
    end

disp('brelan',j,'il y a')
disp('de faire un brelan',j/100000,'il y a une probabilité de')
disp("1)b) il y a une probabilité théoriques de 6*5*4*10*2/6⁵= 0.30864") 
end

if %f then

    j=0;
    for i= 1:100000
       D4=grand(5,1,"uin",1,6);
      [p4]=tabul(D4);
       f=gsort(p4(:,2));
       if f(1)==5 then j=j+1; end
    end

disp('yam',j,'il y a')
disp('de faire un yam',j/100000,'il y a une probabilité de')
disp("1)b) il y a une probabilité théoriques de 6/6⁵=0.00077160") 
end
// **************** Exercice 3 ******************



// **************** Exercice 4 ******************




