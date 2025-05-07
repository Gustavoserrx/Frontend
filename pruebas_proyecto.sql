-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-04-2025 a las 14:06:47
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pruebas_proyecto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_curso`
--

CREATE TABLE `asistencia_curso` (
  `id_asistencia` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `presente` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asistencia_curso`
--

INSERT INTO `asistencia_curso` (`id_asistencia`, `id_curso`, `id_usuario`, `presente`) VALUES
(1, 1, 1, 0),
(2, 1, 2, 0),
(3, 1, 3, 0),
(4, 1, 4, 0),
(5, 1, 6, 0),
(6, 1, 7, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `id_cuenta` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `contraseña` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id_cuenta`, `id_usuario`, `username`, `contraseña`) VALUES
(1, 1, 'Ana', 'anita@hotmail.com'),
(2, 2, 'Carlos', 'carlosteatro'),
(3, 3, 'felipe', 'felipesensei'),
(4, 4, 'Prueba', '$2y$10$PQ0q9H5g8fKxS2EoYbTjOek3T5j/1kaGdZC1dE7uX9MocpL5KWJv6'),
(6, 6, 'Prueba2', '$2y$12$5anmNIbuUPRevyTcEQwh2.TPdYwbmjtadaA9FaiS/l9P7hmnbO4ci'),
(7, 7, 'Nuevo', '$2b$12$JHU5rfObW2QX.w2u9Q7JE.VUw2/.bzFlD9F2wZl6V0h5zXACYoebm');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL,
  `nombre_curso` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `horario` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`id_curso`, `nombre_curso`, `descripcion`, `fecha_inicio`, `fecha_fin`, `horario`) VALUES
(1, 'Curso por Defecto', 'Curso predeterminado para sincronización', '2023-01-01', '2023-12-31', 'Lunes a Viernes, 9:00-12:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `attempt_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `email`, `attempt_time`) VALUES
(1, 'ana@example.com', '2025-04-24 12:46:39'),
(2, 'ana@example.com', '2025-04-24 12:47:15'),
(3, 'ana@example.com', '2025-04-24 12:49:38'),
(4, 'carlos@example.com', '2025-04-24 12:51:27'),
(5, 'carlos@example.com', '2025-04-24 12:53:42'),
(6, 'carlos@example.com', '2025-04-24 12:54:12'),
(7, 'felipe@example.com', '2025-04-24 12:54:38'),
(8, 'felipe@example.com', '2025-04-24 12:58:14'),
(9, 'felipe@example.com', '2025-04-24 12:58:34'),
(10, 'prueba@ejemplo.com', '2025-04-24 12:59:50'),
(11, 'prueba@ejemplo.com', '2025-04-24 13:00:05'),
(12, 'prueba@ejemplo.com', '2025-04-24 13:05:49'),
(13, 'prueba@ejemplo.com', '2025-04-24 13:39:17'),
(14, 'prueba@ejemplo.com', '2025-04-24 13:40:41'),
(15, 'felipe@example.com', '2025-04-24 13:40:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id_pago` int(11) NOT NULL,
  `id_alumno` int(11) NOT NULL,
  `modalidad_pago` int(11) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `estado_pago` enum('pendiente','pagado','vencido') DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id_pago`, `id_alumno`, `modalidad_pago`, `precio`, `fecha_pago`, `estado_pago`) VALUES
(1, 1, NULL, 0.00, NULL, 'pendiente'),
(2, 2, NULL, 0.00, NULL, 'pendiente'),
(3, 3, NULL, 0.00, NULL, 'pendiente'),
(4, 4, NULL, 0.00, NULL, 'pendiente'),
(5, 6, NULL, 0.00, NULL, 'pendiente'),
(6, 7, NULL, 0.00, NULL, 'pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `rol` enum('alumno','profesor','administrador') NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `apellido`, `email`, `contraseña`, `rol`, `fecha_creacion`) VALUES
(1, 'Ana', 'Martinez', 'ana@example.com', 'anita@hotmail.com', 'administrador', '2025-04-03 12:59:47'),
(2, 'Carlos', 'Garcia', 'carlos@example.com', 'carlosteatro', 'profesor', '2025-04-03 12:59:47'),
(3, 'felipe', 'Fernandez', 'felipe@example.com', 'felipesensei', 'alumno', '2025-04-03 12:59:47'),
(4, 'Prueba', 'Usuario', 'prueba@ejemplo.com', '$2y$10$PQ0q9H5g8fKxS2EoYbTjOek3T5j/1kaGdZC1dE7uX9MocpL5KWJv6', 'alumno', '2025-04-24 10:59:37'),
(6, 'Prueba2', 'Usuario', 'prueba2@ejemplo.com', '$2y$12$5anmNIbuUPRevyTcEQwh2.TPdYwbmjtadaA9FaiS/l9P7hmnbO4ci', 'administrador', '2025-04-24 11:03:15'),
(7, 'Nuevo', 'Usuario2', 'usuario2@ejemplo.com', '$2b$12$JHU5rfObW2QX.w2u9Q7JE.VUw2/.bzFlD9F2wZl6V0h5zXACYoebm', 'alumno', '2025-04-24 11:42:50');

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `after_usuario_insert` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO CUENTAS (id_usuario, username, contraseña)
    VALUES (NEW.id_usuario, NEW.nombre, NEW.contraseña);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_usuario_insert_asistencia` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    -- Supongamos que se asocia inicialmente a un curso por defecto (ej. id_curso = 1)
    INSERT INTO ASISTENCIA_CURSO (id_curso, id_usuario, presente)
    VALUES (1, NEW.id_usuario, FALSE);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_usuario_insert_pago` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO PAGOS (id_alumno, modalidad_pago, precio, fecha_pago, estado_pago)
    VALUES (NEW.id_usuario, NULL, 0, NULL, 'pendiente');
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asistencia_curso`
--
ALTER TABLE `asistencia_curso`
  ADD PRIMARY KEY (`id_asistencia`),
  ADD KEY `fk_asistencia_curso` (`id_curso`),
  ADD KEY `fk_asistencia_usuario` (`id_usuario`);

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`id_cuenta`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `cuentas_ibfk_1` (`id_usuario`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id_curso`);

--
-- Indices de la tabla `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`),
  ADD KEY `attempt_time` (`attempt_time`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `fk_pagos_alumno` (`id_alumno`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencia_curso`
--
ALTER TABLE `asistencia_curso`
  MODIFY `id_asistencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id_cuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asistencia_curso`
--
ALTER TABLE `asistencia_curso`
  ADD CONSTRAINT `fk_asistencia_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_asistencia_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD CONSTRAINT `cuentas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `fk_pagos_alumno` FOREIGN KEY (`id_alumno`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
