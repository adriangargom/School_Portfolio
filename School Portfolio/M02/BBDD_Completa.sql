DROP DATABASE IF EXISTS pokemonDB;

CREATE DATABASE pokemonDB;

USE pokemonDB;


CREATE TABLE generation(
	id				INTEGER			AUTO_INCREMENT,
    number			TINYINT(2)		NOT NULL,
    release_date	DATE			NOT NULL,
    region			VARCHAR(40)		NOT NULL,
    starters		VARCHAR(40)		NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT uk_generation_number_region_starters UNIQUE(number, region, starters),
    CONSTRAINT ck_generation_number CHECK(number > 0),
    CONSTRAINT ck_generation_release_date CHECK(release_date >= "1996-02-26")
    );

/*-----New tables-----*/

CREATE TABLE object(
	id				INTEGER			AUTO_INCREMENT,
    name			VARCHAR(40)		NOT NULL,
    description		VARCHAR(150)	NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT uk_generation_name UNIQUE(name));
    
CREATE TABLE pokeballs(
	id				INTEGER,
    catch_rate		INTEGER,
    price			INTEGER,
    rarity			VARCHAR(40),
    drop_chance		INTEGER,
    PRIMARY KEY(id),
	CONSTRAINT fk_object_pokeballs FOREIGN KEY (id) REFERENCES object(id)
);

CREATE TABLE healing(
	id						INTEGER,
    healing_quantity		INTEGER,
    price					INTEGER,
    drop_chance				INTEGER,
    PRIMARY KEY(id),
	CONSTRAINT fk_object_healing FOREIGN KEY (id) REFERENCES object(id)
);

CREATE TABLE special(
	id					INTEGER,
    regional_id			INTEGER,
    price				INTEGER,
    drop_chance			INTEGER,
    PRIMARY KEY(id),
	CONSTRAINT fk_object_special FOREIGN KEY (id) REFERENCES object(id)
);

CREATE TABLE game(
	id				INTEGER		AUTO_INCREMENT,
    generation_id	INTEGER,
    name			VARCHAR(40),
    release_date	DATE,
    PRIMARY KEY(id, generation_id),
    CONSTRAINT fd_generation_game FOREIGN KEY (generation_id) REFERENCES generation(id)
);

/*----------------------*/

CREATE TABLE generation_object(
	id_generation 		INTEGER,
    id_object			INTEGER,
    PRIMARY KEY(id_generation, id_object),
    CONSTRAINT fk_generation_object_generation FOREIGN KEY(id_generation) REFERENCES generation(id),
    CONSTRAINT fk_generation_object_object FOREIGN KEY(id_object) REFERENCES object(id)
);

