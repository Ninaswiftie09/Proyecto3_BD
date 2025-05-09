from django.db import models

class Categoria(models.Model):
    nombre = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.nombre

class Vehiculo(models.Model):
    ESTADO_CHOICES = [
        ('Disponible', 'Disponible'),
        ('Rentado', 'Rentado'),
        ('Mantenimiento', 'Mantenimiento'),
    ]
    marca = models.CharField(max_length=100)
    modelo = models.CharField(max_length=100)
    ano = models.PositiveIntegerField()
    color = models.CharField(max_length=50)
    categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE)
    estado = models.CharField(max_length=20, choices=ESTADO_CHOICES, default='Disponible')
    precio_diario = models.DecimalField(max_digits=10, decimal_places=2)
    imagen_url = models.URLField(blank=True)

    def __str__(self):
        return f"{self.marca} {self.modelo} ({self.ano})"

class Cliente(models.Model):
    nombre = models.CharField(max_length=100)
    apellido = models.CharField(max_length=100)
    dpi = models.CharField(max_length=20, unique=True)
    telefono = models.CharField(max_length=20)
    correo = models.EmailField(unique=True, null=True, blank=True)
    direccion = models.TextField(blank=True)

    def __str__(self):
        return f"{self.nombre} {self.apellido}"

class Empleado(models.Model):
    nombre = models.CharField(max_length=100)
    apellido = models.CharField(max_length=100)
    cargo = models.CharField(max_length=100)
    correo = models.EmailField(unique=True)
    telefono = models.CharField(max_length=20)

    def __str__(self):
        return f"{self.nombre} {self.apellido} ({self.cargo})"

class Alquiler(models.Model):
    ESTADO_CHOICES = [
        ('Pendiente', 'Pendiente'),
        ('Pagado', 'Pagado'),
        ('Cancelado', 'Cancelado'),
    ]
    cliente = models.ForeignKey(Cliente, on_delete=models.CASCADE)
    vehiculo = models.ForeignKey(Vehiculo, on_delete=models.CASCADE)
    empleado = models.ForeignKey(Empleado, on_delete=models.CASCADE)
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField()
    total = models.DecimalField(max_digits=10, decimal_places=2)
    estado = models.CharField(max_length=20, choices=ESTADO_CHOICES, default='Pendiente')

    def __str__(self):
        return f"Alquiler #{self.id} - {self.cliente}"

class Pago(models.Model):
    METODO_CHOICES = [
        ('Efectivo', 'Efectivo'),
        ('Tarjeta', 'Tarjeta'),
        ('Transferencia', 'Transferencia'),
    ]
    alquiler = models.ForeignKey(Alquiler, on_delete=models.CASCADE)
    fecha_pago = models.DateField()
    monto = models.DecimalField(max_digits=10, decimal_places=2)
    metodo_pago = models.CharField(max_length=20, choices=METODO_CHOICES)

    def __str__(self):
        return f"Pago #{self.id} - {self.metodo_pago}"

class Mantenimiento(models.Model):
    TIPO_CHOICES = [
        ('Preventivo', 'Preventivo'),
        ('Correctivo', 'Correctivo'),
    ]
    vehiculo = models.ForeignKey(Vehiculo, on_delete=models.CASCADE)
    fecha = models.DateField()
    descripcion = models.TextField(blank=True)
    costo = models.DecimalField(max_digits=10, decimal_places=2)
    tipo = models.CharField(max_length=20, choices=TIPO_CHOICES)

    def __str__(self):
        return f"Mantenimiento {self.tipo} - {self.fecha}"

class Bitacora(models.Model):
    usuario = models.CharField(max_length=150)
    accion = models.CharField(max_length=100)
    fecha = models.DateTimeField(auto_now_add=True)
    tabla_afectada = models.CharField(max_length=100)
    detalle = models.TextField(blank=True)

    def __str__(self):
        return f"{self.fecha} - {self.usuario} - {self.accion}"

class Accesorio(models.Model):
    nombre = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.nombre

class VehiculoAccesorio(models.Model):
    vehiculo = models.ForeignKey(Vehiculo, on_delete=models.CASCADE)
    accesorio = models.ForeignKey(Accesorio, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('vehiculo', 'accesorio')

    def __str__(self):
        return f"{self.vehiculo} - {self.accesorio}"

