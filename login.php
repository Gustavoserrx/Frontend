<?php
if(isset($_POST["username"]) && isset($_POST["pass"])){

$name = $_POST["username"];
$pass = $_POST["pass"];

$db_host = "localhost";
$db_nombre = "pruebas";
$db_usuario = "root";
$db_contra = "";

$conexion = mysqli_connect($db_host, $db_usuario, $db_contra);

mysqli_select_db($conexion, $db_nombre) or die ("No se encuentra la BBDD");

$query = "SELECT * FROM Users WHERE `Nombre`='$name' AND Pass='$pass'";

$resultados = mysqli_query($conexion, $query);

if (mysqli_num_rows($resultados) > 0){

    //echo "<h2>Login correcto. Hola " . $name . ".</h2>";

    echo "

        Swal.fire({
            title: '¡Bienvenido!',
            text: 'Login exitoso, bienvenido {$name}',
            icon: 'success',
            confirmButtonText: 'Continuar'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = 'index.html';
            }
        });
 ";


}

else{
    echo "
            Swal.fire({
                title: '¡Error!',
                text: 'Login fallido',
                icon: 'error',
                confirmButtonText: 'Intentar de nuevo'
            }).then(() => {
                window.location.href = 'index.html';
            });
       ";
    }


mysqli_close($conexion);

/* if (mysqli_num_rows($resultados) > 0){

//echo "<h2>Login correcto. Hola " . $name . ".</h2>";

echo "
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        title: '¡Bienvenido!',
        text: 'Login exitoso, bienvenido {$name}',
        icon: 'success',
        confirmButtonText: 'Continuar'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'index.php';
        }
    });
</script>";


}

else{
echo "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
    <script>
        Swal.fire({
            title: '¡Error!',
            text: 'Login fallido',
            icon: 'error',
            confirmButtonText: 'Intentar de nuevo'
        }).then(() => {
            window.location.href = 'index.php';
        });
    </script>";
}
*/

}
    ?>