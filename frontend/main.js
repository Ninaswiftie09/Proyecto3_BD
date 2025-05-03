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
    } catch (err) {
      console.error('Error al consultar vehículos:', err);
      document.getElementById('resultado').innerText = 'No se pudo conectar al servidor.';
    }
  }
  