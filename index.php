<?php
session_start(); // Esto es necesario para acceder a las variables de sesión

// Verifica si el usuario está logueado verificando si una variable de sesión específica está establecida
if (!isset($_SESSION['userID'])) { // Asumiendo que 'userID' se establece al momento del inicio de sesión exitoso
    header('Location: login.php'); // Redirige al usuario a la página de inicio de sesión
    exit(); // Asegúrate de no ejecutar más código después de esta redirección
}

include_once 'db.php'; // Asegúrate de que este sea el camino correcto al archivo db.php

$database = new Database();
$db = $database->getConnection();

// Consulta para el carrusel (noticias con más visitas)
$queryCarousel = "SELECT * FROM Noticia ORDER BY visitas DESC LIMIT 4";
$stmtCarousel = $db->prepare($queryCarousel);
$stmtCarousel->execute();
$noticiasCarousel = $stmtCarousel->fetchAll(PDO::FETCH_ASSOC);

// Consulta para las últimas noticias publicadas
$queryUltimasNoticias = "SELECT * FROM Noticia ORDER BY fechaPublicacion DESC LIMIT 6";
$stmtUltimasNoticias = $db->prepare($queryUltimasNoticias);
$stmtUltimasNoticias->execute();
$ultimasNoticias = $stmtUltimasNoticias->fetchAll(PDO::FETCH_ASSOC);
?>

<?php include_once 'template/header.php'; ?>

<!-- Carrusel de imágenes -->
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
        <?php foreach ($noticiasCarousel as $index => $noticia): ?>
            <li data-target="#carouselExampleIndicators" data-slide-to="<?php echo $index; ?>" class="<?php echo $index === 0 ? 'active' : ''; ?>"></li>
        <?php endforeach; ?>
    </ol>
    <div class="carousel-inner">
        <?php foreach ($noticiasCarousel as $index => $noticia): ?>
            <div class="carousel-item <?php echo $index === 0 ? 'active' : ''; ?>">
                <img src="<?php echo $noticia['imagenURL']; ?>" class="d-block w-100" alt="<?php echo htmlspecialchars($noticia['titulo']); ?>">
                <div class="carousel-caption d-none d-md-block">
                    <h5><?php echo htmlspecialchars($noticia['titulo']); ?></h5>
                    <p><?php echo substr(htmlspecialchars($noticia['contenido']), 0, 100) . '...'; ?></p>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Anterior</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Siguiente</span>
    </a>
</div>

<!-- Sección de noticias principales (Las más recientes) -->
<div class="container mt-4">
    <h2>Últimas Noticias</h2>
    <div class="row">
        <?php foreach ($ultimasNoticias as $noticia): ?>
            <div class="col-md-4 mb-4">
                <div class="card" style="width: 18rem;">
                    <!-- Aquí cambiamos a imagenURL -->
                    <?php if (!empty($noticia['imagenURL'])): ?>
                        <img src="<?php echo $noticia['imagenURL']; ?>" class="card-img-top" alt="<?php echo htmlspecialchars($noticia['titulo']); ?>">
                    <?php endif; ?>
                    <div class="card-body">
                        <h5 class="card-title"><?php echo htmlspecialchars($noticia['titulo']); ?></h5>
                        <p class="card-text"><?php echo substr(htmlspecialchars($noticia['contenido']), 0, 120) . '...'; ?></p>
                        <a href="noticia.php?id=<?php echo $noticia['noticiaID']; ?>" class="btn btn-primary">Leer más</a>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</div>

<?php include_once 'template/footer.php'; ?>
