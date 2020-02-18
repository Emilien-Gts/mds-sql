-- Voir le salaire de chacun de ses employers ainsi que leur horaire de travail et les tâches qui leur sont affectés
SELECT employee.id AS employee_id, employee.salary AS salary, schedule.start_at, schedule.end_at, post.name AS post_name 
FROM employee
JOIN post ON post.post_schedule = employee.id_post
JOIN schedule on schedule.id = post.post_schedule
GROUP BY employee.id

-- Voir les soirées à thème programmé (lieu, réduction éventuel, nombre de personne prévu)
SELECT room_theme_room.id AS id, room.name AS name, room.nb_people AS nb_people, room.entrance_price AS entrance_price, building.name AS building_name, address.street_name AS street_name, address.town_name AS town
FROM room_theme_room
INNER JOIN room on room_theme_room.id_room = room.id
INNER JOIN building on room.building_room = building.id
INNER JOIN address on building.address_building = address.id
GROUP BY room_theme_room.id

-- Voir l'ensemble des équipements des différentes pièces de la discothèque afin de voir les améliorations pouvant y être apporté
SELECT nightclub.name AS nightclub_name, building.name AS building_name, room.name AS room_name, gear.name AS gear_name
FROM nightclub
INNER JOIN building ON nightclub.id = building.nightclub_building
INNER JOIN room ON building.id = room.building_room
INNER JOIN room_gear ON room.id = room_gear.id_room
INNER JOIN gear ON gear.id = room_gear.id_gear

-- Voir le chiffre d'affaire réalisé à une date donnée
SELECT DISTINCT customer_room.buy_at AS buy_at, 
    (
        SELECT COALESCE(SUM(room.entrance_price),0) 
        FROM customer_room
        JOIN room ON customer_room.id_room = room.id
        WHERE buy_at like '2015-08-20'
    ) +
    (
        SELECT COALESCE(SUM(price),0) FROM leasing_room
        WHERE start_at like '2015-08-20'
    ) +
    (
        SELECT COALESCE(SUM(price),0) FROM leasing_building
        WHERE start_at like '2015-08-20'
    ) +
    (
        SELECT COALESCE(SUM(gear.price),0) FROM customer_room
        JOIN gear ON gear.id = customer_room.id_gear
        WHERE customer_room.buy_at like '2015-02-24'
    ) as CA
FROM customer_room
WHERE customer_room.buy_at like '2015-08-20'

-- Voir le chiffre d'affaire réalisé entre deux dates
SELECT DISTINCT customer_room.buy_at AS buy_at, 
    (
        SELECT COALESCE(SUM(room.entrance_price),0) 
        FROM customer_room
        JOIN room ON customer_room.id_room = room.id
        WHERE buy_at like '2015-08-20'
    ) +
    (
        SELECT COALESCE(SUM(price),0) FROM leasing_room
        WHERE start_at like '2015-08-20'
    ) +
    (
        SELECT COALESCE(SUM(price),0) FROM leasing_building
        WHERE start_at like '2015-08-20'
    ) +
    (
        SELECT COALESCE(SUM(gear.price),0) FROM customer_room
        JOIN gear ON gear.id = customer_room.id_gear
        WHERE customer_room.buy_at like '2015-08-20'
    ) as CA
FROM customer_room
WHERE customer_room.buy_at BETWEEN '2015-02-24' AND '2015-07-29'
GROUP BY CA

-- Voir le chiffre d'affaire pour les soirée à thèmes entre deux dates
SELECT customer_room.buy_at AS buy_at, theme_room.name as theme_room_name, 
    (
        SELECT COALESCE(SUM(room.entrance_price),0) 
        FROM customer_room
        JOIN room ON customer_room.id_room = room.id
        WHERE buy_at BETWEEN '2015-08-01' AND '2015-08-30'
    ) +
    (
        SELECT COALESCE(SUM(price),0) FROM leasing_room
        WHERE start_at BETWEEN '2015-08-01' AND '2015-08-30'
    ) +
    (
        SELECT COALESCE(SUM(gear.price),0) FROM customer_room
        JOIN gear ON gear.id = customer_room.id_gear
        WHERE customer_room.buy_at BETWEEN '2015-08-01' AND '2015-08-30'
    ) as chiffre_affaire
FROM room
INNER JOIN customer_room ON customer_room.id_room = room.id
INNER JOIN room_theme_room ON room_theme_room.id_room = room.id
INNER JOIN theme_room ON theme_room.id = room_theme_room.id_theme_room
WHERE customer_room.buy_at BETWEEN '2015-02-24' AND '2015-07-29'
GROUP BY theme_room.name

-- Voir l'état des finances de la discothèque pour une année fiscale (la différence de tout se qu'il y a à payer et les revenu)
SELECT 
    (
        SELECT COALESCE(SUM(room.entrance_price),0) FROM customer_room
        JOIN room ON customer_room.id_room = room.id
        WHERE buy_at BETWEEN '2015-01-01' AND '2015-12-31'
    ) +
    (
        SELECT COALESCE(SUM(leasing_room.price),0) FROM leasing_room
	    WHERE start_at BETWEEN '2015-01-01' AND '2015-12-31'
    ) +
    (
        SELECT COALESCE(SUM(leasing_building.price),0) FROM leasing_building
	    WHERE start_at BETWEEN '2015-01-01' AND '2015-12-31'
    ) + 
    (
        SELECT COALESCE(SUM(gear.price),0) FROM customer_room
        JOIN gear ON gear.id = customer_room.id_gear
        WHERE customer_room.buy_at BETWEEN '2015-01-01' AND '2015-12-31'
    ) - 
    (
        (
            SELECT COALESCE(SUM(employee.salary * 12),0) FROM employee
        ) +
        (
            SELECT SUM(room_salable_gear.quantity * room_salable_gear.price) FROM room_salable_gear WHERE room_salable_gear.buy_at BETWEEN '2015-01-01' AND '2015-12-31'
        )
    ) as BENEFICE_DE_2015

-- Voir la consommation moyenne de l'ensemble des client
SELECT customer.id, COALESCE(AVG(leasing_room.price),0) + COALESCE(AVG(leasing_building.price),0) as conso_moy
FROM customer 
JOIN leasing_room ON leasing_room.id_customer = customer.id
JOIN leasing_building ON leasing_building.id_customer = customer.id
GROUP BY customer.id

-- Voir la consommation moyenne de l'ensemble des client avec l'entré
SELECT customer.id, COALESCE(AVG(leasing_room.price),0) + COALESCE(AVG(leasing_building.price),0) + COALESCE(AVG(room.entrance_price),0) as conso_moy
FROM customer 
JOIN leasing_room ON leasing_room.id_customer = customer.id
JOIN leasing_building ON leasing_building.id_customer = customer.id
JOIN customer_room ON customer_room.id_customer = customer.id
JOIN room ON room.id = customer_room.id_room
GROUP BY customer.id

-- Afficher le nombre de personne étant venu à une soirée en particulier puis le nombre de personne mineur, entre 18-25, entre 26-35, plus vieux que 36 ans (SOUS REQUÊTES)

-- Afficher le nombre de personne étant venu à une soirée en particulier puis le nombre de personne mineur, entre 18-25, entre 26-35, plus vieux que 36 ans (UNION)