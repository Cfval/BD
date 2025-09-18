-- 1. Número y nombre de los vendedores que oferten alguna de las piezas que pueden ser suministradas por el vendedor número 1, pero que no oferten ninguna de las que puedan ser suministradas por el vendedor número 2.

SELECT numvend, nomvend
FROM vendedor
WHERE numvend = 1 AND numpieza IN (SELECT numpieza FROM preciosum WHERE numvend = 1)
AND numvend NOT IN (SELECT numvend FROM preciosum WHERE numpieza IN (SELECT numpieza FROM preciosum WHERE numvend = 2));


-- 2. Obtener el número y el nombre de los vendedores y la cantidad de piezas que pueden suministrar a un precio entre 15 y 20 euros, ordenado por el nombre de vendedor.

SELECT v.numvend, v.nomvend, COUNT(p.numpieza) AS cantidad_piezas
FROM vendedor v
JOIN preciosum p ON v.numvend = p.numvend
WHERE p.preciounit BETWEEN 15 AND 20
GROUP BY v.numvend, v.nomvend
ORDER BY v.nomvend;


-- 3. Obtener, para el vendedor que cumple que la diferencia de precio al que le compramos una pieza y el precio que nos había ofrecido por ella sea máxima, el número de vendedor, su nombre y la diferencia media entre el precio al que nos vende las piezas y el que nos había ofrecido por las mismas.

SELECT numvend, nomvend, AVG(p.preciounit - l.preciocompra) AS diferencia_media
FROM vendedor v
JOIN preciosum p ON v.numvend = p.numvend
JOIN linped l ON p.numpieza = l.numpieza
GROUP BY numvend, nomvend
ORDER BY diferencia_media DESC
FETCH FIRST ROW ONLY;


-- 4. Obtener el número de pieza de los teclados que nos han sido servidos en el mayo de cualquier año.

SELECT DISTINCT numpieza
FROM linped
WHERE EXTRACT(MONTH FROM feCHARecep) = 5;


-- 5. Obtener un listado en el que figure el número y nombre de la pieza , junto con el número y nombre de vendedor que nos ha ofertado la pieza, pero al que nunca se la hemos solicitado.

SELECT DISTINCT p.numpieza, p.nompieza, v.numvend, v.nomvend
FROM pieza p
JOIN preciosum ps ON p.numpieza = ps.numpieza
JOIN vendedor v ON ps.numvend = v.numvend
WHERE p.numpieza NOT IN (SELECT DISTINCT l.numpieza FROM linped l);
