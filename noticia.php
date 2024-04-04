<?php
include_once 'db.php'; // Asegúrate de que este sea el camino correcto al archivo db.php

// Instancia la clase Database
$database = new Database();
$db = $database-> getConnection();

// Obtén el ID de la noticia desde la URL
$noticiaID = isset($_GET['id']) ? $_GET['id'] : die('ERROR: Noticia no encontrada.');

// Prepara una consulta para buscar la noticia por su ID
$query = "SELECT titulo, contenido, imagenURL FROM Noticia WHERE noticiaID = ?";
$stmt = $db->prepare($query);

// Vincula el ID de la noticia a la consulta y ejecútala
$stmt->bindParam(1, $noticiaID);
$stmt->execute();

// Recupera los detalles de la noticia
$row = $stmt->fetch(PDO::FETCH_ASSOC);

// Extrae los valores
$titulo = $row['titulo'];
$contenido = $row['contenido'];
$imagenURL = $row['imagenURL'];
?>

<?php include_once 'template/header.php'; ?>
<body>
    <div class="container mt-4" style="margin-bottom: 20px;">
        <div class="row">
            <div class="col-md-12">
                <?php if (!empty($imagenURL)): ?>
                    <img src="<?php echo $imagenURL; ?>" class="img-fluid" alt="<?php echo htmlspecialchars($titulo); ?>">
                <?php endif; ?>
                <h1><?php echo htmlspecialchars($titulo); ?></h1>
                <p><?php echo nl2br(htmlspecialchars($contenido)); ?></p>
                <a href="index.php" class="btn btn-primary">Volver a Inicio</a>
            </div>
        </div>
    </div>
</body>
<?php include_once 'template/footer.php'; ?>

