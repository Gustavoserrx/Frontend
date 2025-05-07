<?php
session_start();
if ($_SESSION['rol'] !== 'administrador') {
    echo "Acceso denegado";
    exit;
}

$conexion = new mysqli("localhost", "root", "", "pruebas_proyecto");
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $accion = $_POST['accion'];

    if ($accion === 'editar') {
        $id = intval($_POST['id']);
        $nombre = $_POST['nombre'];
        $apellido = $_POST['apellido'];
        $email = $_POST['email'];
        $rol = $_POST['rol'];
        $password = $_POST['password']; // Recibe la contraseña (puede estar vacía)
        

        // Comenzamos a preparar la consulta
        if (!empty($password)) {
            // Solo si hay una nueva contraseña se aplica el hash
            $password_hash = password_hash($password, PASSWORD_DEFAULT);

            $stmt = $conexion->prepare("UPDATE usuarios SET nombre=?, apellido=?, email=?, rol=?, contraseña=? WHERE id_usuario=?");
            $stmt->bind_param("sssssi", $nombre, $apellido, $email, $rol, $password_hash, $id);
        } else {
            // Si no hay contraseña, solo actualizamos los demás campos
            $stmt = $conexion->prepare("UPDATE usuarios SET nombre=?, apellido=?, email=?, rol=? WHERE id_usuario=?");
            $stmt->bind_param("ssssi", $nombre, $apellido, $email, $rol, $id);
        }

        if ($stmt->execute()) {
            echo "Usuario actualizado correctamente.";
        } else {
            echo "Error al actualizar usuario.";
        }

        $stmt->close();
    }

    if ($accion === 'eliminar') {
        $id = intval($_POST['id']);
        $stmt = $conexion->prepare("DELETE FROM usuarios WHERE id_usuario = ?");
        $stmt->bind_param("i", $id);
        if ($stmt->execute()) {
            echo "Usuario eliminado correctamente.";
        } else {
            echo "Error al eliminar el usuario.";
        }
        $stmt->close();
    }
}

$conexion->close();
?>
