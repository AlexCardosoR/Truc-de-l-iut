/*Insert into CLIENT
   (ID_CLIENT, NOM, PRENOM, DDN, 
     ADRESSE,CP, VILLE,  CIVILITE
    )
 Values
   ('10081265', 'SANNIE', 'Jean-Louis', TO_DATE('21/07/1949', 'DD/MM/YYYY'), 
     '64 rue La Capelle-Bonance','63000', 'Clermont-Ferrand',  'M'
    );
    
    Insert into client_compte
   (ID_CLIENT, NUMCPT,DATE_RATTACHEMENT,  TYPE_RATTACHEMENT)
 Values
   ('10081265', '2803268247',TO_DATE('12/10/2012 06:46:02', 'DD/MM/YYYY HH24:MI:SS'),  'compte personnel');
*/
   
--1
select Cl.id_client,Cl.nom,Cl.prenom, Cc.numcpt 
from client Cl, client_compte Cc 
where Cl.id_client='10081265' and Cl.id_client= Cc.id_client;

--Pb de tables mais sa marche.

--2

select Cl.id_client, Cl.nom, Cl.prenom, sr.numcpt, sr.dt_mouvement, sr.montant
from client Cl, client_compte Cc
(select M.id_mouvement from mouvement M, client_compte Cc where M.numcpt=Cc.numcpt) sr 
where Cl.id_client=Cc.id_client and sr.numcpt=Cc.numcpt;

--Pb de tables mais sa marche.

--3
select max(montant) "plus eleve ", min(montant) "plus petit" from mouvement;

-- ~ plus eleve  plus petit
-- ~ ----------- ----------
-- ~ 

--4
select max(montant) "plus eleve" from mouvement;
select min(montant) "plus petit" from mouvement;

-- ~ plus eleve
-- ~ ----------
-- ~ 
-- ~ 
-- ~ 
-- ~ plus petit
-- ~ ----------

--5


--6
select Cl.id_client, Cl.nom, Cl.prenom, sr.numcpt, sr.dt_mouvement,max(sr.montant)
from client Cl
(select * from mouvement M, client_compte Cc where M.montant<-100)sr
where Cl.id_client=Cc.id_client and Cc.numcpt=M.numcpt;

--7
select Cl.id_client, M.dt_mouvement
from client Cl, mouvement M, client_compte Cc
where Cl.id_client=Cc.id_client and Cc.numcpt=M.numcpt;

--8
select 
