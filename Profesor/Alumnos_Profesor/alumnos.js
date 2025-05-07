let students = [];
let studentId = 1;

// Función para añadir alumnos en local (no conecta a la BBDD aún)
function addStudent() {
  const name = document.getElementById("nameInput").value.trim();
  const group = document.getElementById("groupInput").value.trim();
  if (!name || !group) return alert("Por favor, completa todos los campos.");

  students.push({ id: studentId++, name, group });
  renderTable(students);

  document.getElementById("nameInput").value = "";
  document.getElementById("groupInput").value = "";
}

// Función para pintar la tabla de alumnos
function renderTable(data) {
  const tableBody = document.getElementById("studentTableBody");
  tableBody.innerHTML = "";

  if (data.length === 0) {
    tableBody.innerHTML = '<tr><td colspan="4">No se encontraron alumnos.</td></tr>';
    return;
  }

  data.forEach(student => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td>${student.id}</td>
      <td><input value="${student.name}" readonly></td>
      <td><input value="${student.group}" readonly></td>
      <td><button onclick="deleteStudent(${student.id})">Eliminar</button></td>
    `;
    tableBody.appendChild(row);
  });
}

// Función para buscar alumnos conectando a la base de datos
function searchStudents() {
  const name = document.getElementById("searchName").value.trim();
  const group = document.getElementById("searchGroup").value.trim();

  fetch('buscar_alumnos.php', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ name: name, group: group })
  })
  .then(response => response.json())
  .then(data => {
    students = data; // actualiza la lista local
    renderTable(students);
  })
  .catch(error => {
    console.error('Error al buscar alumnos:', error);
  });
}

// Función para resetear la búsqueda
function resetSearch() {
  document.getElementById("searchName").value = "";
  document.getElementById("searchGroup").value = "";
  fetchAllStudents();
}

// Función para cargar todos los alumnos al iniciar
function fetchAllStudents() {
  fetch('buscar_alumnos.php', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ name: "", group: "" })
  })
  .then(response => response.json())
  .then(data => {
    students = data;
    renderTable(students);
  })
  .catch(error => {
    console.error('Error al cargar alumnos:', error);
  });
}

// Eliminar alumno en local (más adelante también podemos conectar con BBDD)
function deleteStudent(id) {
  students = students.filter(s => s.id !== id);
  renderTable(students);
}

// Ejecutar al cargar la página
window.addEventListener('DOMContentLoaded', fetchAllStudents);
