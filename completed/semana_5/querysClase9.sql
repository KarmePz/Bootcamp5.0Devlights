CREATE TABLE apartments (
    id SERIAL PRIMARY KEY,
	name VARCHAR(50),
    address VARCHAR(100),
    city VARCHAR(50),
	postal_code VARCHAR(10),
	bedrooms INT,
	area_m2 NUMERIC(6,2),
	price NUMERIC(10,2),
	available BOOLEAN,
	published_date DATE
);

/*Insertar 30 filas*/

INSERT INTO apartments (name, address, city, postal_code, bedrooms, area_m2, price, available, published_date) VALUES
('Depto A', 'Av. Siempre Viva 123', 'Buenos Aires', 'C1000', 2, 55.5, 120000, TRUE, '2023-08-01'),
('Depto B', 'Av. Corrientes 456', 'Buenos Aires', 'C1043', 1, 42.0, 95000, TRUE, '2023-08-05'),
('Depto C', 'Calle San Martin 789', 'Cordoba', 'X5000', 3, 85.5, 180000, FALSE, '2023-08-10'),
('Depto D', 'Av. Colon 321', 'Cordoba', 'X5001', 2, 65.0, 145000, TRUE, '2023-08-12'),
('Depto E', 'Calle Mitre 654', 'Rosario', 'S2000', 1, 38.5, 85000, TRUE, '2023-08-15'),
('Depto F', 'Av. Pellegrini 987', 'Rosario', 'S2001', 3, 92.0, 210000, FALSE, '2023-08-20'),
('Depto G', 'Calle Belgrano 147', 'Mendoza', 'M5500', 2, 60.0, 130000, TRUE, '2023-09-01'),
('Depto H', 'Av. Las Heras 258', 'Mendoza', 'M5501', 1, 45.0, 105000, TRUE, '2023-09-03'),
('Depto I', 'Calle Rivadavia 369', 'Salta', 'A4400', 2, 58.5, 115000, FALSE, '2023-09-05'),
('Depto J', 'Av. Belgrano 741', 'Salta', 'A4401', 3, 88.0, 195000, TRUE, '2023-09-08'),
('Depto K', 'Calle Mitre 852', 'Resistencia', 'H3500', 2, 62.0, 110000, TRUE, '2023-09-10'),
('Depto L', 'Av. Sarmiento 963', 'Resistencia', 'H3501', 1, 40.0, 78000, TRUE, '2023-09-12'),
('Depto M', 'Calle Brown 159', 'Corrientes', 'W3400', 3, 90.0, 175000, FALSE, '2023-09-15'),
('Depto N', 'Av. Costanera 753', 'Corrientes', 'W3401', 2, 68.5, 150000, TRUE, '2023-09-18'),
('Depto O', 'Calle Moreno 357', 'La Plata', 'B1900', 1, 35.0, 72000, TRUE, '2023-09-20'),
('Depto P', 'Av. 7 468', 'La Plata', 'B1901', 2, 57.0, 125000, FALSE, '2023-09-22'),
('Depto Q', 'Calle San Juan 852', 'Mar del Plata', 'B7600', 2, 64.0, 160000, TRUE, '2023-10-01'),
('Depto R', 'Av. Independencia 951', 'Mar del Plata', 'B7601', 3, 95.0, 230000, TRUE, '2023-10-03'),
('Depto S', 'Calle España 246', 'Neuquen', 'Q8300', 1, 43.5, 98000, FALSE, '2023-10-05'),
('Depto T', 'Av. Argentina 357', 'Neuquen', 'Q8301', 2, 70.0, 155000, TRUE, '2023-10-08'),
('Depto U', 'Calle Lavalle 468', 'Tucuman', 'T4000', 2, 59.0, 118000, TRUE, '2023-10-10'),
('Depto V', 'Av. Aconquija 579', 'Tucuman', 'T4107', 3, 105.0, 220000, FALSE, '2023-10-12'),
('Depto W', 'Calle Falsa 123', 'Parana', 'E3100', 1, 39.0, 82000, TRUE, '2023-10-15'),
('Depto X', 'Av. Ramirez 684', 'Parana', 'E3101', 2, 66.0, 140000, TRUE, '2023-10-18'),
('Depto Y', 'Calle Uruguay 795', 'Posadas', 'N3300', 2, 61.5, 135000, FALSE, '2023-10-20'),
('Depto Z', 'Av. Roque Perez 846', 'Posadas', 'N3301', 3, 87.0, 185000, TRUE, '2023-10-22'),
('Depto AA', 'Calle Alem 951', 'San Juan', 'J5400', 1, 44.0, 90000, TRUE, '2023-11-01'),
('Depto AB', 'Av. Libertador 159', 'San Juan', 'J5401', 2, 72.0, 165000, FALSE, '2023-11-05'),
('Depto AC', 'Calle 25 de Mayo 753', 'Santa Fe', 'S3000', 3, 98.0, 205000, TRUE, '2023-11-10'),
('Depto AD', 'Av. General Paz 864', 'Santa Fe', 'S3001', 2, 63.5, 142000, TRUE, '2023-11-15');


/*1. Mostrar los departamentos disponibles, ordenados del más barato al más caro.
*/
SELECT * From apartments ORDER BY price ASC; 


/*2. Mostrar el precio promedio por ciudad.*/

SELECT ROUND(AVG(price), 2) as averagePrice, city  From apartments Group by city ORDER by averagePrice;

