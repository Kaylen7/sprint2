use pizzeria;
SELECT botiga_adreces.provincia,
       SUM(comanda_productes.quantitat) AS total_begudes,
       COUNT(comandes.id) AS "total_comandes"
FROM comandes
JOIN comanda_pasarela_productes
ON comandes.id = comanda_pasarela_productes.id_comanda
JOIN comanda_productes
ON comanda_pasarela_productes.id_productes = comanda_productes.id
JOIN productes
ON comanda_productes.id_producte = productes.id
JOIN botiga_adreces
ON botiga_adreces.id_botiga = comandes.id_botiga
WHERE productes.tipus = "beguda"
AND botiga_adreces.localitat = "Barcelona"
GROUP BY botiga_adreces.provincia;

SELECT comandes.id AS id_comanda,
       comandes.data,
       CASE
           WHEN comandes.a_domicili = 1
               THEN "a domicili"
               ELSE "en botiga"
            END AS a_domicili,
       CONCAT(empleats.nom, " ", empleats.cognom1, " ", empleats.cognom2) AS ates_per
FROM comandes
LEFT JOIN empleats
ON comandes.id_botiga = empleats.id_botiga
WHERE empleats.nif = '436543210';
