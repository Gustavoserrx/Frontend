const form = document.getElementById("messageForm");
const successMsg = document.getElementById("successMsg");

form.addEventListener("submit", function (e) {
  e.preventDefault();

  const name = document.getElementById("name").value;
  const group = document.getElementById("group").value;
  const message = document.getElementById("message").value;

  // Aquí se conectará a la base de datos en el futuro
  // Ejemplo (comentado) con una API REST:
  /*
  fetch("https://tu-api.com/enviarMensaje", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ name, group, message }),
  }).then(res => res.json()).then(data => {
    successMsg.textContent = "Mensaje enviado correctamente.";
  });
  */

  console.log("Mensaje enviado a:", name, group, message); // Por ahora solo consola

  successMsg.textContent = "Mensaje enviado correctamente.";
  form.reset();
});
document.getElementById("search-normal").addEventListener("click", function(event) {
    // Evita que el clic en el campo normal active el menú desplegable
    event.stopPropagation(); // Detiene la propagación del clic
    // Aquí va la lógica para manejar el campo de búsqueda
});

document.querySelector(".navegacion .menu ul li.dropdown").addEventListener("click", function(event) {
    // Lógica para desplegar el menú
    event.stopPropagation(); // Impide que el clic en el menú se propague a otros elementos
});
document.querySelector(".navegacion .menu ul li.dropdown").addEventListener("mouseleave", function() {
    // Lógica para ocultar el menú al salir del mouse
});