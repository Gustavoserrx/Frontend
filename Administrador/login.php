<?php
session_start();
date_default_timezone_set('Europe/Madrid');

// Número máximo de intentos antes de bloqueo
define('MAX_ATTEMPTS', 3);

//
// Función para mostrar un SweetAlert y redirigir
//
function salida_alert($title, $text, $icon, $button, $redirect) {
    echo <<<HTML
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
  <script>
    Swal.fire({
      title: "{$title}",
      text: "{$text}",
      icon: "{$icon}",
      confirmButtonText: "{$button}"
    }).then(() => {
      window.location.href = "{$redirect}";
    });
  </script>
</body>
</html>
HTML;
    exit;
}

if ($_SERVER["REQUEST_METHOD"] === 'POST') {
    $email    = trim($_POST['email']    ?? '');
    $password = $_POST['password']      ?? '';

    // 1) Conexión a la base de datos
    $mysqli = new mysqli("localhost", "root", "", "pruebas_proyecto");
    if ($mysqli->connect_errno) {
        die("Error de conexión: " . $mysqli->connect_error);
    }

    // 2) Contar intentos fallidos de los últimos 15 minutos
    $stmt = $mysqli->prepare("
      SELECT COUNT(*) AS fails
        FROM login_attempts
       WHERE email = ?
         AND attempt_time > NOW() - INTERVAL 15 MINUTE
    ");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $failCount = (int)$stmt->get_result()->fetch_assoc()['fails'];
    $stmt->close();

    /* 
    if ($failCount >= MAX_ATTEMPTS) {
        salida_alert(
            "¡Bloqueado!",
            "Has fallado 3 veces. Vuelve a intentarlo en 15 minutos.",
            "warning",
            "OK",
            "../Login/inicio_user.html"
        );
    }
        */
        if ($failCount >= MAX_ATTEMPTS) {
            header("Location: ../Login/login.html?error=blocked");
            exit;
        }

    // 3) Recuperar usuario de la tabla usuarios
    $stmt = $mysqli->prepare("
      SELECT id_usuario, nombre, rol, pago_inicial, contraseña AS pass_hash
        FROM usuarios
       WHERE email = ?
    ");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $res = $stmt->get_result();
    $stmt->close();

    /*
    if ($res->num_rows !== 1) {
        salida_alert(
            "¡Error!",
            "Usuario no encontrado.",
            "error",
            "Reintentar",
            "../Inicio/inicio_user.html"
        );
    }
    */
    if ($res->num_rows !== 1) {
        header("Location: ../Login/login.html?error=nouser");
        exit;
    }

    $u = $res->fetch_assoc();

    // 4) Verificar contraseña
    if (password_verify($password, $u['pass_hash'])) {
        // a) Éxito: borrar intentos y crear sesión
        $stmt = $mysqli->prepare("DELETE FROM login_attempts WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $stmt->close();

        $_SESSION['id_usuario'] = $u['id_usuario'];
        $_SESSION['rol']        = $u['rol'];
        $_SESSION['nombre']     = $u['nombre'];
        $_SESSION['pago_inicial'] = $u['pago_inicial'];
        $nameEsc = addslashes($u['nombre']);

        $name = urlencode($u['nombre']);

        if($u['pago_inicial'] === 0){
          header("Location: ../Suscripcion/suscripcion.html");
        } else{
          header("Location: ../Inicio/inicio_user.html?login=success&name={$name}");
        }

        exit;

        
    } else {
        // b) Fallo: registrar intento y mostrar mensaje
        $stmt = $mysqli->prepare("
          INSERT INTO login_attempts (email, attempt_time)
          VALUES (?, NOW())
        ");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $stmt->close();

        $remaining = MAX_ATTEMPTS - ($failCount + 1);
        $msg = $remaining > 0
             ? "Contraseña incorrecta. Te quedan {$remaining} intento(s)."
             : "Has agotado los 3 intentos. Intenta de nuevo en 15 minutos.";

        /*
        salida_alert(
            "¡Error!",
            $msg,
            "error",
            "Reintentar",
            "../Inicio/inicio_user.html"
        );
        */
        header("Location: ../Login/login.html?error=badpass");
        exit;
    }

    $mysqli->close();
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Login con Bloqueo</title>
  <style>
    body { font-family: Arial, sans-serif; max-width: 400px; margin: 2em auto; }
    form { display: flex; flex-direction: column; }
    label { margin-top: .5em; }
    input, button { padding: .5em; margin-top: .3em; }
  </style>
</head>
<body>
  <h2>Iniciar sesión</h2>
  <form method="post" action="">
    <label for="email">Email:</label>
    <input id="email" type="email" name="email" required>

    <label for="password">Contraseña:</label>
    <input id="password" type="password" name="password" required>

    <button type="submit">Entrar</button>
  </form>
</body>
</html>
