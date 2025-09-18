-- 1. Número y nombre de los vendedores a los que les hemos solicitado algún pedido en el año 1995 pero no les hemos solicitado ninguno en el año 1992.

SELECT v.numvend, v.nomvend FROM vendedor v WHERE v.numvend IN (
      SELECT p.numvend FROM pedido p WHERE p.fecha BETWEEN TO_DATE('01/01/95','DD/MM/YY') AND TO_DATE('31/12/95','DD/MM/YY')
    ) AND v.numvend NOT IN (
      SELECT p.numvend FROM pedido p WHERE p.fecha BETWEEN TO_DATE('01/01/92','DD/MM/YY') AND TO_DATE('31/12/92','DD/MM/YY')
    );

-- 2. Obtener el número y el nombre las piezas que puedan sernos suministradas por más de dos vendedores de la provincia de Alicante, y que en total (entre todos los pedidos solicitados a todos los vendedores) hayamos pedido más de 500 unidades.

SELECT p.numpieza, p.nompieza FROM pieza p
    JOIN preciosum pr ON p.numpieza=pr.numpieza
    JOIN vendedor v ON pr.numvend=v.numvend
    JOIN pedido pe ON v.numvend=pe.numvend
    JOIN linped ON pe.numpedido=linped.numpedido
    WHERE v.provincia='ALICANTE' GROUP BY p.numpieza, p.nompieza
    HAVING COUNT(DISTINCT v.numvend)>2 AND SUM(linped.cantpedida)>500;

-- 3. Obtener para el número y nombre de los vendedores de Alicante a los que se les haya solicitado alguna pieza, de la que nos habían indicado que su plazo de suministro sería superior a una semana, junto con el número y nombre de la pieza, y la cantidad de pedidos distintos en los que se les ha solicitado. Ordena el resultado por la última columna.

SELECT v.numvend, v.nomvend, pi.numpieza, pi.nompieza, l.numpedido FROM vendedor v
    JOIN pedido p ON v.numvend = p.numvend 
    JOIN linped l ON p.numpedido = l.numpedido
    JOIN pieza pi ON pi.numpieza = l.numpieza
    WHERE  v.provincia='ALICANTE'
    AND  pi.numpieza IN (SELECT pr.numpieza FROM preciosum pr WHERE pr.diassum>7)
    GROUP BY v.numvend, v.nomvend, pi.nompieza, pi.numpieza, l.numpedido 
    ORDER BY l.numpedido DESC;

-- 4. Crea una vista con los datos con todos los datos de los productos que aparezcan en el inventario pero que no hayan aparecido en un pedido.



-- 5. Crea un listado con el numero, nombre, precio de suministro y descuento de todos aquellas piezas que tengamos en la base de datos indepediendentemente que puedan sernos suministradas o no por un vendedor.

SELECT p.numpieza, p.nompieza, pr.preciounit, pr.descuento FROM pieza p 
JOIN preciosum pr ON p.numpieza=pr.numpieza;