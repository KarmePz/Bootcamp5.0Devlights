/*# Semana 6 · Clase 12 · Tarea — JOINs sobre el minimercado
## 📝 Ejercicios

Usar `ORDER BY` en todas las consultas.

### INNER JOIN

1. Mostrar el nombre de cada proveedor y los nombres de sus productos (solo proveedores que tienen productos).*/

SELECT p.nombre AS proveedor, pr.nombre AS producto
FROM proveedores p
INNER JOIN productos pr ON p.id = pr.proveedor_id  
ORDER BY p.nombre, pr.nombre;
/*

### LEFT JOIN

2. Mostrar **todos** los proveedores y cuántos productos tiene cada uno (incluyendo los que tienen 0).
*/
SELECT p.nombre AS proveedor, COUNT(pr.id) AS cantidad_productos
FROM proveedores p
LEFT JOIN productos pr ON p.id = pr.proveedor_id
GROUP BY p.id, p.nombre
ORDER BY p.nombre;


---3. Mostrar las ventas que **no tienen ningún producto** cargado en `venta_productos`.

SELECT v.id AS venta_id, v.fecha, v.total, v.cliente_id, v.metodo_pago_id, vp.cantidad as cantidad_vendida
FROM ventas v
LEFT JOIN venta_productos vp ON v.id = vp.venta_id
WHERE vp.venta_id IS NULL
ORDER BY v.id;

--### RIGHT JOIN

--4. Escribiendo la consulta con `RIGHT JOIN`, mostrar **todos** los métodos de pago y cuántas ventas tiene cada uno.
SELECT mp.nombre AS metodo_pago, COUNT(v.id) AS cantidad_ventas
FROM ventas v 
RIGHT JOIN metodos_pago mp ON v.metodo_pago_id = mp.id
GROUP BY mp.id, mp.nombre
OrDER BY mp.nombre;

---### FULL OUTER JOIN

--5. Hacer un `FULL OUTER JOIN` entre `productos` y `venta_productos` y mostrar los productos que **nunca se vendieron**.
SELECT pr.nombre AS producto, vp.venta_id
FROM productos pr
FULL OUTER JOIN venta_productos vp ON pr.id = vp.producto_id
WHERE vp.venta_id IS NULL
ORDER BY pr.nombre;


--### CROSS JOIN

--6. Generar todas las combinaciones de productos y métodos de pago (producto, precio, método de pago). ¿Cuántas filas devuelve y por qué?
SELECT pr.nombre AS producto, pr.precio, mp.nombre AS metodo_pago
FROM productos pr
CROSS JOIN metodos_pago mp
ORDER BY pr.nombre, mp.nombre;
--Devuelve 50 filas, porque hay 10 productos y 5 metodos de pago, y el cross join devuelve todas las combinaciones entre tablas (10 * 5 = 50).

--### JOIN múltiple

--7. Mostrar cliente , fecha de venta y **cantidad total de unidades** de cada venta, combinando `ventas`, `venta_productos` y `clientes`.
SELECT c.nombre AS cliente, v.fecha, SUM(vp.cantidad) AS cantidad_total_unidades
FROM ventas v
INNER JOIN venta_productos vp ON v.id = vp.venta_id
INNER JOIN clientes c ON v.cliente_id = c.id
GROUP BY v.id, c.nombre, v.fecha
ORDER BY v.fecha, c.nombre;

--8. Mostrar el **total facturado** (`cantidad * precio_unitario`) por proveedor, de mayor a menor.
SELECT p.nombre AS proveedor, SUM(vp.cantidad * pr.precio) AS total_facturado
FROM proveedores p
INNER JOIN productos pr ON p.id = pr.proveedor_id
INNER JOIN venta_productos vp ON pr.id = vp.producto_id
GROUP BY p.id, p.nombre
ORDER BY total_facturado DESC;

--### JOIN múltiple combinando INNER y LEFT

--9. Mostrar **todos** los productos con el nombre de su proveedor y cuántas unidades se vendieron de cada uno. Los productos que nunca se vendieron también tienen que aparecer.
SELECT pr.nombre AS producto, p.nombre AS proveedor, COALESCE(SUM(vp.cantidad), 0) AS unidades_vendidas
FROM productos pr
INNER JOIN proveedores p ON p.id = pr.proveedor_id
LEFT JOIN venta_productos vp ON pr.id = vp.producto_id
GROUP BY p.id, p.nombre, pr.id, pr.nombre
ORDER BY p.nombre, pr.nombre;


--10. Mostrar **todas** las ventas con el nombre del cliente, el método de pago y cuántos productos distintos tiene cada una. Las ventas sin productos cargados tienen que aparecer con 0.
SELECT v.id AS venta_id, c.nombre AS cliente, mp.nombre AS metodo_pago, COUNT(DISTINCT vp.producto_id) AS cantidad_productos_distintos
FROM ventas v
LEFT JOIN clientes c ON v.cliente_id = c.id
LEFT JOIN metodos_pago mp ON v.metodo_pago_id = mp.id
LEFT JOIN venta_productos vp ON v.id = vp.venta_id
GROUP BY v.id, c.nombre, mp.nombre
ORDER BY v.id;

--11. Mostrar **todos** los proveedores y en cuántas ventas distintas se vendió algún producto suyo (0 si nunca). Después probar cambiar el segundo `LEFT JOIN` por `INNER JOIN`: ¿qué proveedores desaparecen y por qué?
SELECT p.nombre AS proveedor, COUNT(DISTINCT vp.venta_id) AS cantidad_ventas_distintas 
FROM proveedores p
LEFT JOIN productos pr ON p.id = pr.proveedor_id
LEFT JOIN venta_productos vp ON pr.id = vp.producto_id
GROUP BY p.id, p.nombre
ORDER BY cantidad_ventas_distintas;


SELECT p.nombre AS proveedor, COUNT(DISTINCT vp.venta_id) AS cantidad_ventas_distintas
FROM proveedores p  
LEFT JOIN productos pr ON p.id = pr.proveedor_id
INNER JOIN venta_productos vp ON pr.id = vp.producto_id
GROUP BY p.id, p.nombre
ORDER BY cantidad_ventas_distintas;
--Desaparecen los proveedores que nunca vendieron productos, porque cuando se cambia el segundo LEFT JOIN por INNER JOIN, se filtran los proveedores que no tienen ventas asociadas o su valor es 0.
--Probando con los datos, desaparecen los proveedores 10 y 11, que no tienen productos asociados.

--## ✅ Entrega

--Archivo `.sql` con las 11 consultas, cada una con un comentario indicando el número de ejercicio.
