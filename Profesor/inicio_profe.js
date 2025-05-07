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