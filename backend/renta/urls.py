from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    CategoriaViewSet, VehiculoViewSet, ClienteViewSet,
    EmpleadoViewSet, AlquilerViewSet, PagoViewSet,
    MantenimientoViewSet, BitacoraViewSet,
    AccesorioViewSet, VehiculoAccesorioViewSet
)

router = DefaultRouter()
router.register(r'categorias', CategoriaViewSet)
router.register(r'vehiculos', VehiculoViewSet)
router.register(r'clientes', ClienteViewSet)
router.register(r'empleados', EmpleadoViewSet)
router.register(r'alquileres', AlquilerViewSet)
router.register(r'pagos', PagoViewSet)
router.register(r'mantenimientos', MantenimientoViewSet)
router.register(r'bitacora', BitacoraViewSet)
router.register(r'accesorios', AccesorioViewSet)
router.register(r'vehiculo-accesorios', VehiculoAccesorioViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
