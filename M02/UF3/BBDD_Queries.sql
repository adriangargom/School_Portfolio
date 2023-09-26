                               
/*-----Queries-----*/

/* Queri 1
	- Show sorted data.
    
    Show all the objects that are pokeballs of the object table and order theme by name
*/
SELECT obj.id AS id, obj.name AS name FROM object AS obj
	RIGHT JOIN pokeballs AS pok ON pok.id = obj.id
    ORDER BY name;
    
    
/* Queri 2
	- Use of subqueries in the various sections of a query: SELECT, FROM and WHERE.
    
    Count the cuantity of objects from each type
*/
SELECT (SELECT COUNT(*) FROM pokeballs) AS object_pokeballs_quantity, 
	   (SELECT COUNT(*) FROM healing) AS object_healing_quantity, 
	   (SELECT COUNT(*) FROM special) AS object_special_quantity;
       
       
/* Queri 3
	- Multiple JOIN type combinations at once.
    
    Select the name and description of the pokeballs from the generation 6
    
*/
SELECT obj.name, obj.description FROM object AS obj
	RIGHT JOIN pokeballs AS pok ON pok.id = obj.id
    INNER JOIN generation_object AS gen_obj ON gen_obj.id_object = obj.id
    WHERE id_generation = 6;
    
    
/* Queri 4
	- Multiple JOIN type combinations at once.
	- Use one of the clauses: UNION, INTERSECT and EXCEPT.
    
    Select all the objects of type pokeball, healing and special that apear in generation 5
*/
SELECT "Pokeball" AS type, obj.name, obj.description FROM object AS obj
	RIGHT JOIN pokeballs AS pok ON pok.id = obj.id
    INNER JOIN generation_object AS gen_obj ON gen_obj.id_object = obj.id
    WHERE id_generation = 5
UNION
SELECT "Healing" AS type, obj.name, obj.description FROM object AS obj
	RIGHT JOIN healing AS hel ON hel.id = obj.id
    INNER JOIN generation_object AS gen_obj ON gen_obj.id_object = obj.id
    WHERE id_generation = 5
UNION
SELECT "Special" AS type, obj.name, obj.description FROM object AS obj
	RIGHT JOIN special AS spe ON spe.id = obj.id
    INNER JOIN generation_object AS gen_obj ON gen_obj.id_object = obj.id
    WHERE id_generation = 5;
    
/* Queri 5
	- Using multiple tables at the same time in the FROM.
    - Use of subqueries in the various sections of a query: SELECT, FROM and WHERE.
    
    Show the pokemon id, the name and the generation ID of the pokemons where the type id is less than 10 and the types are not plant or fire
*/

SELECT pok.id_pokemon AS pokemon_id, pok.name AS name , pok.generation_id FROM pokemon AS pok
	INNER JOIN pokemon_type AS pok_typ ON pok_typ.pokemon_id = pok.id_pokemon
    WHERE pok_typ.type_id IN (SELECT typ.id_type FROM type AS typ 
								WHERE typ.id_type < 10 && typ.name NOT IN ("planta", "fuego"))
                                ORDER BY pokemon_id DESC, name ASC;
                                
/* Queri 6
	- Use one of the clauses: UNION, INTERSECT and EXCEPT.

	Select the generation id from generations that appear in a game
*/
SELECT gen.id FROM generation AS gen
INTERSECT
SELECT gam.generation_id FROM game AS gam;

/* Queri 7
	- Use one of the clauses: UNION, INTERSECT and EXCEPT.

	Select the generation id that not appear in a game
*/
SELECT gen.id FROM generation AS gen
EXCEPT
SELECT gam.generation_id FROM game AS gam;

-- Query 8
/* Select all the pokemons and each pokemon type*/
SELECT p.name AS pokemon, g.number AS generation, t.name AS type
FROM pokemon p
	INNER JOIN generation g ON p.generation_id = g.id
	INNER JOIN pokemon_type pt ON p.id_pokemon = pt.pokemon_id
	INNER JOIN type t ON pt.type_id = t.id_type
ORDER BY p.name;


-- Query 9
/*Show all the objects and the generation number and region name they appear*/
SELECT g.number AS generation_number, g.region AS generation_region, o.name AS object_name
FROM generation g
	INNER JOIN generation_object go ON g.id = go.id_generation
	INNER JOIN object o ON go.id_object = o.id
	LEFT JOIN pokeballs p ON o.id = p.id
	LEFT JOIN healing h ON o.id = h.id
	LEFT JOIN special s ON o.id = s.id
ORDER BY g.number, o.name;


-- Query 10
/*Select all the pokemons and the games where they appear*/
SELECT DISTINCT g.name AS Game, p.name AS Pokemon
FROM game g, pokemon p, generation ge
WHERE p.generation_id < 2 AND ge.starters IS NOT NULL;

-- Query 11
/*Select the pokemon name, type number of evolutions and region they belong to pokemons where the evolution number is bigger or equal to 2*/
SELECT p.name AS pokemon, t.name AS type, p.number_evolution, g.region
FROM pokemon p
	INNER JOIN pokemon_type pt ON p.id_pokemon = pt.pokemon_id
	INNER JOIN type t ON pt.type_id = t.id_type
    INNER JOIN generation g ON p.id_pokemon = g.id
WHERE p.number_evolution >= 2
ORDER BY t.name, p.name;

-- Query 12
/*Select the gym_name, medal_name adn generation number each medal and gym belongs*/
SELECT g.name AS gym_name, m.name AS medal_name, gr.number AS generation_number
FROM gym g
	INNER JOIN gym_leader_gym_medal glgm ON g.id = glgm.gym_id
	INNER JOIN medal m ON glgm.medal_id = m.id
	INNER JOIN gym_leader gl ON glgm.leader_id = gl.id
	INNER JOIN generation gr ON gr.id = gl.generation_id
ORDER BY gr.number, g.name;

-- Queri 13                    
/* Know the games relised under  1997 and her generation region*/
                               
SELECT g.name ,g2.region  FROM game g 
	JOIN generation g2 ON g.generation_id = g2.id 
	WHERE YEAR(g.release_date) <= '1997';
	
	
-- Queri 14
/*Know how many games are in ech region*/
	
SELECT g.region , COUNT(*) AS games FROM generation g 
	JOIN game g2 ON g.id = g2.generation_id 
	GROUP BY g.region ;
	
-- Queri 15
/* Know the diferents object and the type whe can put a where and a condition like h.id IS NOT NULL to know the only one type */

SELECT o.name , h.id , p.id ,s.id  FROM object o  
	LEFT JOIN healing h ON o.id = h.id
	LEFT JOIN pokeballs p ON o.id = p.id
	LEFT JOIN special s ON o.id  = s.id;
	
-- Queri 16
/* Know the GYM LEADER ANG HIS/HER MEDAL */

SELECT gl.name AS 'GYM LEADER',m.name AS MEDAL FROM gym_leader gl 
	JOIN gym_leader_gym_medal glgm ON gl.id = glgm.leader_id 
	JOIN medal m ON glgm.medal_id = m.id ORDER BY gl.name ;

-- Queri 17
/* Know the the gym leaders and his/her gym with generation up of 2000 and have under 20 years */

SELECT gl.name , g2.name  FROM generation g 
	JOIN gym_leader gl ON g.id = gl.generation_id 
	JOIN gym_leader_gym_medal glgm ON gl.id = glgm.leader_id 
	JOIN gym g2 ON glgm.gym_id = g2.id
	WHERE YEAR(release_date) > '2000' AND gl.age > 20;