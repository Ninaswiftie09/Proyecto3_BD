-- Creación de tablas manualmente (aunque se crean en el models.py):
CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE vehiculo (
    id SERIAL PRIMARY KEY,
    marca VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    ano INTEGER NOT NULL CHECK (ano > 0),
    color VARCHAR(50) NOT NULL,
    categoria_id INTEGER NOT NULL REFERENCES categoria(id) ON DELETE CASCADE,
    estado VARCHAR(20) NOT NULL DEFAULT 'Disponible',
    precio_diario NUMERIC(10, 2) NOT NULL,
    imagen_url TEXT
);

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dpi VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(254) UNIQUE,
    direccion TEXT
);

CREATE TABLE empleado (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    correo VARCHAR(254) UNIQUE NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE alquiler (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES cliente(id) ON DELETE CASCADE,
    vehiculo_id INTEGER NOT NULL REFERENCES vehiculo(id) ON DELETE CASCADE,
    empleado_id INTEGER NOT NULL REFERENCES empleado(id) ON DELETE CASCADE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    total NUMERIC(10, 2) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente'
);

CREATE TABLE pago (
    id SERIAL PRIMARY KEY,
    alquiler_id INTEGER NOT NULL REFERENCES alquiler(id) ON DELETE CASCADE,
    fecha_pago DATE NOT NULL,
    monto NUMERIC(10, 2) NOT NULL,
    metodo_pago VARCHAR(20) NOT NULL
);

CREATE TABLE mantenimiento (
    id SERIAL PRIMARY KEY,
    vehiculo_id INTEGER NOT NULL REFERENCES vehiculo(id) ON DELETE CASCADE,
    fecha DATE NOT NULL,
    descripcion TEXT,
    costo NUMERIC(10, 2) NOT NULL,
    tipo VARCHAR(20) NOT NULL
);

CREATE TABLE bitacora (
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(150) NOT NULL,
    accion VARCHAR(100) NOT NULL,
    fecha TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    tabla_afectada VARCHAR(100) NOT NULL,
    detalle TEXT
);

CREATE TABLE accesorio (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE vehiculo_accesorio (
    id SERIAL PRIMARY KEY,
    vehiculo_id INTEGER NOT NULL REFERENCES vehiculo(id) ON DELETE CASCADE,
    accesorio_id INTEGER NOT NULL REFERENCES accesorio(id) ON DELETE CASCADE,
    UNIQUE (vehiculo_id, accesorio_id)
);


-- Inserts para las tablas

-- CATEGORÍAS
INSERT INTO renta_categoria (id, nombre) VALUES
(1, 'SUV'),
(2, 'Sedán'),
(3, 'Crossover');

-- VEHÍCULOS (IDs explícitos)
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES
(1, 'Mazda', 'CX-5', 2017, 'Rojo', 1, 'Disponible', 50.00, 'https://example.com/mazda-cx5.jpg'),
(2, 'Toyota', 'Corolla', 2025, 'Blanco', 2, 'Disponible', 75.00, 'https://example.com/toyota-corolla.jpg'),
(3, 'Kia', 'Stonic', 2025, 'Celeste', 3, 'Disponible', 67.00, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (4, 'Mazda', 'CX-5', 2021, 'Verde', 1, 'Disponible', 56.33, 'https://mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (5, 'Toyota', 'Corolla', 2021, 'Celeste', 2, 'Disponible', 87.48, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (6, 'Ford', 'EcoSport', 2020, 'Azul', 3, 'Disponible', 85.38, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (7, 'Mazda', 'CX-5', 2021, 'Blanco', 1, 'Disponible', 86.05, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (8, 'Honda', 'Civic', 2023, 'Celeste', 2, 'Disponible', 50.23, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (9, 'Toyota', 'Corolla', 2019, 'Azul', 2, 'Disponible', 71.28, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (10, 'Hyundai', 'Tucson', 2024, 'Azul', 1, 'Disponible', 53.9, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (11, 'Hyundai', 'Tucson', 2022, 'Blanco', 1, 'Disponible', 85.62, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (12, 'Toyota', 'Corolla', 2020, 'Rojo', 2, 'Disponible', 75.11, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (13, 'Ford', 'EcoSport', 2022, 'Gris', 3, 'Disponible', 41.95, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (14, 'Honda', 'Civic', 2019, 'Blanco', 2, 'Disponible', 79.93, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (15, 'Ford', 'EcoSport', 2025, 'Blanco', 3, 'Disponible', 50.22, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (16, 'Honda', 'Civic', 2024, 'Blanco', 2, 'Disponible', 60.8, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (17, 'Kia', 'Stonic', 2017, 'Blanco', 3, 'Disponible', 44.12, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (18, 'Hyundai', 'Tucson', 2018, 'Gris', 1, 'Disponible', 64.41, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (19, 'Toyota', 'Corolla', 2022, 'Gris', 2, 'Disponible', 77.53, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (20, 'Kia', 'Stonic', 2025, 'Blanco', 3, 'Disponible', 48.73, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (21, 'Toyota', 'Corolla', 2021, 'Rojo', 2, 'Disponible', 65.72, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (22, 'Honda', 'Civic', 2023, 'Verde', 2, 'Disponible', 49.26, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (23, 'Ford', 'EcoSport', 2017, 'Rojo', 3, 'Disponible', 55.16, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (24, 'Kia', 'Stonic', 2017, 'Celeste', 3, 'Disponible', 63.3, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (25, 'Ford', 'EcoSport', 2022, 'Azul', 3, 'Disponible', 40.01, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (26, 'Mazda', 'CX-5', 2020, 'Verde', 1, 'Disponible', 64.12, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (27, 'Kia', 'Stonic', 2017, 'Verde', 3, 'Disponible', 79.15, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (28, 'Toyota', 'Corolla', 2017, 'Blanco', 2, 'Disponible', 68.64, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (29, 'Mazda', 'CX-5', 2021, 'Negro', 1, 'Disponible', 45.0, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (30, 'Hyundai', 'Tucson', 2020, 'Rojo', 1, 'Disponible', 74.16, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (31, 'Ford', 'EcoSport', 2024, 'Blanco', 3, 'Disponible', 48.51, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (32, 'Mazda', 'CX-5', 2025, 'Rojo', 1, 'Disponible', 51.03, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (33, 'Honda', 'Civic', 2018, 'Rojo', 2, 'Disponible', 86.0, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (34, 'Ford', 'EcoSport', 2023, 'Negro', 3, 'Disponible', 56.72, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (35, 'Mazda', 'CX-5', 2024, 'Rojo', 1, 'Disponible', 71.4, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (36, 'Ford', 'EcoSport', 2022, 'Negro', 3, 'Disponible', 76.22, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (37, 'Mazda', 'CX-5', 2017, 'Blanco', 1, 'Disponible', 79.64, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (38, 'Toyota', 'Corolla', 2023, 'Celeste', 2, 'Disponible', 73.0, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (39, 'Mazda', 'CX-5', 2021, 'Celeste', 1, 'Disponible', 77.75, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (40, 'Toyota', 'Corolla', 2024, 'Celeste', 2, 'Disponible', 66.78, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (41, 'Hyundai', 'Tucson', 2019, 'Blanco', 1, 'Disponible', 89.3, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (42, 'Honda', 'Civic', 2018, 'Negro', 2, 'Disponible', 88.38, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (43, 'Ford', 'EcoSport', 2024, 'Rojo', 3, 'Disponible', 48.01, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (44, 'Hyundai', 'Tucson', 2021, 'Gris', 1, 'Disponible', 58.54, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (45, 'Kia', 'Stonic', 2025, 'Verde', 3, 'Disponible', 89.24, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (46, 'Ford', 'EcoSport', 2021, 'Celeste', 3, 'Disponible', 49.04, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (47, 'Toyota', 'Corolla', 2019, 'Verde', 2, 'Disponible', 81.22, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (48, 'Ford', 'EcoSport', 2019, 'Azul', 3, 'Disponible', 81.92, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (49, 'Mazda', 'CX-5', 2020, 'Gris', 1, 'Disponible', 59.27, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (50, 'Hyundai', 'Tucson', 2021, 'Celeste', 1, 'Disponible', 40.67, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (51, 'Toyota', 'Corolla', 2018, 'Blanco', 2, 'Disponible', 78.76, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (52, 'Toyota', 'Corolla', 2022, 'Negro', 2, 'Disponible', 40.62, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (53, 'Kia', 'Stonic', 2022, 'Blanco', 3, 'Disponible', 67.1, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (54, 'Hyundai', 'Tucson', 2025, 'Negro', 1, 'Disponible', 46.15, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (55, 'Hyundai', 'Tucson', 2022, 'Azul', 1, 'Disponible', 40.41, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (56, 'Mazda', 'CX-5', 2025, 'Azul', 1, 'Disponible', 40.27, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (57, 'Honda', 'Civic', 2025, 'Negro', 2, 'Disponible', 47.0, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (58, 'Hyundai', 'Tucson', 2023, 'Rojo', 1, 'Disponible', 62.92, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (59, 'Mazda', 'CX-5', 2022, 'Negro', 1, 'Disponible', 71.62, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (60, 'Mazda', 'CX-5', 2019, 'Azul', 1, 'Disponible', 89.63, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (61, 'Honda', 'Civic', 2022, 'Negro', 2, 'Disponible', 53.11, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (62, 'Hyundai', 'Tucson', 2023, 'Verde', 1, 'Disponible', 46.3, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (63, 'Ford', 'EcoSport', 2023, 'Gris', 3, 'Disponible', 86.96, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (64, 'Honda', 'Civic', 2019, 'Gris', 2, 'Disponible', 84.55, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (65, 'Hyundai', 'Tucson', 2024, 'Negro', 1, 'Disponible', 83.66, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (66, 'Ford', 'EcoSport', 2024, 'Azul', 3, 'Disponible', 49.41, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (67, 'Hyundai', 'Tucson', 2021, 'Azul', 1, 'Disponible', 80.8, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (68, 'Hyundai', 'Tucson', 2024, 'Gris', 1, 'Disponible', 64.11, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (69, 'Hyundai', 'Tucson', 2020, 'Blanco', 1, 'Disponible', 42.64, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (70, 'Hyundai', 'Tucson', 2025, 'Blanco', 1, 'Disponible', 41.86, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (71, 'Honda', 'Civic', 2021, 'Celeste', 2, 'Disponible', 67.05, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (72, 'Ford', 'EcoSport', 2020, 'Rojo', 3, 'Disponible', 64.92, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (73, 'Mazda', 'CX-5', 2018, 'Rojo', 1, 'Disponible', 48.48, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (74, 'Ford', 'EcoSport', 2023, 'Blanco', 3, 'Disponible', 83.85, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (75, 'Toyota', 'Corolla', 2020, 'Celeste', 2, 'Disponible', 86.8, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (76, 'Kia', 'Stonic', 2020, 'Verde', 3, 'Disponible', 40.03, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (77, 'Hyundai', 'Tucson', 2018, 'Rojo', 1, 'Disponible', 79.53, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (78, 'Ford', 'EcoSport', 2020, 'Negro', 3, 'Disponible', 80.17, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (79, 'Mazda', 'CX-5', 2018, 'Blanco', 1, 'Disponible', 47.57, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (80, 'Ford', 'EcoSport', 2019, 'Gris', 3, 'Disponible', 46.17, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (81, 'Kia', 'Stonic', 2024, 'Azul', 3, 'Disponible', 84.57, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (82, 'Toyota', 'Corolla', 2018, 'Gris', 2, 'Disponible', 60.87, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (83, 'Kia', 'Stonic', 2024, 'Negro', 3, 'Disponible', 43.58, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (84, 'Mazda', 'CX-5', 2021, 'Gris', 1, 'Disponible', 47.05, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (85, 'Kia', 'Stonic', 2019, 'Verde', 3, 'Disponible', 62.24, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (86, 'Kia', 'Stonic', 2023, 'Rojo', 3, 'Disponible', 71.64, 'https://example.com/kia-stonic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (87, 'Hyundai', 'Tucson', 2020, 'Gris', 1, 'Disponible', 42.08, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (88, 'Ford', 'EcoSport', 2022, 'Verde', 3, 'Disponible', 52.82, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (89, 'Mazda', 'CX-5', 2019, 'Verde', 1, 'Disponible', 86.02, 'https://example.com/mazda-cx-5.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (90, 'Hyundai', 'Tucson', 2021, 'Rojo', 1, 'Disponible', 70.12, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (91, 'Toyota', 'Corolla', 2021, 'Gris', 2, 'Disponible', 69.28, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (92, 'Toyota', 'Corolla', 2019, 'Celeste', 2, 'Disponible', 53.91, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (93, 'Hyundai', 'Tucson', 2024, 'Rojo', 1, 'Disponible', 75.77, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (94, 'Toyota', 'Corolla', 2024, 'Azul', 2, 'Disponible', 59.15, 'https://example.com/toyota-corolla.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (95, 'Honda', 'Civic', 2020, 'Rojo', 2, 'Disponible', 60.53, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (96, 'Ford', 'EcoSport', 2022, 'Celeste', 3, 'Disponible', 77.01, 'https://example.com/ford-ecosport.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (97, 'Hyundai', 'Tucson', 2021, 'Blanco', 1, 'Disponible', 80.79, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (98, 'Honda', 'Civic', 2025, 'Rojo', 2, 'Disponible', 47.87, 'https://example.com/honda-civic.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (99, 'Hyundai', 'Tucson', 2017, 'Gris', 1, 'Disponible', 51.61, 'https://example.com/hyundai-tucson.jpg');
INSERT INTO renta_vehiculo (id, marca, modelo, ano, color, categoria_id, estado, precio_diario, imagen_url) VALUES (100, 'Kia', 'Stonic', 2024, 'Blanco', 3, 'Disponible', 53.2, 'https://example.com/kia-stonic.jpg');


-- CLIENTES
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES
(1, 'Carlos', 'Méndez', '1234567890101', '5555-1111', 'carlos@gmail.com', 'Zona 1'),
(2, 'Ana', 'Ramírez', '9876543210101', '5555-2222', 'ana@hotmail.com', 'Zona 10');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (3, 'Carlos', 'García', '2942601170260', '5555-6790', 'carlos.garcía@hotmail.com', 'Zona 7');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (4, 'Luis', 'Rodríguez', '6689964181557', '5555-4331', 'luis.rodríguez@empresa.com', 'Zona 16');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (5, 'Luis', 'Ramírez', '3763279247931', '5555-2795', 'luis.ramírez@empresa.com', 'Zona 4');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (6, 'José', 'Martínez', '5874970098585', '5555-2737', 'josé.martínez@hotmail.com', 'Zona 15');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (7, 'Ana', 'Gómez', '0615597992577', '5555-9649', 'ana.gómez@empresa.com', 'Zona 19');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (8, 'Pedro', 'Sosa', '1365747238343', '5555-1985', 'pedro.sosa@empresa.com', 'Zona 8');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (9, 'José', 'García', '5724723804531', '5555-7748', 'josé.garcía@hotmail.com', 'Zona 8');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (10, 'Sofía', 'Rodríguez', '3856366064100', '5555-7752', 'sofía.rodríguez@hotmail.com', 'Zona 8');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (11, 'Lucía', 'García', '5609386153037', '5555-3144', 'lucía.garcía@empresa.com', 'Zona 2');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (12, 'José', 'Pérez', '6395743941592', '5555-5479', 'josé.pérez@gmail.com', 'Zona 17');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (13, 'Pedro', 'Pérez', '9537945258112', '5555-4559', 'pedro.pérez@empresa.com', 'Zona 18');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (14, 'Pedro', 'Pérez', '8335052790451', '5555-2076', 'pedro.pérez@yahoo.com', 'Zona 8');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (15, 'Jorge', 'Gómez', '0049882809894', '5555-2184', 'jorge.gómez@gmail.com', 'Zona 12');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (16, 'Carlos', 'Pérez', '2047008172043', '5555-2147', 'carlos.pérez@hotmail.com', 'Zona 13');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (17, 'Sofía', 'Pérez', '8992204814498', '5555-7059', 'sofía.pérez@empresa.com', 'Zona 11');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (18, 'Sofía', 'Torres', '1213256837351', '5555-4189', 'sofía.torres@gmail.com', 'Zona 3');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (19, 'Ana', 'Méndez', '0839134492111', '5555-5735', 'ana.méndez@empresa.com', 'Zona 10');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (20, 'Paula', 'Pérez', '8815741207865', '5555-6256', 'paula.pérez@hotmail.com', 'Zona 6');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (21, 'Paula', 'García', '1557528719339', '5555-1605', 'paula.garcía@empresa.com', 'Zona 19');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (22, 'José', 'López', '4941717108358', '5555-7888', 'josé.lópez@empresa.com', 'Zona 8');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (23, 'Luis', 'Gómez', '5471876914525', '5555-2183', 'luis.gómez@empresa.com', 'Zona 18');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (24, 'Carlos', 'Méndez', '7779175206724', '5555-9914', 'carlos.méndez@empresa.com', 'Zona 7');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (25, 'Paula', 'Méndez', '1095464462934', '5555-2867', 'paula.méndez@yahoo.com', 'Zona 5');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (26, 'José', 'Gómez', '1184125125092', '5555-2006', 'josé.gómez@gmail.com', 'Zona 13');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (27, 'Pedro', 'Gómez', '9601080355366', '5555-7394', 'pedro.gómez@hotmail.com', 'Zona 13');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (28, 'Lucía', 'Ramírez', '1768035776806', '5555-3026', 'lucía.ramírez@gmail.com', 'Zona 18');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (29, 'Lucía', 'Sosa', '8235129254950', '5555-7923', 'lucía.sosa@empresa.com', 'Zona 14');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (30, 'Paula', 'López', '2231922013390', '5555-7903', 'paula.lópez@empresa.com', 'Zona 2');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (31, 'Luis', 'García', '9173201257893', '5555-6575', 'luis.garcía@empresa.com', 'Zona 3');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (32, 'Jorge', 'Pérez', '9322551464676', '5555-6277', 'jorge.pérez@yahoo.com', 'Zona 7');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (33, 'Paula', 'Pérez', '0034135494221', '5555-1374', 'paula.pérez@yahoo.com', 'Zona 14');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (34, 'Pedro', 'Méndez', '2177752702784', '5555-2608', 'pedro.méndez@empresa.com', 'Zona 12');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (35, 'Lucía', 'Rodríguez', '7441510037055', '5555-3172', 'lucía.rodríguez@hotmail.com', 'Zona 18');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (36, 'Sofía', 'Torres', '6590473717282', '5555-7710', 'sofía.torres@yahoo.com', 'Zona 20');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (37, 'José', 'Pérez', '7493106143701', '5555-5470', 'josé.pérez@yahoo.com', 'Zona 18');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (38, 'Jorge', 'Rodríguez', '5364682512865', '5555-6234', 'jorge.rodríguez@empresa.com', 'Zona 7');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (39, 'Luis', 'García', '9808622007680', '5555-6231', 'luis.garcía@yahoo.com', 'Zona 14');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (40, 'Lucía', 'Pérez', '0250153811208', '5555-2318', 'lucía.pérez@hotmail.com', 'Zona 4');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (41, 'Carlos', 'Méndez', '9390688786249', '5555-2200', 'carlos.méndez@gmail.com', 'Zona 6');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (42, 'Jorge', 'Gómez', '1465113395684', '5555-6567', 'jorge.gómez@yahoo.com', 'Zona 15');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (43, 'José', 'Rodríguez', '0123158410179', '5555-9557', 'josé.rodríguez@hotmail.com', 'Zona 6');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (44, 'Ana', 'Sosa', '5130550248161', '5555-8931', 'ana.sosa@hotmail.com', 'Zona 12');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (45, 'Ana', 'García', '8934613330539', '5555-4762', 'ana.garcía@empresa.com', 'Zona 15');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (46, 'Jorge', 'Torres', '9159370832796', '5555-1463', 'jorge.torres@empresa.com', 'Zona 4');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (47, 'José', 'López', '3848225432037', '5555-9852', 'josé.lópez@gmail.com', 'Zona 5');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (48, 'Ana', 'Martínez', '3315977113543', '5555-7906', 'ana.martínez@gmail.com', 'Zona 12');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (49, 'Pedro', 'Rodríguez', '2143351929737', '5555-1649', 'pedro.rodríguez@gmail.com', 'Zona 5');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (50, 'Paula', 'Pérez', '3672396973470', '5555-2909', 'paula.pérez@empresa.com', 'Zona 1');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (51, 'Lucía', 'Torres', '3895263670403', '5555-3706', 'lucía.torres@empresa.com', 'Zona 3');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (52, 'José', 'Rodríguez', '1835501316880', '5555-1560', 'josé.rodríguez@yahoo.com', 'Zona 15');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (53, 'José', 'García', '2791215802699', '5555-1951', 'josé.garcía@yahoo.com', 'Zona 15');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (54, 'Pedro', 'Rodríguez', '1279112881745', '5555-3577', 'pedro.rodríguez@empresa.com', 'Zona 13');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (55, 'Pedro', 'Ramírez', '5575523129577', '5555-1377', 'pedro.ramírez@gmail.com', 'Zona 17');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (56, 'Lucía', 'Ramírez', '6467287789619', '5555-4429', 'lucía.ramírez@yahoo.com', 'Zona 13');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (57, 'Pedro', 'Martínez', '4632721666377', '5555-3476', 'pedro.martínez@gmail.com', 'Zona 4');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (58, 'Jorge', 'Sosa', '5835020810738', '5555-5146', 'jorge.sosa@gmail.com', 'Zona 16');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (59, 'Lucía', 'Pérez', '7944948500528', '5555-1116', 'lucía.pérez@gmail.com', 'Zona 1');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (60, 'Jorge', 'García', '6093250867766', '5555-4416', 'jorge.garcía@empresa.com', 'Zona 10');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (61, 'José', 'Pérez', '1071267867834', '5555-4332', 'josé.pérez@hotmail.com', 'Zona 15');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (62, 'Sofía', 'Méndez', '1426121833431', '5555-8742', 'sofía.méndez@empresa.com', 'Zona 20');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (63, 'Pedro', 'Méndez', '8570922114172', '5555-3848', 'pedro.méndez@yahoo.com', 'Zona 18');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (64, 'José', 'Torres', '0850428518522', '5555-3022', 'josé.torres@yahoo.com', 'Zona 6');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (65, 'Paula', 'Sosa', '5977427046229', '5555-2460', 'paula.sosa@empresa.com', 'Zona 20');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (66, 'Ana', 'Ramírez', '5105513839340', '5555-4740', 'ana.ramírez@hotmail.com', 'Zona 11');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (67, 'María', 'Pérez', '1620543486877', '5555-9119', 'maría.pérez@gmail.com', 'Zona 15');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (68, 'José', 'Torres', '3481807355103', '5555-9856', 'josé.torres@empresa.com', 'Zona 6');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (69, 'María', 'Gómez', '4847579204853', '5555-3833', 'maría.gómez@yahoo.com', 'Zona 19');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (70, 'Lucía', 'García', '7783153079777', '5555-9096', 'lucía.garcía@gmail.com', 'Zona 6');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (71, 'Pedro', 'García', '7588838401231', '5555-3798', 'pedro.garcía@hotmail.com', 'Zona 13');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (72, 'José', 'García', '2253704960894', '5555-2419', 'josé.garcía@empresa.com', 'Zona 3');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (73, 'Pedro', 'Gómez', '1748008615574', '5555-9122', 'pedro.gómez@gmail.com', 'Zona 8');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (74, 'Lucía', 'Ramírez', '3400898878861', '5555-7842', 'lucía.ramírez@empresa.com', 'Zona 12');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (75, 'Luis', 'Pérez', '6907354853001', '5555-8576', 'luis.pérez@hotmail.com', 'Zona 2');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (76, 'Jorge', 'Gómez', '2877177453105', '5555-4771', 'jorge.gómez@hotmail.com', 'Zona 2');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (77, 'María', 'Méndez', '4701276581553', '5555-6676', 'maría.méndez@yahoo.com', 'Zona 9');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (78, 'Carlos', 'Méndez', '1037876107988', '5555-5104', 'carlos.méndez@yahoo.com', 'Zona 8');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (79, 'Sofía', 'Pérez', '4653863308511', '5555-7368', 'sofía.pérez@yahoo.com', 'Zona 18');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (80, 'Luis', 'López', '4973945328042', '5555-1375', 'luis.lópez@yahoo.com', 'Zona 20');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (81, 'María', 'Torres', '3661281307413', '5555-9633', 'maría.torres@gmail.com', 'Zona 12');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (82, 'Lucía', 'Martínez', '9572010753523', '5555-9468', 'lucía.martínez@empresa.com', 'Zona 14');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (83, 'Sofía', 'López', '5231635768863', '5555-3709', 'sofía.lópez@yahoo.com', 'Zona 6');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (84, 'Ana', 'Rodríguez', '1989174478342', '5555-6962', 'ana.rodríguez@empresa.com', 'Zona 19');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (85, 'Carlos', 'Gómez', '4568796884316', '5555-1044', 'carlos.gómez@hotmail.com', 'Zona 16');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (86, 'Carlos', 'Torres', '9701146159497', '5555-1659', 'carlos.torres@empresa.com', 'Zona 6');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (87, 'Ana', 'Pérez', '1680214927180', '5555-8174', 'ana.pérez@yahoo.com', 'Zona 6');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (88, 'Paula', 'Gómez', '0186957390251', '5555-6220', 'paula.gómez@yahoo.com', 'Zona 8');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (89, 'Jorge', 'Martínez', '0547520459969', '5555-4716', 'jorge.martínez@empresa.com', 'Zona 9');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (90, 'Carlos', 'Martínez', '1724864396313', '5555-7699', 'carlos.martínez@gmail.com', 'Zona 8');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (91, 'Sofía', 'López', '2312676461850', '5555-1576', 'sofía.lópez@empresa.com', 'Zona 3');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (92, 'Paula', 'Méndez', '4801042415695', '5555-2343', 'paula.méndez@gmail.com', 'Zona 1');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (93, 'Luis', 'Rodríguez', '0794128125477', '5555-7984', 'luis.rodríguez@yahoo.com', 'Zona 14');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (94, 'José', 'Pérez', '2727558920015', '5555-4367', 'josé.pérez@empresa.com', 'Zona 16');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (95, 'Ana', 'Sosa', '1135303639902', '5555-2243', 'ana.sosa@yahoo.com', 'Zona 11');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (96, 'Jorge', 'Martínez', '6807864884390', '5555-4987', 'jorge.martínez@yahoo.com', 'Zona 20');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (97, 'Paula', 'García', '8661535267628', '5555-8424', 'paula.garcía@hotmail.com', 'Zona 10');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (98, 'Lucía', 'López', '4333517938510', '5555-2984', 'lucía.lópez@yahoo.com', 'Zona 1');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (99, 'Sofía', 'Gómez', '2863884271845', '5555-3648', 'sofía.gómez@hotmail.com', 'Zona 4');
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES (100, 'Lucía', 'Méndez', '0672250414017', '5555-1120', 'lucía.méndez@hotmail.com', 'Zona 3');

-- EMPLEADOS
INSERT INTO renta_empleado (id, nombre, apellido, cargo, correo, telefono) VALUES
(1, 'Luis', 'Sosa', 'Administrador', 'luis@empresa.com', '5555-3333'),
(2, 'María', 'Torres', 'Empleado', 'maria@empresa.com', '5555-4444');

-- ALQUILERES
INSERT INTO renta_alquiler (id, cliente_id, vehiculo_id, empleado_id, fecha_inicio, fecha_fin, total, estado) VALUES
(1, 1, 1, 1, '2025-05-01', '2025-05-05', 200.00, 'Pagado'),
(2, 2, 2, 2, '2025-05-03', '2025-05-06', 165.00, 'Pendiente');

-- PAGOS
INSERT INTO renta_pago (id, alquiler_id, fecha_pago, monto, metodo_pago) VALUES
(1, 1, '2025-05-01', 200.00, 'Tarjeta'),
(2, 2, '2025-05-03', 100.00, 'Efectivo');

-- MANTENIMIENTOS
INSERT INTO renta_mantenimiento (id, vehiculo_id, fecha, descripcion, costo, tipo) VALUES
(1, 1, '2025-04-20', 'Cambio de aceite', 50.00, 'Preventivo'),
(2, 2, '2025-04-25', 'Revisión de frenos', 120.00, 'Correctivo');

-- BITÁCORA (con fecha explícita)
INSERT INTO renta_bitacora (id, usuario, accion, fecha, tabla_afectada, detalle) VALUES
(1, 'luis@empresa.com', 'INSERT', '2025-05-01 10:00:00', 'vehiculo', 'Se agregó Corolla 2025'),
(2, 'maria@empresa.com', 'UPDATE', '2025-05-02 14:30:00', 'cliente', 'Se actualizó dirección de Ana Ramírez');

-- ACCESORIOS
INSERT INTO renta_accesorio (id, nombre) VALUES
(1, 'GPS'),
(2, 'Silla bebé'),
(3, 'Bluetooth');

-- VEHÍCULO - ACCESORIOS
INSERT INTO renta_vehiculoaccesorio (vehiculo_id, accesorio_id) VALUES
(1, 1),  -- Mazda CX-5 con GPS
(1, 3),  -- Mazda CX-5 con Bluetooth
(2, 2),  -- Corolla con silla bebé
(3, 1);  -- Stonic con GPS