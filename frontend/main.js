async function consultarVehiculos() {
  try {
    const res = await fetch('http://localhost:8000/vehiculos');
    const data = await res.json();

    const contenedor = document.getElementById('resultado');
    contenedor.innerHTML = `
      <h2>Vehículos disponibles</h2>
      <table>
        <thead>
          <tr>
            <th>Marca</th>
            <th>Modelo</th>
            <th>Año</th>
            <th>Color</th>
            <th>Precio diario</th>
          </tr>
        </thead>
        <tbody>
          ${data.map(v => `
            <tr>
              <td>${v.marca}</td>
              <td>${v.modelo}</td>
              <td>${v.ano}</td>
              <td>${v.color}</td>
              <td>Q${v.precio_diario}</td>
            </tr>
          `).join('')}
        </tbody>
      </table>
    `;

    cargarVehiculosSelect(data);
  } catch (err) {
    console.error('Error al consultar vehículos:', err);
    document.getElementById('resultado').innerText = 'No se pudo conectar al servidor.';
  }
}

function cargarVehiculosSelect(vehiculos) {
  const selectVehiculo = document.getElementById('vehiculo');
  vehiculos.forEach(vehiculo => {
    const option = document.createElement('option');
    option.value = vehiculo.id;
    option.textContent = `${vehiculo.marca} ${vehiculo.modelo} (${vehiculo.ano})`;
    selectVehiculo.appendChild(option);
  });
}

document.getElementById('formulario-reserva').addEventListener('submit', async (event) => {
  event.preventDefault();

  const cliente = document.getElementById('cliente').value;
  const vehiculoId = document.getElementById('vehiculo').value;
  const fechaInicio = document.getElementById('fecha_inicio').value;
  const fechaFin = document.getElementById('fecha_fin').value;

  const response = await fetch('http://localhost:8000/alquileres/', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      cliente,
      vehiculo: vehiculoId,
      fecha_inicio: fechaInicio,
      fecha_fin: fechaFin,
    })
  });

  const data = await response.json();
  if (response.ok) {
    alert('Reserva realizada con éxito!');
  } else {
    alert(`Error: ${data.detail}`);
  }
});
