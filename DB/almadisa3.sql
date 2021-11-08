-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3307
-- Tiempo de generación: 08-11-2021 a las 23:08:22
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `almadisa`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `prcKardex` (IN `idsucursal` INT)  NO SQL
SELECT 
	  ifnull(DA.estado,1)as estado,
      A.id_almacen,
      DA.id_detalle,
	  YEAR(A.fecha_almacen)AS annio,
      A.Codigo,
      E.Razons AS consignado,
      A.contenedor_placa,
      A.poliza, 
      A.referencia,
      A.fecha_almacen,
      CL.Razons AS cliente_Final,
      A.cant_clientes,
      DA.nohbl,
      DA.mercaderia,
      DA.peso,
      DA.volumen,
      DA.bultos,
      DA.ubicacion,
      DA.linea,
      DA.resa,
      ''as Fecha_Retiro,
      '' as Dias_Almacenaje,
      '' as Dias_Libres_Almacenaje,
      '' as Almacenaje,
      '' as Gastos,
      '' as Cif,
      '' as Impuestos 
	FROM 
		almacen AS A  inner join 
		empresas AS E ON E.id_empresa = A.id_consignado	LEFT JOIN 
		detalle_almacen AS DA ON DA.id_almacen = A.id_almacen LEFT JOIN 
		empresas AS CL ON CL.id_empresa = DA.id_cliente
 where A.id_sucursal =idsucursal		
		ORDER BY A.fecha_almacen DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcListadoCreaMaritimo` (IN `idsucursal` INT)  NO SQL
select 
		EM.id_embarque_maritimo,
        date_format(EM.fecha_ingreso,'%m/%d/%Y') as fechaingreso,
        EM.codigo,
        EM.consecutivo,
        TC.nombre as tipocarga,
		TS.nombre as tiposervicio,
        CO.nombre as courier,
        B.nombre as barco,
        EM.viaje,
        AGE.Razons as agente,
        NAGE.Razons as Naviera,
        concat (PO.nombre,'  ',ORI.nombre ) as origen,
        concat (PD.nombre,'  ',DES.nombre) as destino,
        UA.nombre as usuarioA,
        EM.observaciones,
        EM.cant_clientes
		from embarque_maritimo as EM inner join 
			tipo_carga as TC on TC.id_tipo_carga = EM.id_tipo_carga inner join 
            tipo_servicio as TS on TS.id_tipo_servicio = EM.id_tipo_servicio left join 
            envio_courier as CO on CO.id_envio_courier = EM.id_courier inner join 
            barco as B on B.id_barco = EM.id_barco inner join 
            empresas as AGE on AGE.id_empresa = EM.id_agente inner join 
            empresas as NAGE on NAGE.id_empresa = EM.id_nav_age inner join 
            pais as PO on PO.idpais = EM.id_pais_origen inner join 
            ciudad as ORI on ORI.id_ciudad = EM.id_origen inner join 
            pais as PD on PD.idpais = EM.id_pais_destino inner join 
            ciudad as DES on DES.id_ciudad = EM.id_destino inner join 
            login as UA on UA.id_usuario = EM.id_usuario_asignado
where  EM.estado = 1 and EM.id_sucursal = idsucursal$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcListadoUsuarios` ()  NO SQL
SELECT L.id_usuario,
       L.nombre, 
	   L.apellido,
       L.correo,
       L.acceso,
       L.estado, 
       L.avatar, 
       concat (S.razons,' - ',PA.nombre) as  sucursal ,
       D.nombre as depto,
       P.nombre as puesto
		FROM `login`  as L inner JOIN
        	sucursal as S on S.id_sucursal = L.id_sucursal inner JOIN
            depto as D on D.id_depto = L.id_depto inner join 
            puesto as P on P.id_puesto = L.id_puesto INNER JOIN
            pais as PA on PA.idpais = S.idpais$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prclogin` (IN `codigol` VARCHAR(30) CHARSET utf8, IN `usuariol` VARCHAR(30) CHARSET utf8, IN `passl` VARCHAR(100) CHARSET utf8)  NO SQL
select L.id_usuario,
	   L.id_sucursal,
       L.nombre,
       L.apellido,
       L.correo,
       L.avatar,
       S.logo,
       S.direccion,
       S.Telefono,
       S.identificacion,
       S.idpais,
       P.nombre as puesto,
       S.impuesto,
       S.financiacion,
       PA.codigo_area,
       S.codigo as codigo_sucursal
		from login as L INNER JOIN
            sucursal as S on S.id_sucursal = L.id_sucursal INNER JOIN 
            puesto as P on P.id_puesto = L.id_puesto INNER JOIN 
            pais AS PA ON PA.idpais = S.idpais
 where L.acceso = usuariol and L.pass = passl 
 	   and S.codigo = codigol
       and L.estado = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rptcalculo` (IN `idcalculo` INT)  NO SQL
select  C.Razons as cliente,
		C.direccion,
		C.identificacion,
		A.poliza as polizaentrada,--

		CA.poliza_salida,--

		CA.del,--

		CA.al,--

		CA.total_dias,--

		CA.dias_almacen,--

		CA.cif,--

		CA.impuesto,--

		CA.peso,--

        CA.volumen,--

		CA.cnt_clientes,--

		CA.cnt_cuadrilla,--

		CA.base_seguro,--

		CC.nombre as descripcion,--

		(DC.valor + DC.otro_valor)  as valor,--

		CA.iva,--

		CA.subtotal,--

		CA.total,--

		CA.bultos_retirados,--

		DA.resa,--

		DC.signo,--

		A.codigo,--

		/*ifnull (CA.cliente,'') as clientecalculo, pneidnete programar en el sistema*/
		DA.mercaderia,--

		DA.volumen,--

	    ifnull (CA.tipo_cambio,1) as tipocambio,--

		DA.ubicacion,--

		ifnull (CA.id_plantilla,1) AS idplantilla,--

		DC.id_detalle_calculo,--

		ifnull (DA.dut,'')as dut,--

		/*CA.fecha1 ,
	    CA.fecha2 ,
	    CA.fecha3 ,  
	    ISNULL (CA.sub1,0)AS sub1 , 
	    ISNULL (CA.sub2,0)AS sub2 , 
	    ISNULL (CA.sub3,0)AS sub3 , 
	    ISNULL (CA.iva1,0) AS iva1,
	    ISNULL (CA.iva2,0)AS iva2 ,
	    ISNULL (CA.iva3,0) AS iva3 ,
	    ISNULL (CA.tota1,0)AS tota1 ,
	    ISNULL (CA.tota2,0)AS tota2 ,  
	    ISNULL (CA.tota3,0)AS tota3 ,  
	    ISNULL (CA.totas1,0)AS totas1 ,
	    ISNULL (CA.totas2,0)AS totas2 ,  
	    ISNULL (CA.totas3,0)AS totas3 ,  
	    ISNULL (CA.totas4,0)AS totas4 ,   
	    ISNULL (CA.por,0) AS por,
	    ISNULL (CA.porser,0) as porser,*/
	     CON.Nombrec as consignado 
	from almacen as  A inner join
		 empresas as CON on CON.id_empresa = A.id_consignado inner join 
		 detalle_almacen as DA on DA.id_almacen = A.id_almacen inner join
		 calculo_almacen as CA on CA.id_detalle_almacen = DA.id_detalle inner join
		 detalle_calculo as DC on DC.id_calculo = CA.id_calculo inner join
         detalle_plantillaa as DP on DP.id_detalle = DC.id_detalle_plantilla inner join 
		 catalogo as CC on CC.id_catalogo = DP.id_catalogo inner join
		 empresas  as C on C.id_empresa = DA.id_cliente
where CA.id_calculo = idcalculo	
ORDER BY DA.id_detalle$$

