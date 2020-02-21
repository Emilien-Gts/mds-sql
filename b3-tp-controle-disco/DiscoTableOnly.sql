-- DROP DATABASE
DROP DATABASE IF EXISTS mdsdisco;

-- CREATE DATABASE
CREATE DATABASE mdsdisco;

-- USE DATABASE
USE mdsdisco;

-- DROP TABLE IF EXISTS
DROP TABLE IF EXISTS nightclub, author, song, song_type, song_song_type, address, schedule, post, employee, dj, employee_dj, gear, state, gear_state, theme_room, theme_room_gear, allowed_people, base_room, base_room_allowed_people, building, room, room_salable_gear, room_gear, room_state, room_theme_room, dj_room, played, customer, customer_room, leasing_room, leasing_building, nightclub_song;

-- Table nightclub
CREATE TABLE nightclub (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table author
CREATE TABLE author (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table song
CREATE TABLE song (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    duration TIME,
    id_author BIGINT,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table song_type
CREATE TABLE song_type (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table song_song_type
CREATE TABLE song_song_type (
    id_song BIGINT NOT NULL AUTO_INCREMENT,
    id_song_type BIGINT,
    PRIMARY KEY (id_song, id_song_type)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table address
CREATE TABLE address (
    id BIGINT NOT NULL AUTO_INCREMENT,
    postal_code VARCHAR(10),
    civic_num VARCHAR(50),
    street_name VARCHAR(50),
    town_name VARCHAR(150),
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table schedule
CREATE TABLE schedule (
    id BIGINT NOT NULL AUTO_INCREMENT,
    start_at TIME,
    end_at TIME,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table post
CREATE TABLE post (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    base_salary INT,
    post_schedule BIGINT,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table employee
CREATE TABLE employee (
    id BIGINT NOT NULL AUTO_INCREMENT, 
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    number VARCHAR(50) UNIQUE,
    start_at DATE,
    end_at DATE,
    salary INT,
    id_post BIGINT,
    id_address BIGINT,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table dj
CREATE TABLE dj (
    id BIGINT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table employee_dj
CREATE TABLE employee_dj (
    id_employee BIGINT,
    id_dj BIGINT,
    PRIMARY KEY(id_employee, id_dj)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table gear
CREATE TABLE gear (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    price DECIMAL,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table state
CREATE TABLE state (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table gear_state
CREATE TABLE gear_state (
    observed_at DATE,
    id_gear BIGINT,
    id_state BIGINT,
    PRIMARY KEY(id_gear, id_state)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table theme_room
CREATE TABLE theme_room (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table theme_room_gear
CREATE TABLE theme_room_gear (
    id_theme_room BIGINT,
    id_gear BIGINT,
    quantity INT,
    PRIMARY KEY(id_theme_room, id_gear)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table allowed_people
CREATE TABLE allowed_people (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE,
    PRIMARY KEY(id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table base_room
CREATE TABLE base_room (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table base_room_allowed_people
CREATE TABLE base_room_allowed_people (
    id_base_room BIGINT,
    id_allowed_people BIGINT,
    PRIMARY KEY (id_base_room, id_allowed_people)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table building
CREATE TABLE building (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    size DECIMAL,
    building_schedule BIGINT,
    nightclub_building BIGINT,
    address_building BIGINT,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table room
CREATE TABLE room (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    entrance_price DECIMAL,
    nb_people INT,
    set_at DATE,
    building_room BIGINT,
    room_base_room BIGINT,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table room_salable_gear
CREATE TABLE room_salable_gear (
    price INT,
    quantity INT,
    buy_at DATE,
    id_room BIGINT,
    id_gear BIGINT,
    PRIMARY KEY(id_room, id_gear)
) ENGINE=InnoDB CHARACTER SET utf8; 

-- Table room_gear
CREATE TABLE room_gear (
    id_room BIGINT,
    id_gear BIGINT,
    set_at DATE,
    remove_at DATE,
    quantity INT,
    PRIMARY KEY(id_room, id_gear)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table room_state
CREATE TABLE room_state (
    observed_at DATE,
    id_state BIGINT,
    id_room BIGINT,
    PRIMARY KEY(id_room, id_state)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table room_theme_room
CREATE TABLE room_theme_room (
    id BIGINT NOT NULL AUTO_INCREMENT,
    start_at DATE,
    end_at DATE,
    id_room BIGINT,
    id_theme_room BIGINT,
    PRIMARY KEY(id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table dj_room
CREATE TABLE dj_room (
    id BIGINT,
    work_at DATE,
    start_at TIME,
    end_at TIME,
    id_dj BIGINT,
    id_room BIGINT,
    PRIMARY KEY(id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table played
CREATE TABLE played (
    id BIGINT NOT NULL AUTO_INCREMENT,
    played_on DATE,
    id_song BIGINT,
    id_room BIGINT,
    PRIMARY KEY(id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table customer
CREATE TABLE customer (
    id BIGINT NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    date_of_birth DATE,
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8; 

-- Table customer_room
CREATE TABLE customer_room (
    id BIGINT NOT NULL AUTO_INCREMENT,
    buy_at DATE,
    id_customer BIGINT,
    id_room BIGINT,
    id_gear BIGINT,
    PRIMARY KEY(id)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table leasing_room
CREATE TABLE leasing_room (
    id_customer BIGINT,
    id_room BIGINT,
    start_at DATE,
    end_at DATE,
    price DECIMAL,
    PRIMARY KEY(id_customer, id_room)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table leasing_building
CREATE TABLE leasing_building (
    id_customer BIGINT,
    id_building BIGINT,
    start_at DATE,
    end_at DATE,
    price DECIMAL,
    PRIMARY KEY(id_customer, id_building)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Table nightclub_song
CREATE TABLE nightclub_song (
    id_nightclub BIGINT,
    id_song BIGINT,
    price DECIMAL,
    getting_at TIME,
    stoping_at TIME,
    PRIMARY KEY(id_nightclub, id_song)
) ENGINE=InnoDB CHARACTER SET utf8;

-- Foreign KEY TABLE song
ALTER TABLE song ADD FOREIGN KEY (id_author) REFERENCES author(id);

-- Foreign KEY TABLE song_song_type
ALTER TABLE song_song_type ADD FOREIGN KEY (id_song) REFERENCES song(id);
ALTER TABLE song_song_type ADD FOREIGN KEY (id_song_type) REFERENCES song_type(id);

-- Foreign KEY TABLE post
ALTER TABLE post ADD FOREIGN KEY (post_schedule) REFERENCES schedule(id);

-- Foreign KEY TABLE employee
ALTER TABLE employee ADD FOREIGN KEY (id_post) REFERENCES post(id);
ALTER TABLE employee ADD FOREIGN KEY (id_address) REFERENCES address(id);

-- Foreign KEY TABLE employee_dj
ALTER TABLE employee_dj ADD FOREIGN KEY (id_employee) REFERENCES employee(id);
ALTER TABLE employee_dj ADD FOREIGN KEY (id_dj) REFERENCES dj(id);

-- Foreign KEY TABLE gear_state
ALTER TABLE gear_state ADD FOREIGN KEY (id_gear) REFERENCES gear(id);
ALTER TABLE gear_state ADD FOREIGN KEY (id_state) REFERENCES state(id);

-- Foreign KEY TABLE theme_room_gear
ALTER TABLE theme_room_gear ADD FOREIGN KEY (id_theme_room) REFERENCES theme_room(id);
ALTER TABLE theme_room_gear ADD FOREIGN KEY (id_gear) REFERENCES gear(id);

-- Foreign KEY TABLE base_room_allowed_people
ALTER TABLE base_room_allowed_people ADD FOREIGN KEY (id_base_room) REFERENCES base_room(id);
ALTER TABLE base_room_allowed_people ADD FOREIGN KEY (id_allowed_people) REFERENCES allowed_people(id);

-- Foreign KEY TABLE building
ALTER TABLE building ADD FOREIGN KEY (building_schedule) REFERENCES schedule(id);
ALTER TABLE building ADD FOREIGN KEY (nightclub_building) REFERENCES nightclub(id);
ALTER TABLE building ADD FOREIGN KEY (address_building) REFERENCES address(id);

-- Foreign KEY TABLE room
ALTER TABLE room ADD FOREIGN KEY (room_base_room) REFERENCES base_room(id);
ALTER TABLE room ADD FOREIGN KEY (building_room) REFERENCES building(id);

-- Foreign KEY TABLE room_salable_gear
ALTER TABLE room_salable_gear ADD FOREIGN KEY (id_room) REFERENCES room(id);
ALTER TABLE room_salable_gear ADD FOREIGN KEY (id_gear) REFERENCES gear(id);

-- Foreign KEY TABLE room_gear
ALTER TABLE room_gear ADD FOREIGN KEY (id_room) REFERENCES room(id);
ALTER TABLE room_gear ADD FOREIGN KEY (id_gear) REFERENCES gear(id);

-- Foreign KEY TABLE room_state
ALTER TABLE room_state ADD FOREIGN KEY (id_room) REFERENCES room(id);
ALTER TABLE room_state ADD FOREIGN KEY (id_state) REFERENCES state(id);

-- Foreign KEY TABLE room_theme_room
ALTER TABLE room_theme_room ADD FOREIGN KEY (id_room) REFERENCES room(id);
ALTER TABLE room_theme_room ADD FOREIGN KEY (id_theme_room) REFERENCES theme_room(id);

-- Foreign KEY TABLE dj_room
ALTER TABLE dj_room ADD FOREIGN KEY (id_dj) REFERENCES dj(id);
ALTER TABLE dj_room ADD FOREIGN KEY (id_room) REFERENCES room(id);

-- Foreign KEY TABLE played
ALTER TABLE played ADD FOREIGN KEY (id_song) REFERENCES song(id);
ALTER TABLE played ADD FOREIGN KEY (id_room) REFERENCES room(id);

-- Foreign KEY TABLE customer_room
ALTER TABLE customer_room ADD FOREIGN KEY (id_customer) REFERENCES customer(id);
ALTER TABLE customer_room ADD FOREIGN KEY (id_room) REFERENCES room(id);
ALTER TABLE customer_room ADD FOREIGN KEY (id_gear) REFERENCES gear(id);

-- Foreign KEY TABLE leasing_room
ALTER TABLE leasing_room ADD FOREIGN KEY (id_customer) REFERENCES customer(id);
ALTER TABLE leasing_room ADD FOREIGN KEY (id_room) REFERENCES room(id);

-- Foreign KEY TABLE leasing_building
ALTER TABLE leasing_building ADD FOREIGN KEY (id_customer) REFERENCES customer(id);
ALTER TABLE leasing_building ADD FOREIGN KEY (id_building) REFERENCES building(id);

-- Foreign KEY TABLE nightclub_song
ALTER TABLE nightclub_song ADD FOREIGN KEY (id_nightclub) REFERENCES nightclub(id);
ALTER TABLE nightclub_song ADD FOREIGN KEY (id_song) REFERENCES song(id);