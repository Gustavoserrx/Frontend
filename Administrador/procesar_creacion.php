<?php
session_start();
$_SESSION["rol"] = "administrador";
if ($_SESSION['rol'] !== 'administrador') {
    die("Acceso denegado.");
}

$conexion = new mysqli("localhost", "root", "", "pruebas_proyecto"); 

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

$nombre = $_POST['nombre'];
$apellido = $_POST["apellido1"] . " " . $_POST["apellido2"];
$email = $_POST['email'];
$contraseña = password_hash($_POST['contraseña'], PASSWORD_DEFAULT); // Seguridad
$rol = $_POST['rol'];
$grupo = $_POST['grupo'];

$sql = "INSERT INTO usuarios (nombre, apellido, email, contraseña, rol, Grupo) VALUES (?, ?, ?, ?, ?, ?)";
$stmt = $conexion->prepare($sql);
$stmt->bind_param("sssssi", $nombre, $apellido, $email, $contraseña, $rol, $grupo);


try{
    $stmt -> execute();
    header("Location: ../Inicio/index.html?usuario=correcto");
    exit;
}

catch(mysqli_sql_exception $e){
    if(strpos($e->getMessage(), 'email')){
        header("Location: ../Inicio/index.html?usuario=email");
    }
    else if(strpos($e->getMessage(), 'nombre')){
        header("Location: ../Inicio/index.html?usuario=nombre");
    }
    else{
        header("Location: ../Inicio/index.html?usuario=error");
    }
    exit;
}

$stmt->close();
$conexion->close();
?>
