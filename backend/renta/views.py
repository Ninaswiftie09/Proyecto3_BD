from rest_framework import viewsets
from .models import (
    Categoria, Vehiculo, Cliente, Empleado,
    Alquiler, Pago, Mantenimiento,
    Bitacora, Accesorio, VehiculoAccesorio
)
from .serializers import (
    CategoriaSerializer, VehiculoSerializer, ClienteSerializer,
    EmpleadoSerializer, AlquilerSerializer, PagoSerializer,
    MantenimientoSerializer, BitacoraSerializer,
    AccesorioSerializer, VehiculoAccesorioSerializer
)

class CategoriaViewSet(viewsets.ModelViewSet):
    queryset = Categoria.objects.all()
    serializer_class = CategoriaSerializer

class VehiculoViewSet(viewsets.ModelViewSet):
    queryset = Vehiculo.objects.all()
    serializer_class = VehiculoSerializer

class ClienteViewSet(viewsets.ModelViewSet):
    queryset = Cliente.objects.all()
    serializer_class = ClienteSerializer

class EmpleadoViewSet(viewsets.ModelViewSet):
    queryset = Empleado.objects.all()
    serializer_class = EmpleadoSerializer

class AlquilerViewSet(viewsets.ModelViewSet):
    queryset = Alquiler.objects.all()
    serializer_class = AlquilerSerializer

class PagoViewSet(viewsets.ModelViewSet):
    queryset = Pago.objects.all()
    serializer_class = PagoSerializer

class MantenimientoViewSet(viewsets.ModelViewSet):
    queryset = Mantenimiento.objects.all()
    serializer_class = MantenimientoSerializer

class BitacoraViewSet(viewsets.ModelViewSet):
    queryset = Bitacora.objects.all()
    serializer_class = BitacoraSerializer

class AccesorioViewSet(viewsets.ModelViewSet):
    queryset = Accesorio.objects.all()
    serializer_class = AccesorioSerializer

class VehiculoAccesorioViewSet(viewsets.ModelViewSet):
    queryset = VehiculoAccesorio.objects.all()
    serializer_class = VehiculoAccesorioSerializer
