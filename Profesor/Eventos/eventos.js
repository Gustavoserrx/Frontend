let eventos = [];

function agregarEvento() {
  const titulo = document.getElementById("titulo").value.trim();
  const fecha = document.getElementById("fecha").value;
  const alumnosInput = document.getElementById("alumnos").value.trim();
  const alumnos = alumnosInput ? alumnosInput.split(',').map(a => a.trim()) : [];

  if (!titulo || !fecha) {
    alert("Por favor, completa todos los campos");
    return;
  }

  eventos.push({ titulo, fecha, alumnos });
  renderEventos();
  limpiarCampos();
}

function eliminarEvento(index) {
  if (confirm("¿Seguro que deseas eliminar este evento?")) {
    eventos.splice(index, 1);
    renderEventos();
  }
}

function renderEventos() {
  const eventList = document.getElementById("eventList");
  eventList.innerHTML = "";

  eventos.forEach((evento, index) => {
    eventList.innerHTML += `
      <div class="event">
        <div class="event-header">
          <div>
            <div class="event-title">${evento.titulo}</div>
            <div>${evento.fecha}</div>
          </div>
          <button onclick="eliminarEvento(${index})">Eliminar</button>
        </div>
        <div class="alumnos">
          <strong>Alumnos:</strong> ${evento.alumnos.join(", ") || 'Ninguno asignado'}
        </div>
      </div>
    `;
  });
}

function limpiarCampos() {
  document.getElementById("titulo").value = "";
  document.getElementById("fecha").value = "";
  document.getElementById("alumnos").value = "";
}
