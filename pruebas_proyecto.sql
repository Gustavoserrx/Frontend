-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 08-05-2025 a las 22:29:05
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
(13, 1, 25, 0),
(14, 1, 26, 0),
(15, 1, 27, 0);

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
(17, 25, 'Antonio', '$2y$10$CBlMJiOquK31dkzQjyY/N.5wX11ylFWByauxzfjK8Q9QfwE5vA6QW'),
(18, 26, 'Paco', '$2y$10$OE8CI9NGIEyoYFBkFVxPbeqmhOnSrJ6o/Sc7qVWeGsrn3L8uww21e'),
(19, 27, 'Compadre', '$2y$10$3wRcFxrgiWPpH9fFUY5kpuTqVTVW3Ow/VK12pUwV2zO5UM85vTTUC');

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
(15, 'felipe@example.com', '2025-04-24 13:40:50'),
(16, 'sisia@gmail.com', '2025-04-29 11:12:51'),
(17, 'sisia@gmail.com', '2025-04-29 11:12:58'),
(18, 'sisia@gmail.com', '2025-04-29 11:13:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id_mensaje` int(11) NOT NULL,
  `id_emisor` int(11) NOT NULL,
  `id_receptor` int(11) NOT NULL,
  `contenido` longtext NOT NULL,
  `fecha_envío` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(16, 25, NULL, 0.00, NULL, 'pendiente'),
(17, 26, NULL, 0.00, NULL, 'pendiente'),
(18, 27, NULL, 0.00, NULL, 'pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_stripe`
--

CREATE TABLE `pagos_stripe` (
  `session_id` varchar(255) NOT NULL,
  `estado` varchar(30) NOT NULL,
  `payment_intent_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pagos_stripe`
--

INSERT INTO `pagos_stripe` (`session_id`, `estado`, `payment_intent_id`) VALUES
('cs_test_a14JD9RkE8LNR9FYm6X0QPaKC6mn1DwmCK8Xs8KLCp1qyHlXFGQlmT4nhQ', 'exito', 'pi_3RM2f3RSAITdUuT7116hOB2b'),
('cs_test_a19igBFQOkDp6Xmma3jRfloGufongO7gMz8QHAztjiAQKQ2SZP4nwuD3wp', 'fallido', 'pi_3RMWSwRSAITdUuT71MGaCfBS'),
('cs_test_a1p1IdvSFcnCZxrFDtausPq1sN8rziudrimU2HTDEcCF10X9HVSUhY8bCc', 'fallido', 'pi_3RMWS3RSAITdUuT71wPMS1nY'),
('cs_test_a1v56wNkozEyySlf9wB9MUxTxrZv4ejEGqoFjGCeu0HPcCPBsQQmvlSo0N', 'exito', 'pi_3RMWWyRSAITdUuT70vkFOTgw'),
('cs_test_a1V6lbozjxGd3NdTntAAKZvyA2A5fo16Zo9eyArfUqzYrFGaVCVkajdnyF', 'fallido', 'pi_3RMWViRSAITdUuT71BLYc4Xg');

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
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `pago_inicial` bit(1) DEFAULT b'0',
  `Grupo` tinyint(4) DEFAULT NULL,
  `stripe_id` varchar(70) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `apellido`, `email`, `contraseña`, `rol`, `fecha_creacion`, `pago_inicial`, `Grupo`, `stripe_id`) VALUES
(25, 'Antonio', 'Prueba Uno', 'antonio@gmail.com', '$2y$10$CBlMJiOquK31dkzQjyY/N.5wX11ylFWByauxzfjK8Q9QfwE5vA6QW', 'alumno', '2025-05-07 07:16:02', b'0', 4, 'cus_SGZOUwkwSktRgP'),
(26, 'Paco', 'Prueba Usuario', 'pacoprueba@gmail.com', '$2y$10$OE8CI9NGIEyoYFBkFVxPbeqmhOnSrJ6o/Sc7qVWeGsrn3L8uww21e', 'alumno', '2025-05-07 07:42:02', b'0', 5, 'cus_SGZoTbNqyVd1mV'),
(27, 'Compadre', 'Compra Coco', 'compadre@gmail.com', '$2y$10$3wRcFxrgiWPpH9fFUY5kpuTqVTVW3Ow/VK12pUwV2zO5UM85vTTUC', 'alumno', '2025-05-08 15:32:55', b'0', 5, 'cus_SH4g7ciLg0WRWr');

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `after_usuario_insert` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO cuentas (id_usuario, username, contraseña)
    VALUES (NEW.id_usuario, NEW.nombre, NEW.contraseña);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_usuario_insert_asistencia` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    -- Supongamos que se asocia inicialmente a un curso por defecto (ej. id_curso = 1)
    INSERT INTO asistencia_curso (id_curso, id_usuario, presente)
    VALUES (1, NEW.id_usuario, FALSE);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_usuario_insert_pago` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO pagos (id_alumno, modalidad_pago, precio, fecha_pago, estado_pago)
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
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id_mensaje`),
  ADD KEY `id_emisor` (`id_emisor`),
  ADD KEY `id_receptor` (`id_receptor`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `fk_pagos_alumno` (`id_alumno`);

--
-- Indices de la tabla `pagos_stripe`
--
ALTER TABLE `pagos_stripe`
  ADD PRIMARY KEY (`session_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nombre_apellido_unico` (`nombre`,`apellido`),
  ADD UNIQUE KEY `stripe_id` (`stripe_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencia_curso`
--
ALTER TABLE `asistencia_curso`
  MODIFY `id_asistencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id_cuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id_mensaje` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

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
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`id_emisor`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`id_receptor`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `fk_pagos_alumno` FOREIGN KEY (`id_alumno`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
