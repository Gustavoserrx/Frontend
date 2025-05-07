//document.getElementById("envio").addEventListener("click", login);
const searchParams = new URLSearchParams(window.location.search);


if (searchParams.get("pago") === "exitoso") {
  Swal.fire({
    title: "Pago realizado",
    text: `Tu suscripción se ha registrado con éxito.`,
    icon: "success"
  });
} else if (searchParams.get("pago") === "fallido" || searchParams.get("pago") === "error_consulta") {
  Swal.fire({
    title: "Error",
    text: `Ha habido un problema con tu suscripción. Se te ha reembolsado el dinero.`,
    icon: "error"
  });
}
 else if (searchParams.has("usuario")) {
  switch (searchParams.get("usuario")) {
    case "correcto":
      Swal.fire({
        title: "Usuario creado",
        text: `El usuario se ha creado con éxito`,
        icon: "success"
      });
      break;
    case "error":
      Swal.fire({
        title: "Error",
        text: `Ha habido un problema creando el usuario`,
        icon: "error"
      });
      break;
    case "nombre":
      Swal.fire({
        title: "Error",
        text: `Has usado un nombre que ya está registrado`,
        icon: "error"
      });
      break;
    case "email":
      Swal.fire({
        title: "Error",
        text: `Has usado un email que ya está registrado`,
        icon: "error"
      });
      break;
  }
}

/*
        function login(e){
            e.preventDefault();

            const body = document.querySelector("body");
            const script1 = document.createElement("script");
            script1.src = 'https://cdn.jsdelivr.net/npm/sweetalert2@11';

            const script2 = document.createElement("script");

            const username = document.getElementById("username").value;
            const pass = document.getElementById("pass").value;
            let xhr = new XMLHttpRequest();

            xhr.open("POST", "login.php", true);
            xhr.setRequestHeader("Content-type", 'application/x-www-form-urlencoded');

            xhr.onreadystatechange = function(){
                if(xhr.readyState === 4 && xhr.status === 200){
                    script2.innerHTML = xhr.responseText;
                    body.appendChild(script1);
                    body.appendChild(script2);
                }
            };

            xhr.send(`username=${encodeURIComponent(username)}&pass=${encodeURIComponent(pass)}`);
        }

        */
        let indice = 0;

function moverCarrusel(direccion) {
  const carrusel = document.querySelector('.carrusel-imagenes');
  const total = carrusel.children.length;
  indice = (indice + direccion + total) % total;
  carrusel.style.transform = `translateX(-${indice * 100}%)`;
}

// Auto-carrusel cada 3 segundos
setInterval(() => {
  moverCarrusel(1);
}, 3000);