/*3. Mostrar los departamentos con 2 o más habitaciones y menos de 60 m².*/

SELECT * From apartments WHERE bedrooms > 1 AND area_m2 < 60

/*Crear la tabla Ventas*/

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(30),
    price NUMERIC,
    quantity INT,
    sale_date DATE
);


/*Insertar los datos:*/

INSERT INTO sales (product, category, price, quantity, sale_date) VALUES
('Mouse', 'Electronics', 15, 4, '2023-07-10'),
('Keyboard', 'Electronics', 30, 2, '2023-07-11'),
('Notebook', 'Stationery', 8, 10, '2023-07-12'),
('Pen', 'Stationery', 2, 25, '2023-07-13'),
('Headphones', 'Electronics', 40, 3, '2023-07-14'),
('Monitor', 'Electronics', 120, 1, '2023-07-15'),
('Desk Chair', 'Furniture', 85, 2, '2023-07-16'),
('Notebook Case', 'Accessories', 25, 3, '2023-07-17'),
('Printer Paper', 'Stationery', 6, 15, '2023-07-18'),
('USB Drive', 'Electronics', 12, 5, '2023-07-19'),
('Desk Lamp', 'Furniture', 35, 4, '2023-07-20'),
('Stapler', 'Stationery', 7, 6, '2023-07-21'),
('Calculator', 'Electronics', 20, 3, '2023-07-22'),
('Water Bottle', 'Accessories', 10, 8, '2023-07-23'),
('Laptop Stand', 'Accessories', 45, 2, '2023-07-24'),
('Office Desk', 'Furniture', 150, 1, '2023-07-25'),
('Whiteboard', 'Furniture', 60, 1, '2023-07-26'),
('Marker Set', 'Stationery', 5, 12, '2023-07-27'),
('Mouse Pad', 'Accessories', 8, 7, '2023-07-28'),
('Webcam', 'Electronics', 50, 2, '2023-07-29'),
('Smartphone', 'Electronics', 300, 1, '2023-07-30'),
('Notebook Pro', 'Electronics', 900, 1, '2023-07-31'),
('File Cabinet', 'Furniture', 120, 1, '2023-08-01'),
('Backpack', 'Accessories', 40, 3, '2023-08-02'),
('Binder', 'Stationery', 4, 20, '2023-08-03'),
('Headset Stand', 'Accessories', 15, 5, '2023-08-04'),
('Desk Organizer', 'Accessories', 12, 6, '2023-08-05'),
('Laptop Sleeve', 'Accessories', 30, 2, '2023-08-06'),
('Paper Clips', 'Stationery', 1, 50, '2023-08-07'),
('Surge Protector', 'Electronics', 25, 3, '2023-08-08'),
('Pen Holder', 'Accessories', 5, 10, '2023-08-09');

/*EJERCICIOS
1. Mostrar todas las ventas de la categoría `'Electronics'`.
*/
SELECT * FROM sales WHERE category = 'Electronics';
/*2. Calcular el total de ingresos por categoría (`price * quantity`).
*/
SELECT category, SUM(price * quantity) AS total_income FROM sales GROUP BY category;
/*3. Obtener la categoría con mayor ingreso total.
*/
Select category, SUM(price * quantity) AS total_income FROM sales GROUP BY category ORDER BY total_income DESC LIMIT 1;
/*4. Mostrar todas las ventas donde el precio del producto sea mayor a 20.
*/
SELECT * FROM sales WHERE category = 'Electronics';
/*5. Calcular el total de unidades vendidas (`SUM(quantity)`) por cada producto.
*/
SELECT product, SUM(quantity) AS total_quantity FROM sales GROUP BY product;
/*6. Calcular el ingreso promedio por venta (`AVG(price * quantity)`) para cada producto.
*/
SELECT product, AVG(price * quantity) AS average_income FROM sales GROUP BY product;
/*7. Mostrar los 3 productos con mayor cantidad total vendida (`SUM(quantity)`) usando `ORDER BY` y `LIMIT`.
*/
SELECT product, SUM(quantity) AS total_quantity FROM sales GROUP BY product ORDER BY total_quantity DESC LIMIT 3;
/*8. Mostrar todas las ventas realizadas después del 12 de julio de 2023.
*/
SELECT * FROM sales WHERE sale_date > '2023-07-12';
/*9. Mostrar la categoría y el ingreso total, pero solo para categorías cuyo ingreso sea mayor a 50 (`HAVING SUM(price * quantity) > 50`).
*/
SELECT category, SUM(price * quantity) AS total FROM sales GROUP BY category HAVING SUM(price * quantity) > 50;
/*10. Mostrar todas las ventas donde el nombre del producto comience con la letra H (`LIKE 'H%'`).
*/
SELECT * FROM sales WHERE product LIKE 'H%';
/*11. Calcular la cantidad promedio de productos vendidos (`AVG(quantity)`) agrupados por categoría.
*/
SELECT category, AVG(quantity) AS average_quantity FROM sales GROUP BY category;
/*12. Mostrar todas las ventas y calcular el ingreso por fila (`price * quantity`), ordenadas de mayor a menor ingreso.
*/
SELECT *, (price * quantity) AS PricePerQuantity FROM sales ORDER BY PricePerQuantity DESC;
/*13. Mostrar todas las ventas de la categoría `'Electronics'` donde la cantidad sea mayor a 2 y el precio menor a 40.
*/
SELECT * FROM sales WHERE category = 'Electronics' AND quantity > 2 AND price < 40;