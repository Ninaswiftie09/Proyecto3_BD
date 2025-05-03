-- CREACIÓN DE LAS TABLAS
-- TABLA1: categorias (SUV, Sedán, Crossover)
CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE
);

-- TABLA2: vehiculos
CREATE TABLE vehiculos (
    id SERIAL PRIMARY KEY,
    marca TEXT NOT NULL,
    modelo TEXT NOT NULL,
    ano INTEGER NOT NULL CHECK (ano >= 1990),
    color TEXT NOT NULL,
    categoria_id INTEGER REFERENCES categorias(id),
    estado TEXT NOT NULL DEFAULT 'Disponible' CHECK (estado IN ('Disponible', 'Rentado', 'Mantenimiento')),
    precio_diario NUMERIC(10,2) NOT NULL CHECK (precio_diario > 0),
    imagen_url TEXT
);

-- TABLA3: clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    dpi TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    correo TEXT UNIQUE,
    direccion TEXT
);

-- TABLA4: empleados
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    cargo TEXT NOT NULL,
    correo TEXT UNIQUE,
    telefono TEXT
);

-- TABLA5: alquileres
CREATE TABLE alquileres (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(id),
    vehiculo_id INTEGER REFERENCES vehiculos(id),
    empleado_id INTEGER REFERENCES empleados(id),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    total NUMERIC(10,2),
    estado TEXT DEFAULT 'Pendiente' CHECK (estado IN ('Pendiente', 'Pagado', 'Cancelado'))
);

-- TABLA6: pagos
CREATE TABLE pagos (
    id SERIAL PRIMARY KEY,
    alquiler_id INTEGER REFERENCES alquileres(id),
    fecha_pago DATE NOT NULL,
    monto NUMERIC(10,2) NOT NULL CHECK (monto > 0),
    metodo_pago TEXT NOT NULL CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia'))
);

-- TABLA7: mantenimientos
CREATE TABLE mantenimientos (
    id SERIAL PRIMARY KEY,
    vehiculo_id INTEGER REFERENCES vehiculos(id),
    fecha DATE NOT NULL,
    descripcion TEXT,
    costo NUMERIC(10,2),
    tipo TEXT CHECK (tipo IN ('Preventivo', 'Correctivo'))
);

-- TABLA8: bitacora
CREATE TABLE bitacora (
    id SERIAL PRIMARY KEY,
    usuario TEXT NOT NULL,
    accion TEXT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tabla_afectada TEXT,
    detalle TEXT
);

-- TABLA9: accesorios (GPS, Silla bebé, Bluetooth)
CREATE TABLE accesorios (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE
);

-- TABLA10: vehiculo_accesorios (cruce)
CREATE TABLE vehiculo_accesorios (
    vehiculo_id INTEGER REFERENCES vehiculos(id),
    accesorio_id INTEGER REFERENCES accesorios(id),
    PRIMARY KEY (vehiculo_id, accesorio_id)
);

-- INSERTS A LAS TABLAS
-- Categorías
INSERT INTO categorias (nombre) VALUES
('SUV'), ('Sedán'), ('Crossover');

-- Vehículos
INSERT INTO vehiculos (marca, modelo, ano, color, categoria_id, precio_diario, imagen_url) VALUES
-- MAZDA
('Mazda', 'CX-5', 2017, 'Rojo', 1, 50.00, 'https://hips.hearstapps.com/es.h-cdn.co/cades/contenidos/46315/all-newcx-5_2citaly2017_2caction_18.jpg'),
('Mazda', 'CX-9', 2018, 'Negro', 1, 60.00, 'https://s0.smartresize.com/wallpaper/658/517/HD-wallpaper-mazda-cx-9-2018-cars-crossovers-black-cx-9-japanese-cars-mazda.jpg'),
('Mazda', 'CX-5', 2020, 'Negro', 1, 65.00, 'https://hips.hearstapps.com/hmg-prod/images/mazda-cx5-my2020-11-1592826225.jpg'),

