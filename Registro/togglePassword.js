
    const eyeIcon = document.querySelector('#eyeIcon');
    const password = document.querySelector('#password');

    eyeIcon.addEventListener('click', function() {
        // Alternar visibilidad de contraseña
        const type = password.type === 'password' ? 'text' : 'password';
        password.type = type;
        
        // Cambiar icono
        this.classList.toggle('bi-eye');
        this.classList.toggle('bi-eye-slash');
    });
        