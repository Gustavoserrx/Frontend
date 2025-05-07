<?php
session_start();
$_SESSION["rol"] = "administrador";
if ($_SESSION['rol'] !== 'administrador') {
    echo "Acceso denegado.";
    exit;
}
?>

<h2>Crear nuevo usuario</h2>

<form action="procesar_creacion.php" method="POST">
    <input type="text" name="nombre" placeholder="Nombre" required><br><br>
    <input type="text" name="apellido" placeholder="Apellido" required><br><br>
    <input type="email" name="email" placeholder="Correo electrónico" required><br><br>
    <input type="password" name="contraseña" placeholder="Contraseña" required><br><br>

    <label for="rol">Rol:</label>
    <select name="rol" required>
        <option value="profesor">Profesor</option>
        <option value="alumno">Alumno</option>
    </select><br><br>

    <button type="submit">Crear Usuario</button>
</form>
