SELECT count(*) FROM jockeyponey1.course;
SELECT count(*) FROM jockeyponey1.jockey;
SELECT count(*) FROM jockeyponey1.poney;
SELECT count(*) FROM jockeyponey1.jocketponeycourse;

/*
 * Afficher le nom, prenom des participants(jokey) de la course 1
 */
SELECT jockey.nom, jockey.prenom
FROM jockeyponeycourse
INNER JOIN jockey ON jockeyponeycourse.id_jockey = jockey.id
WHERE id_course = 1

/*
 * Afficher le nom, prenom des participants(jokey) de la course 1
 */
SELECT poney.id as poney_id, poney.nom as poney_nom, jockey.nom as jockey_nom, jockey.prenom as jockey_prenom
FROM jockeyponeycourse
INNER JOIN poney ON jockeyponeycourse.id_poney = poney.id
INNER JOIN jockey ON jockeyponeycourse.id_jockey = jockey.id
WHERE jockeyponeycourse.id_jockey = 1

/*
 * 3- Afficher les jockeys (nom, prenom) ayant courut avec le poney 1 (et afficher sont nom)
 */
SELECT poney.id as poney_id, poney.nom as poney_nom, jockey.nom as jockey_nom, jockey.prenom as jockey_prenom
FROM jockeyponeycourse
INNER JOIN poney ON jockeyponeycourse.id_poney = poney.id
INNER JOIN jockey ON jockeyponeycourse.id_jockey = jockey.id
WHERE jockeyponeycourse.id_poney = 1

/*
 * 4- Afficher tout les jockeys (id, nom, prenom) n'ayant jamais couru
 */
SELECT *
FROM jockey
WHERE id NOT IN (
    SELECT DISTINCT(jockeyponeycourse.id_jockey)
    FROM jockeyponeycourse
)

/*
 * 5 - Afficher tout les poneys (id, nom) n'ayant jamais couru
 */
SELECT *
FROM poney
WHERE id NOT IN (
    SELECT DISTINCT(jockeyponeycourse.id_poney)
    FROM jockeyponeycourse
)

/*
 * 6- Afficher les jockeys (id, nom, prenom) ayant couru plus de 6 fois
 */
SELECT Q1.id, Q1.nom, Q1.prenom
FROM (
    SELECT j.id, j.nom, j.prenom , count(*) AS nb
    FROM jockeyponeycourse as r
    INNER JOIN jockey AS j ON r.id_jockey = j.id 
    GROUP BY (r.id_jockey)
    HAVING nb > 6
) as Q1
;

/*
 * 7- Afficher les jockeys (id, nom, prenom) ayant couru au moins 2 fois avec le meme poney (et afficher sont nom)
 */
SELECT j.id AS "Id Jockey", j.nom AS "Nom Jockey", j.prenom AS "Prenom Jockey", p.nom AS "Nom Poney"
FROM jockeyponeycourse AS r
INNER JOIN poney AS p ON r.id_poney = p.id
INNER JOIN jockey AS j ON r.id_jockey = j.id  
GROUP BY r.id_jockey, r.id_poney
HAVING COUNT(r.id_poney) >= 2;

/*
 * 8- Afficher les courses (courses.id, jokey(nom, prenom), poney.name) de plus de 4 participants en classant les données par course, puis par jockey, puis par poney
 */
SELECT r1.id_course, j.nom, j.prenom, p.nom
FROM jockeyponeycourse AS r1
INNER JOIN jockey AS j ON r1.id_jockey = j.id
INNER JOIN poney AS p ON r1.id_poney = p.id 
WHERE r1.id_course IN (
    SELECT r.id_course
    FROM jockeyponeycourse AS r
    GROUP BY r.id_course
    HAVING COUNT(r.id_course) > 4 )
ORDER BY r1.id_course, r1.id_jockey, r1.id_poney;