CREATE TABLE gym(
    id   		 INTEGER   		 AUTO_INCREMENT,
    name		 VARCHAR(40)		 NOT NULL,
    gym_type     VARCHAR(40)    	 NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE medal(
    id   		 INTEGER    	 AUTO_INCREMENT,
    name   	 	 VARCHAR(40)     NOT NULL,
    PRIMARY KEY (id)
    );

CREATE TABLE gym_leader(
    id   			 INTEGER    		 AUTO_INCREMENT,
    name			 VARCHAR(40)    	 NOT NULL,
    age				 INTEGER(3),
    generation_id    INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_gym_leader_generation FOREIGN KEY (generation_id) REFERENCES generation (id),
    CONSTRAINT ck_gym_leader_age CHECK(age < 50 and age > 18 )
    );

CREATE TABLE gym_leader_gym_medal(
    leader_id   	 INTEGER ,
    gym_id   		 INTEGER ,
    medal_id   	 	 INTEGER    	 NOT NULL,
    PRIMARY KEY(leader_id, gym_id),
    CONSTRAINT fk_gym_leader_gym_medal_gym_leader FOREIGN KEY (leader_id) REFERENCES gym_leader (id),
    CONSTRAINT fk_gym_leader_gym_medal_gym FOREIGN KEY (gym_id) REFERENCES gym (id),
    CONSTRAINT fk_gym_leader_gym_medal_medal FOREIGN KEY (medal_id) REFERENCES medal (id)
    );

CREATE TABLE pokemon(
id_pokemon 			INTEGER 			AUTO_INCREMENT,
name 				VARCHAR(40) 		NOT NULL,
evolution 			VARCHAR(40),
number_evolution 	SMALLINT(2),		
generation_id		INTEGER 			NOT NULL,
PRIMARY KEY(id_pokemon),
CONSTRAINT uk_pokemon_name UNIQUE(name),
CONSTRAINT fk_pokemon_generation FOREIGN KEY (generation_id	) REFERENCES generation(id),
CONSTRAINT ck_pokemon_evolution CHECK(number_evolution < 3 and number_evolution > 0)
);

CREATE TABLE type(
id_type 			INTEGER 			AUTO_INCREMENT,
name 				VARCHAR(40),
PRIMARY KEY(id_type)
);

CREATE TABLE pokemon_type(
pokemon_id 			INTEGER,
type_id 			INTEGER,

PRIMARY KEY(pokemon_id,type_id),
CONSTRAINT fk_pokemon_type_pokemon FOREIGN KEY (pokemon_id) REFERENCES pokemon(id_pokemon),
CONSTRAINT fk_pokemon_type_type FOREIGN KEY (type_id) REFERENCES type(id_type)
);

CREATE TABLE type_type(
weak 				INTEGER,
strong				INTEGER,
PRIMARY KEY(weak,strong),
CONSTRAINT fk_type_type_type_weak FOREIGN KEY (weak) REFERENCES type(id_type),
CONSTRAINT fk_type_type_type_strong	FOREIGN KEY (strong) REFERENCES type(id_type)

);








/*-----Indexs-----*/

	-- GENERATION
	CREATE INDEX ix_generation_number ON generation (number);
	CREATE INDEX ix_generation_release_date ON generation (release_date);

	-- OBJECTS
	CREATE INDEX ix_objet_name ON object (name);

	-- GYM
	ALTER TABLE gym ADD INDEX ix_gym_name(name);
	
	-- MEDAL
	ALTER TABLE medal ADD INDEX ix_medal_name(name);

	-- GYM LEADER
	ALTER TABLE gym_leader ADD INDEX ix_gym_leader_name(name);
   
    -- GAME

	CREATE INDEX ix_game_name ON game (name);
   
   

/*Assignment UF2P2 - DB Information*/




/*-----Data insertion-----*/

INSERT INTO generation (number, release_date, region, starters) VALUES
					   (1, "1998-05-01","Kanto","Charmander, Bulbasaur, Squirtle"),
                       (2, "1999-11-23","Kanto","Pikachu"),
					   (3, "2000-10-05","Johto","Cyndaquil, Chikorita , Totodile"),
					   (4, "2007-02-03","Hoenn","Torchic, Treecko, Mudkip"),
					   (5, "2011-11-15","Sinnoh","Chimchar, Turtwig , Piplup"),
                       (6, "2013-11-23","Teselia","Tepig, Snivy , Oshawott"),
                       (7, "2014-11-23","Teselia","Fennekin, Chespin , Froakie"),
                       (8, "2015-11-23","Teselia","Litten, Rowlet , Popplio"),
                       (9, "2016-11-23","Teselia","Fuecoco , Sprigatito , Quaxly"),
                       (10, "2023-11-23","Hoenn","Caterpie"),
					   (11, "1998-05-01","Paldea","dratini"),
                       (12, "1999-11-23","Paldea","charmander"),
					   (13, "2000-10-05","Paldea","pidgey"),
					   (14, "2007-02-03","Hisui","eevee"),
					   (15, "2011-11-15","Hisui","Chespin"),
                       (16, "2013-11-23","Hisui","Feniken, Snivy, Cyndaquil"),
                       (17, "2014-11-23","Galar","Froakie"),
                       (18, "2015-11-23","Galar","Arceus, Palkia, Dialga"),
                       (19, "2016-11-23","Galar","Rayquaza"),
                       (20, "2023-11-23","Sinnoh", "Buizel");
                       
INSERT INTO object (name, description)VALUES 
					/*Healing*/
					("Potion", "Potion that heals 20hp to a pokemon"),
				    ("Superpotion","Potion that heals 60hp to a pokemon"),
				    ("Hiperpotion","Potion that heals 120hp to a pokemon"),
				    ("Max Potion","Potion that heals max health to a pokemon"),
                    ("Revive","Revives a pokemon"),
				    ("Max Revive","Revives a pokemon with max health"),
                    ("Calcium","Increment the pokemon defense ev"),
					("Restore All", "Potion that heals 20hp to a pokemon"),
				    ("Anthidote","Potion that heals 60hp to a pokemon"),
				    ("Antiparaliz","Potion that heals 120hp to a pokemon"),
				    ("Antiquemar","Potion that heals max health to a pokemon"),
                    ("Antihielo","Revives a pokemon"),
				    ("Despertar","Revives a pokemon with max health"),
                    ("Cura total","Increment the pokemon defense ev"),
					("Fresh Water", "Potion that heals 20hp to a pokemon"),
				    ("Mu-Mu Milk","Potion that heals 60hp to a pokemon"),
				    ("Lemonade","Potion that heals 120hp to a pokemon"),
				    ("Lava Cookie","Potion that heals max health to a pokemon"),
                    ("Soda","Revives a pokemon"),
				    ("Berry Juice","Revives a pokemon with max health"),
                    ("Curative Dust","Revives a pokemon with max health"),
                    /*Pokeballs*/
					("Pokeball","Pokeball with a low rate of capture"),
				    ("Superball","Pokeball with a medium rate of capture"),
				    ("Ultraball","Pokeball with a high rate of capture"),
                    ("Beast Ball","Pokeball with bery low capture rate"),
                    ("Cherish Ball","Pokeball with low capture rate"),
					("Dream Ball","Pokeball with medium capture rate"),
					("Master Ball","Pokeball with a low rate of capture"),
				    ("Sfari Ball","Pokeball with a medium rate of capture"),
				    ("Rapid Ball","Pokeball with a high rate of capture"),
                    ("Nivel Ball","Pokeball with bery low capture rate"),
                    ("Cebo Ball","Pokeball with low capture rate"),
					("Peso Ball","Pokeball with medium capture rate"),
					("Amigo Ball","Pokeball with a low rate of capture"),
				    ("Amor Ball","Pokeball with a medium rate of capture"),
				    ("Luna Ball","Pokeball with a high rate of capture"),
                    ("Competi Ball","Pokeball with bery low capture rate"),
                    ("Lujo Ball","Pokeball with low capture rate"),
					("Malla Ball","Pokeball with medium capture rate"),
					("Honor Ball","Pokeball with a low rate of capture"),
				    ("Ocaso Ball","Pokeball with a medium rate of capture"),
					/*Special*/
				   ("Poke Flute","Flute that wakes up a pokemon"),
				   ("pokedex", "Saves a registry of each pokemon"),
				   ("restos","Heals the pokemon in each round"),
				   ("Dragon Fang","Increment dragon type"),
				   ("Charcoal","Increment fire type"),
				   ("Charizardite","Mega evolve charizar"),
				   ("Discount Coupon","Reduces the price in the shop"),
				   ("Focus Band","Flute that wakes up a pokemon"),
				   ("Bicicleta", "Saves a registry of each pokemon"),
				   ("Blastoisita","Heals the pokemon in each round"),
				   ("Blazikenita","Increment dragon type"),
				   ("Friend Block","Increment fire type"),
				   ("Snow Ball","Mega evolve charizar"),
				   ("Ligth Ball","Reduces the price in the shop"),
				   ("Bike Bonus","Flute that wakes up a pokemon"),
				   ("Scape Button", "Saves a registry of each pokemon"),
				   ("Find Mount","Heals the pokemon in each round"),
				   ("Find Objects","Increment dragon type"),
				   ("Share experience","Increment fire type");

INSERT INTO pokeballs(id, catch_rate, price, rarity, drop_chance) VALUES
					(21, 5, 200, 0, 88),
                    (22, 8, 400, 3, 44),
                    (23, 3, 200, 4, 2),
                    (24, 4, 500, 5, 15),
                    (25, 5, 200, 6, 67),
                    (26, 6, 700, 7, 88),
                    (27, 2, 200, 6, 45),
                    (28, 3, 800, 5, 66),
                    (29, 9, 200, 4, 79),
                    (30, 5, 900, 3, 23),
                    (31, 8, 200, 2, 88),
                    (32, 3, 400, 1, 12),
                    (33, 4, 200, 2, 24),
                    (34, 6, 500, 3, 88),
                    (35, 1, 200, 4, 57),
                    (36, 2, 700, 5, 73),
                    (37, 5, 200, 6, 32),
                    (38, 7, 500, 7, 12),
                    (39, 9, 200, 8, 5),
                    (40, 2, 100, 9, 100);

INSERT INTO healing(id, healing_quantity, price, drop_chance) VALUES
					(1, 20, 200, 10),
                    (2, 60, 400, 50),
                    (3, 100, 600, 20),
                    (4, 200, 1000, 30),
                    (5, 0, 300, 40),
                    (6, 0, 400, 50),
                    (7, 0, 100, 80),
                    (8, 0, 300, 60),
                    (9, 0, 400, 90),
                    (10, 0, 900, 70),
                    (11, 0, 700, 30),
                    (12, 35, 500, 40),
                    (13, 200, 400, 20),
                    (14, 1000, 300, 20),
                    (15, 77, 900, 60),
                    (16, 12, 700, 50),
                    (17, 34, 500, 40),
                    (18, 68, 300, 30),
                    (19, 29, 100, 20),
                    (20, 30, 400, 10);
                    
INSERT INTO special (id, regional_id, price, drop_chance) VALUES
						    (41, 0, 10, 44),
							(42, 1, 50, 22),
							(43, 2, 20, 33),
							(44, 3, 30, 55),
							(45, 4, 40, 66),
							(46, 5, 50, 77),
							(47, 6, 80, 88),
							(48, 7, 60, 99),
							(49, 8, 90, 44),
							(50, 9, 70, 33),
							(51, 10, 30, 22),
							(52, 11, 40, 11),
							(53, 12, 20, 44),
							(54, 13, 20, 55),
							(55, 14, 60, 66),
							(56, 15, 50, 77),
							(57, 16, 40, 88),
							(58, 17, 30, 99),
							(59, 18, 20, 33),
							(60, 19, 10, 44);

INSERT INTO game(generation_id, name, release_date) VALUES 
				(1, "Pokemon Red", "1995-03-03"),
                (1, "Pokemon Blue", "1995-03-03"),
                (1, "Pokemon Green", "1995-03-03"),
                (2, "Pokemon Gold", "1997-04-12"),
                (2, "Pokemon Silver", "1997-04-12"),
                (3, "Pokemon Rubi", "1998-05-22"),
                (3, "Pokemon Zaphie", "1998-05-22"),
                (4, "Pokemon Black", "2000-06-06"),
                (4, "Pokemon White", "2000-06-06"),
                (5, "Pokemon Black 2", "2002-07-17"),
                (5, "Pokemon White 2", "2002-08-17"),
                (6, "Pokemon X", "2004-08-29"),
                (6, "Pokemon Y", "2004-08-29"),
                (7, "Pokemon Sun", "2017-09-01"),
                (7, "Pokemon Moon", "2017-09-01"),
                (8, "Pokemon Ultra Sun", "2018-10-30"),
                (8, "Pokemon Ultra Moon", "2018-10-30"),
				(7, "Pokemon Legends Arceus", "2021-11-18"),
                (8, "Pokemon Scarlet", "2022-12-27"),
                (8, "Pokemon Violet", "2022-12-27");



INSERT INTO generation_object(id_generation, id_object) VALUES 
				  (1, 1),
                  (2, 2),
                  (3, 3),
                  (4, 4),
                  (1, 5),
                  (2, 6),
                  (3, 7),
                  (1, 8),
                  (2, 9),
                  (1, 10),
				  (4, 11),
                  (5, 12),
                  (6, 13),
                  (2, 14),
                  (3, 15),
                  (4, 16),
                  (5, 17),
                  (6, 18),
                  (2, 19),
                  (3, 20),
                  (1, 21),
                  (2, 22),
                  (3, 23),
                  (4, 24),
                  (1, 25),
                  (2, 26),
                  (3, 27),
                  (1, 28),
                  (2, 29),
                  (1, 30),
				  (4, 31),
                  (5, 32),
                  (6, 33),
                  (2, 34),
                  (3, 35),
                  (4, 36),
                  (5, 37),
                  (6, 38),
                  (2, 39),
                  (3, 40),
				  (1, 41),
                  (2, 42),
                  (3, 43),
                  (4, 44),
                  (1, 45),
                  (2, 46),
                  (3, 47),
                  (1, 48),
                  (2, 49),
                  (1, 50),
				  (4, 51),
                  (5, 52),
                  (6, 53),
                  (2, 54),
                  (3, 55),
                  (4, 56),
                  (5, 57),
                  (6, 58),
                  (2, 59),
                  (3, 60);
       
INSERT INTO pokemon (name, evolution, number_evolution, generation_id) VALUES 
					("Bulbasaur", "Ivysaur", 2, 1),
                    ("Ivysaur", "Venusaur", 2, 1),
                    ("Venusaur", NULL, 2, 1),
                    ("Charmander", "Charmeleon", 2, 1),
                    ("Charmeleon", "Charizard", 2, 1),
                    ("Charizard", NULL, 2, 1),
                    ("Squirtle", "Wartortle", 2, 1),
                    ("Wartortle", "Blastoise", 2, 1),
                    ("Blastoise", NULL, 2, 1),
                    ("Caterpie", "Metapod", 2, 1),
                    ("Metapod", NULL, 2, 1),
                    ("Butterfree", NULL, 2, 1),
                    ("Weedle", "Kakuna", 2, 1),
                    ("Kakuna", "Beedrill", 2, 1),
                    ("Beedrill", NULL, 2, 1),
                    ("Pidgey", "Pidgeotto", 2, 1),
                    ("Pidgeotto", "Pidgeot", 2, 1),
                    ("Pidgeot", NULL, 2, 1),
					("Rattata", "Raticate", 1, 1),
                    ("Raticate", NULL, 1, 1),
                    ("Spearow", "Fearow", 1, 1),
					("Fearow", NULL, 1, 1),
                    ("Ekans", "Arbok", 1, 1),
                    ("Arbok", NULL, 1, 1),
					("Pikachu", "Raichu", 1, 1),
                    ("Raichu", NULL, 1, 1);
                      
INSERT INTO type(name) VALUES ('dragon'),
							   ('hada'),
							   ('normal'),
							   ('lucha'),
							   ('planta'),
							   ('fuego'),
							   ('agua'),
							   ('veneno'),
							   ('fantasma'),
                               ('roca'),
							   ('acero'),
							   ('bicho'),
							   ('electrico'),
							   ('hielo'),
							   ('psiquico'),
							   ('siniestro'),
							   ('tierra'),
							   ('volador'),
							   ('god'),
                               ('legend');
                               
INSERT INTO pokemon_type VALUES (1,5),
								(1,8),
								(4,6),
								(6,6),
								(6,1),
								(8,7),
								(11,5),
								(19,3),
								(23,8),
								(15,8),
								(16,9),
								(17,10),
								(18,11),
								(19,17),
								(20,16),
								(21,14),
								(23,14),
								(24,13),
								(25,12),
								(26,19);
							
INSERT INTO type_type VALUES (1,1),
							 (1,2),
							 (4,2),
							 (3,4),
							 (5,6),
							 (6,7),
							 (7,5),
							 (5,9),
							 (9,9),
							 (10,6),
							 (2,11),
							 (1,18),
							 (2,5),
							 (12,4),
							 (16,2),
							 (19,8),
							 (16,6),
							 (18,4),
							 (14,8),
							 (8,6);
                            
                            
INSERT INTO gym (name, gym_type) VALUES 
				('Ciudad Celeste','Agua'),
				('Pueblo Pirotín','Bicho'),
				('Pueblo Altamía','Planta'),
				('Ciudad Cántara','Agua'),
				('Pueblo Mestura','Normal'),
				('Pueblo Hozkailu','Fantasma'),
				('Sierra Napada','Hielo'),
				('Ciudad Leudal','Eléctrico'),
				('Pueblo Alforno','Psíquico'),
				('Ciudad Plateada','Roca'),
				('Pewter City','Agua'),
				('Cerulean City','Bicho'),
				('Vermillion City','Planta'),
				('Ciudad Azulona','Agua'),
				('Ciudad Azafrán','Normal'),
				('Ciudad Fucsia','Fantasma'),
				('Isla Canela','Hielo'),
				('Ciudad Verde','Eléctrico'),
				('ciudad Fucsia','Psíquico'),
				('Pewter City','Roca');



    
INSERT INTO medal (name) VALUES
				  ('Cascada'),
				  ('Bicho'),
				  ('Planta'),
				  ('Agua'),
				  ('Normal'),
				  ('Fantasma'),
				  ('Hielo'),
				  ('Eléctrico'),
				  ('Psíquico'),
				  ('Roca'),
				  ('Invierno'),
				  ('Oro'),
				  ('Fuego'),
				  ('Hoja'),
				  ('Plata'),
				  ('Ventisca'),
				  ('Jovani JV'),
				  ('Roca dura'),
				  ('Poder mental'),
				  ('Leyendas');



INSERT INTO gym_leader (name, age, generation_id) VALUES
					   ('misty','26', '1'),
					   ('araceli','38','9'),
					   ('brais','34','9'),
					   ('fuco','44','9'),
					   ('laureano','49','9'),
					   ('lima','49','9'),
					   ('grusha','25','9'),
					   ('e-Nigma','23','9'),
					   ('tuli','43','9'),
					   ('brock','30','1'),
					   ('alex','26', '1'),
					   ('paco','38','9'),
					   ('jaime','34','9'),
					   ('ebay','44','9'),
					   ('illo','49','9'),
					   ('knekro','49','9'),
					   ('folagor','25','9'),
					   ('shiny','23','9'),
					   ('ruben','43','9'),
					   ('iker','30','1');


INSERT INTO gym_leader_gym_medal (leader_id, gym_id, medal_id) VALUES 
								 ('1','1','1'),
							     ('2','2','2'),
							     ('3','3','3'),
							     ('4','4','4'),
							     ('5','5','5'),
							     ('6','6','6'),
							     ('7','7','7'),
							     ('8','8','8'),
							     ('9','9','9'),
							     ('10','10','10'),
								 ('11','11','11'),
							     ('12','12','12'),
							     ('13','13','13'),
							     ('14','14','14'),
							     ('15','15','15'),
							     ('16','16','16'),
							     ('17','17','17'),
							     ('18','18','18'),
							     ('19','19','19'),
							     ('20','20','20');
                                 
                                 
/*-----Queries-----*/

/*Adrian queries*/

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

/*---------------------------------------------------------------------------------------------------------*/
/*Pol queries */

-- Query 1
/* Select all the pokemons and each pokemon type*/
SELECT p.name AS pokemon, g.number AS generation, t.name AS type
FROM pokemon p
	INNER JOIN generation g ON p.generation_id = g.id
	INNER JOIN pokemon_type pt ON p.id_pokemon = pt.pokemon_id
	INNER JOIN type t ON pt.type_id = t.id_type
ORDER BY p.name;


-- Query 2
/*Show all the objects and the generation number and region name they appear*/
SELECT g.number AS generation_number, g.region AS generation_region, o.name AS object_name
FROM generation g
	INNER JOIN generation_object go ON g.id = go.id_generation
	INNER JOIN object o ON go.id_object = o.id
	LEFT JOIN pokeballs p ON o.id = p.id
	LEFT JOIN healing h ON o.id = h.id
	LEFT JOIN special s ON o.id = s.id
ORDER BY g.number, o.name;


-- Query 3
/*Select all the pokemons and the games where they appear*/
SELECT DISTINCT g.name AS Game, p.name AS Pokemon
FROM game g, pokemon p, generation ge
WHERE p.generation_id < 2 AND ge.starters IS NOT NULL;

-- Query 4
/*Select the pokemon name, type number of evolutions and region they belong to pokemons where the evolution number is bigger or equal to 2*/
SELECT p.name AS pokemon, t.name AS type, p.number_evolution, g.region
FROM pokemon p
	INNER JOIN pokemon_type pt ON p.id_pokemon = pt.pokemon_id
	INNER JOIN type t ON pt.type_id = t.id_type
    INNER JOIN generation g ON p.id_pokemon = g.id
WHERE p.number_evolution >= 2
ORDER BY t.name, p.name;

-- Query 5
/*Select the gym_name, medal_name adn generation number each medal and gym belongs*/
SELECT g.name AS gym_name, m.name AS medal_name, gr.number AS generation_number
FROM gym g
	INNER JOIN gym_leader_gym_medal glgm ON g.id = glgm.gym_id
	INNER JOIN medal m ON glgm.medal_id = m.id
	INNER JOIN gym_leader gl ON glgm.leader_id = gl.id
	INNER JOIN generation gr ON gr.id = gl.generation_id
ORDER BY gr.number, g.name;

/*---------------------------------------------------------------------------------------------------------*/
/*Javi queries*/
                               
/* Know the games relised under  1997 and her generation region*/
                               
SELECT g.name ,g2.region  FROM game g 
	JOIN generation g2 ON g.generation_id = g2.id 
	WHERE YEAR(g.release_date) <= '1997';
	
	
/*Know how many games are in ech region*/
	
SELECT g.region , COUNT(*) AS games FROM generation g 
	JOIN game g2 ON g.id = g2.generation_id 
	GROUP BY g.region ;
	
/* Know the diferents object and the type whe can put a where and a condition like h.id IS NOT NULL to know the only one type */

SELECT o.name , h.id , p.id ,s.id  FROM object o  
	LEFT JOIN healing h ON o.id = h.id
	LEFT JOIN pokeballs p ON o.id = p.id
	LEFT JOIN special s ON o.id  = s.id;
	
/* Know the GYM LEADER ANG HIS/HER MEDAL */

SELECT gl.name AS 'GYM LEADER',m.name AS MEDAL FROM gym_leader gl 
	JOIN gym_leader_gym_medal glgm ON gl.id = glgm.leader_id 
	JOIN medal m ON glgm.medal_id = m.id ORDER BY gl.name ;

/* Know the the gym leaders and his/her gym with generation up of 2000 and have under 20 years */

SELECT gl.name , g2.name  FROM generation g 
	JOIN gym_leader gl ON g.id = gl.generation_id 
	JOIN gym_leader_gym_medal glgm ON gl.id = glgm.leader_id 
	JOIN gym g2 ON glgm.gym_id = g2.id
	WHERE YEAR(release_date) > '2000' AND gl.age > 20;