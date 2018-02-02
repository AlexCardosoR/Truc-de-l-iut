--Alex Cardoso et Tom Sanchez
--13/09/2017

DROP TABLE AGENT 		CASCADE CONSTRAINTS;
DROP TABLE CLIENT 		CASCADE CONSTRAINTS;
DROP TABLE COMPTE 		CASCADE CONSTRAINTS;
DROP TABLE MOUVEMENT 		CASCADE CONSTRAINTS;
DROP TABLE PARRAINE 		CASCADE CONSTRAINTS;
DROP TABLE CHARGE_CLIENTELLE 	CASCADE CONSTRAINTS;
DROP TABLE CLIENT_COMPTE	CASCADE CONSTRAINTS;
drop function fct_solde;
drop view verif_solde;


CREATE TABLE AGENT ( 
MATRICULE VARCHAR2(5 BYTE), 
NOM VARCHAR2(50 BYTE), 
PRENOM VARCHAR2(50 BYTE), 
DDN DATE, 
CIVILITE CHAR(1 BYTE) 
);

CREATE TABLE CLIENT ( 
ID_CLIENT VARCHAR2(10 BYTE), 
NOM VARCHAR2(50 BYTE), 
PRENOM VARCHAR2(50 BYTE), 
DDN DATE, 
ADRESSE VARCHAR2(200 BYTE), 
CP VARCHAR2(7 BYTE), 
VILLE VARCHAR2(100 BYTE), 
CIVILITE CHAR(1 BYTE) 
);

CREATE TABLE COMPTE ( 
NUMCPT VARCHAR2(40 BYTE), 
DESIGNATION VARCHAR2(200 BYTE), 
SOLDE NUMBER(10,2) 
);

CREATE TABLE MOUVEMENT ( 
ID_MOUVEMENT NUMBER(20), 
NUMCPT VARCHAR2(40 BYTE), 
DT_MOUVEMENT DATE, 
MONTANT NUMBER(10,2), 
DESIGNATION VARCHAR2(100 BYTE), 
INFO_DC VARCHAR2(200 BYTE) 
);

CREATE TABLE PARRAINE ( 
ID_PARRAIN VARCHAR2(10 BYTE), 
ID_CLIENT VARCHAR2(10 BYTE), 
DATE_PARRAINAGE DATE 
);

CREATE TABLE CHARGE_CLIENTELLE ( 
MATRICULE VARCHAR2(5 BYTE), 
ID_CLIENT VARCHAR2(10 BYTE), 
DEBUT DATE, FIN DATE 
);

CREATE TABLE CLIENT_COMPTE (
ID_CLIENT VARCHAR2(10 BYTE), 
NUMCPT VARCHAR2(40 BYTE), 
DATE_RATTACHEMENT DATE, 
TYPE_RATTACHEMENT VARCHAR2(100 BYTE) 
);


alter table client add (primary key (id_client));
alter table charge_clientelle add (primary key (id_client,matricule,debut));
alter table agent add (primary key (matricule));
alter table client_compte add (primary key (id_client,numcpt));
alter table compte add (primary key (numcpt));
alter table mouvement add (primary key (id_mouvement));
alter table parraine add (primary key (id_parrain,id_client));

ALTER TABLE charge_clientelle
ADD FOREIGN KEY (id_client) REFERENCES client(id_client); 
ALTER TABLE charge_clientelle
ADD FOREIGN KEY (matricule) REFERENCES agent(matricule); 
ALTER TABLE client_compte
ADD FOREIGN KEY (id_client) REFERENCES client(id_client); 
ALTER TABLE client_compte
ADD FOREIGN KEY (numcpt) REFERENCES compte(numcpt); 
ALTER TABLE mouvement
ADD FOREIGN KEY (numcpt) REFERENCES compte(numcpt); 
ALTER TABLE parraine
ADD FOREIGN KEY (id_parrain) REFERENCES client(id_client); 
ALTER TABLE parraine
ADD FOREIGN KEY (id_client) REFERENCES client(id_client); 

--2)
--insert into client values ('75390651','Black','Sirius',TO_DATE('19/04/1975','DD/MM/YYYY'),'M','63000','13 avenue d''italie','Clermont-Fd');
--Réponse: L'ordre des colonnes n'est pas respecté.
--Correction: insert into client values ('75390651','Black','Sirius',TO_DATE('19/04/1975','DD/MM/YYYY'),'13 avenue d''italie','63000','Clermont-Fd','M');

--3)
--@/home/etud/alcardosor/Desktop/2A/BDD/TP2/TP2_insert_tables.sql


/*create view verif_solde as
select C.numcpt, solde, verif
from compte C, (select numcpt, sum(montant) verif
                from mouvement
                group by numcpt) calcul
where C.numcpt = calcul.numcpt and solde != verif;


--4)
create function fct_solde(id_client_entry in varchar2(8))
return number
is solde_total number;
begin
select sum(solde) into solde_total
from compte, compte_client
where compte_client.id_client = id_client_entry
and compte.numcpt = compte_client.numcpt;

return(solde_total);
end;
/

select fct_solde('31627673') from compte group by 1;
*/
