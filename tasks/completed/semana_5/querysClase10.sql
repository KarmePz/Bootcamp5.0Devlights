/*## 🧱 Tablas a crear

### 1️⃣ Uno a Uno (1:1)

**Escenario:** cada **conductor** tiene un solo **vehículo** asignado, y cada vehículo está asignado a un solo conductor.

- **`conductores`:** `id` (PK), `nombre`, `licencia`, `fecha_ingreso`
- **`vehiculos`:** `id` (PK), `patente`, `modelo`, `conductor_id` (FK **única**, referencia `conductores.id`)*/
CREATE TABLE conductores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    licencia VARCHAR(50) UNIQUE NOT NULL,
    fecha_ingreso DATE NOT NULL
);
CREATE TABLE vehiculos (
    id SERIAL PRIMARY KEY,
    patente VARCHAR(20) UNIQUE NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    conductor_id INT UNIQUE REFERENCES conductores(id)
);


/*### 2️⃣ Uno a Muchos (1:N)

**Escenario:** un **profesor** puede dictar muchas **clases**, pero cada clase pertenece a un solo profesor.

- **`profesores`:** `id` (PK), `nombre`, `especialidad`, `fecha_contratacion`
- **`clases`:** `id` (PK), `nombre`, `horario`, `profesor_id` (FK **no nula**, referencia `profesores.id`)*/
CREATE TABLE profesores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL
);
CREATE TABLE clases (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    horario TIME NOT NULL,
    profesor_id INT NOT NULL REFERENCES profesores(id)
); 

/*### 3️⃣ Muchos a Muchos (N:N)

**Escenario:** un **paciente** puede tener varias **enfermedades**, y una enfermedad puede afectar a muchos pacientes.

- **`pacientes`:** `id` (PK), `nombre`, `fecha_nacimiento`, `telefono`
- **`enfermedades`:** `id` (PK), `nombre`, `descripcion`, `nivel_gravedad`
- **`pacientes_enfermedades`:** `paciente_id` (FK), `enfermedad_id` (FK), `fecha_diagnostico`
- Clave primaria compuesta `(paciente_id, enfermedad_id)` para evitar duplicados.



1. Escribir los `CREATE TABLE` de las 7 tablas con sus `PRIMARY KEY` y `REFERENCES`, con un comentario (`--`) arriba de cada par explicando la relación.
2. Agregar al menos estas constraints:
    - `NOT NULL` en los nombres.
    - `UNIQUE` en `licencia` y `patente`.
    - `CHECK` en `nivel_gravedad` para que solo acepte `'leve'`, `'moderada'` o `'grave'`.
3. Generar el **DER** en pgAdmin (clic derecho sobre `relaciones_db` → **ERD For Database**) y verificar que se vean las tres relaciones.
4. Insertar 2–3 filas en cada tabla.
5. Probar que las constraints funcionan: intentar asignar **dos vehículos al mismo conductor** y anotar el error que devuelve Postgres.
---*/
CREATE TABLE pacientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    telefono VARCHAR(20)
);
CREATE TABLE enfermedades (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    nivel_gravedad VARCHAR(20) NOT NULL CHECK (nivel_gravedad IN ('leve', 'moderada', 'grave')) 
);
CREATE TABLE pacientes_enfermedades (
    paciente_id INT REFERENCES pacientes(id),
    enfermedad_id INT REFERENCES enfermedades(id),
    fecha_diagnostico DATE NOT NULL,
    PRIMARY KEY (paciente_id, enfermedad_id)
);


INSERT INTO conductores (nombre, licencia, fecha_ingreso) VALUES
('Juan Pérez', 'ABC123', '2020-01-15'),
('María López', 'XYZ789', '2019-06-20');
INSERT INTO vehiculos (patente, modelo, conductor_id) VALUES
('ABC-123', 'Toyota Corolla', 1),
('XYZ-789', 'Honda Civic', 2);
INSERT INTO profesores (nombre, especialidad, fecha_contratacion) VALUES
('Dr. Carlos Gómez', 'Matemáticas', '2018-03-10'),
('Dra. Ana Torres', 'Física', '2019-09-05');
INSERT INTO clases (nombre, horario, profesor_id) VALUES
('Cálculo I', '08:00:00', 1),
('Física II', '10:00:00', 2);
INSERT INTO pacientes (nombre, fecha_nacimiento, telefono) VALUES
('Pedro Martínez', '1985-04-12', '555-1234'),
('Lucía Fernández', '1990-11-30', '555-5678');
INSERT INTO enfermedades (nombre, descripcion, nivel_gravedad) VALUES
('Gripe', 'Infección viral común', 'leve'),
('Diabetes', 'Enfermedad crónica que afecta la forma en que el cuerpo procesa la glucosa', 'moderada');
INSERT INTO pacientes_enfermedades (paciente_id, enfermedad_id, fecha_diagnostico) VALUES
(1, 1, '2023-01-15'),
(2, 2, '2022-12-20');


Insert into vehiculos (patente, modelo, conductor_id) VALUES ('DEF-456', 'Ford Focus', 1);
/*Error conseguido : ERROR:  duplicate key value violates unique constraint "vehiculos_conductor_id_key"
Key (conductor_id)=(1) already exists. 

SQL state: 23505
Detail: Key (conductor_id)=(1) already exists.*/