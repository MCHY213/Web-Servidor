DROP SCHEMA IF EXISTS FideNews;
DROP USER IF EXISTS admin01;

CREATE DATABASE FideNews;

USE FideNews;

CREATE USER 'admin01'@'%' IDENTIFIED BY '12345';

GRANT ALL PRIVILEGES ON FideNews.* TO 'admin01'@'%';
FLUSH PRIVILEGES;

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    userID INT PRIMARY KEY,
    nombre VARCHAR(255),
    correo VARCHAR(255) UNIQUE,
    password VARCHAR(255) NOT NULL,
    preferenciasCorreo BOOLEAN,
    imagenURL VARCHAR(255)
)ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4;

-- Crear la tabla Tema
CREATE TABLE Tema (
    temaID INT PRIMARY KEY,
    nombre VARCHAR(255)
)ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4;

-- Crear la tabla Noticia
CREATE TABLE Noticia (
    noticiaID INT PRIMARY KEY,
    titulo VARCHAR(255),
    contenido TEXT,
    fechaPublicacion DATE,
    visitas INT DEFAULT 0,
    maxCalificacion INT,
    temaID INT,
    imagenURL VARCHAR(255),
    FOREIGN KEY (temaID) REFERENCES Tema(temaID)
)ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4;

-- Crear la tabla Subtema
CREATE TABLE Subtema (
    subtemaID INT PRIMARY KEY,
    nombre VARCHAR(255),
    temaID INT,
    FOREIGN KEY (temaID) REFERENCES Tema(temaID)
)ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4;

-- Crear la tabla Calificacion
CREATE TABLE Calificacion (
    calificacionID INT PRIMARY KEY,
    estrellas INT,
    fechaCalificacion DATE,
    usuarioID INT,
    noticiaID INT,
    FOREIGN KEY (usuarioID) REFERENCES Usuario(userID),
    FOREIGN KEY (noticiaID) REFERENCES Noticia(noticiaID)
)ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4;

-- Crear la tabla Comentario
CREATE TABLE Comentario (
    comentarioID INT PRIMARY KEY,
    texto TEXT,
    fechaComentario DATE,
    usuarioID INT,
    noticiaID INT,
    FOREIGN KEY (usuarioID) REFERENCES Usuario(userID),
    FOREIGN KEY (noticiaID) REFERENCES Noticia(noticiaID)
)ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4;

-- Crear la tabla EnvioCorreo
CREATE TABLE EnvioCorreo (
    envioCorreoID INT PRIMARY KEY,
    fechaEnvio DATE,
    usuarioID INT,
    noticiaID INT,
    FOREIGN KEY (usuarioID) REFERENCES Usuario(userID),
    FOREIGN KEY (noticiaID) REFERENCES Noticia(noticiaID)
)ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4;

INSERT INTO Usuario (userID, nombre, correo, password, preferenciasCorreo, imagenURL) VALUES
(1, 'Elena Nito', 'elena.nito@example.com', '$2y$10$kqO5xljwaccJbDiASRhRpe7Sh6NfRJZ9S6PyMGah..7wOhYCqHDC2', TRUE, 'https://i.pinimg.com/564x/86/6b/7b/866b7bd1c2a18c2cb02a003ef920765e.jpg'),
(2, 'Armando Casas', 'armando.casas@example.com', '$2y$10$Y39d6P.twij0GRUAuIQ.wuLgZ8rZqTD2NtObBxbvPSt2tn3GmgFeK', FALSE, 'https://i.pinimg.com/564x/4b/cc/54/4bcc54ebe6d0e6700e3df3047c1129c8.jpg'),
(3, 'Susana Oria', 'susana.oria@example.com', '$2y$10$JsjnuzwsCnnux5fx5yiake.io6wTSSRvusfnKVRonOJcTziql06TC', TRUE, 'https://i.pinimg.com/564x/65/bf/a3/65bfa31c1e5ae3b53e438f900e4242ed.jpg'),
(4, 'Esteban Dido', 'esteban.dido@example.com', '$2y$10$mzNdzOlzSoRpdvqoeSt0c.Daqsgsu0Sf0zieMKzazYGFEqaaTigNq', FALSE, 'https://i.pinimg.com/564x/0b/77/77/0b7777ae8de596d4095567f23d0a8b33.jpg'),
(5, 'Rosa Melano', 'rosa.melano@example.com', '$2y$10$w3JaqjPlrfds6U6HltHZ1uRm9FOOSKZhdVnTjg6dEpTvwBHp61iF2', TRUE, 'https://i.pinimg.com/564x/cf/6e/c4/cf6ec445df41899479978aa16f05c996.jpg');

INSERT INTO Tema (temaID, nombre) VALUES
(1, 'Tecnología'),
(2, 'Deportes'),
(3, 'Cultura'),
(4, 'Economía'),
(5, 'Salud');

