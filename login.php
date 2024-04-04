<?php
session_start(); // Asegúrate de llamar a session_start() al principio

// Incluye el archivo de conexión a la base de datos al principio
include_once 'db.php';
$mensaje = "";

// Instancia la clase Database y obtén la conexión
$database = new Database();
$db = $database-> getConnection();

// Verifica si el formulario ha sido enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $correo = $_POST['correo'];
    $password = $_POST['password'];

    // Asegúrate de incluir imagenURL en tu SELECT
    $query = "SELECT userID, nombre, correo, password, imagenURL FROM Usuario WHERE correo = :correo";
    $stmt = $db->prepare($query);

    // Vincula el correo proporcionado por el usuario a la consulta
    $stmt->bindParam(':correo', $correo);

    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        
        // Verifica la contraseña
        if (password_verify($password, $row['password'])) {
            // Inicio de sesión exitoso
            $_SESSION['userID'] = $row['userID'];
            $_SESSION['nombre'] = $row['nombre'];
            $_SESSION['correo'] = $row['correo'];
            $_SESSION['imagenURL'] = $row['imagenURL']; // Almacenar la URL de la imagen en la sesión
            
            header('Location: index.php'); 
            exit();
        } else {
            // La contraseña no coincide
            $mensaje = "Contraseña incorrecta.";
        }
    } else {
        // No se encontró el usuario
        $mensaje = "No existe un usuario con ese correo electrónico.";
    }
}
?>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - FideNews</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<div class="login-container">
    <h2 class="login-title">Iniciar Sesión</h2>
    <?php if ($mensaje): ?>
        <p class="login-message"><?php echo $mensaje; ?></p>
    <?php endif; ?>
    <form action="login.php" method="post" class="login-form">
        <div class="login-form-group">
            <label for="correo" class="login-label">Correo Electrónico:</label>
            <input type="email" name="correo" class="login-input" required>
        </div>
        <div class="login-form-group">
            <label for="password" class="login-label">Contraseña:</label>
            <input type="password" name="password" class="login-input" required>
        </div>
        <button type="submit" class="login-btn btn-primary">Iniciar Sesión</button>
    </form>
</div>
</body>
</html>
