use optica;

# Total compres client
SELECT marca.nom,
       vendes.quantitat,
       client.nom
FROM vendes
JOIN client
ON vendes.id_client = client.id
JOIN ulleres
ON vendes.id_ulleres = ulleres.id
JOIN marca
ON ulleres.id_marca = marca.id
WHERE client.nom = "John Doe"
GROUP BY marca.nom, vendes.quantitat, client.nom;

# Diferents ulleres venudes per un empleat durant un any
SELECT marca.nom,
       CONCAT(ulleres.graduacio_vidre_dret, ulleres.graduacio_vidre_esq) AS graduacio,
       ulleres.muntura,
       ulleres.color_muntura,
       CONCAT(ulleres.color_vidre_esq, ulleres.color_vidre_dret) AS "color vidres",
       ulleres.preu
FROM marca
JOIN ulleres
ON marca.id = ulleres.id_marca
JOIN vendes
ON id_ulleres = ulleres.id
JOIN empleat
ON vendes.id_empleat = empleat.id
WHERE empleat.nom LIKE "Grace%"
AND vendes.data BETWEEN "2024-01-01" AND "2024-12-31";

# Diferents proveidors que han subministrat ulleres venudes amb èxit
SELECT *
FROM proveidor
JOIN marca
ON proveidor.id = marca.id_proveidor
JOIN ulleres
ON marca.id = ulleres.id_marca
RIGHT JOIN vendes
ON ulleres.id = vendes.id_ulleres;