INSERT INTO Noticia (noticiaID, titulo, contenido, fechaPublicacion, visitas, maxCalificacion, temaID, imagenURL) VALUES
(1, 'Nueva tecnología en IA', 'Contenido sobre IA...', '2024-03-01', 150, 5, 1, 'https://miro.medium.com/v2/resize:fit:4800/format:webp/1*udao2MVrXnm2Ig56I5iMwg.jpeg'),
(2, 'Resultados de la liga', 'Contenido sobre fútbol...', '2024-03-02', 200, 5, 2, 'https://i.pinimg.com/564x/ee/e4/23/eee42326466b4ceedb6fcd9bd262e8a9.jpg'),
(3, 'Exposición de arte moderno', 'Contenido sobre arte...', '2024-03-03', 90, 4, 3, 'https://i.pinimg.com/564x/99/4d/1c/994d1c285c00ba7b1359a7edb8312af9.jpg'),
(4, 'Innovaciones en salud', 'Contenido sobre salud...', '2024-03-04', 120, 5, 5, 'https://i.pinimg.com/564x/f8/1f/3b/f81f3b5246c06463d939d34f9ec0c3f8.jpg'),
(5, 'El mercado de criptomonedas', 'Contenido sobre economía...', '2024-03-05', 300, 5, 4, 'https://i.pinimg.com/564x/b1/bb/5f/b1bb5f1e92597548bb46386fa9e9f06f.jpg'),
(6, 'Realidad virtual en la educación', 'Contenido sobre tecnología y educación...', '2024-03-06', 180, 5, 1, 'https://i.pinimg.com/564x/82/79/3b/82793b6390c8f4a6c511e9d56ebf6081.jpg'),
(7, 'Tendencias fitness 2024', 'Contenido sobre salud y ejercicio...', '2024-03-07', 60, 4, 5, 'https://i.pinimg.com/564x/0f/35/2e/0f352e35287c362a0a243b0e86fd38ee.jpg'),
(8, 'Novedades en el mundo del tenis', 'Contenido sobre tenis...', '2024-03-08', 140, 5, 2, 'https://i.pinimg.com/564x/0c/d8/03/0cd8030c81b105b47181a51bf6e9ad1a.jpg'),
(9, 'Festival de cine europeo', 'Contenido sobre cine...', '2024-03-09', 85, 4, 3, 'https://i.pinimg.com/564x/00/81/b6/0081b6169b11a806603d770b179f974a.jpg'),
(10, 'Avances en energías renovables', 'Contenido sobre tecnología y medio ambiente...', '2024-03-10', 220, 5, 1, 'https://i.pinimg.com/564x/67/de/e8/67dee8ef3e5a3092f27a19bd170c9d8b.jpg');

INSERT INTO Subtema (subtemaID, nombre, temaID) VALUES
(1, 'Robótica', 1),
(2, 'Fútbol', 2),
(3, 'Pintura', 3),
(4, 'Criptomonedas', 4),
(5, 'Nutrición', 5);

INSERT INTO Calificacion (calificacionID, estrellas, fechaCalificacion, usuarioID, noticiaID) VALUES
(1, 5, '2024-03-02', 1, 1),
(2, 4, '2024-03-03', 2, 2),
(3, 3, '2024-03-04', 3, 3),
(4, 5, '2024-03-05', 4, 4),
(5, 4, '2024-03-06', 5, 5),
(6, 5, '2024-03-07', 1, 6),
(7, 3, '2024-03-08', 2, 7),
(8, 5, '2024-03-09', 3, 8),
(9, 4, '2024-03-10', 4, 9),
(10, 5, '2024-03-11', 5, 10);

INSERT INTO Comentario (comentarioID, texto, fechaComentario, usuarioID, noticiaID) VALUES
(1, 'Muy interesante el avance en IA.', '2024-03-02', 1, 1),
(2, 'Impresionante resultado en la liga.', '2024-03-03', 2, 2),
(3, 'La exposición de arte promete mucho.', '2024-03-04', 3, 3),
(4, 'Excelentes consejos de salud.', '2024-03-05', 4, 4),
(5, 'El mercado de criptomonedas siempre sorprende.', '2024-03-06', 5, 5),
(6, 'La realidad virtual cambiará la educación.', '2024-03-07', 1, 6),
(7, 'Muy buen artículo sobre fitness.', '2024-03-08', 2, 7),
(8, 'El tenis nunca deja de evolucionar.', '2024-03-09', 3, 8),
(9, 'El cine europeo tiene joyas ocultas.', '2024-03-10', 4, 9),
(10, 'Las energías renovables son el futuro.', '2024-03-11', 5, 10);

INSERT INTO EnvioCorreo (envioCorreoID, fechaEnvio, usuarioID, noticiaID) VALUES
(1, '2024-03-12', 1, 1),
(2, '2024-03-13', 2, 2),
(3, '2024-03-14', 3, 3),
(4, '2024-03-15', 4, 4),
(5, '2024-03-16', 5, 5);