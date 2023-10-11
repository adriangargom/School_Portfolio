
USE pokemonDB;

/*-----USERS AND ROLES-----*/

/*
 *  Creation of a new User Super admin with full privileges and access into all the
 *  databases and tables
*/
CREATE USER 'SuperAdmin' IDENTIFIED BY '1234';
GRANT ALL ON *.* TO 'SuperAdmin';

/*
 *  Creation of a new User PokeAdmin with full privileges over the pokemonDB tables
*/
CREATE USER 'PokeAdmin' IDENTIFIED BY '1234';
GRANT ALL ON pokemondb.* TO 'PokeAdmin';


/* ----- New Roles Creation -----*/

/* 
 *  New Role "ash" with full access over the pokemondb database 
*/
CREATE ROLE ash;
GRANT ALL ON pokemondb.* TO 'ash';

/* 
 *  New Role "pokeselect" with the following permissions : SELECT, EXECUTE. 
 *  Over the pokemonDB database
*/
CREATE ROLE Pokeselect;
GRANT SELECT , EXECUTE ON pokemondb.* TO 'Pokeselect';

/* 
 *  New Role "pokedata" with the following permissions : INSERT, DELETE, UPDATE, SELECT. 
 *  Over the pokemonDB database
*/
CREATE ROLE Pokedata;
GRANT INSERT , DELETE, UPDATE, SELECT ON pokemondb.* TO 'Pokedata';

/* 
 *  New Role "poketable" with the following permissions : CREATE, ALTER, SELECT, DELETE, DROP, INDEX, UPDATE, INSERT. 
 *  Over the pokemonDB database
*/
CREATE ROLE Poketable;
GRANT CREATE , ALTER ,SELECT ,DELETE,DROP ,INDEX ,UPDATE , INSERT ON pokemondb.* TO 'Poketable';

/* 
 *  New Role "pokefuncproce" with the following permissions : ALTER ROUTINE, EXECUTE, CREATE ROUTINE. 
 *  Over the pokemonDB database
*/
CREATE ROLE PokeFuncProce;
GRANT ALTER ROUTINE , EXECUTE , CREATE ROUTINE  ON pokemondb.* TO PokeFuncProce;


/* ----- Roles Assignation -----*/

CREATE USER 'adrian' IDENTIFIED BY '1234';
GRANT Poketable TO 'adrian'; -- Assign the "poketable" rol to the user "adrian"

CREATE USER 'javier' IDENTIFIED BY '1234';
GRANT Pokedata TO 'javier'; -- Assign the "pokedata" rol to the user "javier"

CREATE USER 'pol' IDENTIFIED BY '1234';
GRANT PokeFuncProce TO 'pol'; -- Assign the "pokefuncproce" rol to the user "pol"

CREATE USER 'gabriel' IDENTIFIED BY '1234';
GRANT Pokeselect TO 'gabriel'; -- Assign the "pokeselec" rol to the user "gabriel"

CREATE USER 'juan' IDENTIFIED BY '1234';
GRANT ash TO 'juan'; -- Assign the "ash" rol to the user "juan"


/* ----- User creation and permissions assignation -----*/

/*
 *  Creation of the user "miguel" and assignation of the following permissions : SELECT, INSERT, DELETE.
 *  Over the pokemondb database
*/
CREATE USER 'miguel' IDENTIFIED BY '1234';
GRANT SELECT , INSERT ,DELETE ON pokemondb.* TO 'miguel' ;

/*
 *  Creation of the user "pepe" and assignation of the following permissions : SELECT, UPDATE, CREATE ROUTINE, DROP.
 *  Over the pokemondb database
*/
CREATE USER 'pepe' IDENTIFIED BY '1234';
GRANT SELECT , UPDATE ,CREATE ROUTINE , DROP ON pokemondb.* TO 'pepe';

/*
 *  Creation of the user "guillermo" and assignation of the following permissions : SELECT, CREATE, DROP.
 *  Over the pokemondb database
*/
CREATE USER 'guillermo' IDENTIFIED BY '1234';
GRANT SELECT , CREATE , DROP ON pokemondb.* TO 'guillermo';
GRANT SELECT  ON *.* TO 'guillermo'; -- Provides the user guiller with the permmission for execute "SELECT" over all the databases and tables in the server 
/*
 *  Creation of the user "samuel" and assignation of the following permissions : SELECT, CREATE, DROP.
 *  Over the pokemondb database
*/
CREATE USER 'samuel' IDENTIFIED BY '1234';
GRANT SELECT , CREATE , DROP ON pokemondb.* TO 'guillermo';

/*
 *  Creation of the user "karen" and assignation of the following permissions : SELECT, CREATE ROUTINE, EXECUTE, ALTER ROUTINE.
 *  Over the pokemondb database
*/
CREATE USER 'karen' IDENTIFIED BY '1234';
GRANT SELECT , CREATE ROUTINE , EXECUTE , ALTER ROUTINE ON pokemondb.* TO 'karen';
GRANT SELECT ON *.* TO 'karen'; -- Provides the user karen with the permmission for execute "SELECT" over all the databases and tables in the server 


FLUSH PRIVILEGES ;  -- Reload the privileges information on the server


/* ----- Revoke and edit permisions over users ----- */


-- Revoke all the privileges assigned to the user karen over all the databases and tables of the server
REVOKE ALL PRIVILEGES ON *.* FROM 'karen';

-- Revoke the following privileges ( DROP ) over the user "guillermo" inside of all the tables of the "pokemondb" database
REVOKE DROP ON pokemondb.* FROM 'guillermo';

-- Revoke the following privileges ( DELETE, UPDATE ) over the user "miguel" inside of all the tables of the "pokemondb" database
REVOKE DELETE , UPDATE ON pokemondb.* FROM  'miguel';