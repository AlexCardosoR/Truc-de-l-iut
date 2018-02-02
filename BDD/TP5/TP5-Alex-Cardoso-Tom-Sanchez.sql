--1.
	select c.nom, c.prenom, c.numcpt, cc.id_client
	from client c,  client_compte cc
	where cc.id_client='10081265' and cc.id_client=c.id_client;

	-- ~ ID_CLIENT  NOM
	-- ~ ---------- --------------------------------------------------
	-- ~ PRENOM
	-- ~ --------------------------------------------------
	-- ~ NUMCPT
	-- ~ ----------------------------------------
	-- ~ 10081265   SANNIE
	-- ~ Jean-Louis
	-- ~ 2803268247


--2.
	select cc.id_client, c.nom, c.prenom, m.numcpt, m.dt_mouvement, montant
	from client_compte cc, client c, mouvement m
	where cc.id_client='10081265' 
	and cc.id_client=c.id_client
	and m.numcpt=cc.numcpt;
	

	-- ~ ID_CLIENT  NOM
	-- ~ ---------- --------------------------------------------------
	-- ~ PRENOM
	-- ~ --------------------------------------------------
	-- ~ NUMCPT					 DT_MOUVEM    MONTANT
	-- ~ ---------------------------------------- --------- ----------
	-- ~ Jean-Louis
	-- ~ 2803268247				 19-APR-09	-9.76
	-- ~ 
	-- ~ 10081265   SANNIE
	-- ~ Jean-Louis
	-- ~ 2803268247				 28-FEB-14     122.33
	-- ~ 
	-- ~ 
	-- ~ ID_CLIENT  NOM
	-- ~ ---------- --------------------------------------------------
	-- ~ PRENOM
	-- ~ --------------------------------------------------
	-- ~ NUMCPT					 DT_MOUVEM    MONTANT
	-- ~ ---------------------------------------- --------- ----------
	-- ~ 10081265   SANNIE
	-- ~ Jean-Louis
	-- ~ 2803268247				 06-FEB-04     -26.44

--3.
	select min(montant), max(montant)
	from mouvement;

	-- ~ MIN(MONTANT) MAX(MONTANT)
	-- ~ ------------ ------------
	 -- ~ -199.99	  5874.59

--4.	
	select min(montant) AS Montants from mouvement
	union
	select max(montant) from mouvement;
	
	

--5.
	select cc.id_client, nom, prenom, m.numcpt, dt_mouvement, montant
	from client_compte cc, client c, mouvement m
	where cc.id_client=c.id_client
	and m.numcpt=cc.numcpt
	and montant IN
	(select min(montant)
	from mouvement)
	and montant IN
	(select MAX(montant)
	from mouvement);


--6.
	select c.id_client, nom, prenom, m.numcpt, dt_mouvement, max(montant)
	from client c, client_compte cc, mouvement m
	where cc.id_client=c.id_client
	and m.numcpt=cc.numcpt
	and montant NOT IN(
		select montant
		from mouvement
		where montant<-100);
	

--8.
	select c.id_client, nom, prenom, m.numcpt
	from client c, client_compte cc, mouvement m
	where cc.id_client=c.id_client
	and m.numcpt=cc.numcpt
	and m.montant>=50
	and dt_mouvement>to_date('25/07/2017','DD/MM/YYYY');


	-- ~ ID_CLIENT  NOM
	-- ~ ---------- --------------------------------------------------
	-- ~ PRENOM
	-- ~ --------------------------------------------------
	-- ~ NUMCPT
	-- ~ ----------------------------------------
	-- ~ 26376982   CHEVREL
	-- ~ Florent
	-- ~ 9445419501
	-- ~ 
	-- ~ 17818573   QUINARD
	-- ~ Julien
	-- ~ 5443270971
	-- ~ 
	-- ~ ID_CLIENT  NOM
	-- ~ ---------- --------------------------------------------------
	-- ~ PRENOM
	-- ~ --------------------------------------------------
	-- ~ NUMCPT
	-- ~ ----------------------------------------
	-- ~ 
	-- ~ 33269959   DUMOULIN
	-- ~ Yves
	-- ~ 030444629

	--9.
	set autotrace traceonly
	
	select sum(montant)
	from 
		(select cc.id_client, cc.numcpt, montant
		from  client_compte cc, mouvement m
		where cc.id_client='10081265'
		and cc.numcpt=m.numcpt);
			
	/*Execution Plan
	----------------------------------------------------------
	Plan hash value: 864964792

	--------------------------------------------------------------------------------
	-----

	| Id  | Operation	    | Name	    | Rows  | Bytes | Cost (%CPU)| Time
		|

	--------------------------------------------------------------------------------
	-----

	|   0 | SELECT STATEMENT    |		    |	  1 |	 36 |	 73   (0)| 00:00
	:01 |

	|   1 |  SORT AGGREGATE     |		    |	  1 |	 36 |		 |
		|

	|*  2 |   HASH JOIN	    |		    |	 36 |  1296 |	 73   (0)| 00:00
	:01 |

	|*  3 |    TABLE ACCESS FULL| CLIENT_COMPTE |	  1 |	 20 |	  5   (0)| 00:00
	:01 |

	|   4 |    TABLE ACCESS FULL| MOUVEMENT     | 51577 |	805K|	 68   (0)| 00:00
	:01 |

	--------------------------------------------------------------------------------
	-----


	Predicate Information (identified by operation id):
	---------------------------------------------------

	   2 - access("CC"."NUMCPT"="M"."NUMCPT")
	   3 - filter("CC"."ID_CLIENT"='10081265')