DELIMITER ;

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
(1, 52, 3, 64, '03.31.21', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(2, 52, 27, 64, '03.32.21', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(3, 52, 27, 64, '', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(4, 52, 27, 64, '', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(5, 52, 27, 64, '', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(6, 52, 27, 64, '', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '0000-00-00', '2021-03-14', 52, 2021),
(7, 52, 3, 64, '', 'ASDF', 'asdf', 'ASDF', 1, NULL, 1, NULL, 1, 0, '2021-03-03', '2021-03-14', 52, 2021),
(8, 52, 3, 64, '', 'CONTENEDOR', 'poliza', 'REFERENCIA', 1, NULL, 1, NULL, 1, 0, '2021-03-16', '2021-03-16', 52, 2021),
(9, 52, 3, 64, '', 'ASDF', 'asdf33', '12312', 1, NULL, 1, NULL, 1, 0, '2021-03-18', '2021-03-16', 52, 2021),
(10, 52, 3, 64, '03.42.21', 'ASDFASDFSADF', 'asd', 'ASD', 1, NULL, 1, NULL, 1, 0, '2021-03-24', '2021-03-16', 52, 2021),
(11, 52, 3, 64, '03.43.21', 'ASDF', 'asdf', 'ASDF33234', 2, NULL, 2, NULL, 2, 3, '2021-03-30', '2021-03-18', 52, 2021),
(12, 52, 3, 64, '03.44.21', 'PRUEBA', 'asdf', 'ASDF', 2, NULL, 3, NULL, 3, 3, '2021-03-16', '2021-03-18', 52, 2021),
(13, 52, 3, 64, '03.45.21', 'ASDF', 'asdfasdf', 'ASDF', 1, NULL, 1, NULL, 1, 3, '2021-03-17', '2021-03-18', 52, 2021),
(14, 52, 3, 64, '03.46.21', 'PLACA DE PRUEBA123', 'poliza de prueba', 'REFERENCIA DE PRUEBA', 12, NULL, 23, NULL, 12, 12, '2021-04-02', '2021-03-18', 52, 2021),
(15, 52, 27, 64, '03.47.21', 'PLACA DE PRUEBA CAMBIO', 'poliza de prueba cambio', 'REFERENCIA DE PRUEBA CAMBIO', 10, NULL, 10, NULL, 10, 10, '2021-03-30', '2021-03-20', 52, 2021),
(16, 58, 4, 80, '08.1.21', 'CRFG-12365', 'poliza entrada 1', 'REFERENCIA 502', 100, NULL, 10, NULL, 500, 5, '2021-08-12', '2021-08-12', 58, 2021);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos_embarques`
--

CREATE TABLE `archivos_embarques` (
  `id_archivos` int(11) NOT NULL,
  `id_embarque` int(11) NOT NULL,
  `tipo_e` varchar(5) NOT NULL,
  `nombre_archivo` varchar(40) NOT NULL,
  `ubicacion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `archivos_embarques`
--

INSERT INTO `archivos_embarques` (`id_archivos`, `id_embarque`, `tipo_e`, `nombre_archivo`, `ubicacion`) VALUES
(1, 17, 'M', 'image_2021_08_09T15_24_16_930Z.png', '../ALMCR4/2021/Embarques/Maritimo/Importacion/506.1.10.21.GT'),
(2, 17, 'M', 'image_2021_08_09T15_24_49_309Z.png', '../ALMCR4/2021/Embarques/Maritimo/Importacion/506.1.10.21.GT'),
(3, 13, 'M', 'Sin título.png', '../ALMCR4/2021/Embarques/Maritimo/Importacion/506.1.7.21.GT'),
(4, 29, 'M', 'Sin título.png', '../ALMCR4/2021/Embarques/Maritimo/Exportacion/506.1.12.21.GT'),
(5, 8, 'M', 'Sin título.png', '../ALMCR4/2021/Embarques/Maritimo/Importacion/506.1.221.GT');

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
(113, 52, 20),
(186, 58, 1),
(187, 58, 6),
(188, 58, 7),
(189, 58, 8),
(190, 58, 9),
(191, 58, 10),
(192, 58, 12),
(193, 58, 13),
(194, 58, 14),
(195, 58, 16),
(196, 58, 18),
(197, 58, 19),
(198, 58, 20),
(199, 58, 21),
(200, 58, 22),
(201, 58, 23);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asigna_moneda`
--

CREATE TABLE `asigna_moneda` (
  `id_asigna_moneda` int(11) NOT NULL,
  `id_moneda` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `asigna_moneda`
--

INSERT INTO `asigna_moneda` (`id_asigna_moneda`, `id_moneda`, `id_sucursal`) VALUES
(1, 3, 27),
(2, 5, 27),
(3, 1, 4),
(4, 5, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `banco`
--

CREATE TABLE `banco` (
  `id_banco` int(11) NOT NULL,
  `id_sucursal` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `nombre` varchar(75) DEFAULT NULL,
  `ejecutivo` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `extension` varchar(5) DEFAULT NULL,
  `correo` varchar(75) DEFAULT NULL,
  `observaciones` varchar(250) DEFAULT NULL,
  `fecha_grabacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `banco`
--

INSERT INTO `banco` (`id_banco`, `id_sucursal`, `id_usuario`, `nombre`, `ejecutivo`, `telefono`, `extension`, `correo`, `observaciones`, `fecha_grabacion`) VALUES
(1, 4, 58, 'BANCO INDUSTRIAL', 'no tienedsafsdf', '34123123123', '932', 'manuelcruz86@gmail.com', 'CUENTA PRINCIPAL CAMBIO', '2021-10-13 22:03:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barco`
--

CREATE TABLE `barco` (
  `id_barco` int(11) NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `bandera` varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `barco`
--

INSERT INTO `barco` (`id_barco`, `nombre`, `bandera`) VALUES
(1, 'MSC ROSA', 'Japon'),
(2, 'CGM ALASKA', 'CHINA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calculo_almacen`
--

CREATE TABLE `calculo_almacen` (
  `id_calculo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL DEFAULT 0,
  `id_cliente` int(11) NOT NULL DEFAULT 0,
  `id_plantilla` int(11) NOT NULL DEFAULT 0,
  `id_detalle_almacen` int(11) NOT NULL DEFAULT 0,
  `direccion` varchar(1000) NOT NULL,
  `identificacion` varchar(50) NOT NULL,
  `total_dias` smallint(6) NOT NULL DEFAULT 0,
  `dias_almacen` smallint(6) NOT NULL DEFAULT 0,
  `dias_libres` smallint(6) NOT NULL DEFAULT 0,
  `del` date NOT NULL,
  `al` date NOT NULL,
  `dut` varchar(75) NOT NULL DEFAULT '0',
  `poliza_salida` varchar(75) NOT NULL DEFAULT '0',
  `orden_salida` varchar(75) NOT NULL DEFAULT '0',
  `tipo_cambio` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cif_dolares` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cif` decimal(10,2) NOT NULL DEFAULT 0.00,
  `impuesto` decimal(10,2) NOT NULL DEFAULT 0.00,
  `base_seguro` decimal(10,2) NOT NULL DEFAULT 0.00,
  `bultos_retirados` decimal(10,2) NOT NULL DEFAULT 0.00,
  `peso` decimal(10,3) NOT NULL DEFAULT 0.000,
  `volumen` decimal(10,3) NOT NULL DEFAULT 0.000,
  `cnt_clientes` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cnt_cuadrilla` decimal(10,2) NOT NULL DEFAULT 0.00,
  `id_descuento` tinyint(4) NOT NULL,
  `descuento_valor` decimal(10,2) NOT NULL DEFAULT 0.00,
  `financiacion_valor` decimal(10,2) NOT NULL DEFAULT 0.00,
  `financiacion_porcentaje` decimal(3,2) NOT NULL DEFAULT 0.00,
  `aplica_financiacion` tinyint(4) NOT NULL DEFAULT 0,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `exento_iva` tinyint(4) NOT NULL DEFAULT 0,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `isr` decimal(10,2) NOT NULL DEFAULT 0.00,
  `alcaldia` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='se almacena los campos principales de los calculo de almacenaje de ';

--
-- Volcado de datos para la tabla `calculo_almacen`
--

INSERT INTO `calculo_almacen` (`id_calculo`, `id_usuario`, `id_cliente`, `id_plantilla`, `id_detalle_almacen`, `direccion`, `identificacion`, `total_dias`, `dias_almacen`, `dias_libres`, `del`, `al`, `dut`, `poliza_salida`, `orden_salida`, `tipo_cambio`, `cif_dolares`, `cif`, `impuesto`, `base_seguro`, `bultos_retirados`, `peso`, `volumen`, `cnt_clientes`, `cnt_cuadrilla`, `id_descuento`, `descuento_valor`, `financiacion_valor`, `financiacion_porcentaje`, `aplica_financiacion`, `subtotal`, `iva`, `exento_iva`, `total`, `isr`, `alcaldia`) VALUES
(5, 58, 81, 4, 5, 'CIUDAD DE COSTARICA', '698574', 1, -9, 10, '2021-08-12', '2021-08-25', '', '', '', '123.00', '123.00', '15129.00', '123.00', '15252.00', '500.00', '26.000', '10.000', '5.00', '5.00', 0, '0.00', '2741.17', '3.75', 1, '64916.00', '8440.00', 0, '73098.00', '0.00', '0.00'),
(6, 58, 81, 4, 5, 'CIUDAD DE COSTARICA', '698574', 1, -9, 10, '2021-08-12', '2021-08-25', '', '', '', '123.00', '1.00', '123.00', '2.00', '125.00', '500.00', '26.000', '10.000', '5.00', '5.00', 0, '0.00', '2739.90', '3.75', 1, '64658.00', '8406.00', 1, '73064.00', '0.00', '0.00'),
(7, 58, 81, 4, 5, 'CIUDAD DE COSTARICA', '698574', 1, -9, 10, '2021-08-12', '2021-08-25', '', '', '', '12354.00', '123.00', '1519542.00', '123.00', '1519665.00', '500.00', '26.000', '10.000', '5.00', '5.00', 0, '0.00', '0.00', '3.75', 1, '0.00', '0.00', 0, '0.00', '0.00', '0.00'),
(8, 58, 81, 4, 5, 'CIUDAD DE COSTARICA', '698574', 1, -9, 10, '2021-08-12', '2021-08-25', '', '', '', '12354.00', '123.00', '1519542.00', '123.00', '1519665.00', '500.00', '26.000', '10.000', '5.00', '5.00', 0, '0.00', '2739.90', '3.75', 1, '64658.00', '8406.00', 0, '73064.00', '0.00', '0.00'),
(9, 58, 81, 4, 5, 'CIUDAD DE COSTARICA', '698574', 1, -9, 10, '2021-08-12', '2021-08-25', '', '', '', '12354.00', '123.00', '1519542.00', '123.00', '1519665.00', '500.00', '26.000', '10.000', '5.00', '5.00', 0, '0.00', '2739.90', '3.75', 1, '64658.00', '8406.00', 0, '73064.00', '0.00', '0.00'),
(10, 58, 81, 4, 5, 'CIUDAD DE COSTARICA', '698574', 49, 39, 0, '2021-08-12', '2021-09-29', '', '', '', '12354.00', '123.00', '1519542.00', '123.00', '1519665.00', '500.00', '26.000', '10.000', '0.00', '5.00', 0, '0.00', '2739.90', '3.75', 1, '64658.00', '8406.00', 0, '73064.00', '0.00', '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `canal_distribucion`
--

CREATE TABLE `canal_distribucion` (
  `id_canal_distribucion` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `canal_distribucion`
--

INSERT INTO `canal_distribucion` (`id_canal_distribucion`, `nombre`) VALUES
(1, 'canal dis prueba 1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo`
--

CREATE TABLE `catalogo` (
  `id_catalogo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `nombre_ingles` varchar(100) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `partida_arancelaria` varchar(50) DEFAULT NULL,
  `factor_iva` decimal(5,2) DEFAULT NULL,
  `otro_cargo` smallint(6) DEFAULT NULL,
  `porcentaje_impuesto` decimal(5,2) DEFAULT NULL,
  `fecha_graba` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `catalogo`
--

INSERT INTO `catalogo` (`id_catalogo`, `id_usuario`, `id_sucursal`, `nombre`, `nombre_ingles`, `codigo`, `descripcion`, `partida_arancelaria`, `factor_iva`, `otro_cargo`, `porcentaje_impuesto`, `fecha_graba`) VALUES
(1, 52, 27, 'Seguro', 'secure', '', NULL, NULL, NULL, NULL, NULL, '2021-04-16'),
(2, 52, 27, 'Flete Aereo', 'freight Air', '3', NULL, NULL, NULL, NULL, NULL, '2021-04-30'),
(3, 52, 27, 'Almacenaje', 'gargabe', '3', NULL, NULL, NULL, NULL, NULL, '2021-05-25'),
(4, 52, 3, 'Manejo', '', '001', NULL, NULL, NULL, NULL, NULL, '2021-06-09'),
(5, 52, 3, 'Papeleria', 'paper', '5', NULL, NULL, NULL, NULL, NULL, '2021-08-07'),
(6, 52, 3, 'Descargue', 'download', '', NULL, NULL, NULL, NULL, NULL, '2021-08-07'),
(7, 52, 3, 'Cargue', 'up', '', NULL, NULL, NULL, NULL, NULL, '2021-08-07'),
(8, 58, 4, 'Almacenaje', 'gargabe', '', NULL, NULL, NULL, NULL, NULL, '2021-08-12'),
(9, 58, 4, 'Almacenaje Adicional', '', '', NULL, NULL, NULL, NULL, NULL, '2021-08-12'),
(10, 58, 4, 'Manejo', '', '', NULL, NULL, NULL, NULL, NULL, '2021-08-12'),
(11, 58, 4, 'Seguro', '', '', NULL, NULL, NULL, NULL, NULL, '2021-08-12'),
(12, 58, 4, 'Precintos', '', '', NULL, NULL, NULL, NULL, NULL, '2021-08-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `id_ciudad` int(11) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`id_ciudad`, `id_pais`, `nombre`) VALUES
(1, 92, 'GUATEMALA'),
(2, 92, 'ZACAPA'),
(3, 92, 'PROGRESO'),
(4, 92, 'IZABAL 1'),
(5, 92, 'PETEN');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consecutivos`
--

CREATE TABLE `consecutivos` (
  `id_consecutivo` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `mes` tinyint(4) NOT NULL,
  `anio` year(4) NOT NULL,
  `contador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `consecutivos`
--

INSERT INTO `consecutivos` (`id_consecutivo`, `id_sucursal`, `mes`, `anio`, `contador`) VALUES
(1, 4, 9, 2021, 1),
(2, 4, 9, 2021, 2),
(3, 4, 9, 2021, 3),
(4, 4, 9, 2021, 4),
(5, 4, 9, 2021, 5),
(6, 4, 9, 2021, 6),
(7, 4, 9, 2021, 7),
(8, 4, 9, 2021, 8),
(10, 4, 9, 2021, 9),
(11, 4, 9, 2021, 10),
(12, 4, 9, 2021, 11),
(13, 4, 1, 1970, 1),
(14, 4, 1, 1970, 2),
(15, 4, 1, 1970, 3),
(16, 4, 1, 1970, 4),
(17, 4, 1, 1970, 5),
(18, 4, 1, 1970, 6),
(19, 4, 1, 1970, 7),
(20, 4, 1, 1970, 8),
(21, 4, 1, 1970, 9),
(23, 4, 11, 2021, 1);

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
(23, 37, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros'),
(24, 67, 'manuel', 'cruz', 'opguatemala@sercogua.com', '45285945', 'it'),
(25, 69, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador'),
(26, 70, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador'),
(27, 71, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador'),
(28, 72, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador'),
(29, 73, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador'),
(30, 74, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador'),
(31, 75, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador'),
(32, 76, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador'),
(33, 80, 'est', 'lopez', 'it@gmail.com', '45285948', 'it');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenedor`
--

CREATE TABLE `contenedor` (
  `id_contenedor` int(11) NOT NULL,
  `id_embarque` int(11) NOT NULL,
  `numero` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `contenedor`
--

INSERT INTO `contenedor` (`id_contenedor`, `id_embarque`, `numero`) VALUES
(4, 5, 'ASDF-123333-3'),
(7, 8, 'ASDF-123123-1'),
(8, 29, 'JHJH-458979-9');

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
-- Estructura de tabla para la tabla `correlativoagente`
--

CREATE TABLE `correlativoagente` (
  `id_correlativo` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_agente` int(11) NOT NULL,
  `correlativo` int(11) NOT NULL,
  `anio` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `correlativoagente`
--

INSERT INTO `correlativoagente` (`id_correlativo`, `id_sucursal`, `id_agente`, `correlativo`, `anio`) VALUES
(3, 4, 83, 1, 2021),
(4, 4, 83, 2, 2021),
(5, 4, 83, 3, 2021),
(6, 4, 83, 4, 2021),
(7, 4, 83, 5, 2021),
(8, 4, 83, 6, 2021),
(9, 4, 83, 7, 2021),
(10, 4, 83, 8, 2021),
(12, 4, 83, 9, 2021),
(13, 4, 83, 10, 2021),
(14, 4, 83, 11, 2021),
(15, 4, 0, 1, 1970),
(16, 4, 0, 2, 1970),
(17, 4, 0, 3, 1970),
(18, 4, 0, 4, 1970),
(19, 4, 0, 5, 1970),
(20, 4, 0, 6, 1970),
(21, 4, 0, 7, 1970),
(22, 4, 0, 8, 1970),
(23, 4, 0, 9, 1970),
(25, 4, 83, 12, 2021);

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
(85, 8, 21, 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentabancaria`
--

CREATE TABLE `cuentabancaria` (
  `idcuenta_bancaria` int(11) NOT NULL,
  `id_banco` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `numero_cuenta` varchar(50) NOT NULL,
  `id_moneda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cuentabancaria`
--

INSERT INTO `cuentabancaria` (`idcuenta_bancaria`, `id_banco`, `nombre`, `numero_cuenta`, `id_moneda`) VALUES
(1, 0, '0', 'asd', 213),
(2, 0, 'manuel', '111', 5),
(3, 1, '0', 'prueba', 5),
(4, 1, '0', 'asdfsd', 5),
(5, 1, 'prueba dos cambio', '1231237885', 5);

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
-- Estructura de tabla para la tabla `descuentocalculo`
--

CREATE TABLE `descuentocalculo` (
  `id_descuento` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `porcentaje` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `descuentocalculo`
--

INSERT INTO `descuentocalculo` (`id_descuento`, `id_sucursal`, `porcentaje`) VALUES
(1, 4, '5.00'),
(2, 4, '10.00');

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
(5, 16, 81, 58, 1, 26, 10, 500, 'pendiente', 1, 'rack 10', '', '', '', '', '', 0, '', 'prueba de mercaderia', 'pruebas', '2021-08-12', '2021-08-14', 58, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_calculo`
--

CREATE TABLE `detalle_calculo` (
  `id_detalle_calculo` int(11) NOT NULL,
  `id_calculo` int(11) NOT NULL,
  `id_detalle_plantilla` int(11) NOT NULL,
  `signo` varchar(5) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `otro_valor` decimal(10,2) NOT NULL,
  `ocultar` tinyint(4) NOT NULL,
  `prorratear` tinyint(4) NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `iva` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_calculo`
--

INSERT INTO `detalle_calculo` (`id_detalle_calculo`, `id_calculo`, `id_detalle_plantilla`, `signo`, `valor`, `otro_valor`, `ocultar`, `prorratear`, `descuento`, `iva`) VALUES
(1, 5, 11, '₡.', '20500.00', '258.00', 0, 0, '52.00', '2699.00'),
(2, 5, 12, '₡.', '22658.00', '0.00', 0, 0, '25.00', '2946.00'),
(3, 5, 13, '₡.', '20500.00', '0.00', 0, 0, '85.00', '2665.00'),
(4, 5, 14, '₡.', '1000.00', '0.00', 0, 0, '0.00', '130.00'),
(5, 5, 15, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(6, 6, 11, '₡.', '20500.00', '0.00', 0, 0, '0.00', '2665.00'),
(7, 6, 12, '₡.', '22658.00', '0.00', 0, 0, '0.00', '2946.00'),
(8, 6, 13, '₡.', '20500.00', '0.00', 0, 0, '0.00', '2665.00'),
(9, 6, 14, '₡.', '1000.00', '0.00', 0, 0, '0.00', '130.00'),
(10, 6, 15, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(11, 7, 11, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(12, 7, 12, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(13, 7, 13, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(14, 7, 14, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(15, 7, 15, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(16, 8, 11, '₡.', '20500.00', '0.00', 0, 0, '0.00', '2665.00'),
(17, 8, 12, '₡.', '22658.00', '0.00', 0, 0, '0.00', '2946.00'),
(18, 8, 13, '₡.', '20500.00', '0.00', 0, 0, '0.00', '2665.00'),
(19, 8, 14, '₡.', '1000.00', '0.00', 0, 0, '0.00', '130.00'),
(20, 8, 15, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(21, 9, 11, '₡.', '20500.00', '0.00', 0, 0, '0.00', '2665.00'),
(22, 9, 12, '₡.', '22658.00', '0.00', 0, 0, '0.00', '2946.00'),
(23, 9, 13, '₡.', '20500.00', '0.00', 0, 0, '0.00', '2665.00'),
(24, 9, 14, '₡.', '1000.00', '0.00', 0, 0, '0.00', '130.00'),
(25, 9, 15, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(26, 10, 11, '₡.', '20500.00', '0.00', 0, 0, '0.00', '2665.00'),
(27, 10, 12, '₡.', '22658.00', '0.00', 0, 0, '0.00', '2946.00'),
(28, 10, 13, '₡.', '20500.00', '0.00', 0, 0, '0.00', '2665.00'),
(29, 10, 14, '₡.', '1000.00', '0.00', 0, 0, '0.00', '130.00'),
(30, 10, 15, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_plantillaa`
--

CREATE TABLE `detalle_plantillaa` (
  `id_detalle` int(11) NOT NULL,
  `id_plantilla` int(11) NOT NULL,
  `id_catalogo` int(11) NOT NULL,
  `id_moneda` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `minimo` float NOT NULL,
  `tarifa` float NOT NULL,
  `porcentaje` float NOT NULL,
  `por_peso` int(11) NOT NULL,
  `por_volumen` int(11) NOT NULL,
  `por_dia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_plantillaa`
--

INSERT INTO `detalle_plantillaa` (`id_detalle`, `id_plantilla`, `id_catalogo`, `id_moneda`, `id_sucursal`, `id_usuario`, `minimo`, `tarifa`, `porcentaje`, `por_peso`, `por_volumen`, `por_dia`) VALUES
(1, 1, 4, 5, 27, 1, 25, 3.25, 0, 0, 1, 0),
(2, 1, 1, 5, 27, 52, 21, 0, 0.11, 0, 1, 0),
(7, 1, 3, 5, 27, 52, 90, 0, 0.25, 0, 0, 0),
(8, 1, 5, 5, 3, 52, 0, 4, 0, 0, 0, 0),
(9, 1, 6, 5, 3, 52, 15, 4, 0, 0, 1, 0),
(10, 1, 7, 5, 3, 52, 15, 4, 0, 0, 1, 0),
(11, 4, 8, 1, 4, 58, 20500, 16, 0, 0, 0, 0),
(12, 4, 10, 1, 4, 58, 22658, 5, 0, 0, 0, 0),
(13, 4, 11, 1, 4, 58, 20500, 3, 0, 0, 0, 0),
(14, 4, 12, 1, 4, 58, 0, 1000, 0, 0, 0, 0),
(15, 4, 9, 1, 4, 58, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos_embarque`
--

CREATE TABLE `documentos_embarque` (
  `id_documentos` int(11) NOT NULL,
  `id_embarque` int(11) NOT NULL,
  `tipo_embarque` varchar(5) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `tipo_documento` varchar(11) NOT NULL,
  `cliente` varchar(75) NOT NULL,
  `numero` varchar(50) NOT NULL,
  `original` tinyint(4) NOT NULL,
  `copia` tinyint(4) NOT NULL,
  `observaciones` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `documentos_embarque`
--

INSERT INTO `documentos_embarque` (`id_documentos`, `id_embarque`, `tipo_embarque`, `id_venta`, `tipo_documento`, `cliente`, `numero`, `original`, `copia`, `observaciones`) VALUES
(2, 8, 'M', 0, '0', '', 'NUMERO 21', 1, 1, 'PRUEBA TRES'),
(3, 18, 'M', 1, 'HBL', 'ASDFSADF', 'A123', 2, 2, 'PRUEBAS'),
(4, 29, 'M', 1, 'HAWB', 'CLIENTE', '4587', 2, 2, 'OBSERVACIONES ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `embarque_maritimo`
--

CREATE TABLE `embarque_maritimo` (
  `id_embarque_maritimo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_tipo_carga` int(11) NOT NULL,
  `id_tipo_servicio` int(11) NOT NULL,
  `id_courier` int(11) NOT NULL,
  `id_barco` int(11) NOT NULL,
  `id_agente` int(11) NOT NULL,
  `id_nav_age` int(11) NOT NULL,
  `id_pais_origen` int(11) NOT NULL,
  `id_origen` int(11) NOT NULL,
  `id_pais_destino` int(11) NOT NULL,
  `id_destino` int(11) NOT NULL,
  `id_usuario_asignado` int(11) NOT NULL,
  `codigo` varchar(40) NOT NULL,
  `consecutivo` varchar(40) NOT NULL,
  `viaje` varchar(40) NOT NULL,
  `observaciones` varchar(250) NOT NULL,
  `fecha_ingreso` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_modificacion` date NOT NULL,
  `cant_clientes` tinyint(4) NOT NULL,
  `estado` bit(5) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `embarque_maritimo`
--

INSERT INTO `embarque_maritimo` (`id_embarque_maritimo`, `id_usuario`, `id_sucursal`, `id_tipo_carga`, `id_tipo_servicio`, `id_courier`, `id_barco`, `id_agente`, `id_nav_age`, `id_pais_origen`, `id_origen`, `id_pais_destino`, `id_destino`, `id_usuario_asignado`, `codigo`, `consecutivo`, `viaje`, `observaciones`, `fecha_ingreso`, `fecha_modificacion`, `cant_clientes`, `estado`) VALUES
(5, 58, 4, 3, 2, 1, 2, 83, 85, 92, 1, 92, 4, 58, '506.1.121.GT', '09.1.21', 'ASDF', 'ññljjj', '2021-09-07 20:47:11', '2021-09-07', 2, b'00001'),
(8, 58, 4, 7, 1, 1, 1, 83, 86, 92, 4, 92, 3, 58, '506.1.221.GT', '09.2.21', 'VIAJE 2', '0', '2021-09-06 21:15:14', '2021-09-07', 1, b'00001'),
(9, 58, 4, 3, 2, 1, 2, 83, 85, 92, 3, 92, 2, 58, '506.1.3.21.GT', '09.3.21', 'ASDF', 'ASDF', '2021-09-17 18:31:45', '2021-09-17', 1, b'00001'),
(10, 58, 4, 3, 2, 1, 2, 83, 85, 92, 5, 92, 3, 58, '506.1.4.21.GT', '09.4.21', 'LKJLK', '', '2021-09-17 18:34:16', '2021-09-17', 2, b'00001'),
(11, 58, 4, 3, 1, 1, 2, 83, 85, 92, 4, 92, 3, 58, '506.1.5.21.GT', '09.5.21', 'ASDF', '', '2021-09-17 18:59:23', '2021-09-17', 2, b'11111'),
(12, 58, 4, 3, 1, 1, 2, 83, 85, 92, 4, 92, 3, 58, '506.1.6.21.GT', '09.6.21', 'ASDF', '', '2021-09-17 18:59:29', '2021-09-17', 2, b'11111'),
(13, 58, 4, 3, 1, 1, 2, 83, 85, 92, 4, 92, 3, 58, '506.1.7.21.GT', '09.7.21', 'ASDF', '', '2021-09-17 19:00:12', '2021-09-17', 2, b'00001'),
(14, 58, 4, 3, 1, 1, 2, 83, 85, 92, 4, 92, 3, 58, '506.1.8.21.GT', '09.8.21', 'ASDF', '', '2021-09-17 19:02:41', '2021-09-17', 2, b'00001'),
(16, 58, 4, 3, 1, 1, 2, 83, 85, 92, 4, 92, 3, 58, '506.1.9.21.GT', '09.9.21', 'ASDF', '', '2021-09-17 19:04:21', '2021-09-17', 2, b'00001'),
(17, 58, 4, 3, 1, 1, 2, 83, 85, 92, 1, 92, 3, 58, '506.1.10.21.GT', '09.10.21', 'ASDF', 'PORUEBAS', '2021-09-21 22:49:37', '2021-09-22', 2, b'11111'),
(18, 58, 4, 3, 2, 2, 2, 83, 85, 92, 1, 92, 5, 58, '506.1.11.21.GT', '09.11.21', 'ASADF', '', '2021-09-22 20:29:24', '2021-09-22', 2, b'11111'),
(19, 58, 4, 3, 0, 0, 2, 0, 85, 0, 0, 0, 0, 58, '506..1.70.', '01.1.70', 'ASDF', '', '2021-09-23 20:48:38', '2021-09-23', 0, b'00001'),
(20, 58, 4, 3, 0, 0, 2, 0, 85, 0, 0, 0, 0, 58, '506..2.70.', '01.2.70', 'ASDF', '', '2021-09-23 20:48:40', '2021-09-23', 0, b'00001'),
(21, 58, 4, 3, 0, 0, 2, 0, 85, 0, 0, 0, 0, 58, '506..3.70.', '01.3.70', 'ASDF', '', '2021-09-23 20:48:41', '2021-09-23', 0, b'00001'),
(22, 58, 4, 3, 0, 0, 2, 0, 85, 0, 0, 0, 0, 58, '506..4.70.', '01.4.70', 'ASDF', '', '2021-09-23 20:48:41', '2021-09-23', 0, b'00001'),
(23, 58, 4, 3, 0, 0, 2, 0, 85, 0, 0, 0, 0, 58, '506..5.70.', '01.5.70', 'ASDF', '', '2021-09-23 20:48:41', '2021-09-23', 0, b'00001'),
(24, 58, 4, 3, 0, 0, 2, 0, 85, 0, 0, 0, 0, 58, '506..6.70.', '01.6.70', 'ASDF', '', '2021-09-23 20:48:41', '2021-09-23', 0, b'00001'),
(25, 58, 4, 3, 0, 0, 2, 0, 85, 0, 0, 0, 0, 58, '506..7.70.', '01.7.70', 'ASDF', '', '2021-09-23 20:48:42', '2021-09-23', 0, b'00001'),
(26, 58, 4, 3, 0, 0, 2, 0, 85, 0, 0, 0, 0, 58, '506..8.70.', '01.8.70', 'ASDF', '', '2021-09-23 20:48:42', '2021-09-23', 0, b'00001'),
(27, 58, 4, 3, 0, 0, 2, 0, 85, 0, 0, 0, 0, 58, '506..9.70.', '01.9.70', 'ASDF', '', '2021-09-23 20:48:47', '2021-09-23', 0, b'00001'),
(29, 58, 4, 3, 2, 1, 2, 83, 85, 92, 4, 92, 5, 58, '506.1.12.21.GT', '11.1.21', 'PRUEBA', 'COMENTARIOS', '2021-11-04 22:35:42', '2021-11-04', 4, b'00001');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empaque`
--

CREATE TABLE `empaque` (
  `id_empaque` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `nombre` varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `empaque`
--

INSERT INTO `empaque` (`id_empaque`, `id_sucursal`, `nombre`) VALUES
(1, 4, 'Cajas'),
(2, 4, 'Cartones'),
(3, 1, 'Cartones'),
(4, 2, 'Cartones');

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
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_giro_negocio` int(11) NOT NULL DEFAULT 0,
  `id_tamano_empresa` int(11) NOT NULL DEFAULT 0,
  `id_tipo_carga` int(11) NOT NULL DEFAULT 0,
  `id_canal_distribucion` int(11) NOT NULL DEFAULT 0,
  `id_aslo` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id_empresa`, `id_sucursal`, `id_usuario`, `id_pais`, `Razons`, `Nombrec`, `identificacion`, `direccion`, `telefono`, `Tipoe`, `codigo`, `estado`, `porcentaje_comision`, `tipo_comision`, `fecha`, `id_giro_negocio`, `id_tamano_empresa`, `id_tipo_carga`, `id_canal_distribucion`, `id_aslo`) VALUES
(80, 4, 58, 59, 'SERCOGUA CR', 'SERVICIOS COMERCIALES DE GUATEMALA COSTARICA', '56231', 'CIUDAD COSTARICA', '50623037000', 'CO', '1', 1, 0, 'cbm', '2021-08-12 06:00:00', 0, 0, 0, 0, 0),
(81, 4, 58, 59, 'CLIENTE 1 DE COSTARICA', 'CLIENTE 1 DE COSTARICA', '698574', 'CIUDAD DE COSTARICA', '4569852', 'CL', '1', 1, 0, 'cbm', '2021-08-12 06:00:00', 1, 1, 1, 1, 58),
(82, 4, 58, 59, 'CTM', 'CTM', '59874', 'COSTA RICA', '1236548', 'CO', '2', 1, 0, 'tarifa', '2021-08-24 15:43:58', 0, 0, 0, 0, 0),
(83, 4, 58, 47, 'LEADER GROUP', 'LEADER', '2365458', 'CHINA', '115698854', 'AE', '1', 1, 0, '', '2021-09-02 15:44:15', 0, 0, 0, 0, 0),
(84, 4, 58, 111, 'ONE', 'ONE', '45698', 'JAPON', '458789', 'AE', '2', 1, 0, '', '2021-09-02 16:39:00', 0, 0, 0, 0, 0),
(85, 4, 58, 100, 'LEADER OCEAN', 'LEADER OCEAN', '45896', 'HONG KONG', '5987', 'NA', '1', 1, 0, '', '2021-09-02 16:44:27', 0, 0, 0, 0, 0),
(86, 4, 58, 73, 'EMPRESA DE COLOADER', 'EMPRESA DE COLOADER', '120393918', 'ESPA&Ntilde;A', '101928948', 'AC', '1', 1, 0, '', '2021-09-02 16:59:48', 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `envio_courier`
--

CREATE TABLE `envio_courier` (
  `id_envio_courier` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `envio_courier`
--

INSERT INTO `envio_courier` (`id_envio_courier`, `nombre`) VALUES
(1, 'E-mail'),
(2, 'Fax'),
(3, 'Guia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `giro_negocio`
--

CREATE TABLE `giro_negocio` (
  `id_giro_negocio` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `giro_negocio`
--

INSERT INTO `giro_negocio` (`id_giro_negocio`, `nombre`) VALUES
(1, 'giro prueba 1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `housebl`
--

CREATE TABLE `housebl` (
  `id_hbl` int(11) NOT NULL,
  `id_embarque` int(11) NOT NULL,
  `nohbl` varchar(50) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `cliente` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `housebl`
--

INSERT INTO `housebl` (`id_hbl`, `id_embarque`, `nohbl`, `id_venta`, `cliente`) VALUES
(1, 8, 'HBL', 1, 'CLIETEN 1'),
(2, 18, 'HBL', 1, 'ASDFSADF');

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
(52, 3, 3, 6, '123456', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1608505306.png', 'Manuel', 'De La Cruz', 'manuelcruz86@gmail.com', 1),
(53, 1, 1, 5, '1234', '1234', '', 'maritza', 'De La Cruz', 'itguatemala@gmail.com', 1),
(58, 4, 1, 6, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1636154948.png', 'Manuel de la cruz', 'lopez', 'itguatemala@gmail.com', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `masterbl`
--

CREATE TABLE `masterbl` (
  `id_mbl` int(11) NOT NULL,
  `id_embarque` int(11) NOT NULL,
  `nombl` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `masterbl`
--

INSERT INTO `masterbl` (`id_mbl`, `id_embarque`, `nombl`) VALUES
(1, 8, 'MBL');

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
(20, 'Kardex', 19),
(21, 'Operaciones', 0),
(22, 'Maritimo', 21),
(23, 'Bancos', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moneda`
--

CREATE TABLE `moneda` (
  `id_moneda` int(11) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `signo` varchar(5) NOT NULL,
  `nombre` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `moneda`
--

INSERT INTO `moneda` (`id_moneda`, `id_pais`, `signo`, `nombre`) VALUES
(1, 59, '₡.', 'Colon'),
(2, 99, 'L.', 'Lempira'),
(3, 92, 'Q.', 'Quetzal'),
(4, 144, 'MN$.', 'Peso Mexicano'),
(5, 75, '$.', 'Dolar'),
(6, 157, 'C$.', 'Cordoba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientobancario`
--

CREATE TABLE `movimientobancario` (
  `id_movimiento` int(11) NOT NULL,
  `id_banco` int(11) NOT NULL,
  `id_cuenta` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_tipo_operacion` int(11) NOT NULL,
  `monto` decimal(18,2) NOT NULL,
  `comision` decimal(18,2) NOT NULL,
  `fecha_operacion` date NOT NULL,
  `no_operacion` varchar(75) NOT NULL,
  `beneficiario` varchar(100) NOT NULL,
  `observaciones` varchar(500) NOT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `fechagraba` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `movimientobancario`
--

INSERT INTO `movimientobancario` (`id_movimiento`, `id_banco`, `id_cuenta`, `id_sucursal`, `id_usuario`, `id_tipo_operacion`, `monto`, `comision`, `fecha_operacion`, `no_operacion`, `beneficiario`, `observaciones`, `estado`, `fechagraba`) VALUES
(1, 1, 5, 4, 58, 4, '8.00', '0.00', '2021-10-18', '878', 'PRUE BAS DE NOMBRE', 'OBSER', 1, '2021-10-18 21:15:44'),
(2, 1, 4, 4, 58, 4, '5000.00', '0.00', '2021-10-18', '9865557', 'MANUEL', 'PRUEBAS', 0, '2021-10-18 21:32:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE `pais` (
  `idpais` int(11) NOT NULL,
  `idcontinente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `iniciales` varchar(5) NOT NULL,
  `codigo_area` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`idpais`, `idcontinente`, `nombre`, `iniciales`, `codigo_area`) VALUES
(1, 3, '﻿Abjasia', 'ABJ', ''),
(2, 5, 'Acrotiri y Dhekelia', 'AC', ''),
(3, 3, 'Afganistan', 'AF', ''),
(4, 5, 'Albania', 'AL', ''),
(5, 5, 'Alemania', 'DE', ''),
(6, 5, 'Andorra', 'AD', ''),
(7, 1, 'Angola', 'AO', ''),
(8, 2, 'Anguila', 'AL', ''),
(9, 2, 'Antigua y Barbuda', 'AG', ''),
(10, 3, 'Arabia Saudita', 'AS', ''),
(11, 1, 'Argelia', 'DZ', ''),
(12, 2, 'Argentina', 'AR', ''),
(13, 4, 'Armenia', 'AM', ''),
(14, 2, 'Aruba', 'AW', ''),
(15, 8, 'Australia', 'AU', ''),
(16, 5, 'Austria', 'AT', ''),
(17, 4, 'Azerbaiyan', 'AZ', ''),
(18, 2, 'Bahamas', 'BS', ''),
(19, 3, 'Barein', 'BRE', ''),
(20, 3, 'Banglades', 'BD', ''),
(21, 2, 'Barbados', 'BB', ''),
(22, 5, 'Belgica', 'BE', ''),
(23, 2, 'Belize', 'BZ', ''),
(24, 1, 'Benín', 'BJ', ''),
(25, 2, 'Bermudas', 'GB', ''),
(26, 5, 'Bielorrusia', 'BM', ''),
(27, 3, 'Birmania', 'MYA', ''),
(28, 2, 'Bolivia', 'BOL', ''),
(29, 5, 'Bosnia y Herzegovina', 'BIH', ''),
(30, 1, 'Botsuana', 'BO', ''),
(31, 2, 'Brasil', 'BA', ''),
(32, 3, 'Brunei', 'BRU', ''),
(33, 5, 'Bulgaria', 'BR', ''),
(34, 1, 'Burkina Faso', 'BUR', ''),
(35, 1, 'Burundi', 'BG', ''),
(36, 3, 'Butan', 'BI', ''),
(37, 1, 'Cabo Verde', 'CV', ''),
(38, 2, 'Caiman Islas', 'KY', ''),
(39, 3, 'Camboya', 'CAM', ''),
(40, 1, 'Camerún', 'CMR', ''),
(41, 2, 'Canadá', 'CA', ''),
(42, 3, 'Catar', 'QAT', ''),
(43, 1, 'Centroafricana República', 'CAF', ''),
(44, 1, 'Chad', 'CHA', ''),
(45, 5, 'Checa República', 'CZE', ''),
(46, 2, 'Chile', 'CL', ''),
(47, 3, 'China', 'CHN', ''),
(48, 4, 'Chipre', 'CY', ''),
(49, 4, 'Chipre del Norte', 'CYN', ''),
(50, 3, 'Cocos Islas', 'CC', ''),
(51, 2, 'Colombia', 'CO', ''),
(52, 1, 'Comoras', 'COM', ''),
(53, 1, 'Congo República del', 'CGO', ''),
(54, 1, 'Congo República Democrática del', 'COD', ''),
(55, 8, 'Cook Islas', 'CK', ''),
(56, 3, 'Corea del Norte', 'KP', ''),
(57, 3, 'Corea del Sur', 'KOR', ''),
(58, 1, 'Costa de Marfil', 'CIV', ''),
(59, 2, 'Costa Rica', 'CR', '506'),
(60, 5, 'Croacia', 'CRO', ''),
(61, 2, 'Cuba', 'CU', ''),
(62, 2, 'Curazao', 'CW', ''),
(63, 5, 'Dinamarca', 'DEN', ''),
(64, 2, 'Dominica', 'DMA', ''),
(65, 2, 'Dominicana República', 'DOM', ''),
(66, 2, 'Ecuador', 'EC', ''),
(67, 1, 'Egipto', 'EG', ''),
(68, 2, 'El Salvador', 'SV', ''),
(69, 3, 'Emiratos Árabes Unidos', 'AE', ''),
(70, 1, 'Eritrea', 'ERI', ''),
(71, 5, 'Eslovaquia', 'SVK', ''),
(72, 5, 'Eslovenia', 'SLO', ''),
(73, 5, 'España', 'ES', ''),
(74, 3, 'Estado Islámico', 'EIS', ''),
(75, 2, 'Estados Unidos', 'US', ''),
(76, 5, 'Estonia', 'EST', ''),
(77, 1, 'Etiopía', 'ETH', ''),
(78, 5, 'Feroe Islas', 'FRO', ''),
(79, 3, 'Filipinas', 'PHI', ''),
(80, 5, 'Finlandia', 'FIN', ''),
(81, 8, 'Fiyi', 'FIJ', ''),
(82, 5, 'Francia', 'FR', ''),
(83, 1, 'Gabón', 'GAB', ''),
(84, 1, 'Gambia', 'GAM', ''),
(85, 4, 'Georgia', 'GEO', ''),
(86, 1, 'Ghana', 'GHA', ''),
(87, 5, 'Gibraltar', 'GBZ', ''),
(88, 2, 'Granada', 'GRN', ''),
(89, 5, 'Grecia', 'GRE', ''),
(90, 2, 'Groenlandia', 'GL', ''),
(91, 8, 'Guam', 'GU', ''),
(92, 2, 'Guatemala', 'GT', '502'),
(93, 5, 'Guernsey', 'GG', ''),
(94, 1, 'Guinea', 'GUI', ''),
(95, 1, 'Guinea-Bisáu', 'GBS', ''),
(96, 1, 'Guinea Ecuatorial', 'GEQ', ''),
(97, 2, 'Guyana', 'GUY', ''),
(98, 2, 'Haití', 'HAI', ''),
(99, 2, 'Honduras', 'HN', ''),
(100, 3, 'Hong Kong', 'HK', ''),
(101, 5, 'Hungría', 'HUN', ''),
(102, 3, 'India', 'IND', ''),
(103, 3, 'Indonesia', 'INA', ''),
(104, 3, 'Irak', 'IRQ', ''),
(105, 3, 'Irán', 'IRI', ''),
(106, 5, 'Irlanda', 'IRL', ''),
(107, 5, 'Islandia', 'ISL', ''),
(108, 3, 'Israel', 'ISR', ''),
(109, 5, 'Italia', 'ITA', ''),
(110, 2, 'Jamaica', 'JAM', ''),
(111, 3, 'Japón', 'JPN', ''),
(112, 5, 'Jersey', 'JE', ''),
(113, 3, 'Jordania', 'JOR', ''),
(114, 4, 'Kazajistán', 'KAZ', ''),
(115, 1, 'Kenia', 'KEN', ''),
(116, 3, 'Kirguistán', 'KGZ', ''),
(117, 8, 'Kiribati', 'KIR', ''),
(118, 5, 'Kosovo', 'RKS', ''),
(119, 3, 'Kuwait', 'KUW', ''),
(120, 3, 'Laos', 'LAO', ''),
(121, 1, 'Lesoto', 'LES', ''),
(122, 5, 'Letonia', 'LV', ''),
(123, 3, 'Líbano', 'LIB', ''),
(124, 1, 'Liberia', 'LB', ''),
(125, 1, 'Libia', 'LBA', ''),
(126, 5, 'Liechtenstein', 'LIE', ''),
(127, 5, 'Lituania', 'LTU', ''),
(128, 5, 'Luxemburgo', 'LUX', ''),
(129, 3, 'Macao', 'MO', ''),
(130, 5, 'Macedonia', 'MKD', ''),
(131, 1, 'Madagascar', 'MAD', ''),
(132, 3, 'Malasia', 'MAS', ''),
(133, 1, 'Malaui', 'MAW', ''),
(134, 3, 'Maldivas', 'MDV', ''),
(135, 1, 'Malí', 'MLI', ''),
(136, 5, 'Malta', 'MLT', ''),
(137, 2, 'Malvinas, Islas', 'MIS', ''),
(138, 5, 'Man Isla de', 'ISM', ''),
(139, 8, 'Marianas del Norte Islas', 'NIM', ''),
(140, 1, 'Marruecos', 'MAR', ''),
(141, 8, 'Marshall Islas', 'MHL', ''),
(142, 1, 'Mauricio', 'MRI', ''),
(143, 1, 'Mauritania', 'MTN', ''),
(144, 2, 'México', 'MX', ''),
(145, 8, 'Micronesia', 'MCA', ''),
(146, 5, 'Moldavia', 'MDA', ''),
(147, 5, 'Mónaco', 'MON ', ''),
(148, 3, 'Mongolia', 'MGL', ''),
(149, 5, 'Montenegro', 'MNE', ''),
(150, 2, 'Montserrat', 'MSR', ''),
(151, 1, 'Mozambique', 'MOZ', ''),
(152, 4, 'Nagorno Karabaj', 'NKJ', ''),
(153, 1, 'Namibia', 'NAM', ''),
(154, 8, 'Nauru', 'NRU', ''),
(155, 3, 'Navidad Isla de', 'IDN', ''),
(156, 3, 'Nepal', 'NEP', ''),
(157, 2, 'Nicaragua', 'NI', ''),
(158, 1, 'Níger', 'NIG', ''),
(159, 1, 'Nigeria', 'NGR', ''),
(160, 8, 'Niue', 'UN', ''),
(161, 8, 'Norfolk Isla', 'INK', ''),
(162, 5, 'Noruega', 'NOR', ''),
(163, 8, 'Nueva Caledonia', 'NC', ''),
(164, 5, 'Nueva Rusia', 'NR', ''),
(165, 8, 'Nueva Zelanda', 'NZL', ''),
(166, 3, 'Omán', 'OMA', ''),
(167, 4, 'Osetia del Sur', 'OS', ''),
(168, 5, 'Países Bajos', 'NED', ''),
(169, 3, 'Pakistán', 'PAK', ''),
(170, 8, 'Palaos', 'PL', ''),
(171, 3, 'Palestina', 'PS', ''),
(172, 2, 'Panamá', 'PA', ''),
(173, 8, 'Papúa Nueva Guinea', 'PNG', ''),
(174, 2, 'Paraguay', 'PY', ''),
(175, 2, 'Perú', 'PER', ''),
(176, 8, 'Pitcairn Islas', 'IP', ''),
(177, 8, 'Polinesia Francesa', 'PF', ''),
(178, 5, 'Polonia', 'POL', ''),
(179, 5, 'Portugal', 'POR', ''),
(180, 2, 'Puerto Rico', 'PR', ''),
(181, 5, 'Reino Unido', 'RU', ''),
(182, 1, 'Ruanda', 'RUD', ''),
(183, 5, 'Rumania', 'RO', ''),
(184, 6, 'Rusia', 'RUS', ''),
(185, 1, 'Sahara Occidental', 'SO', ''),
(186, 8, 'Salomón Islas', 'ISM', ''),
(187, 8, 'Samoa', 'SAM', ''),
(188, 8, 'Samoa Americana', 'AS', ''),
(189, 2, 'San Bartolomé', 'SB', ''),
(190, 2, 'San Cristóbal y Nieves', 'SCN', ''),
(191, 5, 'San Marino', 'SM', ''),
(192, 2, 'San Martín', 'SMN', ''),
(193, 2, 'Sint Maarten', 'SMT', ''),
(194, 2, 'San Pedro y Miquelón', 'SPM', ''),
(195, 2, 'San Vicente y las Granadinas', 'SVG', ''),
(196, 7, 'Santa Elena  Ascensión y Tristán de Acuña', 'SET', ''),
(197, 2, 'Santa Lucía', 'STL', ''),
(198, 1, 'Santo Tomé y Príncipe', 'STP', ''),
(199, 1, 'Senegal', 'SEN', ''),
(200, 5, 'Serbia', 'SRB', ''),
(201, 1, 'Seychelles', 'SEY', ''),
(202, 1, 'Sierra Leona', 'SLE', ''),
(203, 3, 'Singapur', 'SIN', ''),
(204, 3, 'Siria', 'SYR', ''),
(205, 1, 'Somalia', 'SOM', ''),
(206, 1, 'Somalilandia', 'SOD', ''),
(207, 3, 'Sri Lanka', 'SLK', ''),
(208, 1, 'Suazilandia', 'SWZ', ''),
(209, 1, 'Sudáfrica', 'ZA', ''),
(210, 1, 'Sudán', 'SUD', ''),
(211, 1, 'Sudán del Sur', 'SDS', ''),
(212, 5, 'Suecia', 'SE', ''),
(213, 5, 'Suiza', 'SUI', ''),
(214, 2, 'Surinam', 'SUR', ''),
(215, 5, 'Svalbard', 'SVD', ''),
(216, 3, 'Tailandia', 'THA', ''),
(217, 3, 'Taiwán', 'TW', ''),
(218, 1, 'Tanzania', 'TAN', ''),
(219, 3, 'Tayikistán', 'TJ', ''),
(220, 3, 'Timor Oriental', 'TL', ''),
(221, 1, 'Togo', 'TG', ''),
(222, 8, 'Tokelau', 'TK', ''),
(223, 8, 'Tonga', 'TGA', ''),
(224, 5, 'Transnistria', 'TNA', ''),
(225, 2, 'Trinidad y Tobago', 'TT', ''),
(226, 1, 'Túnez', 'TN', ''),
(227, 2, 'Turcas y Caicos Islas', 'ITC', ''),
(228, 3, 'Turkmenistán', 'TKM', ''),
(229, 4, 'Turquía', 'TUR', ''),
(230, 8, 'Tuvalu', 'TUV', ''),
(231, 5, 'Ucrania', 'UKR', ''),
(232, 1, 'Uganda', 'UGA', ''),
(233, 2, 'Uruguay', 'URU', ''),
(234, 3, 'Uzbekistán', 'UZB', ''),
(235, 8, 'Vanuatu', 'VNT', ''),
(236, 5, 'Vaticano Ciudad del', 'CDV', ''),
(237, 2, 'Venezuela', 'VEN', ''),
(238, 3, 'Vietnam', 'VIE', ''),
(239, 2, 'Vírgenes Británicas Islas', 'IVB', ''),
(240, 2, 'Vírgenes de los Estados Unidos Islas', 'IVU', ''),
(241, 8, 'Wallis y Futuna', 'WF', ''),
(242, 3, 'Yemen', 'YM', ''),
(243, 1, 'Yibuti', 'YT', ''),
(244, 1, 'Zambia', 'ZB', ''),
(245, 1, 'Zimbabue', 'ZBB', '');

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
-- Estructura de tabla para la tabla `plantilla_calculoa`
--

CREATE TABLE `plantilla_calculoa` (
  `id_plantilla` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `tarifa_minima` float NOT NULL,
  `moneda` int(11) NOT NULL,
  `dias_libres` int(11) NOT NULL,
  `omitir_almacenaje` int(11) NOT NULL,
  `fecha_grabacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `plantilla_calculoa`
--

INSERT INTO `plantilla_calculoa` (`id_plantilla`, `id_usuario`, `id_sucursal`, `nombre`, `tarifa_minima`, `moneda`, `dias_libres`, `omitir_almacenaje`, `fecha_grabacion`) VALUES
(1, 52, 3, 'calculo 18%', 8006, 5, 13, 0, '2021-04-11'),
(2, 52, 3, 'calculo 30%', 800, 3, 12, 1, '2021-04-11'),
(3, 52, 3, 'calculo sercogua 26', 900, 3, 15, 1, '2021-04-13'),
(4, 58, 4, 'Plantilla Normal', 80000, 1, 10, 0, '2021-08-12');

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
  `codigo` varchar(30) NOT NULL,
  `impuesto` decimal(10,2) DEFAULT NULL,
  `financiacion` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`id_sucursal`, `razons`, `nombrec`, `Telefono`, `identificacion`, `direccion`, `logo`, `fechaingreso`, `estado`, `idpais`, `codigo`, `impuesto`, `financiacion`) VALUES
(1, 'ALAMDISA DE NICARAGUA', 'ALMADISA DE NICARAGUA', '50222123085', 'identi', 'nicaragua', '', '2021-01-20', 1, 0, 'ALMNI3', '0.15', '1.00'),
(2, 'Servicios Comerciales de Guatemala', 'Sercogua', '50223037000', '22354589', '0 calle b 17-10 colonia el maestro zona 15, Guatemala', 'logo2.jfif', '2021-01-06', 1, 92, 'SERGT1', '0.12', '1.00'),
(3, 'Almacenamiento Manejo y Distribuci&oacute;n de Guatemala', 'Almadisa', '50222123085', '123445', 'Interior Alpasa', '', '2021-01-06', 1, 92, 'ALMGT1', '0.12', '1.00'),
(4, 'ALMADISA CR', 'ALMACENAMIENTO MANEJO Y DISTRIBUCION COSTA RICA', '50623037000', '123456789101112', 'bodega caldera costa rica', '', '2021-08-11', 1, 59, 'ALMCR4', '0.13', '3.75');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tamano_empresa`
--

CREATE TABLE `tamano_empresa` (
  `id_tamano` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tamano_empresa`
--

INSERT INTO `tamano_empresa` (`id_tamano`, `nombre`) VALUES
(1, 'tamano prueba 1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_carga`
--

CREATE TABLE `tipo_carga` (
  `id_tipo_carga` int(11) NOT NULL,
  `id_tipo_medio` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_carga`
--

INSERT INTO `tipo_carga` (`id_tipo_carga`, `id_tipo_medio`, `nombre`) VALUES
(1, 1, 'Guia'),
(2, 1, 'Courier'),
(3, 2, 'FCL/FCL'),
(4, 2, 'FCL/LCL'),
(5, 2, 'LCL/LCL'),
(6, 2, 'LCL/FCL'),
(7, 2, 'Coloader'),
(8, 3, 'FTL'),
(9, 3, 'LTL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_carga_empresa`
--

CREATE TABLE `tipo_carga_empresa` (
  `id_tipo_carga_empresa` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_carga_empresa`
--

INSERT INTO `tipo_carga_empresa` (`id_tipo_carga_empresa`, `nombre`) VALUES
(1, 'tipo carga 1 prueba'),
(2, 'tipo carga 1 prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `id_tipo_documento` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_documento`
--

INSERT INTO `tipo_documento` (`id_tipo_documento`, `nombre`) VALUES
(1, 'HBL'),
(2, 'MBL'),
(3, 'HAWB'),
(4, 'MAWB'),
(5, 'CP'),
(6, 'INV'),
(7, 'FAC'),
(8, 'MAN'),
(9, 'PKL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_medio`
--

CREATE TABLE `tipo_medio` (
  `id_tipo_medio` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_medio`
--

INSERT INTO `tipo_medio` (`id_tipo_medio`, `nombre`) VALUES
(1, 'Aereo'),
(2, 'Maritimo'),
(3, 'Terrestre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_operacion_bancos`
--

CREATE TABLE `tipo_operacion_bancos` (
  `id_tipo_operacion` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_operacion_bancos`
--

INSERT INTO `tipo_operacion_bancos` (`id_tipo_operacion`, `nombre`) VALUES
(1, 'CHE'),
(2, 'DEP'),
(3, 'TRA'),
(4, 'ACH'),
(5, 'TCR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_servicio`
--

CREATE TABLE `tipo_servicio` (
  `id_tipo_servicio` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_servicio`
--

INSERT INTO `tipo_servicio` (`id_tipo_servicio`, `nombre`) VALUES
(1, 'Importacion'),
(2, 'Exportacion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_ro`
--

CREATE TABLE `venta_ro` (
  `id_venta` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `numero` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `venta_ro`
--

INSERT INTO `venta_ro` (`id_venta`, `id_sucursal`, `numero`) VALUES
(1, 4, '1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `almacen`
--
ALTER TABLE `almacen`
  ADD PRIMARY KEY (`id_almacen`);

--
-- Indices de la tabla `archivos_embarques`
--
ALTER TABLE `archivos_embarques`
  ADD PRIMARY KEY (`id_archivos`);

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
-- Indices de la tabla `banco`
--
ALTER TABLE `banco`
  ADD PRIMARY KEY (`id_banco`);

--
-- Indices de la tabla `barco`
--
ALTER TABLE `barco`
  ADD PRIMARY KEY (`id_barco`);

--
-- Indices de la tabla `calculo_almacen`
--
ALTER TABLE `calculo_almacen`
  ADD PRIMARY KEY (`id_calculo`);

--
-- Indices de la tabla `canal_distribucion`
--
ALTER TABLE `canal_distribucion`
  ADD PRIMARY KEY (`id_canal_distribucion`);

--
-- Indices de la tabla `catalogo`
--
ALTER TABLE `catalogo`
  ADD PRIMARY KEY (`id_catalogo`);

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`id_ciudad`);

--
-- Indices de la tabla `consecutivos`
--
ALTER TABLE `consecutivos`
  ADD PRIMARY KEY (`id_consecutivo`);

--
-- Indices de la tabla `contactos_e`
--
ALTER TABLE `contactos_e`
  ADD PRIMARY KEY (`id_contacto`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `contenedor`
--
ALTER TABLE `contenedor`
  ADD PRIMARY KEY (`id_contenedor`);

--
-- Indices de la tabla `continente`
--
ALTER TABLE `continente`
  ADD PRIMARY KEY (`nombre`),
  ADD UNIQUE KEY `idcontinente_UNIQUE` (`idcontinente`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `correlativoagente`
--
ALTER TABLE `correlativoagente`
  ADD PRIMARY KEY (`id_correlativo`);

--
-- Indices de la tabla `correlativo_almacen`
--
ALTER TABLE `correlativo_almacen`
  ADD PRIMARY KEY (`idcorrelativo`);

--
-- Indices de la tabla `cuentabancaria`
--
ALTER TABLE `cuentabancaria`
  ADD PRIMARY KEY (`idcuenta_bancaria`);

--
-- Indices de la tabla `depto`
--
ALTER TABLE `depto`
  ADD PRIMARY KEY (`id_depto`);

--
-- Indices de la tabla `descuentocalculo`
--
ALTER TABLE `descuentocalculo`
  ADD PRIMARY KEY (`id_descuento`);

--
-- Indices de la tabla `detalle_almacen`
--
ALTER TABLE `detalle_almacen`
  ADD PRIMARY KEY (`id_detalle`);

--
-- Indices de la tabla `detalle_calculo`
--
ALTER TABLE `detalle_calculo`
  ADD PRIMARY KEY (`id_detalle_calculo`);

--
-- Indices de la tabla `detalle_plantillaa`
--
ALTER TABLE `detalle_plantillaa`
  ADD PRIMARY KEY (`id_detalle`);

--
-- Indices de la tabla `documentos_embarque`
--
ALTER TABLE `documentos_embarque`
  ADD PRIMARY KEY (`id_documentos`);

--
-- Indices de la tabla `embarque_maritimo`
--
ALTER TABLE `embarque_maritimo`
  ADD PRIMARY KEY (`id_embarque_maritimo`);

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
-- Indices de la tabla `envio_courier`
--
ALTER TABLE `envio_courier`
  ADD PRIMARY KEY (`id_envio_courier`);

--
-- Indices de la tabla `giro_negocio`
--
ALTER TABLE `giro_negocio`
  ADD PRIMARY KEY (`id_giro_negocio`);

--
-- Indices de la tabla `housebl`
--
ALTER TABLE `housebl`
  ADD PRIMARY KEY (`id_hbl`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `masterbl`
--
ALTER TABLE `masterbl`
  ADD PRIMARY KEY (`id_mbl`);

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
-- Indices de la tabla `movimientobancario`
--
ALTER TABLE `movimientobancario`
  ADD PRIMARY KEY (`id_movimiento`);

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
-- Indices de la tabla `plantilla_calculoa`
--
ALTER TABLE `plantilla_calculoa`
  ADD PRIMARY KEY (`id_plantilla`);

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
-- Indices de la tabla `tamano_empresa`
--
ALTER TABLE `tamano_empresa`
  ADD PRIMARY KEY (`id_tamano`);

--
-- Indices de la tabla `tipo_carga`
--
ALTER TABLE `tipo_carga`
  ADD PRIMARY KEY (`id_tipo_carga`);

--
-- Indices de la tabla `tipo_carga_empresa`
--
ALTER TABLE `tipo_carga_empresa`
  ADD PRIMARY KEY (`id_tipo_carga_empresa`);

--
-- Indices de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`id_tipo_documento`);

--
-- Indices de la tabla `tipo_medio`
--
ALTER TABLE `tipo_medio`
  ADD PRIMARY KEY (`id_tipo_medio`);

--
-- Indices de la tabla `tipo_operacion_bancos`
--
ALTER TABLE `tipo_operacion_bancos`
  ADD PRIMARY KEY (`id_tipo_operacion`);

--
-- Indices de la tabla `tipo_servicio`
--
ALTER TABLE `tipo_servicio`
  ADD PRIMARY KEY (`id_tipo_servicio`);

--
-- Indices de la tabla `venta_ro`
--
ALTER TABLE `venta_ro`
  ADD PRIMARY KEY (`id_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `almacen`
--
ALTER TABLE `almacen`
  MODIFY `id_almacen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `archivos_embarques`
--
ALTER TABLE `archivos_embarques`
  MODIFY `id_archivos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `asigna_menu`
--
ALTER TABLE `asigna_menu`
  MODIFY `idasigna_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202;

--
-- AUTO_INCREMENT de la tabla `asigna_moneda`
--
ALTER TABLE `asigna_moneda`
  MODIFY `id_asigna_moneda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `banco`
--
ALTER TABLE `banco`
  MODIFY `id_banco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `barco`
--
ALTER TABLE `barco`
  MODIFY `id_barco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `calculo_almacen`
--
ALTER TABLE `calculo_almacen`
  MODIFY `id_calculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `canal_distribucion`
--
ALTER TABLE `canal_distribucion`
  MODIFY `id_canal_distribucion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `catalogo`
--
ALTER TABLE `catalogo`
  MODIFY `id_catalogo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `id_ciudad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `consecutivos`
--
ALTER TABLE `consecutivos`
  MODIFY `id_consecutivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `contactos_e`
--
ALTER TABLE `contactos_e`
  MODIFY `id_contacto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `contenedor`
--
ALTER TABLE `contenedor`
  MODIFY `id_contenedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `correlativoagente`
--
ALTER TABLE `correlativoagente`
  MODIFY `id_correlativo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `correlativo_almacen`
--
ALTER TABLE `correlativo_almacen`
  MODIFY `idcorrelativo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT de la tabla `cuentabancaria`
--
ALTER TABLE `cuentabancaria`
  MODIFY `idcuenta_bancaria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `depto`
--
ALTER TABLE `depto`
  MODIFY `id_depto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `descuentocalculo`
--
ALTER TABLE `descuentocalculo`
  MODIFY `id_descuento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `detalle_almacen`
--
ALTER TABLE `detalle_almacen`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_calculo`
--
ALTER TABLE `detalle_calculo`
  MODIFY `id_detalle_calculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `detalle_plantillaa`
--
ALTER TABLE `detalle_plantillaa`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `documentos_embarque`
--
ALTER TABLE `documentos_embarque`
  MODIFY `id_documentos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `embarque_maritimo`
--
ALTER TABLE `embarque_maritimo`
  MODIFY `id_embarque_maritimo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `empaque`
--
ALTER TABLE `empaque`
  MODIFY `id_empaque` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `envio_courier`
--
ALTER TABLE `envio_courier`
  MODIFY `id_envio_courier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `giro_negocio`
--
ALTER TABLE `giro_negocio`
  MODIFY `id_giro_negocio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `housebl`
--
ALTER TABLE `housebl`
  MODIFY `id_hbl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de la tabla `masterbl`
--
ALTER TABLE `masterbl`
  MODIFY `id_mbl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `moneda`
--
ALTER TABLE `moneda`
  MODIFY `id_moneda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `movimientobancario`
--
ALTER TABLE `movimientobancario`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
-- AUTO_INCREMENT de la tabla `plantilla_calculoa`
--
ALTER TABLE `plantilla_calculoa`
  MODIFY `id_plantilla` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `puesto`
--
ALTER TABLE `puesto`
  MODIFY `id_puesto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `id_sucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tamano_empresa`
--
ALTER TABLE `tamano_empresa`
  MODIFY `id_tamano` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipo_carga`
--
ALTER TABLE `tipo_carga`
  MODIFY `id_tipo_carga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tipo_carga_empresa`
--
ALTER TABLE `tipo_carga_empresa`
  MODIFY `id_tipo_carga_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `id_tipo_documento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tipo_medio`
--
ALTER TABLE `tipo_medio`
  MODIFY `id_tipo_medio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_operacion_bancos`
--
ALTER TABLE `tipo_operacion_bancos`
  MODIFY `id_tipo_operacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipo_servicio`
--
ALTER TABLE `tipo_servicio`
  MODIFY `id_tipo_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `venta_ro`
--
ALTER TABLE `venta_ro`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
