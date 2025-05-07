const groups = {
    "Grupo A": [
      { nombre: "Laura", apellidos: "Gómez Pérez", clase: "Intermedio" },
      { nombre: "Carlos", apellidos: "Ramírez López", clase: "Avanzado" },
    ],
    "Grupo B": [
      { nombre: "Ana", apellidos: "Martínez Ruiz", clase: "Principiante" },
      { nombre: "David", apellidos: "Fernández Soto", clase: "Intermedio" },
    ],
    "Grupo C": [
      { nombre: "Lucía", apellidos: "Morales Gil", clase: "Avanzado" },
      { nombre: "Juan", apellidos: "Navarro Díaz", clase: "Principiante" },
    ]
  };
  
  const groupSelect = document.getElementById("groupSelect");
  const searchInput = document.getElementById("searchInput");
  const groupContent = document.getElementById("groupContent");
  
  // Cargar opciones de grupo
  Object.keys(groups).forEach(grupo => {
    const option = document.createElement("option");
    option.value = grupo;
    option.textContent = grupo;
    groupSelect.appendChild(option);
  });
  
  // Habilitar input cuando se selecciona grupo
  groupSelect.addEventListener("change", () => {
    const selectedGroup = groupSelect.value;
    searchInput.disabled = !selectedGroup;
    groupContent.innerHTML = "";
    searchInput.value = "";
  });
  
  // Buscar dentro del grupo seleccionado
  searchInput.addEventListener("input", () => {
    const query = searchInput.value.trim().toLowerCase();
    const groupName = groupSelect.value;
    groupContent.innerHTML = "";
  
    if (!groupName || !query) return;
  
    const results = groups[groupName].filter(alumno => {
      const fullName = `${alumno.nombre} ${alumno.apellidos}`.toLowerCase();
      return fullName.includes(query);
    });
  
    if (results.length === 0) {
      groupContent.innerHTML = "<p>No se encontraron resultados.</p>";
      return;
    }
  
    results.forEach(alumno => {
      const card = document.createElement("div");
      card.className = "card";
      card.innerHTML = `
        <h3>${alumno.nombre} ${alumno.apellidos}</h3>
        <p><strong>Clase:</strong> ${alumno.clase}</p>
      `;
      groupContent.appendChild(card);
    });
  });
  