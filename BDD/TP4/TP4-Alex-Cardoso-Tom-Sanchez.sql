

--1/
SELECT 'Il est '|| to_char(sysdate,'HH24') || ' heure '|| to_char(sysdate,'MI') ||' minutes ' || ' et ' || to_char(sysdate,'SS') ||' secondes, nous sommes le'|| INITCAP(to_char(sysdate,'DAY')) from DUAL;

--Il est 08 heure 21 minutes  et 21 secondes, nous sommes le Wednesday


--2/
SELECT RPAD((to_char(sysdate,'DAY')),20,'$') from dual;
--WEDNESDAY$$$$$$$$$$$


--3/
spool question3.sql;



@question3.sql;
spool off;

--Concurrence d'accés

/*
1/

alcardosor@session1: create table tp4 as select * from client;
tosanchez@session2: create table tp4 as select * from client;

alcardosor@session1: DELETE tp4 where id_client='75390651';
	1 row deleted.
tosanchez@session2: DELETE tp4 where id_client='75390651';
	1 row deleted.
	
La 2ème transaction n'est pas bloquée car les create ont été fait dans 2 sessions distinctes.


2/
alcardosor@session1: DELETE tp4 where id_client='75390651';
	1row deleted.
alcardosor@session2: DELETE tp4 where id_client='75390651';
...
alcardosor@session1: rollback;
	Rollback completed.
alcardosor@session2: rollback;
	Rollback completed.

La 2ème transaction est bloquée car il a un cadenas sur la table et sur la ligne où client='75390651'.
Il faudrait faire un commit aprés la 1er transaction pour déverouiller la ligne et la table.



3/
alcardosor@session1: DELETE tp4 where id_client='75390651';
	1row deleted.
alcardosor@session2: DELETE tp4 where id_client='CONAND';
...
alcardosor@session1: rollback;
	rollback completed.
alcardosor@session2: 
	1 row deleted.
alcardosor@session1: rollback;
	Rollback completed.
alcardosor@session2: rollback;
	Rollback completed.
	
La 2ème tansaction est bloquée par la première car elle a posé un verrou de ligne. 
La deuxième attend donc que la première fasse tombé son verrou pour pouvoir s'éxécuter. 



4/
alcardosor@session1: UPDATE tp4 SET nom='CONNAND' WHERE id_client='75390651';
	1 row updated.
alcardosor@session2: ALTER TABLE tp4 MODIFY (cp varchar2(8));
	ERROR at line 1;
	ORA-0054: ressource busy and aquire with NOWAIT specified or timeout expired
alcardosor@session1: rollback;
	Rollback completed.
alcardosor@session2: ALTER TABLE tp4 MODIFY (cp varchar2(8));
	Table altered.
	
La 1er transaction met un verrou de ligne et de table.
La  2ème tansaction est bloqué par les verrous.
La 1er transaction réalise un rollback et dévérouille la table et ligne.
La 2ème transaction peut s'éxécuter librement.
	
	
5/

alcardosor@session1: DELETE tp4;
		1 row deleted.
alcardosor@session1: SELECT count(1) FROM tp4;
  COUNT(1)
----------
	 0




/*