-- TOYOTA
('Toyota', 'Yaris Cross', 2024, 'Gris', 3, 70.00, 'https://www.toyota.com.gt/hubfs/yaris-cross-colores-plateado.jpg'),
('Toyota', 'RAV4', 2016, 'Rojo', 1, 55.00, 'https://www.visionautomotriz.com.mx/wp-content/uploads/fly-images/4218/toyota-rav4-precios-mexico-1100x690-c.jpg'),
('Toyota', 'Corolla', 2025, 'Blanco', 2, 75.00, 'https://images.dealer.com/ddc/vehicles/2025/Toyota/Corolla/Sedan/trim_SE_284942/color/Ice%20Cap-040-251%2C250%2C248-640-en_US.jpg'),

-- KIA
('Kia', 'Sorento', 2024, 'Negro', 1, 68.00, 'https://i.ytimg.com/vi/XGK5hC-qWbc/hq720.jpg'),
('Kia', 'Sportage', 2023, 'Blanco', 1, 62.00, 'https://di-uploads-pod20.dealerinspire.com/southernlynnhavenkia/uploads/2021/07/2022-kia-sportage-front-quarter.jpg'),
('Kia', 'Stonic', 2025, 'Celeste', 3, 67.00, 'https://www.kia.com/content/dam/kwcms/kme/global/en/assets/vehicles/stonic/my24/discover/kia-stonic-my24-action-panel.jpg');

-- Clientes
INSERT INTO clientes (nombre, apellido, dpi, telefono, correo, direccion) VALUES
('Carlos', 'Méndez', '1234567890101', '5555-1111', 'carlos@gmail.com', 'Zona 1'),
('Ana', 'Ramírez', '9876543210101', '5555-2222', 'ana@hotmail.com', 'Zona 10');

-- Empleados
INSERT INTO empleados (nombre, apellido, cargo, correo, telefono) VALUES
('Luis', 'Sosa', 'Administrador', 'luis@empresa.com', '5555-3333'),
('María', 'Torres', 'Empleado', 'maria@empresa.com', '5555-4444');

-- Alquileres
INSERT INTO alquileres (cliente_id, vehiculo_id, empleado_id, fecha_inicio, fecha_fin, total, estado) VALUES
(1, 1, 1, '2025-05-01', '2025-05-05', 200.00, 'Pagado'),
(2, 5, 2, '2025-05-03', '2025-05-06', 165.00, 'Pendiente');

-- Pagos
INSERT INTO pagos (alquiler_id, fecha_pago, monto, metodo_pago) VALUES
(1, '2025-05-01', 200.00, 'Tarjeta'),
(2, '2025-05-03', 100.00, 'Efectivo');

-- Mantenimientos 
INSERT INTO mantenimientos (vehiculo_id, fecha, descripcion, costo, tipo) VALUES
(3, '2025-04-20', 'Cambio de aceite', 50.00, 'Preventivo'),
(4, '2025-04-25', 'Revisión de frenos', 120.00, 'Correctivo');


-- Bitácora 
INSERT INTO bitacora (usuario, accion, tabla_afectada, detalle) VALUES
('luis@empresa.com', 'INSERT', 'vehiculos', 'Se agregó Toyota Corolla 2025'),
('maria@empresa.com', 'UPDATE', 'clientes', 'Se actualizó dirección de Ana Ramírez');

-- Accesorios 
INSERT INTO accesorios (nombre) VALUES
('GPS'),
('Silla bebé'),
('Bluetooth');

-- Vehículos accesorios 
INSERT INTO vehiculo_accesorios (vehiculo_id, accesorio_id) VALUES
(1, 1),  -- CX-5 con GPS
(1, 3),  -- CX-5 con Bluetooth
(2, 2),  -- CX-9 con silla bebé
(4, 1),  -- Yaris Cross con GPS
(6, 3);  -- Corolla con Bluetooth

select * from vehiculos;