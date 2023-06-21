-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-06-2023 a las 06:53:34
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `nima_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `boton`
--

CREATE TABLE `boton` (
  `id_boton` int(11) NOT NULL,
  `imagen` varchar(250) NOT NULL,
  `descripcion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `boton`
--

INSERT INTO `boton` (`id_boton`, `imagen`, `descripcion`) VALUES
(1, 'blanco 1', 'blanco 1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuello`
--

CREATE TABLE `cuello` (
  `id_cuello` int(11) NOT NULL,
  `imagen` varchar(250) NOT NULL,
  `descripcion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuello`
--

INSERT INTO `cuello` (`id_cuello`, `imagen`, `descripcion`) VALUES
(1, 'cuello 1', 'cuello 1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuerpo`
--

CREATE TABLE `cuerpo` (
  `id_cuerpo` int(11) NOT NULL,
  `imagen` varchar(250) NOT NULL,
  `descripcion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuerpo`
--

INSERT INTO `cuerpo` (`id_cuerpo`, `imagen`, `descripcion`) VALUES
(1, 'cuerpo 1', 'cuerpo 1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `manga`
--

CREATE TABLE `manga` (
  `id_manga` int(11) NOT NULL,
  `imagen` varchar(250) NOT NULL,
  `descripcion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `manga`
--

INSERT INTO `manga` (`id_manga`, `imagen`, `descripcion`) VALUES
(1, 'manga 1', 'manga 1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `direccion` varchar(250) NOT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `imagen` varchar(250) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `id_boton` int(11) NOT NULL,
  `id_tela` int(11) NOT NULL,
  `id_cuerpo` int(11) NOT NULL,
  `id_cuello` int(11) NOT NULL,
  `id_manga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `imagen`, `descripcion`, `id_boton`, `id_tela`, `id_cuerpo`, `id_cuello`, `id_manga`) VALUES
(1, '1111', 'Blusa de escote grande...', 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tela`
--

CREATE TABLE `tela` (
  `id_tela` int(11) NOT NULL,
  `imagen` varchar(250) NOT NULL,
  `descripcion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tela`
--

INSERT INTO `tela` (`id_tela`, `imagen`, `descripcion`) VALUES
(1, 'crepe-arena', 'crepe-arena');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `boton`
--
ALTER TABLE `boton`
  ADD PRIMARY KEY (`id_boton`);

--
-- Indices de la tabla `cuello`
--
ALTER TABLE `cuello`
  ADD PRIMARY KEY (`id_cuello`);

--
-- Indices de la tabla `cuerpo`
--
ALTER TABLE `cuerpo`
  ADD PRIMARY KEY (`id_cuerpo`);

--
-- Indices de la tabla `manga`
--
ALTER TABLE `manga`
  ADD PRIMARY KEY (`id_manga`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `Refboton2` (`id_boton`),
  ADD KEY `Reftela3` (`id_tela`),
  ADD KEY `Refcuello4` (`id_cuello`),
  ADD KEY `Refcuerpo5` (`id_cuerpo`),
  ADD KEY `Refmanga6` (`id_manga`);

--
-- Indices de la tabla `tela`
--
ALTER TABLE `tela`
  ADD PRIMARY KEY (`id_tela`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `boton`
--
ALTER TABLE `boton`
  MODIFY `id_boton` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cuello`
--
ALTER TABLE `cuello`
  MODIFY `id_cuello` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cuerpo`
--
ALTER TABLE `cuerpo`
  MODIFY `id_cuerpo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `manga`
--
ALTER TABLE `manga`
  MODIFY `id_manga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tela`
--
ALTER TABLE `tela`
  MODIFY `id_tela` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `Refboton2` FOREIGN KEY (`id_boton`) REFERENCES `boton` (`id_boton`),
  ADD CONSTRAINT `Refcuello4` FOREIGN KEY (`id_cuello`) REFERENCES `cuello` (`id_cuello`),
  ADD CONSTRAINT `Refcuerpo5` FOREIGN KEY (`id_cuerpo`) REFERENCES `cuerpo` (`id_cuerpo`),
  ADD CONSTRAINT `Refmanga6` FOREIGN KEY (`id_manga`) REFERENCES `manga` (`id_manga`),
  ADD CONSTRAINT `Reftela3` FOREIGN KEY (`id_tela`) REFERENCES `tela` (`id_tela`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
