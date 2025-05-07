<?php


if (isset($_GET['session_id'])) {
    $sessionId = $_GET['session_id'];   

    $conexion = new mysqli("localhost", "root", "", "pruebas_proyecto");

    if ($conexion->connect_error) {
        die("Error de conexión " . $conexion->connect_error);
    }

    $query_select_estado = "SELECT estado FROM pagos_stripe WHERE session_id = ?";
    $stmt_select_estado = $conexion->prepare($query_select_estado);
    $stmt_select_estado->bind_param("s", $sessionId);

    $stmt_select_estado->execute();
    $stmt_select_estado->bind_result($estado);

    error_log("Hemos llegado");
    if ($stmt_select_estado->fetch()) {
        error_log("aqui?");
        echo $estado;
    } else {
        error_log("o aqui tal vez?");
        echo "error";
    }

    $stmt_select_estado->close();
    $conexion->close();
}

?>