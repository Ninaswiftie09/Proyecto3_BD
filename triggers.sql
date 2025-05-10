-- 1. Trigger: Log en bitácora al crear un alquiler
CREATE OR REPLACE FUNCTION log_alquiler_insert()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO renta_bitacora(usuario, accion, fecha, tabla_afectada, detalle)
  VALUES ('sistema', 'INSERT', NOW(), 'renta_alquiler', 'Se creó un nuevo alquiler ID=' || NEW.id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_alquiler_insert
AFTER INSERT ON renta_alquiler
FOR EACH ROW EXECUTE FUNCTION log_alquiler_insert();

-- 2. Trigger: Log en bitácora al registrar un pago
CREATE OR REPLACE FUNCTION log_pago_insert()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO renta_bitacora(usuario, accion, fecha, tabla_afectada, detalle)
  VALUES ('sistema', 'INSERT', NOW(), 'renta_pago', 'Se registró un pago de Q' || NEW.monto || ' al alquiler ID=' || NEW.alquiler_id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_pago_insert
AFTER INSERT ON renta_pago
FOR EACH ROW EXECUTE FUNCTION log_pago_insert();

-- 3. Trigger: Cambiar estado del vehículo a 'Rentado' al crear alquiler
CREATE OR REPLACE FUNCTION actualizar_estado_vehiculo()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE renta_vehiculo
  SET estado = 'Rentado'
  WHERE id = NEW.vehiculo_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_estado_vehiculo_rentado
AFTER INSERT ON renta_alquiler
FOR EACH ROW EXECUTE FUNCTION actualizar_estado_vehiculo();

-- 4. Trigger: Cambiar estado a 'Disponible' si se elimina un alquiler
CREATE OR REPLACE FUNCTION devolver_vehiculo()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE renta_vehiculo
  SET estado = 'Disponible'
  WHERE id = OLD.vehiculo_id;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_estado_vehiculo_disponible
AFTER DELETE ON renta_alquiler
FOR EACH ROW EXECUTE FUNCTION devolver_vehiculo();

-- 5. Trigger: Evitar alquilar un vehículo que ya está rentado
CREATE OR REPLACE FUNCTION prevenir_doble_renta()
RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM renta_vehiculo
    WHERE id = NEW.vehiculo_id AND estado != 'Disponible'
  ) THEN
    RAISE EXCEPTION 'Este vehículo no está disponible para renta.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevenir_doble_renta
BEFORE INSERT ON renta_alquiler
FOR EACH ROW EXECUTE FUNCTION prevenir_doble_renta();
