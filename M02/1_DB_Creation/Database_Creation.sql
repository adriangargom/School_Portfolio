DROP DATABASE IF EXISTS pokemonDB;

CREATE DATABASE pokemonDB IF NOT EXISTS;

USE pokemonDB;

/* ----- Database Table Creations ----- */

CREATE TABLE generation(
	id				INTEGER			AUTO_INCREMENT,
    number			TINYINT(2)		NOT NULL,
    release_date	DATE			NOT NULL,
    region			VARCHAR(40)		NOT NULL,
    starters		VARCHAR(40)		NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT uk_generation_number_region_starters UNIQUE(number, region, starters),
    CONSTRAINT ck_generation_number CHECK(number > 0 AND number < 100),
    CONSTRAINT ck_generation_release_date CHECK(release_date >= "1996-02-26")
)AUTO_INCREMENT=100;

CREATE TABLE object(
	id				INTEGER			AUTO_INCREMENT,
    name			VARCHAR(40)		NOT NULL,
    description		VARCHAR(150)	NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT uk_generation_name UNIQUE(name)
);
    
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


/* ----- Indexs ----- */

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