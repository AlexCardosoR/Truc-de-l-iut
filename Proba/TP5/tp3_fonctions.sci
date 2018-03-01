// Fichier de fonctions Scilab (.sci) pour le TP3



// ========================================================================
//          debit_routeur : fonction aléatoire qui renvoie un débit,
//                          pour un routeur pris au hasard sur internet
// ========================================================================

function deb = debit_routeur()

    // poids des 3 composantes de la pdf
    p1 = 0.5 ;
    p2 = 0.25 ;
    p3 = 0.25 ;

    cmp = rand();

    if cmp < p1 then         // composante normale
        m = 60;
        sig = 7;
        deb = grand(1,1,"nor",m,sig);
    elseif cmp < p1+p2 then  // première composante gamma
        shape = 3;
        scale = 1/4;
        deb = grand(1,1,"gam",shape,scale);
    else                      // deuxième composante gamma
        shape = 9;
        scale = 1/4;
        deb = grand(1,1,"gam",shape,scale);
    end

endfunction




// ========================================================================
//          my_histc : Calcul d'histogramme
//
// remplacement "maison" à la fonction Scilab 'histc', autrefois absente des salles de TP.
//
// INPUT :
//     * ax : axe des abscisses, définissant les différentes classes de l'histogramme
//     * data : données à trier dans l'histogramme
// OUTPUT :
//     * cf : histogramme des données
//
// L'usage est globalement le même que celui de 'histc', à deux détails près :
//     * utilisation de la variable 'ax' un peu plus intuitive qu'avec 'histc'
//     * l'histogramme en sortie n'est pas normalisé. Il faut le faire après coup, si nécessaire.
// ========================================================================


function cf = my_histc(ax, data)

    // Version bourrine et lente
    // cf = zeros(length(ax), 1);
    // for n = 1:length(data)
    //     i = find(ax>=data(n), 1);
    //     if ~isempty(i) then
    //         cf(i) = cf(i)+1;
    //     end
    // end

    // Version scilab avec dsearch
    ax = [-%inf matrix(ax, 1, length(ax))];   // nouvel axe : assure un format ligne, rajoute une case à gauche
    [ind, cf] = dsearch(data, ax);

endfunction



