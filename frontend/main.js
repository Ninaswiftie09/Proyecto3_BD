const API_BASE = "http://localhost:8000/renta";
const container = document.getElementById("vehiculos-container");
const fechaInicioInput = document.getElementById("fechaInicio");
const fechaFinInput = document.getElementById("fechaFin");
const modal = document.getElementById("modal");
const cerrarModal = document.getElementById("cerrarModal");
const formRenta = document.getElementById("formRenta");
const clienteSelect = document.getElementById("clienteSelect");
const empleadoSelect = document.getElementById("empleadoSelect");
const modalFechaInicio = document.getElementById("modalFechaInicio");
const modalFechaFin = document.getElementById("modalFechaFin");
const vehiculoInput = document.getElementById("vehiculo_id");

let vehiculos = [];

// ---------------------- Función principal ----------------------

async function cargarVehiculos() {
  try {
    const res = await fetch(`${API_BASE}/vehiculos/`);
    vehiculos = await res.json();
    renderVehiculos(vehiculos);
  } catch (error) {
    container.innerHTML = "<p>Error al cargar vehículos.</p>";
  }
}

// ---------------------- Verifica imagen ----------------------

function verificarImagen(url) {
  return new Promise((resolve) => {
    const img = new Image();
    img.onload = () => resolve(url);
    img.onerror = () => resolve("https://placehold.co/300x180?text=Vehiculo");
    img.src = url;
  });
}

// ---------------------- Renderiza las tarjetas ----------------------

async function renderVehiculos(lista) {
  container.innerHTML = "";
  for (const v of lista) {
    const imagen = await verificarImagen(v.imagen_url);
    const card = document.createElement("div");
    card.className = "card";
    card.innerHTML = `
      <img src="${imagen}" alt="Vehículo" />
      <div class="card-body">
        <h3>${v.marca} ${v.modelo}</h3>
        <p>Año: ${v.ano} • ${v.color}</p>
        <p><strong>Categoría:</strong> ${v.categoria?.nombre || 'N/A'}</p>
        <p><strong>Precio:</strong> Q${v.precio_diario}/día</p>
        <button onclick="verDisponibilidad(${v.id})">Ver disponibilidad</button>
      </div>
    `;
    container.appendChild(card);
  }
}

// ---------------------- Verifica disponibilidad ----------------------

async function verDisponibilidad(vehiculo_id) {
  const fi = fechaInicioInput.value;
  const ff = fechaFinInput.value;

  if (!fi || !ff) {
    alert("Selecciona fechas válidas.");
    return;
  }

  try {
    const res = await fetch(`${API_BASE}/alquileres/?vehiculo_id=${vehiculo_id}`);
    const alquileres = await res.json();

    const estaDisponible = alquileres.every(a => {
      const inicio = new Date(a.fecha_inicio);
      const fin = new Date(a.fecha_fin);
      const fInicio = new Date(fi);
      const fFin = new Date(ff);
      return fFin < inicio || fInicio > fin;
    });

    if (estaDisponible) {
      abrirModal(vehiculo_id, fi, ff);
    } else {
      alert("Este vehículo no está disponible en esas fechas.");
    }
  } catch (error) {
    alert("Error al verificar disponibilidad.");
  }
}

// ---------------------- Abre modal con formulario ----------------------

async function abrirModal(vehiculo_id, fi, ff) {
  modal.style.display = "block";
  vehiculoInput.value = vehiculo_id;
  modalFechaInicio.value = fi;
  modalFechaFin.value = ff;
  await cargarSelect(`${API_BASE}/clientes/`, clienteSelect);
  await cargarSelect(`${API_BASE}/empleados/`, empleadoSelect);
}

async function cargarSelect(url, select) {
  try {
    const res = await fetch(url);
    const datos = await res.json();
    select.innerHTML = "";
    datos.forEach(d => {
      const opt = document.createElement("option");
      opt.value = d.id;
      opt.textContent = `${d.nombre} ${d.apellido}`;
      select.appendChild(opt);
    });
  } catch {
    select.innerHTML = "<option>Error</option>";
  }
}

// ---------------------- Enviar alquiler ----------------------

formRenta.addEventListener("submit", async (e) => {
  e.preventDefault();

  const data = {
    cliente_id: clienteSelect.value,
    vehiculo_id: vehiculoInput.value,
    empleado_id: empleadoSelect.value,
    fecha_inicio: modalFechaInicio.value,
    fecha_fin: modalFechaFin.value,
    total: 0,
    estado: "Pendiente"
  };

// ---------------------- Generar PDF ----------------------
function generarPDF(cliente, empleado, fechaInicio, fechaFin, total) {
  const { jsPDF } = window.jspdf;
  const doc = new jsPDF();

  // Título
  doc.setFontSize(18);
  doc.text('Confirmación de Renta', 14, 20);

  // Información del alquiler
  doc.setFontSize(12);
  doc.text(`Cliente: ${cliente}`, 14, 40);
  doc.text(`Empleado: ${empleado}`, 14, 50);
  doc.text(`Fecha Inicio: ${fechaInicio}`, 14, 60);
  doc.text(`Fecha Fin: ${fechaFin}`, 14, 70);
  doc.text(`Total: Q${total.toFixed(2)}`, 14, 80);

  // Guardar el PDF
  doc.save('confirmacion_renta.pdf');
}

// ---------------------- Enviar alquiler ----------------------

formRenta.addEventListener("submit", async (e) => {
  e.preventDefault();

  const data = {
    cliente_id: clienteSelect.value,
    vehiculo_id: vehiculoInput.value,
    empleado_id: empleadoSelect.value,
    fecha_inicio: modalFechaInicio.value,
    fecha_fin: modalFechaFin.value,
    total: 0,
    estado: "Pendiente"
  };

  // Calcular total antes de enviar (opcional)
  const dias = (new Date(data.fecha_fin) - new Date(data.fecha_inicio)) / (1000 * 60 * 60 * 24);
  const vehiculo = vehiculos.find(v => v.id == data.vehiculo_id);
  if (vehiculo) {
    data.total = dias * parseFloat(vehiculo.precio_diario);
  }

  // Obtener los nombres del cliente y el empleado
  const cliente = clienteSelect.options[clienteSelect.selectedIndex].text;
  const empleado = empleadoSelect.options[empleadoSelect.selectedIndex].text;

  // Generar el PDF con los datos del alquiler
  generarPDF(cliente, empleado, data.fecha_inicio, data.fecha_fin, data.total);

  // Enviar el alquiler
  const res = await fetch(`${API_BASE}/alquileres/`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data)
  });

  if (res.ok) {
    alert("¡Alquiler creado!");
    modal.style.display = "none";
    cargarVehiculos();
  } else {
    alert("Error al alquilar.");
  }
});


  const res = await fetch(`${API_BASE}/alquileres/`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data)
  });

  if (res.ok) {
    alert("¡Alquiler creado!");
    modal.style.display = "none";
    cargarVehiculos();
  } else {
    alert("Error al alquilar.");
  }
});

cerrarModal.addEventListener("click", () => {
  modal.style.display = "none";
});

cargarVehiculos();
