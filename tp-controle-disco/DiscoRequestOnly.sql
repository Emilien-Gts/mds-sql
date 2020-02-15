-- Voir le salaire de chacun de ses employers ainsi que leur horaire de travail et les tâches qui leur sont affectés
SELECT employee.firstname AS firstname, employee.lastname AS lastname, employee.salary AS salary, employee.start_at AS start, employee.end_at AS end_at, post.name AS post
FROM employee
INNER JOIN post ON employee.id_post = post.id

-- Voir les soirées à thème programmé (lieu, réduction éventuel, nombre de personne prévu)


-- Voir l'ensemble des équipements des différentes pièces de la discothèque afin de voir les améliorations pouvant y être apporté
SELECT nightclub.name AS nightclub, building.name AS building, room.name AS room, gear.name AS gear
FROM nightclub
INNER JOIN building ON nightclub.id = building.nightclub_building
INNER JOIN room ON building.id = room.building_room
INNER JOIN room_gear ON room.id = room_gear.id_room
INNER JOIN gear ON gear.id = room_gear.id_gear

-- Voir le chiffre d'affaire réalisé à une date donnée
SELECT  SUM(CA) CA
FROM
    ( 
        select coalesce(sum(leasing_room.price), 0) CA from leasing_room
        where leasing_room.start_at = '2015-08-20'
        UNION ALL
        select coalesce(sum(leasing_building.price), 0) CA from leasing_building
        where leasing_building.start_at = '2015-08-20'
    ) s

-- Voir le chiffre d'affaire réalisé entre deux dates
SELECT  SUM(CA) CA
FROM
    ( 
        select coalesce(sum(leasing_room.price), 0) CA from leasing_room
        where leasing_room.start_at BETWEEN '2015-10-02' AND '2015-12-10'
        UNION ALL
        select coalesce(sum(leasing_building.price), 0) CA from leasing_building
        where leasing_building.start_at BETWEEN '2015-10-02' AND '2015-12-10'
    ) s

-- Voir le chiffre d'affaire pour les soirée à thèmes entre deux dates

-- Voir l'état des finances de la discothèque pour une année fiscale (la différence de tout se qu'il y a à payer et les revenu)

-- Voir la consommation moyenne de l'ensemble des client

-- Voir la consommation moyenne de l'ensemble des client avec l'entré

-- Afficher le nombre de personne étant venu à une soirée en particulier puis le nombre de personne mineur, entre 18-25, entre 26-35, plus vieux que 36 ans (UNION)

-- Afficher le nombre de personne étant venu à une soirée en particulier puis le nombre de personne mineur, entre 18-25, entre 26-35, plus vieux que 36 ans (SOUS REQUÊTES)