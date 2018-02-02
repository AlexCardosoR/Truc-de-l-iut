
// Trois lignes utiles à mettre au début de chaque script :
xdel(winsid());                 // ferme toutes les fenetres a chaque nouvel appel du script
clear;                          // nettoie toutes les variables a chaque nouvel appel du script
mode(0);                        // pour afficher toutes les lignes ne terminant pas par ;


// Charge les fonctions du TP
exec("patinage_vitesse_2002.sce", -1);
exec("tp3_fonctions.sci", -1);


// **************** Exercice 1 ******************
if %f then
    //N=10000;
    //Y=grand(N,2,"exp",0.2);
    //Mn=sum(Y,"c")/2;
    //S2=(sum(Y.^2,"c")/2)-(Mn.^2);
    
    //ax=[0:0.01:1];
        
     //   f=(my_histc(ax,Mn)/N);
       // figure();
        //plot(ax,f,'red');
      couleur = ["blue","magenta","yellow","red","black"]

      
                
         bx=[0:0.01:0.2];
         ax=[0:0.01:1];
         
         N=10000;
          
       y=1;  
       
       for i = [2,5,10,50,200]
          

        Y=grand(N,i,"exp",0.2);
        
            f=(my_histc(ax,Y)/N);
            plot(ax,f,couleur(y));
            y=y+1;
       end   
          
          
       
       figure();
       y=1;
      for i = [2,5,10,50,200]
          

        Y=grand(N,i,"exp",0.2);
        Mn=sum(Y,"c")/i;
        
            
            f=(my_histc(ax,Mn)/N);
            plot(ax,f,couleur(y));
            y=y+1;
       end
            
            
       figure();
       y=1;
       for i = [2,5,10,50,200]
              
        Y=grand(N,i,"exp",0.2);
        Mn=sum(Y,"c")/i;
        S2=(sum(Y.^2,"c")/i)-(Mn.^2);
        
        f=(my_histc(bx,S2)/N);
        plot(bx,f,couleur(y));
        y=y+1;
      
        end
      
        

        
        
        Emn=sum(Mn)/N;
        Es2=sum(S2)/N;
        
        
        disp("La moyenne théorique est de 0.2, on peut donc voir que m est un bon estimateur de la moyenne puisque la forme normale de m est centré en 0.2") 
        disp("La variance théorique est de 0.03 ")
    
end 







// **************** Exercice 2 ******************
if %t then
      delta=temps(:,2)-temps(:,1);
        plot(1:23,delta);
      
     
      idx=find(delta>0);
       interieur=length(idx)
      exterieur=23-interieur
      
    
end

















































