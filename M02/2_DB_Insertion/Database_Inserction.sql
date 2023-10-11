
USE pokemonDB;

/* ----- Data insertion ----- */

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
    /* Healing */
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
    /* Pokeballs */
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
    /* Special */
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
    (101, "Pokemon Red", "1995-03-03"),
    (101, "Pokemon Blue", "1995-03-03"),
    (101, "Pokemon Green", "1995-03-03"),
    (102, "Pokemon Gold", "1997-04-12"),
    (102, "Pokemon Silver", "1997-04-12"),
    (103, "Pokemon Rubi", "1998-05-22"),
    (103, "Pokemon Zaphie", "1998-05-22"),
    (104, "Pokemon Black", "2000-06-06"),
    (104, "Pokemon White", "2000-06-06"),
    (105, "Pokemon Black 2", "2002-07-17"),
    (105, "Pokemon White 2", "2002-08-17"),
    (106, "Pokemon X", "2004-08-29"),
    (106, "Pokemon Y", "2004-08-29"),
    (107, "Pokemon Sun", "2017-09-01"),
    (107, "Pokemon Moon", "2017-09-01"),
    (108, "Pokemon Ultra Sun", "2018-10-30"),
    (108, "Pokemon Ultra Moon", "2018-10-30"),
    (107, "Pokemon Legends Arceus", "2021-11-18"),
    (108, "Pokemon Scarlet", "2022-12-27"),
    (108, "Pokemon Violet", "2022-12-27");



INSERT INTO generation_object(id_generation, id_object) VALUES 
    (101, 1),
    (102, 2),
    (103, 3),
    (104, 4),
    (101, 5),
    (102, 6),
    (103, 7),
    (101, 8),
    (102, 9),
    (101, 10),
    (104, 11),
    (105, 12),
    (106, 13),
    (102, 14),
    (103, 15),
    (104, 16),
    (105, 17),
    (106, 18),
    (102, 19),
    (103, 20),
    (101, 21),
    (102, 22),
    (103, 23),
    (104, 24),
    (101, 25),
    (102, 26),
    (103, 27),
    (101, 28),
    (102, 29),
    (101, 30),
    (104, 31),
    (105, 32),
    (106, 33),
    (102, 34),
    (103, 35),
    (104, 36),
    (105, 37),
    (106, 38),
    (102, 39),
    (103, 40),
    (101, 41),
    (102, 42),
    (103, 43),
    (104, 44),
    (101, 45),
    (102, 46),
    (103, 47),
    (101, 48),
    (102, 49),
    (101, 50),
    (104, 51),
    (105, 52),
    (106, 53),
    (102, 54),
    (103, 55),
    (104, 56),
    (105, 57),
    (106, 58),
    (102, 59),
    (103, 60);
       
INSERT INTO pokemon (name, evolution, number_evolution, generation_id) VALUES 
    ("Bulbasaur", "Ivysaur", 2, 101),
    ("Ivysaur", "Venusaur", 2, 101),
    ("Venusaur", NULL, 2, 101),
    ("Charmander", "Charmeleon", 2, 101),
    ("Charmeleon", "Charizard", 2, 101),
    ("Charizard", NULL, 2, 101),
    ("Squirtle", "Wartortle", 2, 101),
    ("Wartortle", "Blastoise", 2, 101),
    ("Blastoise", NULL, 2, 101),
    ("Caterpie", "Metapod", 2, 101),
    ("Metapod", NULL, 2, 101),
    ("Butterfree", NULL, 2, 101),
    ("Weedle", "Kakuna", 2, 101),
    ("Kakuna", "Beedrill", 2, 101),
    ("Beedrill", NULL, 2, 101),
    ("Pidgey", "Pidgeotto", 2, 101),
    ("Pidgeotto", "Pidgeot", 2, 101),
    ("Pidgeot", NULL, 2, 101),
    ("Rattata", "Raticate", 1, 101),
    ("Raticate", NULL, 1, 101),
    ("Spearow", "Fearow", 1, 101),
    ("Fearow", NULL, 1, 101),
    ("Ekans", "Arbok", 1, 101),
    ("Arbok", NULL, 1, 101),
    ("Pikachu", "Raichu", 1, 101),
    ("Raichu", NULL, 1, 101);
                      
INSERT INTO type(name) VALUES 
    ('dragon'),
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
    
INSERT INTO pokemon_type VALUES 
    (1,5),
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
							
INSERT INTO type_type VALUES 
    (1,1),
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
    ('misty','26', '101'),
    ('araceli','38','109'),
    ('brais','34','109'),
    ('fuco','44','109'),
    ('laureano','49','109'),
    ('lima','49','109'),
    ('grusha','25','109'),
    ('e-Nigma','23','109'),
    ('tuli','43','109'),
    ('brock','30','101'),
    ('alex','26', '101'),
    ('paco','38','109'),
    ('jaime','34','109'),
    ('ebay','44','109'),
    ('illo','49','109'),
    ('knekro','49','109'),
    ('folagor','25','109'),
    ('shiny','23','109'),
    ('ruben','43','109'),
    ('iker','30','101');


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