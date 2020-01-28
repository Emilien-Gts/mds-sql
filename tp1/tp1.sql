DROP DATABASE IF EXISTS jocketponey;
DROP TABLE IF EXISTS jockey, poney, course, jockeyponeycourse;

CREATE TABLE jockey (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    prenom VARCHAR(50) NOT NULL,
    nom VARCHAR(50) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE poney (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE course (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    start_course DATETIME NOT NULL
)ENGINE=InnoDB;

CREATE TABLE jockeyponeycourse(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_jockey INT NOT NULL,
    id_poney INT NOT NULL,
    id_course INT NOT NULL,
    date_arrive DATETIME,
    FOREIGN KEY (id_jockey) REFERENCES jockey(id),
    FOREIGN KEY (id_poney) REFERENCES poney(id),
    FOREIGN KEY (id_course) REFERENCES course(id)
)ENGINE=InnoDB;