# BASE DE DADES TIENDA
USE tienda;
# 1
SELECT * FROM producto;
# 2
SELECT nombre, precio FROM producto;

# 3
SHOW COLUMNS FROM producto;

# 4
SELECT nombre,
       precio AS '€',
       ROUND((precio * 1.12), 2) AS 'USD'
FROM producto;

# 5
SELECT nombre AS 'nom de "producto"',
       precio AS 'euros',
       ROUND((precio * 1.12), 2) AS 'dòlars nord-americans'
FROM producto;

# 6
SELECT UPPER(nombre),
       precio
FROM producto;

# 7
SELECT LOWER(nombre),
       precio
FROM producto;

# 8
SELECT nombre,
       UPPER(SUBSTRING(nombre, 1, 2))
FROM fabricante;

# 9
SELECT nombre,
       ROUND(precio)
FROM producto;

# 10
SELECT precio,
       TRUNCATE(precio, 0)
FROM producto;

# 11
SELECT codigo_fabricante
FROM producto
JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante;

# 12
SELECT codigo_fabricante
FROM producto
JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
GROUP BY codigo_fabricante;

# 13
SELECT nombre
FROM fabricante
ORDER BY nombre ASC;

# 14
SELECT nombre
FROM fabricante
ORDER BY nombre DESC;

#15
SELECT nombre
FROM producto
ORDER BY nombre ASC, precio DESC;

# 16
SELECT *
FROM fabricante
LIMIT 5;


# 17
SELECT *
FROM fabricante
LIMIT 3,2;


# 18
SELECT nombre,
       precio
FROM producto
ORDER BY precio
LIMIT 1;

# 19
SELECT nombre,
       precio
FROM producto
ORDER BY precio DESC
LIMIT 1;

# 20
SELECT nombre
FROM producto
WHERE codigo_fabricante = 2;

# 21
SELECT producto.nombre,
       producto.precio,
       fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo;

# 22
SELECT producto.nombre,
       producto.precio,
       fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre;

# 23
SELECT producto.codigo,
       producto.nombre,
       producto.codigo_fabricante,
       fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo;

# 24
SELECT producto.nombre,
    producto.precio,
    fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
ORDER BY precio ASC
LIMIT 1;

# 25
SELECT producto.nombre,
    producto.precio,
    fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
ORDER BY precio DESC
LIMIT 1;

#26
SELECT producto.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

#27
SELECT producto.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;


#28
SELECT producto.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre REGEXP ('Asus|Hewlett-Packard|Seagate');


#29
SELECT producto.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

#30
SELECT producto.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE ('%e');

#31
SELECT producto.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE ('%w%');


# 32
SELECT producto.nombre,
       producto.precio,
       fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE precio >= 180
ORDER BY producto.precio DESC, producto.nombre;


# 33
SELECT DISTINCT fabricante.codigo,
                fabricante.nombre
FROM fabricante
JOIN producto
ON fabricante.codigo = producto.codigo_fabricante;

# 34
SELECT fabricante.nombre,
       GROUP_CONCAT(producto.nombre SEPARATOR ', ') AS productos
FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.nombre;

# 35
SELECT fabricante.nombre
FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.codigo IS NULL;

# 36
SELECT nombre
FROM producto
WHERE codigo_fabricante = (SELECT codigo
                           FROM fabricante
                           WHERE nombre = 'Lenovo');

# 37
SELECT *
FROM producto
WHERE precio = (SELECT MAX(precio)
                FROM producto
                WHERE codigo_fabricante = (SELECT codigo
                                           FROM fabricante
                                           WHERE nombre = 'Lenovo'));

#38
SELECT producto.nombre,
       producto.precio
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo'
ORDER BY producto.precio DESC
LIMIT 1;

#39
SELECT nombre,
       precio
FROM producto
WHERE precio = (SELECT MIN(producto.precio)
                       FROM producto
                       JOIN fabricante
                       ON producto.codigo_fabricante = fabricante.codigo
                       WHERE fabricante.nombre = 'Hewlett-Packard');

#40
SELECT nombre,
       precio
FROM producto
WHERE precio >= (SELECT MAX(producto.precio)
                 FROM producto
                 JOIN fabricante
                 ON producto.codigo_fabricante = fabricante.codigo
                 WHERE fabricante.nombre = 'Lenovo');

#41
SELECT *
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus'
AND producto.precio > (
    SELECT AVG(producto.precio)
    FROM producto
    JOIN fabricante
    ON producto.codigo_fabricante = fabricante.codigo
    WHERE fabricante.nombre = 'Asus'
    );

USE universidad;
# PART 1
# 1
SELECT DISTINCT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

# 2
SELECT DISTINCT nombre, apellido1, apellido2, telefono
FROM persona
WHERE tipo = 'alumno'
  AND telefono IS NULL;

# 3
SELECT DISTINCT nombre,
       apellido1,
       apellido2,
       fecha_nacimiento
