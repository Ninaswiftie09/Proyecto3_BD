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

// ---------------------- Cargar Vehículos ----------------------

async function cargarVehiculos() {
  try {
    const res = await fetch(`${API_BASE}/vehiculos/`);
    vehiculos = await res.json();
    renderVehiculos(vehiculos);
  } catch (error) {
    container.innerHTML = "<p>Error al cargar vehículos.</p>";
  }
}

// ---------------------- Verificar imagen ----------------------

function verificarImagen(url) {
  return new Promise((resolve) => {
    const img = new Image();
    img.onload = () => resolve(url);
    img.onerror = () => resolve("https://placehold.co/300x180?text=Vehiculo");
    img.src = url;
  });
}

// ---------------------- Renderizar tarjetas ----------------------

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

// ---------------------- Verificar disponibilidad ----------------------

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

// ---------------------- Abrir modal ----------------------

async function abrirModal(vehiculo_id, fi, ff) {
  modal.style.display = "block";
  vehiculoInput.value = vehiculo_id;
  modalFechaInicio.value = fi;
  modalFechaFin.value = ff;
  await cargarSelect(`${API_BASE}/clientes/`, clienteSelect);
  await cargarSelect(`${API_BASE}/empleados/`, empleadoSelect);
}

// ---------------------- Cargar clientes y empleados ----------------------

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

// ---------------------- Generar PDF ----------------------

function generarPDF(cliente, empleado, fechaInicio, fechaFin, dias, precio, total) {
  const jsPDF = window.jspdf?.jsPDF;
  if (!jsPDF) {
    console.warn("jsPDF no está cargado");
    return;
  }

  const doc = new jsPDF();
  doc.setFontSize(18);
  doc.text('Confirmación de Renta', 14, 20);

  doc.setFontSize(12);
  doc.text(`Cliente: ${cliente}`, 14, 40);
  doc.text(`Empleado: ${empleado}`, 14, 50);
  doc.text(`Fecha Inicio: ${fechaInicio}`, 14, 60);
  doc.text(`Fecha Fin: ${fechaFin}`, 14, 70);
  doc.text(`Días de renta: ${dias}`, 14, 80);
  doc.text(`Precio por día: Q${precio.toFixed(2)}`, 14, 90);
  doc.text(`Total: Q${total.toFixed(2)}`, 14, 100);

  doc.save('confirmacion_renta.pdf');
}

// ---------------------- Enviar alquiler ----------------------

formRenta.addEventListener("submit", async (e) => {
  e.preventDefault();

  const cliente = clienteSelect.options[clienteSelect.selectedIndex]?.text || "N/A";
  const empleado = empleadoSelect.options[empleadoSelect.selectedIndex]?.text || "N/A";
  const fechaInicio = modalFechaInicio.value;
  const fechaFin = modalFechaFin.value;
  const vehiculoId = parseInt(vehiculoInput.value);

  const dias = (new Date(fechaFin) - new Date(fechaInicio)) / (1000 * 60 * 60 * 24);
  const vehiculo = vehiculos.find(v => v.id === vehiculoId);
  const precioPorDia = vehiculo ? parseFloat(vehiculo.precio_diario) : 0;
  const total = dias * precioPorDia;

  generarPDF(cliente, empleado, fechaInicio, fechaFin, dias, precioPorDia, total);

  const data = {
    cliente_id: parseInt(clienteSelect.value),
    vehiculo_id: vehiculoId,
    empleado_id: parseInt(empleadoSelect.value),
    fecha_inicio: fechaInicio,
    fecha_fin: fechaFin,
    estado: "Pendiente"
  };

  try {
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
      const errorText = await res.text();
      console.error("ERROR EN RESPUESTA:", errorText);
      alert("Error al alquilar. Revisa la consola.");
    }
  } catch (error) {
    console.error("ERROR AL ENVIAR:", error);
    alert("Error al enviar el formulario.");
  }
});

// ---------------------- Cerrar modal ----------------------

cerrarModal.addEventListener("click", () => {
  modal.style.display = "none";
});

// ---------------------- Iniciar ----------------------

cargarVehiculos();
