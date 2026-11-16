/*# Semana 6 · Clase 11 · Tarea — Diseñar una base de datos transaccional
---CASO ELEGIDO---

## 1️⃣ Biblioteca

- **Tablas:** `autores`, `libros`, `socios`, `carnets`, `prestamos`, `prestamo_libros`.
- **Relaciones:**
    - Cada socio tiene un solo carnet y cada carnet es de un solo socio (**1:1** `socios` ↔ `carnets`).
    - Un autor escribe muchos libros; cada libro tiene un solo autor (**1:N** `autores` → `libros`).
    - Un socio puede tener muchos préstamos (**1:N** `socios` → `prestamos`).
    - Un préstamo puede incluir varios libros y un libro puede estar en varios préstamos (**N:N** mediante `prestamo_libros`).
---
## 📝 Pasos

1. `CREATE TABLE` en **PostgreSQL** con PKs, FKs y un comentario (`--`) en cada relación, usando al menos una vez cada constraint: `NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT`.
2. Generar el **DER** en pgAdmin (clic derecho sobre la base → **ERD For Database**) y verificar que se vean las relaciones 1:1, 1:N y N:N.
3. Insertar al menos 3 filas por tabla.
---
## ✅ Entrega

- Captura del DER de pgAdmin.
- Archivo `.sql` con los `CREATE TABLE` y los `INSERT`.
*/


CREATE TABLE autores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50),
    fecha_nacimiento DATE
);

--cada libro guarda solamente un autor, pero un autor puede tener muchos libros. Relación 1:N autores → libros
CREATE TABLE libros (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    id_autor INT NOT NULL,
    fecha_publicacion DATE,
    genero VARCHAR(50),
    stock INT CHECK (stock >= 0) DEFAULT 1,
    FOREIGN KEY (id_autor) REFERENCES autores(id)
);

--Socios y Carnets tienen una relación 1:1, cada socio tiene un solo carnet y cada carnet es de un solo socio
CREATE TABLE socios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(15),
    email VARCHAR(100) UNIQUE
);
CREATE TABLE carnets (
    id SERIAL PRIMARY KEY,
    id_socio INT UNIQUE NOT NULL,
    fecha_expedicion DATE,
    fecha_vencimiento DATE,
    FOREIGN KEY (id_socio) REFERENCES socios(id) 
);

--Un socio puede tener muchos préstamos, pero un préstamo pertenece a un solo socio. Relación 1:N socios → prestamos
CREATE TABLE prestamos (
    id SERIAL PRIMARY KEY,
    id_socio INT NOT NULL,
    fecha_prestamo DATE DEFAULT CURRENT_DATE,
    fecha_devolucion_pactada DATE DEFAULT CURRENT_DATE + INTERVAL '7 days',
    FOREIGN KEY (id_socio) REFERENCES socios(id)
);

--Un préstamo puede incluir varios libros y un libro puede estar en varios préstamos, evitando duplicados de libro en el mismo préstamo. Relación N:N mediante prestamo_libros
CREATE TABLE prestamo_libros (
    id SERIAL PRIMARY KEY,
    id_prestamo INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_devolucion_real DATE,
    FOREIGN KEY (id_prestamo) REFERENCES prestamos(id),
    FOREIGN KEY (id_libro) REFERENCES libros(id),
    UNIQUE (id_prestamo, id_libro) 
);



--Insertado de datos de prueba en las tablas
-- 1. AUTORES 
INSERT INTO autores (nombre, nacionalidad, fecha_nacimiento) VALUES
('Jorge Luis Borges', 'Argentina', '1899-08-24'),
('Julio Cortázar', 'Argentina', '1914-08-26'),
('Gabriel García Márquez', 'Colombia', '1927-03-06'),
('Isabel Allende', 'Chile', '1942-08-02'),
('Mario Vargas Llosa', 'Perú', '1936-03-28'),
('Silvina Ocampo', 'Argentina', '1903-07-28'),
('Horacio Quiroga', 'Uruguay', '1878-12-31'),
('Stephen King', 'Estados Unidos', '1947-09-21'),
('Haruki Murakami', 'Japón', '1949-01-12'),
('George Orwell', 'Reino Unido', '1903-06-25');