FROM persona
WHERE tipo='alumno'
    AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

# 4
SELECT DISTINCT nombre,
                apellido1,
                apellido2,
                nif
FROM persona
JOIN profesor
ON persona.id = profesor.id_profesor
WHERE telefono IS NULL
AND nif LIKE ('%K');

# 5
SELECT asignatura.nombre,
       asignatura.creditos,
       asignatura.tipo
FROM asignatura
JOIN grado
ON asignatura.id_grado = grado.id
WHERE grado.id = 7
AND asignatura.cuatrimestre = 1;

# 6
SELECT DISTINCT
       persona.apellido1,
       persona.apellido2,
       persona.nombre,
       departamento.nombre
FROM persona
JOIN profesor
ON persona.id = profesor.id_profesor
JOIN departamento
ON departamento.id = profesor.id_departamento
ORDER BY apellido1 DESC, apellido2 DESC, persona.nombre DESC;

# 7
SELECT asignatura.nombre,
       curso_escolar.anyo_inicio,
       curso_escolar.anyo_fin
FROM asignatura
JOIN alumno_se_matricula_asignatura
ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
JOIN curso_escolar
ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE alumno_se_matricula_asignatura.id_alumno = (SELECT id
                                                  FROM persona
                                                  WHERE nif = '26902806M');
#8
SELECT departamento.nombre
FROM grado
JOIN asignatura
ON grado.id = asignatura.id_grado
JOIN profesor
ON asignatura.id_profesor = profesor.id_profesor
JOIN departamento
ON profesor.id_departamento = departamento.id
WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)'
GROUP BY departamento.nombre;

# 9
SELECT DISTINCT p.nombre,
       p.apellido1,
       p.apellido2
FROM persona p
JOIN alumno_se_matricula_asignatura a_mat
ON p.id = a_mat.id_alumno
JOIN curso_escolar ce
ON a_mat.id_curso_escolar = ce.id
WHERE anyo_inicio = '2018';

# PART 2 [idx] n_pregunta
#[10] 1
SELECT dep.nombre,
    p.nombre,
    p.apellido1,
    p.apellido2
FROM persona p
JOIN profesor pf
ON p.id = pf.id_profesor
LEFT JOIN departamento dep
ON pf.id_departamento = dep.id
ORDER BY dep.nombre DESC, p.apellido1 DESC, p.apellido2 DESC, p.nombre;

#[11] 2
SELECT DISTINCT p.nombre,
                p.apellido1,
                p.apellido2
FROM persona p
JOIN profesor pf
ON p.id = pf.id_profesor
LEFT JOIN departamento dep
ON pf.id_departamento = dep.id
WHERE pf.id_departamento IS NULL;

#[12] 3
SELECT dep.nombre
FROM departamento dep
LEFT JOIN profesor
ON dep.id = profesor.id_departamento
WHERE profesor.id_departamento IS NULL;

#[13] 4
SELECT DISTINCT CONCAT(p.nombre,' ',p.apellido1, ' ', p.apellido2) AS profesors_sense_asignatura
FROM persona p
JOIN profesor
LEFT JOIN asignatura
ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.nombre IS NULL
GROUP BY profesors_sense_asignatura;

#[14] 5
SELECT asignatura.nombre AS asignaturas_sin_profesor
FROM asignatura
LEFT JOIN profesor
ON asignatura.id_profesor = profesor.id_profesor
WHERE asignatura.id_profesor IS NULL;

#[15] 6
SELECT dep.nombre
FROM departamento dep
LEFT JOIN profesor p
ON dep.id = p.id_departamento
LEFT JOIN asignatura a
ON p.id_profesor = a.id_profesor
LEFT JOIN alumno_se_matricula_asignatura ama
ON a.id = ama.id_asignatura
GROUP BY dep.id
HAVING COUNT(ama.id_curso_escolar) = 0;

# PART 3: Consultes resum
#[16] 1
SELECT COUNT(DISTINCT p.id)
FROM persona p
WHERE tipo = 'alumno';

#[17] 2
SELECT COUNT(DISTINCT p.id)
FROM persona p
WHERE p.tipo = 'alumno' AND p.fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

#[18] 3
SELECT DISTINCT dep.nombre AS departamento,
                COUNT(profesor.id_profesor) AS numero_profesores
FROM departamento dep
JOIN profesor
ON dep.id = profesor.id_departamento
GROUP BY dep.nombre
ORDER BY numero_profesores DESC;

#[19] 4
SELECT DISTINCT dep.nombre,
                COUNT(profesor.id_profesor)
FROM departamento dep
LEFT JOIN profesor
ON dep.id = profesor.id_departamento
GROUP BY dep.nombre;

#[20] 5
SELECT DISTINCT g.nombre,
       COUNT(a.id) AS asignaturas
FROM grado g
LEFT JOIN asignatura a
ON g.id = a.id_grado
GROUP BY g.nombre
ORDER BY asignaturas DESC;