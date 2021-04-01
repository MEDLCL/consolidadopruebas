-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3307
-- Tiempo de generación: 01-04-2021 a las 22:12:28
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `almacen`
--
CREATE DATABASE IF NOT EXISTS `almacen` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `almacen`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(4, 'prueba'),
(1, 'Repuestos'),
(2, 'Tornillos'),
(3, 'Tuercas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `media`
--

CREATE TABLE `media` (
  `id` int(11) UNSIGNED NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `media`
--

INSERT INTO `media` (`id`, `file_name`, `file_type`) VALUES
(1, 'filter.jpg', 'image/jpeg'),
(2, 'tornillo1.jpg', 'image/jpeg'),
(3, 'tornillo2.jpg', 'image/jpeg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `partNo` varchar(60) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `buy_price` decimal(25,2) DEFAULT NULL,
  `sale_price` decimal(25,2) NOT NULL,
  `categorie_id` int(10) UNSIGNED NOT NULL,
  `location` varchar(255) NOT NULL,
  `media_id` int(11) DEFAULT 0,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `name`, `partNo`, `quantity`, `buy_price`, `sale_price`, `categorie_id`, `location`, `media_id`, `date`) VALUES
(1, 'Filtro de gasolina', 'FILT_AB0F01', 101, '5.00', '10.00', 1, 'X1', 1, '2017-06-16 07:03:16'),
(2, 'Tornillo hexagonal 10mm x 50mm', 'TOR_HEX_001', 80, NULL, '0.00', 2, 'A1', 2, '2019-03-01 07:03:16'),
(3, 'Tornillo hexagonal 8mm x 45mm', 'TOR_HEX_002', 90, NULL, '0.00', 2, 'A2', 2, '2019-03-01 07:03:16'),
(4, 'Tornillo hexagonal 8mm x 60mm', 'TOR_HEX_003', 100, NULL, '0.00', 2, 'X2', 2, '2019-03-01 07:03:16'),
(5, 'Tornillo Phillips1 70mm', 'TOR_PHI_170', 100, NULL, '0.00', 2, 'A1', 3, '2019-03-02 07:05:23'),
(6, 'Tornillo Phillips1 80mm', 'TOR_PHI_180', 100, NULL, '0.00', 2, 'A2', 3, '2019-03-02 07:05:34'),
(7, 'Tornillo Phillips1 90mm', 'TOR_PHI_190', 100, NULL, '0.00', 2, 'X2', 3, '2019-03-02 07:06:02'),
(8, 'Tornillo Phillips2 70mm', 'TOR_PHI_270', 100, NULL, '0.00', 2, 'X4', 3, '2019-03-02 07:06:10'),
(9, 'Tornillo Phillips2 80mm', 'TOR_PHI_280', 100, NULL, '0.00', 2, 'X4', 3, '2019-03-02 07:06:15'),
(10, 'Tornillo Phillips2 90mm', 'TOR_PHI_290', 100, NULL, '0.00', 2, 'X4', 3, '2019-03-02 07:06:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales`
--

CREATE TABLE `sales` (
  `id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(25,2) NOT NULL,
  `destination` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sales`
--

INSERT INTO `sales` (`id`, `product_id`, `qty`, `price`, `destination`, `date`) VALUES
(1, 2, 10, '0.00', 'Patio de almacenaje Nro1', '2019-02-05 07:00:10'),
(2, 3, 10, '0.00', 'Patio de almacenaje Nro1', '2019-02-05 07:01:05'),
(3, 7, 10, '0.00', 'Patio de almacenaje Nro2', '2019-02-06 07:01:12'),
(4, 7, 10, '0.00', 'Patio de almacenaje Nro2', '2019-03-01 07:01:05'),
(5, 7, 5, '0.00', 'Patio de almacenaje Nro2', '2019-03-01 07:01:05'),
(6, 8, 10, '0.00', 'Patio de almacenaje Nro1', '2019-03-02 07:01:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_level` int(11) NOT NULL,
  `image` varchar(255) DEFAULT 'no_image.jpg',
  `status` int(1) NOT NULL,
  `last_login` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `user_level`, `image`, `status`, `last_login`) VALUES
(1, 'Admin Users', 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 1, 'pzg9wa7o1.jpg', 1, '2021-02-28 02:48:35'),
(2, 'Special User', 'special', 'ba36b97a41e7faf742ab09bf88405ac04f99599a', 2, 'no_image.jpg', 1, '2017-06-16 07:11:26'),
(3, 'Default User', 'user', '12dea96fec20593566ab75692c9949596833adc9', 3, 'no_image.jpg', 1, '2017-06-16 07:11:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_groups`
--

CREATE TABLE `user_groups` (
  `id` int(11) NOT NULL,
  `group_name` varchar(150) NOT NULL,
  `group_level` int(11) NOT NULL,
  `group_status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `user_groups`
--

INSERT INTO `user_groups` (`id`, `group_name`, `group_level`, `group_status`) VALUES
(1, 'Admin', 1, 1),
(2, 'Special', 2, 0),
(3, 'User', 3, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `partNo` (`partNo`),
  ADD KEY `categorie_id` (`categorie_id`),
  ADD KEY `media_id` (`media_id`);

--
-- Indices de la tabla `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `user_level` (`user_level`);

--
-- Indices de la tabla `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_level` (`group_level`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `media`
--
ALTER TABLE `media`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `FK_products` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `SK` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_user` FOREIGN KEY (`user_level`) REFERENCES `user_groups` (`group_level`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de datos: `almadisa`
--
CREATE DATABASE IF NOT EXISTS `almadisa` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `almadisa`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacen`
--

CREATE TABLE `almacen` (
  `id_almacen` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_consignado` int(11) NOT NULL,
  `codigo` varchar(25) NOT NULL,
  `contenedor_placa` varchar(50) NOT NULL,
  `poliza` varchar(50) NOT NULL,
  `referencia` varchar(50) NOT NULL,
  `peso` float NOT NULL,
  `id_medida_peso` int(11) DEFAULT NULL,
  `volumen` float NOT NULL,
  `id_medida_volumen` int(11) DEFAULT NULL,
  `bultos` int(11) NOT NULL,
  `cant_clientes` int(11) NOT NULL,
  `fecha_almacen` date DEFAULT NULL,
  `fecha_graba` date NOT NULL,
  `id_usuario_modifica` int(11) DEFAULT NULL,
  `fecha_modifica` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `almacen`
--

INSERT INTO `almacen` (`id_almacen`, `id_usuario`, `id_sucursal`, `id_consignado`, `codigo`, `contenedor_placa`, `poliza`, `referencia`, `peso`, `id_medida_peso`, `volumen`, `id_medida_volumen`, `bultos`, `cant_clientes`, `fecha_almacen`, `fecha_graba`, `id_usuario_modifica`, `fecha_modifica`) VALUES
(1, 52, 27, 64, '03.31.21', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(2, 52, 27, 64, '03.32.21', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(3, 52, 27, 64, '', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(4, 52, 27, 64, '', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(5, 52, 27, 64, '', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(6, 52, 27, 64, '', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(7, 52, 27, 64, '', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '2021-03-03', '2021-03-14', 52, 2021),
(8, 52, 27, 64, '', 'CONTENEDOR', 'poliza', 'REFERENCIA', 1, NULL, 1, NULL, 1, 0, '2021-03-16', '2021-03-16', 52, 2021),
(9, 52, 27, 64, '', 'ASDF', 'asdf33', '12312', 1, NULL, 1, NULL, 1, 0, '2021-03-18', '2021-03-16', 52, 2021),
(10, 52, 27, 64, '03.42.21', 'ASDFASDFSADF', 'asd', 'ASD', 1, NULL, 1, NULL, 1, 0, '2021-03-24', '2021-03-16', 52, 2021),
(11, 52, 27, 64, '03.43.21', 'ASDF', 'asdf', 'ASDF33234', 2, NULL, 2, NULL, 2, 3, '2021-03-30', '2021-03-18', 52, 2021),
(12, 52, 27, 64, '03.44.21', 'PRUEBA', 'asdf', 'ASDF', 2, NULL, 3, NULL, 3, 3, '2021-03-16', '2021-03-18', 52, 2021),
(13, 52, 27, 64, '03.45.21', 'ASDF', 'asdfasdf', 'ASDF', 1, NULL, 1, NULL, 1, 3, '2021-03-17', '2021-03-18', 52, 2021),
(14, 52, 27, 64, '03.46.21', 'PLACA DE PRUEBA123', 'poliza de prueba', 'REFERENCIA DE PRUEBA', 12, NULL, 23, NULL, 12, 12, '2021-04-02', '2021-03-18', 52, 2021),
(15, 52, 27, 64, '03.47.21', 'PLACA DE PRUEBA CAMBIO', 'poliza de prueba cambio', 'REFERENCIA DE PRUEBA CAMBIO', 10, NULL, 10, NULL, 10, 10, '2021-03-30', '2021-03-20', 52, 2021);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asigna_menu`
--

CREATE TABLE `asigna_menu` (
  `idasigna_menu` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `asigna_menu`
--

INSERT INTO `asigna_menu` (`idasigna_menu`, `id_usuario`, `id_menu`) VALUES
(55, 55, 8),
(56, 55, 9),
(57, 55, 10),
(61, 53, 1),
(83, 56, 1),
(84, 56, 6),
(85, 56, 7),
(86, 56, 9),
(87, 56, 10),
(88, 57, 1),
(89, 57, 6),
(90, 57, 7),
(91, 57, 8),
(92, 57, 9),
(103, 52, 1),
(104, 52, 6),
(105, 52, 7),
(106, 52, 8),
(107, 52, 9),
(108, 52, 10),
(109, 52, 12),
(110, 52, 13),
(111, 52, 14),
(112, 52, 19),
(113, 52, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asigna_moneda`
--

CREATE TABLE `asigna_moneda` (
  `id_asigna_moneda` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_moneda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `asigna_moneda`
--

INSERT INTO `asigna_moneda` (`id_asigna_moneda`, `id_sucursal`, `id_moneda`) VALUES
(1, 27, 1),
(2, 27, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos_e`
--

CREATE TABLE `contactos_e` (
  `id_contacto` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `apellido` varchar(75) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `puesto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `contactos_e`
--

INSERT INTO `contactos_e` (`id_contacto`, `id_empresa`, `nombre`, `apellido`, `correo`, `telefono`, `puesto`) VALUES
(18, 32, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros'),
(19, 33, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros'),
(20, 34, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros'),
(21, 35, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros'),
(22, 36, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros'),
(23, 37, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `continente`
--

CREATE TABLE `continente` (
  `idcontinente` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `continente`
--

INSERT INTO `continente` (`idcontinente`, `nombre`) VALUES
(1, 'Africa'),
(2, 'America'),
(3, 'Asia'),
(4, 'Asia-Europa'),
(5, 'Europa'),
(6, 'Europa-Asia'),
(7, 'O. Atlantico'),
(8, 'Oceania');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correlativo_almacen`
--

CREATE TABLE `correlativo_almacen` (
  `idcorrelativo` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `annio` int(11) NOT NULL,
  `contador` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `correlativo_almacen`
--

INSERT INTO `correlativo_almacen` (`idcorrelativo`, `mes`, `annio`, `contador`, `id_sucursal`) VALUES
(20, 3, 21, 1, 27),
(21, 3, 21, 2, 27),
(22, 3, 21, 3, 27),
(23, 3, 21, 4, 27),
(24, 3, 21, 5, 27),
(25, 3, 21, 6, 27),
(26, 3, 21, 7, 27),
(27, 3, 21, 8, 27),
(28, 3, 21, 9, 27),
(29, 3, 21, 10, 27),
(30, 3, 21, 11, 27),
(31, 3, 21, 12, 27),
(32, 3, 21, 13, 27),
(33, 3, 21, 14, 27),
(34, 3, 21, 15, 27),
(35, 3, 21, 16, 27),
(36, 3, 21, 17, 27),
(37, 3, 21, 18, 27),
(38, 3, 21, 19, 27),
(39, 3, 21, 20, 27),
(40, 3, 21, 21, 27),
(41, 3, 21, 22, 27),
(42, 3, 21, 23, 27),
(43, 3, 21, 24, 27),
(44, 3, 21, 25, 27),
(45, 3, 21, 26, 27),
(46, 3, 21, 27, 27),
(47, 3, 21, 28, 27),
(48, 3, 21, 29, 27),
(49, 3, 21, 30, 27),
(50, 3, 21, 31, 27),
(51, 3, 21, 32, 27),
(52, 3, 21, 33, 27),
(53, 3, 21, 34, 27),
(54, 3, 21, 35, 27),
(55, 3, 21, 36, 27),
(56, 3, 21, 37, 27),
(57, 3, 21, 38, 27),
(58, 3, 21, 39, 27),
(59, 3, 21, 40, 27),
(60, 3, 21, 41, 27),
(61, 3, 21, 42, 27),
(62, 3, 21, 43, 27),
(63, 3, 21, 44, 27),
(64, 3, 21, 45, 27),
(65, 3, 21, 46, 27),
(66, 3, 21, 47, 27),
(67, 3, 21, 48, 27),
(68, 3, 21, 49, 27),
(69, 3, 21, 50, 27),
(70, 3, 21, 51, 27),
(71, 3, 21, 52, 27),
(72, 3, 21, 53, 27),
(73, 3, 21, 54, 27),
(74, 3, 21, 55, 27),
(75, 3, 21, 56, 27),
(76, 3, 21, 57, 27),
(77, 3, 21, 58, 27),
(78, 3, 21, 59, 27),
(79, 3, 21, 60, 27),
(80, 3, 21, 61, 27),
(81, 3, 21, 62, 27),
(82, 3, 21, 63, 27),
(83, 3, 21, 64, 27),
(84, 3, 21, 65, 27),
(85, 3, 21, 66, 27);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `depto`
--

CREATE TABLE `depto` (
  `id_depto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `depto`
--

INSERT INTO `depto` (`id_depto`, `nombre`) VALUES
(1, 'Administración'),
(2, 'Gerencia'),
(3, 'IT'),
(4, 'Operaciones'),
(5, 'Regional'),
(6, 'Servicio Al Cliente'),
(7, 'Ventas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_almacen`
--

CREATE TABLE `detalle_almacen` (
  `id_detalle` int(11) NOT NULL,
  `id_almacen` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_embalaje` int(11) NOT NULL,
  `peso` float NOT NULL,
  `volumen` float NOT NULL,
  `bultos` int(11) NOT NULL,
  `nohbl` varchar(50) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `ubicacion` varchar(100) NOT NULL,
  `linea` varchar(50) NOT NULL,
  `resa` varchar(50) DEFAULT NULL,
  `dti` varchar(50) DEFAULT NULL,
  `no_cancel` varchar(50) DEFAULT NULL,
  `no_orden` varchar(50) DEFAULT NULL,
  `liberado` tinyint(1) DEFAULT NULL,
  `dut` varchar(50) DEFAULT NULL,
  `mercaderia` varchar(250) NOT NULL,
  `observaciones` varchar(250) NOT NULL,
  `fecha_graba` date NOT NULL,
  `fecha_modificacion` date NOT NULL,
  `id_usuario_modifica` int(11) DEFAULT NULL,
  `bultos_retirados` int(11) DEFAULT NULL,
  `carga_retenida` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_almacen`
--

INSERT INTO `detalle_almacen` (`id_detalle`, `id_almacen`, `id_cliente`, `id_usuario`, `id_embalaje`, `peso`, `volumen`, `bultos`, `nohbl`, `estado`, `ubicacion`, `linea`, `resa`, `dti`, `no_cancel`, `no_orden`, `liberado`, `dut`, `mercaderia`, `observaciones`, `fecha_graba`, `fecha_modificacion`, `id_usuario_modifica`, `bultos_retirados`, `carga_retenida`) VALUES
(1, 14, 65, 52, 1, 2, 2, 3, 'no de hbl2', 0, 'rj 45', 'linea 3', 'resa 12', 'dt 2', 'no cancel 2', 'no de o 3', 1, 'no tiene', 'mercaderia numero 2', 'observaciones 2', '2021-03-21', '2021-03-23', 52, NULL, NULL),
(2, 14, 67, 52, 1, 3, 2, 3, 'hbl 2', 1, 'ubicacion2', 'lineda 3', 'resa 2', 'dti2', 'cancel 2', 'orden 2', 1, 'dut no hay', 'mercaderia 2', 'observaciones 2', '2021-03-23', '2021-03-23', 52, NULL, NULL),
(3, 14, 67, 52, 2, 3, 3, 3, 'hbl3', 0, 'ubicacion3', 'linea 3', 'resa 3', 'dti 3', 'cancel 3', 'order 3', 0, 'dut no hay 3', 'maerca 2', 'observaciones 3', '2021-03-23', '2021-03-23', 52, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empaque`
--

CREATE TABLE `empaque` (
  `id_empaque` int(11) NOT NULL,
  `nombre` varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `empaque`
--

INSERT INTO `empaque` (`id_empaque`, `nombre`) VALUES
(1, 'Cajas'),
(2, 'Cartones');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id_empresa` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `Razons` varchar(150) NOT NULL,
  `Nombrec` varchar(150) NOT NULL,
  `identificacion` varchar(75) NOT NULL,
  `direccion` varchar(1000) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `Tipoe` varchar(25) NOT NULL,
  `codigo` varchar(25) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `porcentaje_comision` float NOT NULL,
  `tipo_comision` varchar(15) NOT NULL,
  `fecha` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id_empresa`, `id_sucursal`, `id_usuario`, `id_pais`, `Razons`, `Nombrec`, `identificacion`, `direccion`, `telefono`, `Tipoe`, `codigo`, `estado`, `porcentaje_comision`, `tipo_comision`, `fecha`) VALUES
(64, 27, 52, 92, 'MANUEL', 'MANUEL', '12332', 'GUATEMALA', '234', 'CO', '1', 1, 1, 'cbm', '2021-03-03'),
(65, 27, 52, 4, 'CLIENTE 1', 'CLIENTE 1', 'asdf', 'ASDF', '123', 'CL', '1', 1, 0, '', '2021-03-13'),
(66, 27, 52, 157, 'SERCOGUA NICARAGUA', 'SERCOGUA NICARAGUA', '12355', 'NICARAGUA', '50523659', 'CO', '2', 1, 0, '', '2021-03-19'),
(67, 27, 52, 92, 'CLIENTE 2', 'CLIENTE 2', '2345689', 'GUATEMALA', '45285945', 'CL', '2', 1, 0, '', '2021-03-22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `id_usuario` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_depto` int(11) NOT NULL,
  `id_puesto` int(11) NOT NULL,
  `acceso` varchar(50) NOT NULL,
  `pass` varchar(150) NOT NULL,
  `avatar` varchar(150) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `apellido` varchar(150) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `estado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`id_usuario`, `id_sucursal`, `id_depto`, `id_puesto`, `acceso`, `pass`, `avatar`, `nombre`, `apellido`, `correo`, `estado`) VALUES
(52, 27, 3, 6, '123456', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1608505306.png', 'Manuel', 'De La Cruz', 'manuelcruz86@gmail.com', 1),
(53, 27, 1, 5, '1234', '1234', '', 'maritza', 'De La Cruz', 'itguatemala@gmail.com', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `id_menu` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `id_Padre` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`id_menu`, `nombre`, `id_Padre`) VALUES
(1, 'Administracion', 0),
(6, 'Sucursales', 1),
(7, 'Usuarios', 1),
(8, 'Registros', 0),
(9, 'Agente Embarcador', 8),
(10, 'Agencia de Carga', 8),
(11, 'Aéreo-linea', 8),
(12, 'Almacenadora', 8),
(13, 'Consignatario', 8),
(14, 'Consignado', 8),
(15, 'Embarcador', 8),
(16, 'Naviera', 8),
(17, 'Proveedor', 8),
(18, 'Transportista', 8),
(19, 'Almacen', 0),
(20, 'Kardex', 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moneda`
--

CREATE TABLE `moneda` (
  `id_moneda` int(11) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `signo` varchar(10) NOT NULL,
  `nombre` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `moneda`
--

INSERT INTO `moneda` (`id_moneda`, `id_pais`, `signo`, `nombre`) VALUES
(1, 92, 'Q.', 'Quetzal'),
(2, 75, '$.', 'Dollar'),
(3, 144, 'MDX.', 'Peso Mexicano'),
(4, 99, 'L.', 'Lempira'),
(5, 157, 'C$.', 'Cordoba'),
(6, 59, '₡.', 'Colon');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE `pais` (
  `idpais` int(11) NOT NULL,
  `idcontinente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `iniciales` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`idpais`, `idcontinente`, `nombre`, `iniciales`) VALUES
(1, 3, '﻿Abjasia', 'ABJ'),
(2, 5, 'Acrotiri y Dhekelia', 'AC'),
(3, 3, 'Afganistan', 'AF'),
(4, 5, 'Albania', 'AL'),
(5, 5, 'Alemania', 'DE'),
(6, 5, 'Andorra', 'AD'),
(7, 1, 'Angola', 'AO'),
(8, 2, 'Anguila', 'AL'),
(9, 2, 'Antigua y Barbuda', 'AG'),
(10, 3, 'Arabia Saudita', 'AS'),
(11, 1, 'Argelia', 'DZ'),
(12, 2, 'Argentina', 'AR'),
(13, 4, 'Armenia', 'AM'),
(14, 2, 'Aruba', 'AW'),
(15, 8, 'Australia', 'AU'),
(16, 5, 'Austria', 'AT'),
(17, 4, 'Azerbaiyan', 'AZ'),
(18, 2, 'Bahamas', 'BS'),
(19, 3, 'Barein', 'BRE'),
(20, 3, 'Banglades', 'BD'),
(21, 2, 'Barbados', 'BB'),
(22, 5, 'Belgica', 'BE'),
(23, 2, 'Belize', 'BZ'),
(24, 1, 'Benín', 'BJ'),
(25, 2, 'Bermudas', 'GB'),
(26, 5, 'Bielorrusia', 'BM'),
(27, 3, 'Birmania', 'MYA'),
(28, 2, 'Bolivia', 'BOL'),
(29, 5, 'Bosnia y Herzegovina', 'BIH'),
(30, 1, 'Botsuana', 'BO'),
(31, 2, 'Brasil', 'BA'),
(32, 3, 'Brunei', 'BRU'),
(33, 5, 'Bulgaria', 'BR'),
(34, 1, 'Burkina Faso', 'BUR'),
(35, 1, 'Burundi', 'BG'),
(36, 3, 'Butan', 'BI'),
(37, 1, 'Cabo Verde', 'CV'),
(38, 2, 'Caiman Islas', 'KY'),
(39, 3, 'Camboya', 'CAM'),
(40, 1, 'Camerún', 'CMR'),
(41, 2, 'Canadá', 'CA'),
(42, 3, 'Catar', 'QAT'),
(43, 1, 'Centroafricana República', 'CAF'),
(44, 1, 'Chad', 'CHA'),
(45, 5, 'Checa República', 'CZE'),
(46, 2, 'Chile', 'CL'),
(47, 3, 'China', 'CHN'),
(48, 4, 'Chipre', 'CY'),
(49, 4, 'Chipre del Norte', 'CYN'),
(50, 3, 'Cocos Islas', 'CC'),
(51, 2, 'Colombia', 'CO'),
(52, 1, 'Comoras', 'COM'),
(53, 1, 'Congo República del', 'CGO'),
(54, 1, 'Congo República Democrática del', 'COD'),
(55, 8, 'Cook Islas', 'CK'),
(56, 3, 'Corea del Norte', 'KP'),
(57, 3, 'Corea del Sur', 'KOR'),
(58, 1, 'Costa de Marfil', 'CIV'),
(59, 2, 'Costa Rica', 'CR'),
(60, 5, 'Croacia', 'CRO'),
(61, 2, 'Cuba', 'CU'),
(62, 2, 'Curazao', 'CW'),
(63, 5, 'Dinamarca', 'DEN'),
(64, 2, 'Dominica', 'DMA'),
(65, 2, 'Dominicana República', 'DOM'),
(66, 2, 'Ecuador', 'EC'),
(67, 1, 'Egipto', 'EG'),
(68, 2, 'El Salvador', 'SV'),
(69, 3, 'Emiratos Árabes Unidos', 'AE'),
(70, 1, 'Eritrea', 'ERI'),
(71, 5, 'Eslovaquia', 'SVK'),
(72, 5, 'Eslovenia', 'SLO'),
(73, 5, 'España', 'ES'),
(74, 3, 'Estado Islámico', 'EIS'),
(75, 2, 'Estados Unidos', 'US'),
(76, 5, 'Estonia', 'EST'),
(77, 1, 'Etiopía', 'ETH'),
(78, 5, 'Feroe Islas', 'FRO'),
(79, 3, 'Filipinas', 'PHI'),
(80, 5, 'Finlandia', 'FIN'),
(81, 8, 'Fiyi', 'FIJ'),
(82, 5, 'Francia', 'FR'),
(83, 1, 'Gabón', 'GAB'),
(84, 1, 'Gambia', 'GAM'),
(85, 4, 'Georgia', 'GEO'),
(86, 1, 'Ghana', 'GHA'),
(87, 5, 'Gibraltar', 'GBZ'),
(88, 2, 'Granada', 'GRN'),
(89, 5, 'Grecia', 'GRE'),
(90, 2, 'Groenlandia', 'GL'),
(91, 8, 'Guam', 'GU'),
(92, 2, 'Guatemala', 'GT'),
(93, 5, 'Guernsey', 'GG'),
(94, 1, 'Guinea', 'GUI'),
(95, 1, 'Guinea-Bisáu', 'GBS'),
(96, 1, 'Guinea Ecuatorial', 'GEQ'),
(97, 2, 'Guyana', 'GUY'),
(98, 2, 'Haití', 'HAI'),
(99, 2, 'Honduras', 'HN'),
(100, 3, 'Hong Kong', 'HK'),
(101, 5, 'Hungría', 'HUN'),
(102, 3, 'India', 'IND'),
(103, 3, 'Indonesia', 'INA'),
(104, 3, 'Irak', 'IRQ'),
(105, 3, 'Irán', 'IRI'),
(106, 5, 'Irlanda', 'IRL'),
(107, 5, 'Islandia', 'ISL'),
(108, 3, 'Israel', 'ISR'),
(109, 5, 'Italia', 'ITA'),
(110, 2, 'Jamaica', 'JAM'),
(111, 3, 'Japón', 'JPN'),
(112, 5, 'Jersey', 'JE'),
(113, 3, 'Jordania', 'JOR'),
(114, 4, 'Kazajistán', 'KAZ'),
(115, 1, 'Kenia', 'KEN'),
(116, 3, 'Kirguistán', 'KGZ'),
(117, 8, 'Kiribati', 'KIR'),
(118, 5, 'Kosovo', 'RKS'),
(119, 3, 'Kuwait', 'KUW'),
(120, 3, 'Laos', 'LAO'),
(121, 1, 'Lesoto', 'LES'),
(122, 5, 'Letonia', 'LV'),
(123, 3, 'Líbano', 'LIB'),
(124, 1, 'Liberia', 'LB'),
(125, 1, 'Libia', 'LBA'),
(126, 5, 'Liechtenstein', 'LIE'),
(127, 5, 'Lituania', 'LTU'),
(128, 5, 'Luxemburgo', 'LUX'),
(129, 3, 'Macao', 'MO'),
(130, 5, 'Macedonia', 'MKD'),
(131, 1, 'Madagascar', 'MAD'),
(132, 3, 'Malasia', 'MAS'),
(133, 1, 'Malaui', 'MAW'),
(134, 3, 'Maldivas', 'MDV'),
(135, 1, 'Malí', 'MLI'),
(136, 5, 'Malta', 'MLT'),
(137, 2, 'Malvinas, Islas', 'MIS'),
(138, 5, 'Man Isla de', 'ISM'),
(139, 8, 'Marianas del Norte Islas', 'NIM'),
(140, 1, 'Marruecos', 'MAR'),
(141, 8, 'Marshall Islas', 'MHL'),
(142, 1, 'Mauricio', 'MRI'),
(143, 1, 'Mauritania', 'MTN'),
(144, 2, 'México', 'MX'),
(145, 8, 'Micronesia', 'MCA'),
(146, 5, 'Moldavia', 'MDA'),
(147, 5, 'Mónaco', 'MON '),
(148, 3, 'Mongolia', 'MGL'),
(149, 5, 'Montenegro', 'MNE'),
(150, 2, 'Montserrat', 'MSR'),
(151, 1, 'Mozambique', 'MOZ'),
(152, 4, 'Nagorno Karabaj', 'NKJ'),
(153, 1, 'Namibia', 'NAM'),
(154, 8, 'Nauru', 'NRU'),
(155, 3, 'Navidad Isla de', 'IDN'),
(156, 3, 'Nepal', 'NEP'),
(157, 2, 'Nicaragua', 'NI'),
(158, 1, 'Níger', 'NIG'),
(159, 1, 'Nigeria', 'NGR'),
(160, 8, 'Niue', 'UN'),
(161, 8, 'Norfolk Isla', 'INK'),
(162, 5, 'Noruega', 'NOR'),
(163, 8, 'Nueva Caledonia', 'NC'),
(164, 5, 'Nueva Rusia', 'NR'),
(165, 8, 'Nueva Zelanda', 'NZL'),
(166, 3, 'Omán', 'OMA'),
(167, 4, 'Osetia del Sur', 'OS'),
(168, 5, 'Países Bajos', 'NED'),
(169, 3, 'Pakistán', 'PAK'),
(170, 8, 'Palaos', 'PL'),
(171, 3, 'Palestina', 'PS'),
(172, 2, 'Panamá', 'PA'),
(173, 8, 'Papúa Nueva Guinea', 'PNG'),
(174, 2, 'Paraguay', 'PY'),
(175, 2, 'Perú', 'PER'),
(176, 8, 'Pitcairn Islas', 'IP'),
(177, 8, 'Polinesia Francesa', 'PF'),
(178, 5, 'Polonia', 'POL'),
(179, 5, 'Portugal', 'POR'),
(180, 2, 'Puerto Rico', 'PR'),
(181, 5, 'Reino Unido', 'RU'),
(182, 1, 'Ruanda', 'RUD'),
(183, 5, 'Rumania', 'RO'),
(184, 6, 'Rusia', 'RUS'),
(185, 1, 'Sahara Occidental', 'SO'),
(186, 8, 'Salomón Islas', 'ISM'),
(187, 8, 'Samoa', 'SAM'),
(188, 8, 'Samoa Americana', 'AS'),
(189, 2, 'San Bartolomé', 'SB'),
(190, 2, 'San Cristóbal y Nieves', 'SCN'),
(191, 5, 'San Marino', 'SM'),
(192, 2, 'San Martín', 'SMN'),
(193, 2, 'Sint Maarten', 'SMT'),
(194, 2, 'San Pedro y Miquelón', 'SPM'),
(195, 2, 'San Vicente y las Granadinas', 'SVG'),
(196, 7, 'Santa Elena  Ascensión y Tristán de Acuña', 'SET'),
(197, 2, 'Santa Lucía', 'STL'),
(198, 1, 'Santo Tomé y Príncipe', 'STP'),
(199, 1, 'Senegal', 'SEN'),
(200, 5, 'Serbia', 'SRB'),
(201, 1, 'Seychelles', 'SEY'),
(202, 1, 'Sierra Leona', 'SLE'),
(203, 3, 'Singapur', 'SIN'),
(204, 3, 'Siria', 'SYR'),
(205, 1, 'Somalia', 'SOM'),
(206, 1, 'Somalilandia', 'SOD'),
(207, 3, 'Sri Lanka', 'SLK'),
(208, 1, 'Suazilandia', 'SWZ'),
(209, 1, 'Sudáfrica', 'ZA'),
(210, 1, 'Sudán', 'SUD'),
(211, 1, 'Sudán del Sur', 'SDS'),
(212, 5, 'Suecia', 'SE'),
(213, 5, 'Suiza', 'SUI'),
(214, 2, 'Surinam', 'SUR'),
(215, 5, 'Svalbard', 'SVD'),
(216, 3, 'Tailandia', 'THA'),
(217, 3, 'Taiwán', 'TW'),
(218, 1, 'Tanzania', 'TAN'),
(219, 3, 'Tayikistán', 'TJ'),
(220, 3, 'Timor Oriental', 'TL'),
(221, 1, 'Togo', 'TG'),
(222, 8, 'Tokelau', 'TK'),
(223, 8, 'Tonga', 'TGA'),
(224, 5, 'Transnistria', 'TNA'),
(225, 2, 'Trinidad y Tobago', 'TT'),
(226, 1, 'Túnez', 'TN'),
(227, 2, 'Turcas y Caicos Islas', 'ITC'),
(228, 3, 'Turkmenistán', 'TKM'),
(229, 4, 'Turquía', 'TUR'),
(230, 8, 'Tuvalu', 'TUV'),
(231, 5, 'Ucrania', 'UKR'),
(232, 1, 'Uganda', 'UGA'),
(233, 2, 'Uruguay', 'URU'),
(234, 3, 'Uzbekistán', 'UZB'),
(235, 8, 'Vanuatu', 'VNT'),
(236, 5, 'Vaticano Ciudad del', 'CDV'),
(237, 2, 'Venezuela', 'VEN'),
(238, 3, 'Vietnam', 'VIE'),
(239, 2, 'Vírgenes Británicas Islas', 'IVB'),
(240, 2, 'Vírgenes de los Estados Unidos Islas', 'IVU'),
(241, 8, 'Wallis y Futuna', 'WF'),
(242, 3, 'Yemen', 'YM'),
(243, 1, 'Yibuti', 'YT'),
(244, 1, 'Zambia', 'ZB'),
(245, 1, 'Zimbabue', 'ZBB');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `id_permiso` int(11) NOT NULL,
  `nombre` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`id_permiso`, `nombre`) VALUES
(1, 'Consultar'),
(2, 'Agregar'),
(3, 'Editar'),
(4, 'Eliminar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puesto`
--

CREATE TABLE `puesto` (
  `id_puesto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `puesto`
--

INSERT INTO `puesto` (`id_puesto`, `nombre`) VALUES
(1, 'Asistente Cobros'),
(2, 'Asistente Pagos'),
(3, 'Gerente'),
(4, 'Coordinador'),
(5, 'Operaciones'),
(6, 'Programador'),
(7, 'Telemarketing');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `id_sucursal` int(11) NOT NULL,
  `razons` varchar(75) NOT NULL,
  `nombrec` varchar(75) NOT NULL,
  `Telefono` varchar(50) NOT NULL,
  `identificacion` varchar(50) NOT NULL,
  `direccion` varchar(150) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `fechaingreso` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `idpais` int(11) NOT NULL,
  `codigo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`id_sucursal`, `razons`, `nombrec`, `Telefono`, `identificacion`, `direccion`, `logo`, `fechaingreso`, `estado`, `idpais`, `codigo`) VALUES
(0, 'ALAMDISA DE NICARAGUA', 'ALMADISA DE NUCA', '50222123085', 'identi', 'nicaragua', '', '2021-01-20', 1, 0, 'ALMNI3'),
(1, 'Servicios Comerciales de Guatemala', 'Sercogua', '50223037000', '22354589', '0 calle b 17-10 colonia el maestro zona 15, Guatemala', 'logo2.jfif', '2021-01-06', 1, 92, 'SERGT1'),
(27, 'Almacenamiento Manejo y Distribuci&oacute;n de Guatemala', 'Almadisa', '50222123085', '123445', 'Interior Alpasa', '', '2021-01-06', 1, 92, 'ALMGT1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `almacen`
--
ALTER TABLE `almacen`
  ADD PRIMARY KEY (`id_almacen`);

--
-- Indices de la tabla `asigna_menu`
--
ALTER TABLE `asigna_menu`
  ADD PRIMARY KEY (`idasigna_menu`);

--
-- Indices de la tabla `asigna_moneda`
--
ALTER TABLE `asigna_moneda`
  ADD PRIMARY KEY (`id_asigna_moneda`);

--
-- Indices de la tabla `contactos_e`
--
ALTER TABLE `contactos_e`
  ADD PRIMARY KEY (`id_contacto`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `continente`
--
ALTER TABLE `continente`
  ADD PRIMARY KEY (`nombre`),
  ADD UNIQUE KEY `idcontinente_UNIQUE` (`idcontinente`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `correlativo_almacen`
--
ALTER TABLE `correlativo_almacen`
  ADD PRIMARY KEY (`idcorrelativo`);

--
-- Indices de la tabla `depto`
--
ALTER TABLE `depto`
  ADD PRIMARY KEY (`id_depto`);

--
-- Indices de la tabla `detalle_almacen`
--
ALTER TABLE `detalle_almacen`
  ADD PRIMARY KEY (`id_detalle`);

--
-- Indices de la tabla `empaque`
--
ALTER TABLE `empaque`
  ADD PRIMARY KEY (`id_empaque`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id_empresa`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indices de la tabla `moneda`
--
ALTER TABLE `moneda`
  ADD PRIMARY KEY (`id_moneda`);

--
-- Indices de la tabla `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`idpais`),
  ADD UNIQUE KEY `idpais_UNIQUE` (`idpais`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`id_permiso`);

--
-- Indices de la tabla `puesto`
--
ALTER TABLE `puesto`
  ADD PRIMARY KEY (`id_puesto`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`id_sucursal`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `almacen`
--
ALTER TABLE `almacen`
  MODIFY `id_almacen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `asigna_menu`
--
ALTER TABLE `asigna_menu`
  MODIFY `idasigna_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT de la tabla `asigna_moneda`
--
ALTER TABLE `asigna_moneda`
  MODIFY `id_asigna_moneda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `contactos_e`
--
ALTER TABLE `contactos_e`
  MODIFY `id_contacto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `correlativo_almacen`
--
ALTER TABLE `correlativo_almacen`
  MODIFY `idcorrelativo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT de la tabla `depto`
--
ALTER TABLE `depto`
  MODIFY `id_depto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `detalle_almacen`
--
ALTER TABLE `detalle_almacen`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `empaque`
--
ALTER TABLE `empaque`
  MODIFY `id_empaque` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `moneda`
--
ALTER TABLE `moneda`
  MODIFY `id_moneda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `pais`
--
ALTER TABLE `pais`
  MODIFY `idpais` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `puesto`
--
ALTER TABLE `puesto`
  MODIFY `id_puesto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- Base de datos: `crudpdo`
--
CREATE DATABASE IF NOT EXISTS `crudpdo` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;
USE `crudpdo`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `idEmp` int(11) NOT NULL,
  `Nombres` varchar(100) COLLATE utf32_spanish2_ci NOT NULL,
  `Apellidos` varchar(100) COLLATE utf32_spanish2_ci NOT NULL,
  `Telefono` text COLLATE utf32_spanish2_ci NOT NULL,
  `Carrera` varchar(100) COLLATE utf32_spanish2_ci NOT NULL,
  `Pais` varchar(100) COLLATE utf32_spanish2_ci NOT NULL,
  `logo` varchar(150) COLLATE utf32_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish2_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`idEmp`, `Nombres`, `Apellidos`, `Telefono`, `Carrera`, `Pais`, `logo`) VALUES
(9, 'Katrina', 'Cespedes', '465055545', 'Psicologia', 'Panama camio mucho', '1602467613.png'),
(11, 'Luis cambio', 'Morales', '785232655', 'Modelamiento dfsdf', 'Mexico', ''),
(12, 'Luis cambios 3', 'Morales', '785232655', 'Modelamiento', 'Mexico cambio', ''),
(17, 'Manuel de la cruz', 'asdf', '22123085', 'repostera', 'asdf', ''),
(19, 'categoria 1256', '', '', '', '', ''),
(20, 'prueabas', '', '', '', '', ''),
(21, 'prueabas', '', '', '', '', ''),
(22, 'kljlkjlkjkllk', '', '', '', '', ''),
(23, 'lopiuy88987kj', '', '', '', '', ''),
(24, 'no quiere ingersar imagen', '', '', '', '', ''),
(28, '', '', '', '', '', ''),
(29, 'zdghy', 'asdf', '22123085', '', 'asdf', ''),
(39, 'Manuel de la cruz', 'yaque', '22123085', '', '', '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`idEmp`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `idEmp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin DEFAULT NULL,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Volcado de datos para la tabla `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"snap_to_grid\":\"off\",\"relation_lines\":\"true\",\"angular_direct\":\"direct\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"almadisa\",\"table\":\"asigna_moneda\"},{\"db\":\"almadisa\",\"table\":\"sucursal\"},{\"db\":\"almadisa\",\"table\":\"moneda\"},{\"db\":\"almadisa\",\"table\":\"pais\"},{\"db\":\"almadisa\",\"table\":\"detalle_almacen\"},{\"db\":\"almadisa\",\"table\":\"correlativo_almacen\"},{\"db\":\"almadisa\",\"table\":\"almacen\"},{\"db\":\"almadisa\",\"table\":\"empresas\"},{\"db\":\"almadisa\",\"table\":\"empaque\"},{\"db\":\"almadisa\",\"table\":\"contactos_e\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin DEFAULT NULL,
  `data_sql` longtext COLLATE utf8_bin DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2021-04-01 20:12:14', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"es\",\"DefaultConnectionCollation\":\"utf8_general_ci\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `prueba`
--
CREATE DATABASE IF NOT EXISTS `prueba` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;
USE `prueba`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_user`
--

CREATE TABLE `tbl_user` (
  `userID` int(11) NOT NULL,
  `userName` varchar(20) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `userProfesion` varchar(50) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `userPic` varchar(200) COLLATE utf8mb4_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `tbl_user`
--

INSERT INTO `tbl_user` (`userID`, `userName`, `userProfesion`, `userPic`) VALUES
(2, 'prueba', 'programador', '490702.png'),
(3, 'prueba', 'programador', '5185.png'),
(4, 'prueba', 'programador', '155973.png'),
(5, 'manuel', 'desarrollador web', '837807.png');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Base de datos: `simple_invoice`
--
CREATE DATABASE IF NOT EXISTS `simple_invoice` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `simple_invoice`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre_cliente` varchar(255) NOT NULL,
  `telefono_cliente` char(30) NOT NULL,
  `email_cliente` varchar(64) NOT NULL,
  `direccion_cliente` varchar(255) NOT NULL,
  `status_cliente` tinyint(4) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_factura`
--

CREATE TABLE `detalle_factura` (
  `id_detalle` int(11) NOT NULL,
  `numero_factura` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `id_factura` int(11) NOT NULL,
  `numero_factura` int(11) NOT NULL,
  `fecha_factura` datetime NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `condiciones` varchar(30) NOT NULL,
  `total_venta` varchar(20) NOT NULL,
  `estado_factura` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id_producto` int(11) NOT NULL,
  `codigo_producto` char(20) NOT NULL,
  `nombre_producto` char(255) NOT NULL,
  `status_producto` tinyint(4) NOT NULL,
  `date_added` datetime NOT NULL,
  `precio_producto` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id_producto`, `codigo_producto`, `nombre_producto`, `status_producto`, `date_added`, `precio_producto`) VALUES
(1, 'as', 'qwere', 1, '2021-01-09 05:56:31', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tmp`
--

CREATE TABLE `tmp` (
  `id_tmp` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad_tmp` int(11) NOT NULL,
  `precio_tmp` double(8,2) DEFAULT NULL,
  `session_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL COMMENT 'auto incrementing user_id of each user, unique index',
  `firstname` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'user''s name, unique',
  `user_password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'user''s password in salted and hashed format',
  `user_email` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'user''s email, unique',
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='user data';

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`user_id`, `firstname`, `lastname`, `user_name`, `user_password_hash`, `user_email`, `date_added`) VALUES
(1, 'Obed', 'Alvarado', 'admin', '$2y$10$MPVHzZ2ZPOWmtUUGCq3RXu31OTB.jo7M9LZ7PmPQYmgETSNn19ejO', 'admin@admin.com', '2016-05-21 15:06:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `codigo_producto` (`nombre_cliente`);

--
-- Indices de la tabla `detalle_factura`
--
ALTER TABLE `detalle_factura`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `numero_cotizacion` (`numero_factura`,`id_producto`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`id_factura`),
  ADD UNIQUE KEY `numero_cotizacion` (`numero_factura`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id_producto`),
  ADD UNIQUE KEY `codigo_producto` (`codigo_producto`);

--
-- Indices de la tabla `tmp`
--
ALTER TABLE `tmp`
  ADD PRIMARY KEY (`id_tmp`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_factura`
--
ALTER TABLE `detalle_factura`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `id_factura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tmp`
--
ALTER TABLE `tmp`
  MODIFY `id_tmp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'auto incrementing user_id of each user, unique index', AUTO_INCREMENT=2;
--
-- Base de datos: `sistema`
--
CREATE DATABASE IF NOT EXISTS `sistema` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `sistema`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cars`
--

CREATE TABLE `cars` (
  `id` int(11) NOT NULL,
  `marca_modelo` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `poblacion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `empleado` int(11) NOT NULL,
  `matricula` char(7) COLLATE utf8_spanish_ci NOT NULL,
  `estado` enum('activo','inactivo') COLLATE utf8_spanish_ci NOT NULL,
  `fecha_compra` date NOT NULL,
  `ultima_revision` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cars`
--

INSERT INTO `cars` (`id`, `marca_modelo`, `poblacion`, `empleado`, `matricula`, `estado`, `fecha_compra`, `ultima_revision`) VALUES
(1, 'Ford Transit Custom', 'Zaragoza', 2, '1234BCD', 'activo', '2020-07-27', '2020-07-28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(2, 'LÃ­quidos'),
(1, 'Repuestos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `poblacion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `estado` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` char(9) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_inicio` date NOT NULL,
  `activo` enum('si','no') COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `clients`
--

INSERT INTO `clients` (`id`, `nombre`, `direccion`, `poblacion`, `estado`, `telefono`, `descripcion`, `fecha_inicio`, `activo`) VALUES
(2, 'Pepe Perez', 'Calle MarÃ­a 1', 'Zaragoza', 'EspaÃ±a', '666666666', 'Primer cliente', '2002-02-02', 'si');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `foto` int(11) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `dni` char(10) COLLATE utf8_spanish_ci NOT NULL,
  `lugar_nacimiento` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `domicilio` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `codigo_postal` int(5) NOT NULL,
  `ciudad` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `region` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `carnet_conducir` enum('si','no') COLLATE utf8_spanish_ci NOT NULL,
  `titulacion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `puesto` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `inicio_contrato` date NOT NULL,
  `fin_contrato` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `employees`
--

INSERT INTO `employees` (`id`, `foto`, `nombre`, `apellidos`, `dni`, `lugar_nacimiento`, `fecha_nacimiento`, `domicilio`, `codigo_postal`, `ciudad`, `region`, `carnet_conducir`, `titulacion`, `puesto`, `inicio_contrato`, `fin_contrato`) VALUES
(1, 2, 'Carlos', 'Utrilla', '12345678A', 'Zaragoza', '1977-04-21', 'Pº Rosales 16', 50008, 'Zaragoza', 'Zaragoza', 'no', 'Auxiliar Administrativo', 'Administración', '2020-08-08', '0000-00-00'),
(2, 2, 'pepe', 'perez', '87654321Z', 'Zaragoza', '1999-12-31', 'C/ BoterÃ³n', 50001, 'Zaragoza', 'AragÃ³n', 'si', 'Oficial de carretillas', 'Carretillero', '2020-01-01', '9999-12-31'),
(6, 0, 'Alberto', 'Tierno', '12121212k', 'Zaragoza', '1999-01-01', 'C/ BoterÃ³n', 50008, 'Zaragoza', 'Zaragoza', 'no', 'Oficial de carretillas', 'Carretillero', '2019-12-31', '2099-12-31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materials`
--

CREATE TABLE `materials` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `cantidad` int(4) NOT NULL,
  `fecha_compra` date NOT NULL,
  `precio_compra` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `materials`
--

INSERT INTO `materials` (`id`, `nombre`, `descripcion`, `cantidad`, `fecha_compra`, `precio_compra`) VALUES
(2, 'MÃ¡quina de envasado al vacÃ­o', 'Envasadora Mackinley 40023A 8l', 1, '2020-02-20', '123.45'),
(3, 'Cortadora', 'Modelo L400', 2, '2020-08-12', '59.99'),
(4, 'Caja registradora', 'Fort500', 1, '2001-01-01', '49.90');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `media`
--

CREATE TABLE `media` (
  `id` int(11) UNSIGNED NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `media`
--

INSERT INTO `media` (`id`, `file_name`, `file_type`) VALUES
(1, 'filter.jpg', 'image/jpeg'),
(2, 'carita.jpg', 'image/jpeg'),
(3, 'liquid.jpg', 'image/jpeg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `quantity` varchar(50) DEFAULT NULL,
  `buy_price` decimal(25,2) DEFAULT NULL,
  `sale_price` decimal(25,2) NOT NULL,
  `categorie_id` int(11) UNSIGNED NOT NULL,
  `media_id` int(11) DEFAULT 0,
  `date` datetime NOT NULL,
  `id_supplier` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `name`, `quantity`, `buy_price`, `sale_price`, `categorie_id`, `media_id`, `date`, `id_supplier`) VALUES
(1, 'Filtro de gasolina', '101', '5.00', '10.00', 1, 1, '2017-06-16 07:03:16', 1),
(2, 'Garrafa de 5 litros de agua carbonatada', '50', '3.50', '7.00', 2, 3, '2020-08-11 20:09:32', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `total` decimal(5,2) NOT NULL,
  `date` date NOT NULL,
  `supplier` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `purchases`
--

INSERT INTO `purchases` (`id`, `product_id`, `qty`, `price`, `total`, `date`, `supplier`) VALUES
(1, 1, 1, '5.00', '5.00', '2020-07-25', 1),
(2, 2, 1, '3.50', '3.50', '2020-08-11', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salary`
--

CREATE TABLE `salary` (
  `id` int(11) NOT NULL,
  `empleado` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `fecha` date NOT NULL,
  `horas_base` int(3) NOT NULL,
  `horas_extra` int(3) NOT NULL,
  `pago_base` decimal(6,2) NOT NULL,
  `pago_extra` decimal(6,2) NOT NULL,
  `total_horas` int(3) NOT NULL,
  `total_pago` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `salary`
--

INSERT INTO `salary` (`id`, `empleado`, `fecha`, `horas_base`, `horas_extra`, `pago_base`, `pago_extra`, `total_horas`, `total_pago`) VALUES
(1, 'Utrilla,Carlos', '2020-08-14', 8, 2, '600.00', '200.00', 10, '800.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales`
--

CREATE TABLE `sales` (
  `id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `total` decimal(5,2) NOT NULL,
  `date` date NOT NULL,
  `client` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sales`
--

INSERT INTO `sales` (`id`, `product_id`, `qty`, `price`, `total`, `date`, `client`) VALUES
(1, 1, 1, '10.00', '10.00', '2020-07-23', 1),
(2, 2, 1, '7.00', '7.00', '2020-08-11', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `shops`
--

CREATE TABLE `shops` (
  `id` int(11) NOT NULL,
  `direccion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `cod_postal` char(5) COLLATE utf8_spanish_ci NOT NULL,
  `poblacion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `empleado` int(11) NOT NULL,
  `metros_cuadrados` decimal(4,2) NOT NULL,
  `alquiler` enum('si','no') COLLATE utf8_spanish_ci NOT NULL,
  `adquisicion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `shops`
--

INSERT INTO `shops` (`id`, `direccion`, `cod_postal`, `poblacion`, `empleado`, `metros_cuadrados`, `alquiler`, `adquisicion`) VALUES
(1, 'PÂº Rosales', '50008', 'Zaragoza', 1, '24.35', 'no', '2012-02-02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `poblacion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `estado` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` char(9) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_inicio` date NOT NULL,
  `activo` enum('si','no') COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `suppliers`
--

INSERT INTO `suppliers` (`id`, `nombre`, `direccion`, `poblacion`, `estado`, `telefono`, `descripcion`, `fecha_inicio`, `activo`) VALUES
(1, 'PlÃ¡sticos Hernando', 'C/ Alvarez 2', 'Zaragoza', 'EspaÃ±a', '976123456', 'PlÃ¡sticos y envases sencillos', '2001-01-01', 'si');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_level` int(11) NOT NULL,
  `image` varchar(255) DEFAULT 'no_image.jpg',
  `status` int(1) NOT NULL,
  `last_login` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `user_level`, `image`, `status`, `last_login`) VALUES
(1, 'Administrador', 'Admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 1, '50b8fzt1.jpg', 1, '0000-00-00 00:00:00'),
(2, 'Usuario Especial', 'special', 'ba36b97a41e7faf742ab09bf88405ac04f99599a', 2, 'wuqrvc6z2.jpg', 1, '2020-07-28 17:00:38'),
(3, 'Usuario Normal', 'user', '12dea96fec20593566ab75692c9949596833adc9', 3, '1tvxj5493.jpg', 1, '2020-07-26 16:52:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_groups`
--

CREATE TABLE `user_groups` (
  `id` int(11) NOT NULL,
  `group_name` varchar(150) NOT NULL,
  `group_level` int(11) NOT NULL,
  `group_status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `user_groups`
--

INSERT INTO `user_groups` (`id`, `group_name`, `group_level`, `group_status`) VALUES
(1, 'Admin', 1, 1),
(2, 'Special', 2, 1),
(3, 'User', 3, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `foto` (`foto`);

--
-- Indices de la tabla `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `categorie_id` (`categorie_id`),
  ADD KEY `media_id` (`media_id`),
  ADD KEY `id_supplier` (`id_supplier`);

--
-- Indices de la tabla `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `supplier` (`supplier`) USING BTREE;

--
-- Indices de la tabla `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `client` (`client`);

--
-- Indices de la tabla `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `empleado` (`empleado`);

--
-- Indices de la tabla `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `user_level` (`user_level`);

--
-- Indices de la tabla `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_level` (`group_level`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cars`
--
ALTER TABLE `cars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `materials`
--
ALTER TABLE `materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `media`
--
ALTER TABLE `media`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `salary`
--
ALTER TABLE `salary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `FK_products` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `SK` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_user` FOREIGN KEY (`user_level`) REFERENCES `user_groups` (`group_level`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
