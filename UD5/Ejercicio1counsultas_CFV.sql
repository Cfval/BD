--1. Seleccciona todos los campos de inventario que hayan sido inventariadas en octubre del 92

SELECT * FROM inventario WHERE FECHARECUENTO>=TO_DATE('01/10/92', 'DD/MM/YY') AND FECHARECUENTO<=TO_DATE('30/10/92', 'DD/MM/YY');

--2. Selecciona el nombre de las piezas y el precio de venta de aquellas piezas que sean PEGATINAS y cuyo valor supere los 50€

SELECT NOMPIEZA, PRECIOVENT FROM PIEZA WHERE NOMPIEZA LIKE '%PEGATINAS%' AND PRECIOVENT > 50;

--3. Selecciona el nombre del vendedor, nombre de la comercial y nombre del producto de aquellas piezas que pueden sernos suministradas con un descuento

SELECT NOMVEND ,NOMBRECOMER , NOMPIEZA FROM VENDEDOR V,PRECIOSUM PS ,PIEZA P
WHERE V.NUMVEND=PS.NUMVEND AND PS.NUMPIEZA=P.NUMPIEZA AND PS.DESCUENTO IS NOT NULL AND PS.DESCUENTO !=0

--4. Selecciona la media más alta de descuento de todos los productos que pueden sernos suministrados

SELECT   MAX(AVG(descuento)) FROM PRECIOSUM WHERE DESCUENTO IS NOT NULL AND DESCUENTO !=0 GROUP BY DESCUENTO;

--5. Selecciona aquellas piezas cuya cantidad pedida media por pedido supere las 30 unidades

SELECT NUMPIEZA, AVG(CANTPEDIDA) FROM LINPED GROUP BY NUMPIEZA HAVING AVG(CANTPEDIDA) > 30;