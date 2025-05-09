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

-- CLIENTES
INSERT INTO renta_cliente (id, nombre, apellido, dpi, telefono, correo, direccion) VALUES
(1, 'Carlos', 'Méndez', '1234567890101', '5555-1111', 'carlos@gmail.com', 'Zona 1'),
(2, 'Ana', 'Ramírez', '9876543210101', '5555-2222', 'ana@hotmail.com', 'Zona 10');

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
