document.getElementById("envio").addEventListener("click", login);

function login(e) {
  e.preventDefault();

  const correo = document.getElementById("correo").value;
  const password = document.getElementById("password").value;

  const xhr = new XMLHttpRequest();
  xhr.open("POST", "../panel-admin-proyecto/login.php", true);
  xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
      try {
        const response = JSON.parse(xhr.responseText); // Tu PHP debe devolver JSON

        if (response.status === "ok") {
          window.location.href = response.redirect; // redirige si es exitoso
        } else {
          Swal.fire({
            title: "Error",
            text: response.message,
            icon: "error",
            confirmButtonText: "OK"
          });
        }
      } catch (error) {
        console.error("Respuesta no válida:", xhr.responseText);
      }
    }
  };

  xhr.send(`correo=${encodeURIComponent(correo)}&password=${encodeURIComponent(password)}`);
}
