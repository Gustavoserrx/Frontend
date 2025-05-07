document.addEventListener("DOMContentLoaded", () => {
  const grupoSelect = document.getElementById("grupo-select");
  const contenedor = document.getElementById("grupo-contenedor");
  const cargandoMensaje = document.createElement("p");
  cargandoMensaje.classList.add("cargando");
  cargandoMensaje.textContent = "Cargando alumnos...";

  grupoSelect.addEventListener("change", () => {
    const grupo = grupoSelect.value;
    contenedor.innerHTML = ""; // Limpia el contenedor
    contenedor.appendChild(cargandoMensaje); // Muestra "Cargando..."
    cargandoMensaje.style.display = "block"; // Habilita el mensaje

    if (grupo) {
      setTimeout(() => cargarAlumnos(grupo), 1500); // Simula un retraso
    }
  });
});

// Esta función simula la carga de los alumnos
function cargarAlumnos(grupo) {
  const datosFalsos = {
    grupo1: [
      { nombre: "Juan", apellidos: "Pérez", id: "juan_perez" },
      { nombre: "María", apellidos: "Gómez", id: "maria_gomez" },
    ],
    grupo2: [
      { nombre: "Ana", apellidos: "López", id: "ana_lopez" },
      { nombre: "Carlos", apellidos: "Muñoz", id: "carlos_munoz" },
    ],
    grupo3: [
      { nombre: "Sofía", apellidos: "Martín", id: "sofia_martin" },
      { nombre: "David", apellidos: "Fernández", id: "david_fernandez" },
    ],
  };

  const alumnos = datosFalsos[grupo] || [];
  const contenedor = document.getElementById("grupo-contenedor");

  // Oculta mensaje "Cargando..."
  const cargandoMensaje = document.querySelector(".cargando");
  cargandoMensaje.style.display = "none";

  if (alumnos.length === 0) {
    contenedor.innerHTML = "<p>No hay alumnos en este grupo.</p>";
    return;
  }

  const grupoDiv = document.createElement("div");
  grupoDiv.classList.add("grupo");
  grupoDiv.classList.add("activo");

  const titulo = document.createElement("h2");
  titulo.textContent = `Alumnos de ${grupo}`;
  grupoDiv.appendChild(titulo);

  const lista = document.createElement("ul");
  lista.classList.add("alumnos-lista");

  alumnos.forEach(alumno => {
    const li = document.createElement("li");
    li.innerHTML = `
      <span>${alumno.nombre} ${alumno.apellidos}</span>
      <div>
        <button class="sí" onclick="marcarAsistencia('${alumno.id}', true)">Sí</button>
        <button class="no" onclick="marcarAsistencia('${alumno.id}', false)">No</button>
      </div>
    `;
    lista.appendChild(li);
  });

  grupoDiv.appendChild(lista);
  contenedor.appendChild(grupoDiv);
}

// Función para marcar la asistencia
function marcarAsistencia(id, asistio) {
  console.log(`Alumno ${id} ha ${asistio ? "asistido" : "faltado"}.`);
}
