
// Deux lignes utiles à mettre au début de chaque script :
xdel(winsid());                 // ferme toutes les fenetres a chaque nouvel appel du script
clear;                          // nettoie toutes les variables a chaque nouvel appel du script
mode(0);                        // pour que le script se comporte comme une console (pas de point virgule => affichage du résultat) 


// **************** Exercice 1 ******************
if %t then
        
        function result=monty_hall_simulation ( strategie )
         lavoiture = [0, 0, 0] ;
            lavoiture (grand(1,1,"uin",1,3)) = 1
            choix_initial = [0, 0, 0] ;
            choix_initial (grand(1,1,"uin",1,3)) = 1
            boites_restantes = lavoiture + choix_initial
            
            if strategie=='changer' then
                  [indice]=find(boites_restantes==0)
                  taille = length(indice)
                  if taille > 1 then 
                      result =0;
                  else                                    
                  choix_final = boites_restantes-choix_initial;
                  result = 1;
                  end
             end  

            if strategie=='garder' then 
                choix_final=choix_initial
                if choix_final==lavoiture then 
                    result = 1;
                else 
                    result = 0 ;
                end
                
            end 
        
        
                
                     
    endfunction
    

    resultats_garder=0;
    for i=0:1:10000
                rnd = [0,0];
                rnd (grand(1,1,"uin",1,2))=1;
                [indice]=find(rnd==0);
                if [indice] == 1 then
                    result = monty_hall_simulation( 'changer' );
                else 
                    result = monty_hall_simulation( 'garder' );
                end
        //result = monty_hall_simulation( 'changer' );
        //result = monty_hall_simulation( 'garder' );
        resultats_garder=result+resultats_garder;
    end
        resultats_garder/10000
end


// **************** Exercice 2 ******************



// **************** Exercice 3 ******************

//1)P(V)=1/3
//2)P(C|V)

// **************** Exercice 4 ******************




