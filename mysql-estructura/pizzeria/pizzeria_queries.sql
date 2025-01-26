use pizzeria;
/* Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat. */

SELECT SUM(cp.quantitat) AS "total begudes venudes a BCN"
FROM comandes c
JOIN comanda_productes cp
ON cp.id_comanda = c.id
JOIN botigues b
    ON c.id_botiga = b.id
JOIN adreces a
ON a.id_usuari = b.id
JOIN productes p
ON cp.id_producte = p.id
WHERE p.tipus = "beguda"
AND a.localitat = "Barcelona";



/* Llista quantes comandes ha efectuat un determinat empleat/da. */
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