-- 2. LIBROS 
INSERT INTO libros (titulo, id_autor, fecha_publicacion, genero, stock) VALUES
('Ficciones', 1, '1944-01-01', 'Cuento', 4),
('El Aleph', 1, '1949-01-01', 'Cuento', 2),
('Rayuela', 2, '1963-06-28', 'Novela', 3),
('Cien años de soledad', 3, '1967-05-30', 'Realismo mágico', 5),
('La casa de los espíritus', 4, '1982-01-01', 'Novela', 2),
('La ciudad y los perros', 5, '1963-10-10', 'Novela', 1),
('La furia', 6, '1959-01-01', 'Cuento', 3),
('Cuentos de amor de locura y de muerte', 7, '1917-01-01', 'Cuento', 0),
('El resplandor', 8, '1977-01-28', 'Terror', 4),
('It (Eso)', 8, '1986-09-15', 'Terror', 2);

-- 3. SOCIOS 
INSERT INTO socios (nombre, direccion, telefono, email) VALUES
('Lucía Fernández', 'Av. San Martín 450', '3624112233', 'lucia.fernandez@email.com'),
('Martín Gómez', 'Calle Güemes 120', '3624223344', 'martin.gomez@email.com'),
('Sofía Rodríguez', 'Av. Alberdi 890', '3624334455', 'sofia.rodriguez@email.com'),
('Diego Pérez', 'Calle Frondizi 310', '3624445566', 'diego.perez@email.com'),
('Valentina López', 'Av. 25 de Mayo 1020', '3624556677', NULL),
('Camila Torres', 'Calle Pellegrini 55', '3624667788', 'camila.torres@email.com'),
('Mateo Díaz', 'Av. Sarmiento 1400', '3624778899', 'mateo.diaz@email.com'),
('Julieta Ruiz', 'Calle Donovan 215', '3624889900', 'julieta.ruiz@email.com'),
('Nicolás Castro', 'Av. Belgrano 730', '3624990011', 'nicolas.castro@email.com'),
('Agustina Silva', 'Calle Necochea 412', '3624001122', 'agustina.silva@email.com');

-- 4. CARNETS 
INSERT INTO carnets (id_socio, fecha_expedicion, fecha_vencimiento) VALUES
(1, '2025-01-15', '2027-01-15'),
(2, '2025-02-10', '2027-02-10'),
(3, '2024-05-20', '2026-05-20'), -- Carnet vencido
(4, '2025-06-01', '2027-06-01'),
(5, '2025-07-12', '2027-07-12'),
(6, '2025-08-19', '2027-08-19'),
(7, '2024-01-10', '2026-01-10'), -- Carnet vencido
(8, '2025-09-25', '2027-09-25'),
(9, '2026-11-01', '2028-11-01'), 
(10, '2026-11-10', '2028-11-10'); 

-- 5. PRÉSTAMOS
INSERT INTO prestamos (id_socio, fecha_prestamo, fecha_devolucion_pactada) VALUES
(1, '2026-10-01', '2026-10-08'), 
(1, '2026-11-12', '2026-11-19'), 
(2, '2026-10-15', '2026-10-22'), 
(3, '2026-10-20', '2026-10-27'), 
(4, '2026-11-01', '2026-11-08'), 
(5, '2026-11-14', '2026-11-21'), 
(6, '2026-09-10', '2026-09-17'), 
(6, '2026-11-15', '2026-11-22'), 
(7, '2026-10-05', '2026-10-12'), 
(2, '2026-11-16', '2026-11-23'); 

-- 6. PRESTAMO_LIBROS 
INSERT INTO prestamo_libros (id_prestamo, id_libro, fecha_devolucion_real) VALUES
(1, 1, '2026-10-07'), 
(1, 3, '2026-10-08'), 
(2, 2, NULL),         
(3, 4, '2026-10-25'), 
(4, 5, NULL),         
(5, 6, '2026-11-08'), 
(5, 7, NULL),         
(6, 1, NULL),         
(7, 8, '2026-09-16'), 
(8, 3, NULL),         
(9, 2, '2026-10-12'), 
(10, 4, NULL);              

