--Alex Cardoso et Tom Sanchez
--7/09/2017


drop table data_banque;
drop table t_telephone;
drop table t_client;
drop table t_compte;


--question 1 
create table data_banque as select * from ladesros.source;

 -- ~ Name					   Null?    Type
 -- ~ ----------------------------------------- -------- ----------------------------
 -- ~ ID_CLIENT					    VARCHAR2(10)
 -- ~ NOM						    VARCHAR2(50)
 -- ~ PRENOM 					    VARCHAR2(50)
 -- ~ DDN						    DATE
 -- ~ ADRESSE					    VARCHAR2(200)
 -- ~ CP						    VARCHAR2(7)
 -- ~ VILLE						    VARCHAR2(100)
 -- ~ CIVILITE					    CHAR(1)
 -- ~ NUMCPT 					    VARCHAR2(40)
 -- ~ DATE_RATTACHEMENT				    DATE
 -- ~ TYPE_RATTACHEMENT				    VARCHAR2(100)
 -- ~ DESIGNATION					    VARCHAR2(200)
 -- ~ SOLDE						    NUMBER(10,2)
 -- ~ TELEPHONE_FIXE 				    VARCHAR2(15)
 -- ~ TELEPHONE_MOBILE				    VARCHAR2(15)
 -- ~ TELEPHONE_PROFESSIONNEL			    VARCHAR2(15)
 -- ~ TELEPHONE_CONTACT				    VARCHAR2(15)
 -- ~ NUM_INSEE					    VARCHAR2(10)

-- Pour la 1 FN : La 1ere forme normale n'est pas respectée car elle contient une structure répétitives.
-- Pour la 2 FN : La 2eme forme normale n'est pas respectée car elle ne respecte pas la première.
-- Pour la 3 FN : La 3eme forme normale n'est pas respectée car elle ne respecte pas la deuxième.
-- Pour la 4 FN : La 4eme forme normale n'est pas respectée car elle ne respecte pas la troisième.

create table t_telephone as select TELEPHONE_FIXE,TELEPHONE_MOBILE,TELEPHONE_PROFESSIONNEL,TELEPHONE_CONTACT from data_banque;
create table t_client as select distinct id_client,nom,prenom,ddn,adresse,cp,ville,civilite,numcpt,telephone_fixe from data_banque;
create table t_compte as select numcpt,date_rattachement,type_rattachement,designation,solde from data_banque;
--alter table t_client add constraint pk_id_client primary key (id_client); 
--alter table t_telephone add constraint pk_telephone_mobile primary key (telephone_mobile); 
--alter table t_compte add constraint pk_numcpt primary key (numcpt);
alter table t_client add constraint fk_numcpt foreign key (numcpt)references t_compte(numcpt);
alter table t_client add constraint fk_telephone_mobile foreign key (telephone_mobile)references t_telephone(telephone_mobile) ;
