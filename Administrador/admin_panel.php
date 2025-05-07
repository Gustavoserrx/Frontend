<?php
session_start();
if ($_SESSION['rol'] !== 'administrador') {
    echo "Acceso denegado.";
    exit;
}

$conexion = new mysqli("localhost", "root", "", "pruebas_proyecto");
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

$resultado = $conexion->query("SELECT * FROM usuarios ORDER BY fecha_creacion DESC");
?>

<h2>Panel de Administración - Usuarios</h2>

<label for="buscador">🔍 Buscar:</label>
<input type="text" id="buscador" placeholder="Escribe nombre o apellido..." style="margin-bottom:10px; padding:5px; width:300px;">

<table border="1" cellpadding="8">
    <thead>
      <tr>
        <th>ID</th>
        <th>Apellido</th>
        <th>Nombre</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody>

    <?php while ($fila = $resultado->fetch_assoc()): ?>
        <tr>
            <td><?= $fila['id_usuario'] ?></td>
            <td><?= htmlspecialchars($fila['apellido']) ?></td>
            <td><?= htmlspecialchars($fila['nombre']) ?></td>
            <td>
                <button class="btn-editar"
                    data-id="<?= $fila['id_usuario'] ?>"
                    data-nombre="<?= htmlspecialchars($fila['nombre']) ?>"
                    data-apellido="<?= htmlspecialchars($fila['apellido']) ?>"
                    data-email="<?= htmlspecialchars($fila['email']) ?>"
                    data-rol="<?= $fila['rol'] ?>">
                  Editar
                </button>
                <button class="btn-eliminar" data-id="<?= $fila['id_usuario'] ?>">Eliminar</button>
            </td>
        </tr>
    <?php endwhile; ?>
</table>

<!-- Modal para editar usuario -->
<div id="modal-editar" style="display:none; position:fixed; top:10%; left:50%; transform:translateX(-50%); background:#fff; padding:20px; box-shadow:0 0 10px rgba(0,0,0,0.3); z-index:1000;">
    <h3>Editar usuario</h3>
    <form id="form-editar">
        <input type="hidden" name="id" id="edit-id">
        <label>Nombre:</label>
        <input type="text" name="nombre" id="edit-nombre"><br>
        <label>Apellido:</label>
        <input type="text" name="apellido" id="edit-apellido"><br>
        <label>Email:</label>
        <input type="email" name="email" id="edit-email"><br>
        <label>Rol:</label>
        <label>Contraseña:</label>
        <input type="password" name="password" id="modal-password" autocomplete="new-password">


        <select name="rol" id="edit-rol">
            <option value="administrador">Administrador</option>
            <option value="profesor">Profesor</option>
            <option value="alumno">Alumno</option>
        </select><br><br>
        <button type="submit">Guardar cambios</button>
        <button type="button" onclick="document.getElementById('modal-editar').style.display='none'">Cancelar</button>
    </form>
</div>

<?php
$conexion->close();
?>

<script>
document.querySelectorAll('.btn-eliminar').forEach(btn => {
    btn.addEventListener('click', function() {
        const id = this.getAttribute('data-id');

        if (!confirm('¿Seguro que deseas eliminar este usuario?')) return;

        fetch('acciones_admin.php', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: new URLSearchParams({
                accion: 'eliminar',
                id: id
            })
        })
        .then(res => res.text())
        .then(respuesta => {
            alert(respuesta);
            location.reload();
        });
    });
});

document.querySelectorAll('.btn-editar').forEach(btn => {
    btn.addEventListener('click', function() {
        document.getElementById('edit-id').value = this.dataset.id;
        document.getElementById('edit-nombre').value = this.dataset.nombre;
        document.getElementById('edit-apellido').value = this.dataset.apellido;
        document.getElementById('edit-email').value = this.dataset.email;
        document.getElementById('edit-rol').value = this.dataset.rol;
        document.getElementById('modal-password').value = "";
        document.getElementById('modal-editar').style.display = 'block';
    });
});

document.getElementById('form-editar').addEventListener('submit', function(e) {
    e.preventDefault();

    fetch('acciones_admin.php', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: new URLSearchParams({
            accion: 'editar',
            id: document.getElementById('edit-id').value,
            nombre: document.getElementById('edit-nombre').value,
            apellido: document.getElementById('edit-apellido').value,
            email: document.getElementById('edit-email').value,
            rol: document.getElementById('edit-rol').value,
            password: document.getElementById('modal-password').value

        })
    })
    .then(res => res.text())
    .then(mensaje => {
        alert(mensaje);
        document.getElementById('modal-editar').style.display = 'none';
        location.reload();
    });
});
</script>
<script>
// Filtrado en tiempo real
document.getElementById('buscador').addEventListener('keyup', function() {
    const filtro = this.value.toLowerCase();
    document.querySelectorAll('table tbody tr').forEach(fila => {
        // Solo chequeamos las columnas de apellido y nombre
        const apellido = fila.children[1].innerText.toLowerCase();
        const nombre   = fila.children[2].innerText.toLowerCase();
        fila.style.display = (apellido.includes(filtro) || nombre.includes(filtro)) ? '' : 'none';
    });
});
</script>
