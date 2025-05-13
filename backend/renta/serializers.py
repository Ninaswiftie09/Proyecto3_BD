from rest_framework import serializers
from .models import (
    Categoria,
    Vehiculo,
    Cliente,
    Empleado,
    Alquiler,
    Pago,
    Mantenimiento,
    Bitacora,
    Accesorio,
    VehiculoAccesorio
)

class CategoriaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Categoria
        fields = '__all__'

class VehiculoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehiculo
        fields = '__all__'

class ClienteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cliente
        fields = '__all__'

class EmpleadoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Empleado
        fields = '__all__'

class AlquilerSerializer(serializers.ModelSerializer):
    cliente_id = serializers.PrimaryKeyRelatedField(
        queryset=Cliente.objects.all(),
        source='cliente'
    )
    vehiculo_id = serializers.PrimaryKeyRelatedField(
        queryset=Vehiculo.objects.all(),
        source='vehiculo'
    )
    empleado_id = serializers.PrimaryKeyRelatedField(
        queryset=Empleado.objects.all(),
        source='empleado'
    )

    class Meta:
        model = Alquiler
        fields = [
            'id',
            'cliente_id',
            'vehiculo_id',
            'empleado_id',
            'fecha_inicio',
            'fecha_fin',
            'total',
            'estado'
        ]
        read_only_fields = ['total']

    def create(self, validated_data):
        vehiculo = validated_data['vehiculo']
        fecha_inicio = validated_data['fecha_inicio']
        fecha_fin = validated_data['fecha_fin']
        dias = (fecha_fin - fecha_inicio).days

        validated_data['total'] = dias * float(vehiculo.precio_diario)
        return super().create(validated_data)

class PagoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pago
        fields = '__all__'

class MantenimientoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Mantenimiento
        fields = '__all__'

class BitacoraSerializer(serializers.ModelSerializer):
    class Meta:
        model = Bitacora
        fields = '__all__'

class AccesorioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Accesorio
        fields = '__all__'

class VehiculoAccesorioSerializer(serializers.ModelSerializer):
    class Meta:
        model = VehiculoAccesorio
        fields = '__all__'
