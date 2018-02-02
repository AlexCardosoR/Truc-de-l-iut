drop table trace ;
drop table mouvement1;
drop table compte1;




create table Trace (
	quand DATE,
	qui varchar2(20),
	quoi varchar2(40)
	);

CREATE TABLE MOUVEMENT1 ( 
ID_MOUVEMENT NUMBER(20), 
NUMCPT VARCHAR2(40 BYTE), 
DT_MOUVEMENT DATE, 
MONTANT NUMBER(10,2), 
DESIGNATION VARCHAR2(100 BYTE), 
INFO_DC VARCHAR2(200 BYTE) 
);

CREATE TABLE COMPTE1 ( 
NUMCPT VARCHAR2(40 BYTE), 
DESIGNATION VARCHAR2(200 BYTE), 
SOLDE NUMBER(10,2) 
);


Insert into COMPTE1
   (NUMCPT, DESIGNATION, SOLDE)
 Values
   ('7503114368', 'compte personnel', 1000);
Insert into COMPTE1
   (NUMCPT, DESIGNATION, SOLDE)
 Values
   ('4808817053', 'compte personnel', 700);



Insert into MOUVEMENT1	Values (474, '7503114368', TO_DATE('28/05/2014 09:11:21', 'DD/MM/YYYY HH24:MI:SS'), -70, NULL, 
    NULL);
Insert into MOUVEMENT1	Values (475, '4808817053', TO_DATE('20/02/1991 09:11:21', 'DD/MM/YYYY HH24:MI:SS'), 160, NULL, 
    NULL);

--select * from mouvement1;
-- 1/

-- Table dropped.
-- Table created.

-- 2/ Cette commande permet d'afficher le nom de l'utilisateur qui est connecté.

--SYS_CONTEXT('USERENV','SESSION_USER')
--------------------------------------------------------------------------------
--ALCARDOSOR

--3/a/
create or replace trigger trig_tracer 
after delete on mouvement1
for each row

declare 
dnom varchar2(20);

begin 
select sys_context ('USERENV', 'SESSION_USER') into dnom from dual;
Insert into trace values (sysdate,dnom,:old.ID_MOUVEMENT||' ' || :old.NUMCPT||' ' || :old.DT_MOUVEMENT||' ' || :old.MONTANT||' ' || :old.DESIGNATION ||' '|| :old.INFO_DC );
end;
/

Delete from mouvement1 where id_mouvement=474;


/*Trigger created.

1 row deleted.


QUAND	  QUI		       QUOI
--------- -------------------- ----------------------------------------
20-SEP-17 ALCARDOSOR	       474 7503114368 28-MAY-14 -74.35

*/








--3/b/
select * from compte1;

CREATE OR REPLACE TRIGGER trig_update
BEFORE 
INSERT OR UPDATE OR DELETE ON MOUVEMENT1

FOR EACH ROW

BEGIN
	IF INSERTING OR UPDATING THEN
		UPDATE COMPTE1 SET SOLDE = SOLDE + :NEW.MONTANT WHERE :NEW.NUMCPT=COMPTE1.NUMCPT;
	END IF;
	
	IF DELETING THEN
		UPDATE COMPTE1 SET SOLDE = SOLDE - :OLD.MONTANT WHERE :NEW.NUMCPT=COMPTE1.NUMCPT;
	END IF;
END;
/


--4/
Insert into MOUVEMENT1 Values(474, '4808817053', TO_DATE('20/02/1991 09:11:21', 'DD/MM/YYYY HH24:MI:SS'), 1200, NULL, NULL);

--select * from compte1;

/*
	NUMCPT
----------------------------------------
DESIGNATION
--------------------------------------------------------------------------------
     SOLDE
----------
7503114368
compte personnel
    594.33

4808817053
compte personnel
    736.65

NUMCPT
----------------------------------------
DESIGNATION
--------------------------------------------------------------------------------
     SOLDE
----------



Trigger created.


1 row created.


NUMCPT
----------------------------------------
DESIGNATION
--------------------------------------------------------------------------------
     SOLDE
----------
7503114368
compte personnel
    594.33

4808817053
compte personnel
     893.8

NUMCPT
----------------------------------------
DESIGNATION
--------------------------------------------------------------------------------
     SOLDE
----------

*/

Delete from mouvement1 where id_mouvement=475;
select * from compte1;


/*
5 a) On peut résoudre le problème de 2 façons :
	- Modifier les doits de lecture sur les tables pour des utilisateurs donnés avec la commande GRANT SELECT ON TRACE TO alcardosor
        - Utiliser des vues et ce comporter de la même façon au niveau des permis qu'avec la solution antérieur



5 b) - grant select on trace to alcardosor; // depuis alcardosor : select * from tosanchez.trace;
     - create view matrace as select * from trace; // depuis alcardosor : select * from tosanchez.matrace;
*/



