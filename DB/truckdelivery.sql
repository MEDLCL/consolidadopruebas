-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3307
-- Tiempo de generación: 16-03-2022 a las 00:10:10
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
-- Base de datos: `truckdelivery`
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcListadoCreaMaritimoAsignado` (IN `idsucursal` INT, IN `idusuario` INT)  NO SQL
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
where  EM.estado = 1 and EM.id_sucursal = idsucursal and EM.id_usuario_asignado = idusuario$$

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
            pais as PA on PA.idpais = S.idpais
where L.estado = 1            
order by L.estado,S.id_sucursal$$

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
-- Estructura de tabla para la tabla `archivos_evalua_proyecto`
--

CREATE TABLE `archivos_evalua_proyecto` (
  `id_archivo` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `nombre_archivo` varchar(70) NOT NULL,
  `ubicacion` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `archivos_evalua_proyecto`
--

INSERT INTO `archivos_evalua_proyecto` (`id_archivo`, `id_proyecto`, `nombre_archivo`, `ubicacion`) VALUES
(11, 63, 'IMG_20211122_085512.jpg', '../TRUGT5/2022/EvaluacionProyecto/CT90P19'),
(13, 63, '213889 SOLICITUD GENERADA.pdf', '../TRUGT5/2022/EvaluacionProyecto/CT90P19'),
(14, 63, 'CARTA DE NO FAMILIARES.pdf', '../TRUGT5/2022/EvaluacionProyecto/CT90P19'),
(15, 67, 'Untitled.pdf', '../TRUGT5/2022/EvaluacionProyecto/CT90P21');

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
(201, 58, 23),
(226, 52, 1),
(227, 52, 6),
(228, 52, 7),
(229, 52, 8),
(230, 52, 9),
(231, 52, 10),
(232, 52, 12),
(233, 52, 13),
(234, 52, 14),
(235, 52, 18),
(236, 52, 19),
(237, 52, 20),
(238, 52, 21),
(239, 52, 22),
(292, 223, 1),
(293, 223, 6),
(294, 223, 7),
(295, 223, 8),
(296, 223, 9),
(297, 223, 13),
(298, 223, 15),
(299, 223, 18),
(300, 223, 24),
(301, 223, 25),
(302, 223, 26),
(303, 223, 27);

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
(4, 5, 4),
(5, 3, 5),
(6, 5, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asigna_unidad_proyecto`
--

CREATE TABLE `asigna_unidad_proyecto` (
  `id_asigna_unidad` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `id_tipo_unidad` int(11) NOT NULL,
  `id_tipo_equipo` int(11) NOT NULL,
  `cantidad_unidad` smallint(6) NOT NULL,
  `temperatura` varchar(45) DEFAULT NULL,
  `especificacion` varchar(800) DEFAULT NULL,
  `id_seguridad` int(11) NOT NULL,
  `id_marchamo` int(11) NOT NULL,
  `id_gps` int(11) NOT NULL,
  `lugar_carga` varchar(800) DEFAULT NULL,
  `lugar_descarga` varchar(800) DEFAULT NULL,
  `id_canal_distribucion` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `asigna_unidad_proyecto`
--

INSERT INTO `asigna_unidad_proyecto` (`id_asigna_unidad`, `id_proyecto`, `id_tipo_unidad`, `id_tipo_equipo`, `cantidad_unidad`, `temperatura`, `especificacion`, `id_seguridad`, `id_marchamo`, `id_gps`, `lugar_carga`, `lugar_descarga`, `id_canal_distribucion`) VALUES
(1, 9, 1, 1, 2, '', 'especifiacion', 1, 1, 1, 'lugar de carga', 'lugar descarga', 1),
(2, 9, 1, 1, 2, '', 'especifiacion', 1, 1, 1, 'lugar de carga', 'lugar descarga', 1),
(3, 9, 1, 1, 2, '', 'especifiacion', 1, 1, 1, 'lugar de carga', 'lugar descarga', 1),
(4, 9, 1, 1, 2, '', 'asdfsdf', 1, 1, 1, 'sdfee', 'dfee', 1),
(5, 9, 1, 1, 2, '', 'asdfsdf', 1, 1, 1, 'sdfee', 'dfee', 1),
(6, 9, 2, 1, 2, '', 'fgree', 1, 1, 1, 'asdfsdf', 'asdfsdf', 1),
(7, 9, 1, 1, 3, '', '&ntilde;lk&ntilde;l', 1, 1, 1, 'kñl', 'lkjkl', 1),
(8, 9, 2, 2, 2, '', 'asdf', 1, 1, 1, 'asdf', 'asdf', 1),
(9, 9, 1, 1, 2, '', 'asdf', 1, 1, 1, 'asdf', 'asdf', 1),
(10, 9, 1, 1, 4, '', 'asdf', 1, 1, 1, 'asdf', 'asdf', 1),
(11, 9, 1, 1, 2, '', 'sadf', 1, 1, 1, 'asdf', 'asdf', 1),
(12, 10, 1, 1, 3, '', 'asdfsdf', 1, 1, 1, 'asdf', 'asdf', 1),
(13, 11, 1, 1, 3, '', 'asdf', 1, 1, 1, 'asdf', 'asdf', 2),
(14, 12, 1, 1, 3, '', 'asdfsadf', 1, 1, 1, 'asdf', 'asdf', 2),
(15, 13, 1, 1, 3, '', 'asdf', 1, 1, 1, 'asdf', 'asdf', 2),
(16, 16, 2, 2, 4, '', 'especificacion cambio', 2, 2, 2, 'lugar de carga cambio', 'lugar descarga cambio', 2),
(17, 17, 2, 4, 3, '', 'caract', 2, 2, 2, 'carga', 'descarga', 1),
(18, 36, 1, 1, 2, 'ASDF', 'asdf', 2, 2, 2, 'asdf', 'asdf', 1),
(19, 47, 3, 1, 5, '0', 'equipoasdfs', 1, 2, 1, 'lugar de carga1', 'lugar de descarga1', 1),
(20, 55, 1, 1, 2, '', 'asdf', 2, 2, 2, 'sdf', 'df', 1),
(21, 47, 1, 1, 2, '123', 'asdf', 2, 2, 2, 'asdf', 'asdf', 2),
(22, 60, 2, 1, 4, 'ASDF', 'asdf', 2, 2, 2, 'asdfdsfsdf', 'dfd', 2),
(23, 61, 2, 4, 3, 'ASDF', 'asdf', 2, 2, 2, 'asdfasdf', 'asdfsdf', 1),
(24, 62, 1, 2, 3, 'ASDF1112', 'asdfadffff', 2, 2, 2, 'asdfasdf', 'asdfasdfdsf', 2),
(27, 66, 3, 8, 9, '', 'asdfasdf', 2, 2, 2, 'asdf', 'adsf', 4),
(28, 67, 5, 1, 5, 'EE', 'asdf', 1, 2, 2, 'sac', 'c', 2);

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
  `bandera` varchar(75) DEFAULT NULL,
  `idBarco` int(11) NOT NULL,
  `Estado` bit(1) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `fechaIngreso` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `idUsuarioModifica` int(11) NOT NULL,
  `id_sucursal` int(11) DEFAULT NULL,
  `fechamodificacion` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tipo` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `barco`
--

INSERT INTO `barco` (`id_barco`, `nombre`, `bandera`, `idBarco`, `Estado`, `idUsuario`, `fechaIngreso`, `idUsuarioModifica`, `id_sucursal`, `fechamodificacion`, `tipo`) VALUES
(5, 'MAERKS ANTARES', NULL, 1, b'1', 1, '2007-12-27 00:35:00', 131, 2, '2017-09-19 20:05:00', NULL),
(6, 'SCOTIA', NULL, 2, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2012-11-16 19:40:00', NULL),
(7, 'CONTI CARTAGENA', NULL, 3, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(8, 'PRES TRUMAN', NULL, 4, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(9, 'PRES JACKSON', NULL, 5, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(10, 'ARKONA TRADER', NULL, 6, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(11, 'ARKONA', NULL, 7, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(12, 'CONTI  CARTAGENA', NULL, 8, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(13, 'APL QUETZAL', NULL, 9, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(14, 'COLUMBUS CHINA', NULL, 10, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(15, 'CALIFORNIA MERCURY', NULL, 11, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(16, 'PRES TRUMAN', NULL, 12, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(17, 'APL IVORY', NULL, 13, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(18, 'SEABOARD STAR', NULL, 14, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(19, 'COLUMBUS CHILE', NULL, 15, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(20, 'DA QING HE', NULL, 16, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(21, 'SUN ADMIRAL', NULL, 17, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(22, 'MOL INITIATIVE', NULL, 18, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(23, 'P&O NEDLLOYD MERCATOR', NULL, 19, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(24, 'CCNI ARICA', NULL, 20, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(25, 'SANTA FEDERICA', NULL, 21, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(26, 'CCNI ARICA', NULL, 22, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(27, 'P&O NEDLLOYD MERCATOR', NULL, 23, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(28, 'IRENES LOGOS', NULL, 24, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(29, 'PRESIDENT KENNEDY', NULL, 25, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(30, 'PRESIDENT ADAMS', NULL, 26, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(31, 'APL ALEXANDRITE', NULL, 27, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(32, 'POS CHALLENGE', NULL, 28, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(33, 'HP-1288', NULL, 29, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(34, 'PRESIDENT POL V.151E', NULL, 30, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(35, 'DONATA SCHULTE', NULL, 31, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(36, 'CSAV LIVORNO', NULL, 32, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(37, 'LYKES FLYER', NULL, 33, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(38, 'CORRADO', NULL, 34, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(39, 'WESTERKADE', NULL, 35, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(40, 'STADT DUESSELDORF', NULL, 36, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(41, 'COMANCHE', NULL, 37, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(42, 'APL GUATEMALA', NULL, 38, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(43, 'PANATLANTIC', NULL, 39, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(44, 'NYK LEO', NULL, 40, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(45, 'SEA ADMIRAL', NULL, 41, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(46, 'SL ENDURANCE', NULL, 42, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(47, 'LYKES DELIVERER', NULL, 43, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(48, 'SUMIDA', NULL, 44, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(49, 'SCANDIA', NULL, 45, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(50, 'NEW ORIENT', NULL, 46, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(51, 'TMM TABASCO', NULL, 47, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(52, 'TIAN SHUN', NULL, 48, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(53, 'SEABOARD FLORIDA', NULL, 49, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(54, 'EWL ROTTERDAM', NULL, 50, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(55, 'CCNI ANTARTICO', NULL, 51, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(56, 'TMM YUCATAN', NULL, 52, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(57, 'CSCL TANTAI', NULL, 53, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(58, 'LYKES VOYAGER', NULL, 54, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(59, 'TMM MONTERREY', NULL, 55, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(60, 'SANTA GIULIANA', NULL, 56, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(61, 'SHIMA', NULL, 57, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(62, 'APL PHILIPPINES', NULL, 58, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(63, 'WESTER HERVER V. 1307', NULL, 59, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(64, 'CLARA MAERSK', NULL, 60, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(65, 'SANTA ELENA', NULL, 61, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(66, 'APL TOPAZ', NULL, 62, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(67, 'MARE BALTICUM', NULL, 63, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(68, 'FORWARDERS', NULL, 64, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(69, 'RIDVAN OZERLER V. 0323', NULL, 65, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(70, 'EMERALD SEA', NULL, 66, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(71, 'GLORY', NULL, 67, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(72, 'ANGELA JURGENS', NULL, 68, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(73, 'HEUNG-A OSAKA', NULL, 69, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(74, 'APL ALMANDINE', NULL, 70, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(75, 'FLORIDA WEST', NULL, 71, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(76, 'EDYTH L', NULL, 72, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(77, 'MARWAN', NULL, 73, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(78, 'SANTA GIOVANNA', NULL, 74, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(79, 'CORONA', NULL, 75, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(80, 'EWL CENTRAL AMERICA', NULL, 76, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(81, 'SOGA', NULL, 77, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(82, 'COURTNEY', NULL, 78, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(83, 'PRES POLK', NULL, 79, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(84, 'APL TURQUOISE', NULL, 80, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(85, 'APL TURQUOISE', NULL, 81, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(86, 'APL TURQUOISE', NULL, 82, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(87, 'VUELO', NULL, 83, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(88, 'CCNI ARICA', NULL, 84, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(89, 'DONATA SCHULTE', NULL, 85, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(90, 'CCNI ARICA', NULL, 86, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(91, 'SL EXPLORER', NULL, 87, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(92, 'PRESIDENT POLK', NULL, 88, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(93, 'SETTSU', NULL, 89, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(94, 'MARIA', NULL, 90, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(95, 'MERKUR CLOUD', NULL, 91, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(96, 'YING JIANG', NULL, 92, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(97, 'SUN ADMIRAL S306', NULL, 93, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(98, 'BARBARROSA V06S15', NULL, 94, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(99, 'CHEUNG KEE', NULL, 95, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(100, 'GIRAC AIR CARGO', NULL, 96, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(101, 'PRESIDENT TRUMAN', NULL, 97, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(102, 'LYKES PROVIDER', NULL, 98, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(103, 'MARUBA TRADER', NULL, 99, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(104, 'PONL HOUSTON', NULL, 100, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(105, 'COMANCHE', NULL, 101, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(106, 'COMANCHE', NULL, 102, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(107, 'CMA CGM CHARDIN', NULL, 103, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(108, 'KMTC PUSAN', NULL, 104, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(109, 'TIAN  RONG', NULL, 105, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(110, 'MOL INGENUITY', NULL, 106, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(111, 'TIAN RONG', NULL, 107, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(112, 'SL DEFENDER', NULL, 108, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(113, 'HEUNG-A SEOUL', NULL, 109, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(114, 'CORRADO', NULL, 110, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(115, 'POS ANGEL', NULL, 111, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(116, 'NOBLE', NULL, 112, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(117, 'SANUKI', NULL, 113, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(118, 'MV GLORY', NULL, 114, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(119, 'HAI HE 01', NULL, 115, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(120, 'COMANCHE', NULL, 116, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(121, 'WEHR MUDEN', NULL, 117, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(122, 'COLUMBUS CHILE', NULL, 118, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(123, 'GLORY', NULL, 119, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(124, 'APL CHINA', NULL, 120, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(125, 'SANTA MARGHERITA', NULL, 121, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(126, 'SANTA ELENA', NULL, 122, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(127, 'BUXSUND', NULL, 123, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(128, 'APL THAILAND', NULL, 124, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(129, 'TACA INTERNATIONAL', NULL, 125, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(130, 'SUNNY OAK', NULL, 126, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(131, 'LA LINDA', NULL, 127, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(132, 'NORDLAKE', NULL, 128, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(133, 'CAPE DARNLEY', NULL, 129, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(134, 'APL KOREA', NULL, 130, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(135, 'CROWLEY AMBASSADOR', NULL, 131, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(136, 'TMM YUCATAN', NULL, 132, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(137, 'APL KOREA V. 067-1', NULL, 133, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(138, 'BUXSUND V-302N', NULL, 134, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(139, 'BUXSUND V-302N', NULL, 135, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(140, 'BUXSUND V. 302N', NULL, 136, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(141, 'BUXSUND', NULL, 137, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(142, 'SB FLORIDA', NULL, 138, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(143, 'ARMADA HOLLAND', NULL, 139, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(144, 'IRENES LOGOS', NULL, 140, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(145, 'AMERICANA 2', NULL, 141, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(146, 'ARROW AIR INC.', NULL, 142, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(147, 'SOGA', NULL, 143, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(148, 'PRES TRUMAN', NULL, 144, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(149, 'MONTEVERDE', NULL, 145, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(150, 'ATLANTIC ACTION', NULL, 146, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(151, 'TMM HIDALGO', NULL, 147, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(152, 'MAERSK RIO GRANDE', NULL, 148, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(153, 'APL HONDURAS', NULL, 149, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(154, 'SANTA GIOVANNA', NULL, 150, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(155, 'PURITAN', NULL, 151, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(156, 'PONL DAMMAM', NULL, 152, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(157, 'CALA PONENTE', NULL, 153, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(158, 'CCNI ANTOFAGASTA', NULL, 154, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(159, 'PATSY', NULL, 155, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(160, 'APL PANAMA', NULL, 156, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(161, 'ZIM VIRGINIA', NULL, 157, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(162, 'SANTA GIULIETTA', NULL, 158, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(163, 'APL TOPAZ', NULL, 159, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(164, 'APL SIBNGAPORE', NULL, 160, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(165, 'PU HARMONY', NULL, 161, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(166, 'LIKES EAGLE', NULL, 162, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(167, 'NORDFALCON', NULL, 163, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(168, 'WESTERKADE', NULL, 164, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(169, 'CALA PILAR', NULL, 165, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(170, 'CONTI LA ZPEZIA', NULL, 166, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(171, 'LUO HANG', NULL, 167, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(172, 'SL INNOVATOR', NULL, 168, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(173, 'FELICITAS RICKMERS', NULL, 169, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(174, 'CANMAR DYNASTY', NULL, 170, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(175, 'HYUNDAI VLADIVOSTOK', NULL, 171, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(176, 'TMM AGUASCALIENTES', NULL, 172, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(177, 'MARE BALTICUM', NULL, 173, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(178, 'SEABOARD COSTA RICA', NULL, 174, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(179, 'DORIAN', NULL, 175, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(180, 'CALA PORTOFINO', NULL, 176, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(181, 'CORONA', NULL, 177, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(182, 'CCNI AUSTRAL', NULL, 178, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(183, 'APL HONDURAS', NULL, 179, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(184, 'MOL EFFICIENCY', NULL, 180, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(185, 'TMM COLOMBIA', NULL, 181, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(186, 'LYKES EAGLE', NULL, 182, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(187, 'POLN BUENOS AIRES', NULL, 183, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(188, 'MOL VISSION', NULL, 184, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(189, 'SL LIBERTOR', NULL, 185, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(190, 'APL THAILAND V. 066-1', NULL, 186, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(191, 'NORDLAKE', NULL, 187, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(192, 'MOL ENCORE', NULL, 188, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(193, 'SANTA ISABELLA', NULL, 189, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(194, 'SOGA', NULL, 190, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(195, 'SUNNY OLIVE', NULL, 191, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(196, 'SANTA GIULIETTA', NULL, 192, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(197, 'MOL EXCELLENCE 002-01', NULL, 193, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(198, 'HOHESAND V.001W', NULL, 194, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(199, 'CROWLEY SENATOR', NULL, 195, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(200, 'YANG JIAN HE', NULL, 196, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(201, 'HUA OU', NULL, 197, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(202, 'SAN ANTONIO', NULL, 198, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(203, 'FELICITAS RICKMERS', NULL, 199, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(204, 'HELVETIA D314', NULL, 200, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(205, 'SL EXPLORER', NULL, 201, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(206, 'ANDINO  321EB', NULL, 202, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(207, 'MOL ENDEAVOR', NULL, 203, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(208, 'MOL ENDEAVOR', NULL, 204, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(209, 'DEIKE RICKMERS', NULL, 205, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(210, 'MAERSK FREMANTLE', NULL, 206, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(211, 'C.C CLAUDEL', NULL, 207, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(212, 'SL DEFENDER', NULL, 208, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(213, 'ZIM PANAMA', NULL, 209, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(214, 'APL TAHILAND', NULL, 210, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(215, 'NING WU JI 198', NULL, 211, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(216, 'MINA K', NULL, 212, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(217, 'MOL EXPEDITOR', NULL, 213, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(218, 'MOL EXCELLENCE', NULL, 214, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(219, 'PATSY', NULL, 215, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(220, 'GODDESS', NULL, 216, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(221, 'HEUNG-A OSAKA', NULL, 217, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(222, 'APL KOREA', NULL, 218, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(223, 'SB INTREPID', NULL, 219, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(224, 'NORDCOAST', NULL, 220, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(225, 'PAMPERO', NULL, 221, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(226, 'CANMAR DYNASTY', NULL, 222, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(227, 'SANTA ELENA', NULL, 223, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(228, 'MOL ENDEAVOR', NULL, 224, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(229, 'HYUNDAI DUKE', NULL, 225, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(230, 'CARIBE MERCHANT', NULL, 226, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(231, 'APL PHILIPPINES', NULL, 227, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(232, 'CROWLEY SUN', NULL, 228, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(233, 'MOL EXCELLENCE V-004-1', NULL, 229, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(234, 'APL THAILAND V.068-1', NULL, 230, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(235, 'APL PANAMA', NULL, 231, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(236, 'ZIM CARIBE IV', NULL, 232, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(237, 'APL CHINA', NULL, 233, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(238, 'CALA PONENTE', NULL, 234, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(239, 'CARIBE MERCHANT', NULL, 235, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(240, 'TMM MONTERREY', NULL, 236, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(241, 'LYKES EAGLE', NULL, 237, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(242, 'SOGA', NULL, 238, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(243, 'PURITAN', NULL, 239, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(244, 'APL SINGAPORE', NULL, 240, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(245, 'CANMAR PROMISE', NULL, 241, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(246, 'CANMAR PROMISE', NULL, 242, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(247, 'ZIM ASIA V. 26W', NULL, 243, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(248, 'PURITAN', NULL, 244, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(249, 'MOL ENDEAVOR', NULL, 245, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(250, 'HEUNG-A OSAKA', NULL, 246, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(251, 'MIN TAI', NULL, 247, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(252, 'CHANG YING', NULL, 248, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(253, 'SINOTAC SHIPPING AAGENCY CORP.', NULL, 249, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(254, 'SBD VOYAGER', NULL, 250, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(255, 'SBD INTREPID', NULL, 251, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(256, 'SBD INTREPID', NULL, 252, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(257, 'SBD INTREPID', NULL, 253, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(258, 'HYUNDAI HARMONY', NULL, 254, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(259, 'PALUCCA', NULL, 255, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(260, 'PELUCCA', NULL, 256, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(261, 'LIBRA RIO', NULL, 257, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(262, 'FELICITAS RICKMERS', NULL, 258, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(263, 'ZIM JAMAICA', NULL, 259, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(264, 'POS CHALLENGE', NULL, 260, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(265, 'EWL CURACAO', NULL, 261, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(266, 'APL HONDURAS', NULL, 262, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(267, 'YANTIAN', NULL, 263, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(268, 'SHING CHONG QING', NULL, 264, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(269, 'MOL EXCELLENCE', NULL, 265, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(270, 'SUMIDA', NULL, 266, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(271, 'LYKES DELIVERER', NULL, 267, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(272, 'LYKES RANGER', NULL, 268, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(273, 'SIM CONTAINER LINE', NULL, 269, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(274, 'LYKES RANGER', NULL, 270, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(275, 'XINRUI AN', NULL, 271, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(276, 'HYUNDAI CONCORD', NULL, 272, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(277, 'SHUM HUNG', NULL, 273, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(278, 'APL CHINA', NULL, 274, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(279, 'PONL SALSA', NULL, 275, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(280, 'EWL ROTTERDAM', NULL, 276, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(281, 'POLN SALSA', NULL, 277, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(282, 'MOL EXPEDITOR', NULL, 278, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(283, 'SILKEBORG', NULL, 279, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(284, 'SBD. EXPRESS', NULL, 280, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(285, 'APL THAILAND V. 069-1', NULL, 281, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(286, 'SL EAGLE', NULL, 282, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(287, 'LYKES VOYAGER', NULL, 283, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(288, 'CANMAR PROMISE', NULL, 284, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(289, 'HYUNDAI CONCORD', NULL, 285, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(290, 'CCNI ARICA', NULL, 286, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(291, 'LYKES PROVIDER', NULL, 287, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(292, 'ZIM IBERIA', NULL, 288, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(293, 'EWL ANTILLES VOY B03054', NULL, 289, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(294, 'XIANG ZHOU V.213OE', NULL, 290, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(295, 'SCHACKENBORG', NULL, 291, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(296, 'ZIM PACIFIC', NULL, 292, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(297, 'SETTSU', NULL, 293, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(298, 'MOL EXCELLENCE', NULL, 294, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(299, 'NIPPON YUSEN KAISHA LINE', NULL, 295, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(300, 'EWL CURACAO', NULL, 296, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(301, 'PALLUCA V. 258/E', NULL, 297, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(302, 'CALA PROVIDENCIA V. 507', NULL, 298, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(303, 'TMM TABASCO', NULL, 299, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(304, 'FELICITAS RICKMERS', NULL, 300, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(305, 'SANTA GIOVANNA', NULL, 301, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(306, 'APL CHINA', NULL, 302, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(307, 'CSCL TIANJIN', NULL, 303, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(308, 'IWAKI', NULL, 304, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(309, 'APL PANAMA V. 007E', NULL, 305, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(310, 'SKANDERBORG', NULL, 306, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(311, 'APL THAILAND', NULL, 307, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(312, 'PAMPERO V-241', NULL, 308, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(313, 'PAMPERO V-241/E', NULL, 309, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(314, 'MAERSK ROTTERDAM', NULL, 310, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(315, 'APL SINGAPORE', NULL, 311, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(316, 'SL CHAMPION', NULL, 312, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(317, 'TMM AGUASCALIENTES', NULL, 313, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(318, 'OOCL NEW YORK', NULL, 314, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(319, 'PURITAN', NULL, 315, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(320, 'SANTA GIULIETTA', NULL, 316, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(321, 'SL RACER', NULL, 317, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(322, 'PONL PANTANAL', NULL, 318, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(323, 'PARANGA', NULL, 319, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(324, 'SL MERCURY', NULL, 320, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(325, 'ALBERTA', NULL, 321, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(326, 'SBD VICTORY', NULL, 322, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(327, 'RTTTTRRTT', NULL, 323, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(328, 'SL CHARGER', NULL, 324, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(329, 'SANUKI', NULL, 325, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(330, 'CIELO DI AMERICA', NULL, 326, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(331, 'CSAV PERU', NULL, 327, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(332, 'APL SCOTLAND', NULL, 328, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(333, 'SL METEOR', NULL, 329, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(334, 'VILLE DE MIMOSA', NULL, 330, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(335, 'OOCL BRITAIN', NULL, 331, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(336, 'AMANDA', NULL, 332, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(337, 'SL COMET', NULL, 333, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(338, 'VILLE DE TAURUS', NULL, 334, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(339, 'SKODSBORG', NULL, 335, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(340, 'ALEMANIA EXPRESS', NULL, 336, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(341, 'OOCL AMERICA', NULL, 337, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(342, 'ZIM NEW YORK', NULL, 338, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(343, 'NEDLLOYD CLEMENT', NULL, 339, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(344, 'WING ON', NULL, 340, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(345, 'APL PANAMA', NULL, 341, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(346, 'SUNMAN', NULL, 342, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(347, 'ZIM CALIFORNIA', NULL, 343, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(348, 'CAP BLANCO', NULL, 344, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(349, 'HONG KONG STAR', NULL, 345, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(350, 'APL ENGLAND', NULL, 346, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(351, 'CAP VINCENT', NULL, 347, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(352, 'SAKURA', NULL, 348, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(353, 'SANTIAGO EXPRESS', NULL, 349, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(354, 'MAHIMAHI', NULL, 350, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(355, 'BRIGHT GOLD', NULL, 351, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(356, 'P &O NEDLLOYD PANANAMA', NULL, 352, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(357, 'VERACRUZ', NULL, 353, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(358, 'P & O NEDLLOYD PANTANAL', NULL, 354, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(359, 'ZIM SHANGHAI', NULL, 355, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(360, 'CMA-CGM COLOMBIE', NULL, 356, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(361, 'P&O NEDLLOYD SALSA', NULL, 357, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(362, 'THOR SUSANNE', NULL, 358, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(363, 'MEXICA', NULL, 359, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(364, 'PONL SAMBA', NULL, 360, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(365, 'P&O NEDLLOYD SAMBA', NULL, 361, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(366, 'XIN LONG GANG', NULL, 362, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(367, 'NYK CASTOR', NULL, 363, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(368, 'MAERSK GAIRLOCH', NULL, 364, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(369, 'BRAZIL', NULL, 365, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(370, 'APL BRAZIL', NULL, 366, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(371, 'SUI GANG XIN', NULL, 367, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(372, 'LIKES DELIVERER', NULL, 368, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(373, 'CHUNG HE', NULL, 369, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(374, 'ZIM MEXICO III', NULL, 370, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(375, 'QIAN YUAN SHAN', NULL, 371, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(376, 'TMM GUANAJUATO', NULL, 372, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(377, 'SHION', NULL, 373, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(378, 'CHIQUITA NEDERLAND', NULL, 374, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(379, 'CMA CGM CLAUDEL', NULL, 375, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(380, 'CMA CGM COLOMBIE', NULL, 376, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(381, 'TOKYO EXPESS', NULL, 377, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(382, 'CHUN HE', NULL, 378, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(383, 'KMTC ULSAN', NULL, 379, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(384, 'CIELO D EUROPA', NULL, 380, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(385, 'SHION 2', NULL, 381, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(386, 'ANTWERP', NULL, 382, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(387, 'ZIM CHINA', NULL, 383, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(388, 'SL INTREPID', NULL, 384, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(389, 'OOCL FRANCE', NULL, 385, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(390, 'IZU', NULL, 386, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(391, 'CALAPACUARE', NULL, 387, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(392, 'APL HOLLAND', NULL, 388, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(393, 'CENTRAL AMERICA', NULL, 389, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(394, 'MERKUR SEA', NULL, 390, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(395, 'OOCL QINGDAO', NULL, 391, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(396, 'BERLINE EXPRESS', NULL, 392, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(397, 'ASIAN ZEPHYR', NULL, 393, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(398, 'CCNI HONG KONG', NULL, 394, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(399, 'CAP ORTEGAL', NULL, 395, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(400, 'SL PERFORMANCE', NULL, 396, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(401, 'ACHIM', NULL, 397, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(402, 'EWL WEST INDIES V.4032', NULL, 398, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(403, 'EWL WESTS INDIES V.4032', NULL, 399, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(404, 'WEL WEST INDIES', NULL, 400, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(405, 'LYKES MASTER', NULL, 401, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(406, 'SL INTEGRITY', NULL, 402, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(407, 'NORDPOL', NULL, 403, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(408, 'CITRUS', NULL, 404, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(409, 'CANMAR FORTUNE', NULL, 405, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(410, 'CAP DOMINGO', NULL, 406, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(411, 'ZIM HOUSTON III', NULL, 407, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(412, 'CALA PALENQUE', NULL, 408, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(413, 'AURETTE A', NULL, 409, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(414, 'LYKES RACER', NULL, 410, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(415, 'SL QUALITY', NULL, 411, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(416, 'NYK ARTEMIS', NULL, 412, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(417, 'LYKES CRUSADER', NULL, 413, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(418, 'TAICHUNG', NULL, 414, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(419, 'CALAPIEDAD', NULL, 415, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(420, 'KUALA LUMPUR EXPRESS', NULL, 416, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(421, 'EWL WEST INDIES', NULL, 417, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(422, 'NYK LYRA', NULL, 418, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(423, 'IKOMA', NULL, 419, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(424, 'NEDLLOYD MERCATOR', NULL, 420, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(425, 'OOCL GERMANY', NULL, 421, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(426, 'SL COMMITMENT', NULL, 422, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(427, 'WEST INDIES', NULL, 423, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(428, 'WEST INDIES', NULL, 424, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(429, 'PAPAGAYO V-MA004W', NULL, 425, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(430, 'P&O NEDLLOYD HUDSON', NULL, 426, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(431, 'BO SHI YUN 28', NULL, 427, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(432, 'BO SHI YUN 28', NULL, 428, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(433, 'NYK ANDROMEDA', NULL, 429, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(434, 'EVER REFINE', NULL, 430, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(435, 'MOL ENDURANCE', NULL, 431, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(436, 'CONDOR', NULL, 432, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(437, 'IGA', NULL, 433, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(438, 'SL MARINER', NULL, 434, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(439, 'SANDRA BLANCA', NULL, 435, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(440, 'KOTA WARUNA', NULL, 436, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(441, 'P&O NEDLLOYD TASMAN', NULL, 437, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(442, 'OOCL JAPAN', NULL, 438, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(443, 'SIERRA EXPRESS', NULL, 439, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(444, 'TOBIAS MAERSK', NULL, 440, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(445, 'KOTA WANGSA', NULL, 441, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(446, 'ALIANCA SHANGHAI', NULL, 442, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(447, 'WEHRALTONA', NULL, 443, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(448, 'EWL ANTILLES', NULL, 444, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(449, 'SEABOARD EXPRESS', NULL, 445, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(450, 'SL PATRIOT', NULL, 446, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(451, 'KOTA WARIS', NULL, 447, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(452, 'BUNGA PELANGI DUA', NULL, 448, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(453, 'CAP FRIO', NULL, 449, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(454, 'LYKES TRADER', NULL, 450, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(455, 'LYKES COMMANDER', NULL, 451, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(456, 'ZHONG ZHOU', NULL, 452, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(457, 'MAERSK NEW ORLEANDS', NULL, 453, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(458, 'GAO CHENG', NULL, 454, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(459, 'BING CHENG', NULL, 455, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(460, 'KOTA WIJAYA', NULL, 456, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(461, 'COOK STRAIT', NULL, 457, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(462, 'KOTA WAJAR', NULL, 458, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(463, 'JIN ZHOU', NULL, 459, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(464, 'SL INDEPENDENCE', NULL, 460, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(465, 'CMA CGM QUETZAL', NULL, 461, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(466, 'GOLDEN CLOUD', NULL, 462, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(467, 'CMA  CGM PAPAGAYO', NULL, 463, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(468, 'TAO YUAN', NULL, 464, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(469, 'ZIM PUSAN', NULL, 465, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(470, 'WEHR ALTONA', NULL, 466, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(471, 'P & O NEDLLOYD CARIBBEAN', NULL, 467, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(472, 'P & O NEDLLOYD CARIBBEAN', NULL, 468, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(473, 'MEXICAN', NULL, 469, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(474, 'CALA PROVIDENCIA', NULL, 470, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(475, 'LIKES RACER', NULL, 471, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(476, 'TRUCKHAO MAIDEN', NULL, 472, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(477, 'TUCKAHOE MAIDEN', NULL, 473, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(478, 'CALA PINAR DEL RIO', NULL, 474, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(479, 'MOL ENTERPRISE', NULL, 475, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(480, 'CMA CGM CAPELLA', NULL, 476, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(481, 'WEN LONG', NULL, 477, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(482, 'IBUKI', NULL, 478, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(483, 'VAN PHONG', NULL, 479, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(484, 'E.R. SYDNEY', NULL, 480, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(485, 'LIAN FA 67', NULL, 481, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(486, 'YUE ZUH 1', NULL, 482, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(487, 'UNI FOREVER', NULL, 483, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(488, 'SL LIBERATOR', NULL, 484, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(489, 'INABA', NULL, 485, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(490, 'XIN YONG QIANG2', NULL, 486, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(491, 'CMA CGM COLIBRI', NULL, 487, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(492, 'MV EYRENE', NULL, 488, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(493, 'CMA CGM BERLIOZ', NULL, 489, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(494, 'CHUN HE', NULL, 490, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(495, 'ALBERTA', NULL, 491, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(496, 'INORI', NULL, 492, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(497, 'P&O NLL PANTANAL', NULL, 493, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(498, 'SL INNOVATOR', NULL, 494, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(499, 'SL DEVELOPED', NULL, 495, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(500, 'SANTA FELICITA', NULL, 496, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(501, 'CIELO DI SAN FRANCIS', NULL, 497, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(502, 'MAERKS TOLEDO', NULL, 498, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(503, 'NYK SPRINGTIDE', NULL, 499, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(504, 'SUI JIAN HANG', NULL, 500, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(505, 'CCNI MAGALLANES', NULL, 501, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(506, 'APL ARGENTINA', NULL, 502, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(507, 'HUMBOLDT EXPRESS', NULL, 503, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(508, 'LUEN  SHING', NULL, 504, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(509, 'WERH FLOTTBECK', NULL, 505, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL);
INSERT INTO `barco` (`id_barco`, `nombre`, `bandera`, `idBarco`, `Estado`, `idUsuario`, `fechaIngreso`, `idUsuarioModifica`, `id_sucursal`, `fechamodificacion`, `tipo`) VALUES
(510, 'MAERSK TOLEDO', NULL, 506, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(511, 'MAERSK TOLEDO', NULL, 507, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(512, 'CALA PONENTE', NULL, 508, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(513, 'OLIVIA MAERSK', NULL, 509, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(514, 'APL CHILE', NULL, 510, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(515, 'TIAN XIANG', NULL, 511, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(516, 'SL ENDURANCE', NULL, 512, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(517, 'CMA CGM CARIOCA', NULL, 513, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(518, 'CANMAR', NULL, 514, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(519, 'CANMAR FORTUNE V. 051E', NULL, 515, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(520, 'TAT LEE', NULL, 516, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(521, 'LYKES DELIVERER V. 018E', NULL, 517, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(522, 'NEDLLOYD CLEMENT 503S', NULL, 518, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(523, 'NEDLLOYD CLEMENT', NULL, 519, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(524, 'BAO ZHONG 68', NULL, 520, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(525, 'XION HUI', NULL, 521, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(526, 'MAERSK TRIESTE', NULL, 522, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(527, 'MSC REBECA V. 236R', NULL, 523, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(528, 'XIN HUT HE', NULL, 524, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(529, 'XIN HUT HE', NULL, 525, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(530, 'TIAN XIANG 2 HAO', NULL, 526, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(531, 'ZHAO QING HE', NULL, 527, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(532, 'SHION V-06', NULL, 528, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(533, 'MOL THAMES', NULL, 529, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(534, 'MOL EXPEDITOR', NULL, 530, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(535, 'CSAV PERY', NULL, 531, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(536, 'MAERSK FREEMANTLE', NULL, 532, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(537, 'NYK ARGUS', NULL, 533, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(538, 'APL GUADALAJARA', NULL, 534, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(539, 'CHRISTINE', NULL, 535, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(540, 'LYKES PATHFINDER', NULL, 536, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(541, 'VAN PHONG', NULL, 537, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(542, 'HUMBOLDT EXPRESS', NULL, 538, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(543, 'CALA PAESTUM', NULL, 539, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(544, 'BALTIMAR OKEANOS', NULL, 540, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(545, 'ALICE RICKMERS', NULL, 541, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(546, 'MAERSK FELIXSTOWE', NULL, 542, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(547, 'WANG FAT 3', NULL, 543, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(548, 'APL ITALY', NULL, 544, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(549, 'SL ENDURANCE', NULL, 545, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(550, 'MAERSK TOYAMA', NULL, 546, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(551, 'SL PATRIOT', NULL, 547, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(552, 'MOL DISCOVERY', NULL, 548, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(553, 'KAEDI', NULL, 549, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(554, 'APL ARGENTINA 005E', NULL, 550, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(555, 'MOL EXPEDITOR 014-1', NULL, 551, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(556, 'MAERSK TOLEDO', NULL, 552, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(557, 'MAERSK TOLEDO', NULL, 553, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(558, 'MAERSK TOLEDO', NULL, 554, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(559, 'EASLINE TIIANJIN', NULL, 555, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(560, 'IRIS', NULL, 556, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(561, 'LUNG TANG 28', NULL, 557, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(562, 'WANG FAT 38', NULL, 558, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(563, 'CAP BLANCO', NULL, 559, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(564, 'CMA CGM PUMA', NULL, 560, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(565, 'BINYI', NULL, 561, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(566, 'BRAZIL EXPRESS', NULL, 562, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(567, 'ORSO', NULL, 563, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(568, 'MANOA', NULL, 564, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(569, 'SETTSU', NULL, 565, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(570, 'MAERSK TRIESTE', NULL, 566, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(571, 'CSAV MARESIAS', NULL, 567, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(572, 'CHANG DA', NULL, 568, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(573, 'TMM MONTERREY', NULL, 569, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(574, 'TMM AGUASCALIENTES', NULL, 570, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(575, 'EYRENE', NULL, 571, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(576, 'EYRENE', NULL, 572, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(577, 'CSAV SAN ANTONIO', NULL, 573, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(578, 'HAI FENG SHAN', NULL, 574, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(579, 'LYKES DELIVERER', NULL, 575, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(580, 'APL ARGENTINA', NULL, 576, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(581, 'CAP CORTES', NULL, 577, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(582, 'SL ENDURANCE', NULL, 578, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(583, 'CSAV MANZANILLO', NULL, 579, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(584, 'VAN PHONG', NULL, 580, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(585, 'PURITAN 523', NULL, 581, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(586, 'MOKIHANA', NULL, 582, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(587, 'ANGLIA', NULL, 583, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(588, 'MAERKS TOLEDO', NULL, 584, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(589, 'CSAV SHANGHAI', NULL, 585, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(590, 'ZIM BARCELONA', NULL, 586, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(591, 'SL DEFENDER', NULL, 587, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(592, 'AQUITANIA', NULL, 588, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(593, 'P&O NEDLLOYD BARENTSZ', NULL, 589, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(594, 'E.R. CAPE TOWN', NULL, 590, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(595, 'EASLINE TIANJIN', NULL, 591, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(596, 'CSAV TIANJIN', NULL, 592, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(597, 'EYRENE MARUBA', NULL, 593, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(598, 'PRES WILSON', NULL, 594, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(599, 'MARIENBORG', NULL, 595, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(600, 'MIN TAI 4', NULL, 596, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(601, 'PURITAN', NULL, 597, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(602, 'CSAV CALLAO', NULL, 598, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(603, 'MAERSK PECEM', NULL, 599, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(604, 'HUA YING', NULL, 600, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(605, 'P & O  NEDLLOYD SOUTHAM', NULL, 601, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(606, 'PRES GRANT', NULL, 602, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(607, 'APL CHILE', NULL, 603, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(608, 'HAN ZHONG HE', NULL, 604, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(609, 'PIONEER', NULL, 605, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(610, 'INDEPENDENTE', NULL, 606, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(611, 'BUXFA VOURITE', NULL, 607, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(612, 'CALA PANAMA', NULL, 608, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(613, 'CMA CGM PAULISTA', NULL, 609, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(614, 'CMA CGM QUETZAL', NULL, 610, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(615, 'ANGLIA', NULL, 611, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(616, 'IZUMO', NULL, 612, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(617, 'RONGDA', NULL, 613, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(618, 'MARIA SIBUM', NULL, 614, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(619, 'MAERSK NEUSTADI', NULL, 615, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(620, 'CALA PINAR DEL RIO', NULL, 616, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(621, 'MAERSK NEUSTADT', NULL, 617, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(622, 'WING ON 128 706W', NULL, 618, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(623, 'SHUM HUNG', NULL, 619, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(624, 'ROTTERDAM', NULL, 620, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(625, 'ELQUI', NULL, 621, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(626, 'CSAV MEXICO', NULL, 622, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(627, 'PAC BANDA', NULL, 623, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(628, 'KOTA BINTANG', NULL, 624, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(629, 'CMA CGM PUMA', NULL, 625, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(630, 'SL PATRIOT', NULL, 626, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(631, 'LYKES PROVIDER', NULL, 627, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(632, 'MAERSK JAUN', NULL, 628, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(633, 'STOCKHOLM', NULL, 629, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(634, 'VALPARAISO EXPRESS', NULL, 630, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(635, 'CSAV CHICAGO', NULL, 631, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(636, 'MAERSK PITTSBURG', NULL, 632, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(637, 'CLAN LEGIONARY', NULL, 633, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(638, 'VEGA DIAMOND', NULL, 634, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(639, 'LIBRA SANTA CATARINA', NULL, 635, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(640, 'CALA PUEBLA', NULL, 636, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(641, 'TONG HAO', NULL, 637, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(642, 'KMTC PUSAN', NULL, 638, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(643, 'MAERSK GIRONE', NULL, 639, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(644, 'MAERSK GIRONDE', NULL, 640, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(645, 'CSAV SAN ANTONIA', NULL, 641, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(646, 'CMA CGM QUETZAL', NULL, 642, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(647, 'EWL ANTILLES', NULL, 643, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(648, 'HAJIN OSLO', NULL, 644, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(649, 'ANDREA', NULL, 645, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(650, 'ZHEN DONG', NULL, 646, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(651, 'ANDREAS', NULL, 647, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(652, 'MAERSK DOHA', NULL, 648, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(653, 'LIAN FA 66', NULL, 649, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(654, 'CLAN TRIBUNE', NULL, 650, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(655, 'CSAV HONGKONG', NULL, 651, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(656, 'DOLPHIN STRAIT', NULL, 652, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(657, 'CSAV SHENZHEN', NULL, 653, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(658, 'WESTER HEVER', NULL, 654, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(659, 'P&O NEDL. MARIANA', NULL, 655, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(660, 'HANJIN MIAMI', NULL, 656, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(661, 'HANJIN BOSTON', NULL, 657, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(662, 'CONTI GERMANY', NULL, 658, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(663, 'VEGA DIAMOND', NULL, 659, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(664, 'DIRCH MAERSK', NULL, 660, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(665, 'SAFMARINE IKAPA', NULL, 661, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(666, 'SEA PUMA', NULL, 662, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(667, 'CSAV NEW YORK', NULL, 663, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(668, 'XIN HUI HE', NULL, 664, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(669, 'CHARLOTTENBORG', NULL, 665, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(670, 'CSAV MANZANILLO', NULL, 666, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(671, 'CP DELIVERER', NULL, 667, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(672, 'DONATA SCHULTE', NULL, 668, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(673, 'LIBRA CHILE', NULL, 669, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(674, 'MAERSK DUBLIN', NULL, 670, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(675, 'BUXFAVOURITE', NULL, 671, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(676, 'HANJIN PARIS', NULL, 672, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(677, 'XIN HUI HE', NULL, 673, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(678, 'DA HONG', NULL, 674, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(679, 'CP MONTERREY', NULL, 675, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(680, 'CLAN GLADIATOR', NULL, 676, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(681, 'CCNI HONG KONG', NULL, 677, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(682, 'HANJIN OSLO', NULL, 678, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(683, 'MONTEBELLO', NULL, 679, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(684, 'WESTERKADE', NULL, 680, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(685, 'NITHI BHUM', NULL, 681, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(686, 'CHUNG HE', NULL, 682, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(687, 'CSAV YOKOHAMA', NULL, 683, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(688, 'MARION GREEN', NULL, 684, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(689, 'SAN FERNANDO', NULL, 685, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(690, 'CHEUNG KEE NO. 28', NULL, 686, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(691, 'CMA CGM PUMA', NULL, 687, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(692, 'HENG DA', NULL, 688, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(693, 'CMA CGM CONDOR', NULL, 689, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(694, 'CP PROVIDER', NULL, 690, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(695, 'ANTILLES', NULL, 691, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(696, 'CP AGUASCALIENTE', NULL, 692, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(697, 'ANNA', NULL, 693, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(698, 'LIBRA', NULL, 694, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(699, 'CP DELIVERER', NULL, 695, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(700, 'ANGLIA', NULL, 696, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(701, 'H. KIRKENES', NULL, 697, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(702, 'C PUEBLA', NULL, 698, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(703, 'CLAN LEGIONARY', NULL, 699, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(704, 'WEHR ALTONA', NULL, 700, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(705, 'ANDREAS', NULL, 701, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(706, 'SETTSU', NULL, 702, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(707, 'SETTSU', NULL, 703, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(708, 'SETTSU', NULL, 704, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(709, 'SETTAU', NULL, 705, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(710, 'MIN TAI 3', NULL, 706, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(711, 'ANDRAS', NULL, 707, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(712, 'CLAN LEGIONARY', NULL, 708, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(713, 'CENTRAL AMERICA', NULL, 709, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(714, 'ACX CHERRY', NULL, 710, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(715, 'CLAN TANGUN', NULL, 711, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(716, 'CALAPARANA', NULL, 712, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(717, 'YOUN YUE CON', NULL, 713, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(718, 'IZU', NULL, 714, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(719, 'IZU', NULL, 715, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(720, 'MAERSK DOHA', NULL, 716, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(721, 'MAERSK FORTALEZA', NULL, 717, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(722, 'MARIENBORG', NULL, 718, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(723, 'GLOBAL CARRIER', NULL, 719, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(724, 'MAERKS DUBLIN', NULL, 720, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(725, 'CLAN TRIBUNE', NULL, 721, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(726, 'SEA PUMA', NULL, 722, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(727, 'HANJIN BALTIMORE', NULL, 723, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(728, 'MAERKS RAVENNA', NULL, 724, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(729, 'CURACAO', NULL, 725, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(730, 'H NATIONAL', NULL, 726, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(731, 'ANABISETIA', NULL, 727, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(732, 'BUXFAVOURITE', NULL, 728, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(733, 'HANJIN CHICAGO', NULL, 729, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(734, 'HANJIN YANTIAN', NULL, 730, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(735, 'MONTEBELLO', NULL, 731, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(736, 'DONG RONG', NULL, 732, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(737, 'MERKUR STAR', NULL, 733, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(738, 'CFS PAMPLONA', NULL, 734, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(739, 'P$O NEDLLOYD BRISBANE', NULL, 735, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(740, 'CALA PALENQUE', NULL, 736, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(741, 'ANNA GABRIELE', NULL, 737, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(742, 'CMA CGM PAPAGAYO', NULL, 738, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(743, 'XIN HUI HE', NULL, 739, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(744, 'GUATEMALA', NULL, 740, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(745, 'MAERKS GIRONDE', NULL, 741, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(746, 'HANJIN DALLAS', NULL, 742, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(747, 'MAERSK NAVIA', NULL, 743, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(748, 'SBD EXPRESS', NULL, 744, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(749, 'XIN YUAN  68', NULL, 745, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(750, 'CFS PALAMEDES', NULL, 746, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(751, 'HANJIN MIAMI', NULL, 747, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(752, 'CMA CGM CARIOCA', NULL, 748, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(753, 'APL KENNEDY', NULL, 749, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(754, 'PONL REM', NULL, 750, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(755, 'EASLINE TIAJIN', NULL, 751, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(756, 'EASLINE TIANJIN', NULL, 752, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(757, 'BRASIL EXPRESS', NULL, 753, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(758, 'XIN HUI HE', NULL, 754, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(759, 'HANJIN BOSTON', NULL, 755, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(760, 'CALA PARANA', NULL, 756, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(761, 'APL LILAC', NULL, 757, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(762, 'CP MONTERREY', NULL, 758, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(763, 'MSC KERRY', NULL, 759, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(764, 'HYUNDAI HIGHWAY', NULL, 760, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(765, 'CAP SAN RAFHAEL', NULL, 761, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(766, 'HANJIN YANTIAN', NULL, 762, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(767, 'INTREPIDO VG', NULL, 763, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(768, 'MAERSK DERINCE', NULL, 764, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(769, 'SANTA FIORENZA', NULL, 765, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(770, 'MAERSK FREEPORT', NULL, 766, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(771, 'SANTA GIOVANNA', NULL, 767, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(772, 'SANTA GIOVANNA', NULL, 768, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(773, 'CCNI ANTARTICO', NULL, 769, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(774, 'HANJIN DALLAS', NULL, 770, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(775, 'YONG YUE NO.6', NULL, 771, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(776, 'WELL STAR', NULL, 772, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(777, 'VIRA BHUM', NULL, 773, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(778, 'WELL STAR', NULL, 774, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(779, 'CCNI ANTARTICO', NULL, 775, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(780, 'YONG YUE 6', NULL, 776, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(781, 'YONG YUE 6', NULL, 777, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(782, 'IZU', NULL, 778, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(783, 'MAERSK FORTALEZA', NULL, 779, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(784, 'JEPPESEN MAERSK', NULL, 780, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(785, 'CALA PEDRA', NULL, 781, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(786, 'CALA PEDRA', NULL, 782, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(787, 'CALA PEDRA', NULL, 783, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(788, 'CAP VERDE', NULL, 784, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(789, 'SAKURA', NULL, 785, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(790, 'HANJIN MIAMI', NULL, 786, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(791, 'CALA PINTADA', NULL, 787, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(792, 'CALA PALMIRA', NULL, 788, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(793, 'CHENG GONG 78', NULL, 789, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(794, 'HANNE CHRISTINE HUMBOLDT EXPRESS', NULL, 790, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(795, 'APL SAN JUAN', NULL, 791, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(796, 'CAP  PILAR', NULL, 792, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(797, 'CAP PILAR', NULL, 793, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(798, 'HANJIN BALTIMORE', NULL, 794, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(799, 'CALA PUEBLA', NULL, 795, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(800, 'CALA PUEBLA', NULL, 796, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(801, 'APL PERU', NULL, 797, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(802, 'APL MIAMI', NULL, 798, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(803, 'CAP NORTE', NULL, 799, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(804, 'HANJIN BALTIMORE', NULL, 800, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(805, 'TIAN MA', NULL, 801, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(806, 'CHIN CHUN ', NULL, 802, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(807, 'CCNI MAGALLANES', NULL, 803, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(808, 'CCNI GUAYAS', NULL, 804, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(809, 'CAP PALMAS', NULL, 805, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(810, 'MARUBA COTOPAXI', NULL, 806, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(811, 'BARQUITO', NULL, 807, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(812, 'CSAV CALIFORNIA', NULL, 808, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(813, 'HANJIN BOSTON ', NULL, 809, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(814, 'CAPE FRASER', NULL, 810, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(815, 'ZIM HOUSTON III', NULL, 811, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(816, 'CSAV TIANJIN ', NULL, 812, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(817, 'ZHENG DONG', NULL, 813, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(818, 'GOLDEN MERCHANT', NULL, 814, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(819, 'IZU', NULL, 815, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(820, 'HANJIN YANTIRAN', NULL, 816, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(821, 'MAERSK FREMANTLE', NULL, 817, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(822, 'CCNI ANTILLANCA', NULL, 818, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(823, 'MARUBA COTOPAXI', NULL, 819, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(824, 'CAP DELGADO', NULL, 820, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(825, 'CCNI RIMAC', NULL, 821, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(826, 'APL ACAJUTLA', NULL, 822, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(827, 'SUPA BHUM', NULL, 823, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(828, 'APL RUBY', NULL, 824, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(829, 'EASLINE TIANJIN', NULL, 825, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(830, 'YONG YOE', NULL, 826, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(831, 'CSCL DALIAN', NULL, 827, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(832, 'APL CHINA ', NULL, 828, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(833, 'YONG YUE  NO.6 ', NULL, 829, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(834, 'ZIM HOUSTON', NULL, 830, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(835, 'CALA PILAR', NULL, 831, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(836, 'CALA PINAR DEL RIO', NULL, 832, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(837, 'CAP DOUKATO', NULL, 833, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(838, 'URU BHUM ', NULL, 834, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(839, 'BUXLAGOON', NULL, 835, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(840, 'CHUN HE ', NULL, 836, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(841, 'PIRA BHUM', NULL, 837, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(842, 'CALA PAESTUM', NULL, 838, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(843, 'CMA CGM TUCANO', NULL, 839, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(844, 'WESTFALIA', NULL, 840, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(845, 'ZIN MEXICO  III', NULL, 841, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(846, 'IKARUGA', NULL, 842, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(847, 'ARNIS', NULL, 843, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(848, 'SITC DALIAN', NULL, 844, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(849, 'KRIPA', NULL, 845, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(850, 'NORDEAGLE', NULL, 846, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(851, 'SETTSU', NULL, 847, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(852, 'KMTC HONGKONG ', NULL, 848, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(853, 'APL PERU', NULL, 849, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(854, 'CHU HONG', NULL, 850, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(855, 'CSAV MONTREAL', NULL, 851, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(856, 'KMTC  ULSAN ', NULL, 852, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(857, 'LIBRA CHILE', NULL, 853, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(858, 'SAXONIA EXP', NULL, 854, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(859, 'PAC BANDA', NULL, 855, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(860, 'MARUBA CATHAY', NULL, 856, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(861, 'CONTI ARABIAN', NULL, 857, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(862, 'CP CHALLENGER', NULL, 858, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(863, 'SEABOARD VICTORY ', NULL, 859, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(864, 'TEVAL', NULL, 860, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(865, 'GALA PONENTE', NULL, 861, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(866, 'CALA PONENTE', NULL, 862, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(867, 'APL SAN JUAN ', NULL, 863, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(868, 'BEI DAI HE', NULL, 864, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(869, 'MAIZAR', NULL, 865, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(870, 'CROWLEY SENATOR', NULL, 866, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(871, 'AMIZAR', NULL, 867, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(872, 'CSCL LIANYUNGANG', NULL, 868, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(873, 'CLAN LEGIONARY', NULL, 869, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(874, 'SUSANNE', NULL, 870, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(875, 'C. PUEBLA', NULL, 871, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(876, 'ZHONG DA 9 HAO', NULL, 872, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(877, 'CALAPOSITANO', NULL, 873, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(878, 'CMA CGM AZTECA ', NULL, 874, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(879, 'JOHANNES MAERSK', NULL, 875, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(880, 'AURETTE ', NULL, 876, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(881, 'CSCL SHANGHAI', NULL, 877, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(882, 'HAMMONIA EXPRESS', NULL, 878, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(883, 'HOLSATA EXPRESS', NULL, 879, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(884, 'MIZAR', NULL, 880, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(885, 'CLAN  TRIBUNE', NULL, 881, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(886, 'IRENES LOGOS', NULL, 882, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(887, 'HOECHST EXPRESS', NULL, 883, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(888, 'APL SAN JUAN', NULL, 884, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(889, 'HAMMONIA EXP', NULL, 885, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(890, 'VALENCIA EXPRESS', NULL, 886, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(891, 'CMA CGM AGUILA', NULL, 887, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(892, 'CSAV RIO PETROHUE', NULL, 888, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(893, 'MATHILDE MAERSK', NULL, 889, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(894, 'KHUDO ZHINK ZHUKOV', NULL, 890, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(895, 'JANDAVID', NULL, 891, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(896, 'CMA CGM AGUILA', NULL, 892, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(897, 'EWL ANTILLES', NULL, 893, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(898, 'CALA PONIENTE', NULL, 894, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(899, 'CSCL LIANYUNGANG', NULL, 895, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(900, 'CMA CGM TUCANO', NULL, 896, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(901, 'CMA CGM CONDOR', NULL, 897, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(902, 'MARUBA TANGO', NULL, 898, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(903, 'COLUMBUS VICTORIA', NULL, 899, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(904, 'SHUN FAT', NULL, 900, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(905, 'ROTHORN', NULL, 901, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(906, 'WING ON', NULL, 902, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(907, 'SUI GANG XIN 313', NULL, 903, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(908, 'EWL CENTRAL AMERICA', NULL, 904, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(909, 'CMA CGM QUETZAL', NULL, 905, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(910, 'BERHARD', NULL, 906, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(911, 'CLAN TRIBUNE', NULL, 907, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(912, 'CMA CGM TUCANO', NULL, 908, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(913, 'MARUBA TANGO', NULL, 909, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(914, 'MEGLEBY MAERKS', NULL, 910, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(915, 'MAGLEBY MAERKS', NULL, 911, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(916, 'CCNI SHANGHAI', NULL, 912, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(917, 'XIN TAI  SHUN', NULL, 913, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(918, 'MIN TUE', NULL, 914, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(919, 'CLAN LEGIONARY', NULL, 915, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(920, 'IMARI', NULL, 916, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(921, 'MAERSK FALMOUTH', NULL, 917, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(922, 'E.R. DURBAN', NULL, 918, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(923, 'SATD WISMAR ', NULL, 919, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(924, 'STADT WISMAR', NULL, 920, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(925, 'KWAI SING NO. 2', NULL, 921, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(926, 'MAJESTIC MAERSK', NULL, 922, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(927, 'H.EMPEROR', NULL, 923, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(928, 'CMA CGM PUMA', NULL, 924, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(929, 'AMERICAN FEEDER', NULL, 925, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(930, 'CSAV RIO TOLTEN', NULL, 926, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(931, 'CHEUNG KEE ', NULL, 927, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(932, 'JUIST TRADER ', NULL, 928, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(933, 'CAP VERDE', NULL, 929, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(934, 'XIANG RONG', NULL, 930, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(935, 'SANTA MONICA', NULL, 931, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(936, 'ASIAN TRADER', NULL, 932, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(937, 'CLAN PRAETORIAN ', NULL, 933, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(938, 'H. INDEPENDIENTE', NULL, 934, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(939, 'CALA PARADISO', NULL, 935, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(940, 'XINGTAI 2', NULL, 936, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(941, 'ANABISETIA', NULL, 937, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(942, 'SBD. EXPLORER II', NULL, 938, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(943, 'PEACE OCEAN', NULL, 939, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(944, 'CLAN PRAETORIAN', NULL, 940, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(945, 'CALA PIEDAD', NULL, 941, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(946, 'CONTI ARABIAN', NULL, 942, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(947, 'SHEN HANG ', NULL, 943, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(948, 'CMA CGM MAYA', NULL, 944, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(949, 'CSCL LIANYUNGANG ', NULL, 945, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(950, 'NEDLLOYD DRAKE', NULL, 946, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(951, 'EXPRESS', NULL, 947, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(952, 'CSCL SYDNEY', NULL, 948, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(953, 'WESTERDEICH', NULL, 949, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(954, 'CMA CGM QUETZAL', NULL, 950, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(955, 'CSAV GENOVA', NULL, 951, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(956, 'SBD. INTREPID ', NULL, 952, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(957, 'MAERSK PETERHEAD', NULL, 953, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(958, 'H.HIGHNESS', NULL, 954, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(959, 'IRENE LOGOS', NULL, 955, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(960, 'CMA CGM PUMA', NULL, 956, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(961, 'OOCL AMERICA', NULL, 957, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(962, 'CMA CGM COLIBRI', NULL, 958, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(963, 'MC-KINNEY MAERSK ', NULL, 959, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(964, 'CLAN TRIBUNE ', NULL, 960, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(965, 'JOHANNES MAERSK', NULL, 961, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(966, 'IBERIA', NULL, 962, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(967, 'CMA CGM COLIBRI ', NULL, 963, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(968, 'CMA CGM COLIBRI', NULL, 964, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(969, 'CALA PORTOFINO', NULL, 965, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(970, 'CONTI ARABIAN ', NULL, 966, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(971, 'CMA CGM BAHIA', NULL, 967, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(972, 'CEC MERMAID', NULL, 968, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(973, 'CLAN PRAETORIAN', NULL, 969, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(974, 'SHEN ZHEN', NULL, 970, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(975, 'MARIE MAERSK', NULL, 971, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(976, 'APL ARGENTINA', NULL, 972, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(977, 'H. DUKE ', NULL, 973, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(978, 'OLGA MAERSK', NULL, 974, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(979, 'OLGA MAERSK', NULL, 975, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(980, 'CSAV MEXICO', NULL, 976, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(981, 'MAERSK DUNDEE', NULL, 977, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(982, 'MAERSK DUNDEE', NULL, 978, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(983, 'HONG KONG EXPRESS', NULL, 979, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(984, 'CLAN TANGUN', NULL, 980, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(985, 'SOGA', NULL, 981, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(986, 'CMA CGM ESMERALDAS', NULL, 982, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(987, 'CMA CGM ESMERALDAS', NULL, 983, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(988, 'CALA PINAR DEL RIO ', NULL, 984, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(989, 'ANGLIA  ', NULL, 985, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(990, 'CMA CGM MAYA', NULL, 986, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(991, 'BARCO NUEVO', NULL, 987, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(992, 'OOCL BRITAIN', NULL, 988, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(993, 'OOCL BRITAIN ', NULL, 989, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(994, 'HOLSATIA EXP', NULL, 990, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(995, 'BARCO DE PRUEBA', NULL, 991, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(996, 'MARUBA TANGO', NULL, 992, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(997, 'CALA PALENQUE', NULL, 993, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(998, 'ANGLIA', NULL, 994, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(999, 'MARUBA TANGO ', NULL, 995, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1000, 'CAPE MAY', NULL, 996, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1001, 'QC WISDOM', NULL, 997, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1002, 'HOLSATIA EXPRESS', NULL, 998, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1003, 'HUIHONG 1', NULL, 999, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1004, 'WESTFALIA EXPRESS', NULL, 1000, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1005, 'PHOENIX', NULL, 1001, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1006, 'EXPRESS', NULL, 1002, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1007, 'CP LIBERATOR', NULL, 1003, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1008, 'CALA PINTADA', NULL, 1004, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1009, 'TAI DE SHENG', NULL, 1005, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1010, 'LIAN FA ', NULL, 1006, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1011, 'APL PERU', NULL, 1007, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1012, 'CMA CGM COLIBRI', NULL, 1008, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL);
INSERT INTO `barco` (`id_barco`, `nombre`, `bandera`, `idBarco`, `Estado`, `idUsuario`, `fechaIngreso`, `idUsuarioModifica`, `id_sucursal`, `fechamodificacion`, `tipo`) VALUES
(1013, 'DA YANG', NULL, 1009, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1014, 'SAXONIA EXPRESS', NULL, 1010, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1015, 'CMA CGM AGUILA', NULL, 1011, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1016, 'MAERSK FORTALEZA', NULL, 1012, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1017, 'KMTC SHANGHAI', NULL, 1013, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1018, 'PURITAN', NULL, 1014, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1019, 'MAERSK DUNFARE', NULL, 1015, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1020, 'APL SAN JUAN', NULL, 1016, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1021, 'APL SAN JUAN', NULL, 1017, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1022, 'OOCL EUROPE', NULL, 1018, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1023, 'CMA CGM PUMA', NULL, 1019, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1024, 'HANSA BERGEN ', NULL, 1020, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1025, 'CAP PILAR', NULL, 1021, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1026, 'H KIRKENES', NULL, 1022, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1027, 'CAP PILAR', NULL, 1023, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1028, 'JOHANNES MAERSK', NULL, 1024, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1029, 'CMA CGM CARTAGENA', NULL, 1025, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1030, 'CMA CGM PUMA', NULL, 1026, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1031, 'CAP PILAR ', NULL, 1027, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1032, 'CMA CGM ESMERALDAS', NULL, 1028, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1033, 'IKARUGA', NULL, 1029, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1034, 'SBD INTREPID ', NULL, 1030, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1035, 'JIAN HAI  1', NULL, 1031, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1036, 'TIAN LI', NULL, 1032, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1037, 'MARUBA ZONDA', NULL, 1033, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1038, 'BERNHARD S', NULL, 1034, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1039, 'CLAN TANGUN', NULL, 1035, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1040, 'INES', NULL, 1036, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1041, 'CLAN PRAETORIAN', NULL, 1037, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1042, 'EASLINE TIANJIN ', NULL, 1038, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1043, 'NEDLLOYD MERCATOR', NULL, 1039, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1044, 'CLAN PRAETORIAN ', NULL, 1040, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1045, 'CMA CGM MAYA', NULL, 1041, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1046, 'MARUBA TANGO', NULL, 1042, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1047, 'MARUBA TANGO', NULL, 1043, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1048, 'SHINA', NULL, 1044, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1049, 'XIN HUI HE', NULL, 1045, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1050, 'QUAN XING', NULL, 1046, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1051, 'SHIMA ', NULL, 1047, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1052, 'ST. LOUIS EXPRESS', NULL, 1048, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1053, 'CMA CGM BUENOS AIRES', NULL, 1049, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1054, 'MERKUR BAY', NULL, 1050, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1055, 'CLAN TANGUN', NULL, 1051, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1056, 'CLAN TANGUN', NULL, 1052, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1057, 'CAP PALMAS', NULL, 1053, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1058, 'JEN MAERSK', NULL, 1054, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1059, 'MERKUR BAY', NULL, 1055, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1060, 'CALAPARADISO', NULL, 1056, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1061, 'STX TOKYO', NULL, 1057, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1062, 'CCNI ANTOFAGASTA', NULL, 1058, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1063, 'CMA CGM BUENOS AIRES', NULL, 1059, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1064, 'NEDLLOYD MERCATOR', NULL, 1060, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1065, 'NEDLLOYD MERCATOR', NULL, 1061, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1066, 'RIO GRANDE EXPRESS', NULL, 1062, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1067, 'NEDLLOYD AFRICA', NULL, 1063, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1068, 'SING PING', NULL, 1064, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1069, 'TITAN', NULL, 1065, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1070, 'CMA CGM CARIBBEAN', NULL, 1066, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1071, 'ANTILLES', NULL, 1067, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1072, 'H. FEEDOM ', NULL, 1068, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1073, 'OOCL DUBAI', NULL, 1069, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1074, 'OCEAN WAVE I', NULL, 1070, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1075, 'CMA CGM LIMON', NULL, 1071, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1076, 'ER DURBAN VG', NULL, 1072, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1077, 'CMA CGM LIMON', NULL, 1073, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1078, 'KOTA PERWIRA', NULL, 1074, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1079, 'EASLINE TIANJIN', NULL, 1075, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1080, 'BELGIAN EXPRESS', NULL, 1076, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1081, 'TRIESTE', NULL, 1077, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1082, 'SUNNY OLIVE', NULL, 1078, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1083, 'CMA CGM AGUILA', NULL, 1079, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1084, 'CAP MALEAS ', NULL, 1080, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1085, 'YUJI', NULL, 1081, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1086, 'SAN JUAN ', NULL, 1082, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1087, 'CMA CGM CORTES', NULL, 1083, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1088, 'APL MIAMI', NULL, 1084, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1089, 'ZERAN', NULL, 1085, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1090, 'CMA CGM ESMERALDAS', NULL, 1086, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1091, 'HONG YUN HE', NULL, 1087, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1092, 'YONG HUI 8', NULL, 1088, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1093, 'OOCL KAOHSIUNG', NULL, 1089, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1094, 'YUJI', NULL, 1090, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1095, 'SANTA CRISTINA', NULL, 1091, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1096, 'CALAPINAR DEL RIO', NULL, 1092, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1097, 'SANTOS EXPRESS', NULL, 1093, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1098, 'RIO GRANDE EXPRESS', NULL, 1094, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1099, 'ADRIAN', NULL, 1095, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1100, 'STX YOKOHAMA ', NULL, 1096, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1101, 'LUETJENBURG', NULL, 1097, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1102, 'TIAN RONG', NULL, 1098, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1103, 'JPO SAGITTARIUS', NULL, 1099, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1104, 'INTREPID ', NULL, 1100, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1105, 'CMA CGM LIMON', NULL, 1101, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1106, 'TEST', NULL, 1102, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1107, 'NEDLLOYD DRAKE', NULL, 1103, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1108, 'MAERSK MONTREAL', NULL, 1104, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1109, 'CLAN AMAZONAS', NULL, 1105, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1110, 'NAN GANG 26', NULL, 1106, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1111, 'APL AUSTRALIA', NULL, 1107, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1112, 'MSC TINA', NULL, 1108, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1113, 'CALAPOSITANO', NULL, 1109, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1114, 'MARMARA SEA', NULL, 1110, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1115, 'NYK ESTRELA ', NULL, 1111, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1116, 'APL VIRGINIA', NULL, 1112, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1117, 'ZIM PIRAEUS ', NULL, 1113, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1118, 'MSC LUDOVICA', NULL, 1114, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1119, 'MSC LUDOVICA ', NULL, 1115, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1120, 'APL  BEIJING', NULL, 1116, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1121, 'MSC FRIBOURG', NULL, 1117, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1122, 'SUI DONG FANG 389', NULL, 1118, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1123, 'APL EMPEROR', NULL, 1119, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1124, 'MSC CHICAGO', NULL, 1120, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1125, 'TURIN EXPRESS', NULL, 1121, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1126, 'SENAR BALI', NULL, 1122, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1127, 'HUNSA GHUM', NULL, 1123, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1128, 'MSC TINA', NULL, 1124, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1129, 'RUBYN MY', NULL, 1125, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1130, 'CLAN AMAZONAS', NULL, 1126, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1131, 'CANOPUS J', NULL, 1127, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1132, 'ZIM BUENOS AIRES', NULL, 1128, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1133, 'SUMIDA', NULL, 1129, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1134, 'COLUMBIAN EXPRESS', NULL, 1130, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1135, 'CALA PONENTE', NULL, 1131, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1136, 'CAP CARMEL', NULL, 1132, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1137, 'MSC MARIANNA ', NULL, 1133, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1138, 'JPO SCORPIUS', NULL, 1134, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1139, 'CLAN INTREPID', NULL, 1135, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1140, 'MSC FRANCE', NULL, 1136, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1141, 'YUE CHAO 1', NULL, 1137, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1142, 'MSC GINA 271', NULL, 1138, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1143, 'IPANEMIA', NULL, 1139, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1144, 'IPANEMA', NULL, 1140, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1145, 'HENG DA', NULL, 1141, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1146, 'MSC BARBARA', NULL, 1142, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1147, 'MSC LUISA', NULL, 1143, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1148, 'CALA PROVIDENCIA ', NULL, 1144, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1149, 'SB COSTA RICA', NULL, 1145, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1150, 'COSCO BRISBANE', NULL, 1146, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1151, 'ZIM PUSAN', NULL, 1147, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1152, 'SUN RIGHT', NULL, 1148, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1153, 'MSC ILONA', NULL, 1149, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1154, 'MSC MANDY', NULL, 1150, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1155, 'SANTOS EXPRESS ', NULL, 1151, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1156, 'KMTC KEELUNG', NULL, 1152, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1157, 'MSC EMMA', NULL, 1153, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1158, 'HUNSA BHUM', NULL, 1154, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1159, 'KUO HUNG ', NULL, 1155, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1160, 'MSC DEBRA', NULL, 1156, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1161, 'SL MOTIVATOR', NULL, 1157, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1162, 'MSC ATLANTIC', NULL, 1158, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1163, 'CLAN LEGIONARY ', NULL, 1159, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1164, 'CMA CGM CASTILLA', NULL, 1160, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1165, 'CMA CGM BRASILIA', NULL, 1161, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1166, 'CALA PROVIDENA', NULL, 1162, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1167, 'MSC LISBON', NULL, 1163, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1168, 'CALA POSITANO ', NULL, 1164, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1169, 'KMTC KEELUNG ', NULL, 1165, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1170, 'KMTC KEELUNG', NULL, 1166, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1171, 'IZU', NULL, 1167, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1172, 'H.CONFIDENCE', NULL, 1168, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1173, 'CAP MATAPAN ', NULL, 1169, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1174, 'MSC MADELEINE', NULL, 1170, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1175, 'CMA CGM ROMANIA', NULL, 1171, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1176, 'RIO DE JANEIRO EXPRESS', NULL, 1172, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1177, 'MSC BOSTON', NULL, 1173, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1178, 'CLAN AMAZONAS', NULL, 1174, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1179, 'IWATO', NULL, 1175, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1180, 'LUZON STRAIT', NULL, 1176, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1181, 'KMTC SINGAPORE', NULL, 1177, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1182, 'JIN SHENG ', NULL, 1178, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1183, 'WESTERHAVEN', NULL, 1179, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1184, 'CHANG TONG', NULL, 1180, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1185, 'YORKTOWN EXPRESS', NULL, 1181, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1186, 'MSC STELLA', NULL, 1182, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1187, 'PRUEBA', NULL, 1183, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1188, 'IZU', NULL, 1184, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1189, 'IZU', NULL, 1185, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1190, 'CLAN LEGIONARY', NULL, 1186, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1191, 'VANCOUVER EXP', NULL, 1187, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1192, 'MSC VIVIANA', NULL, 1188, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1193, 'MSC CLAUDIA', NULL, 1189, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1194, 'CMA CGM CARTAGENA', NULL, 1190, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1195, 'H. INDEPENDENCE', NULL, 1191, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1196, 'MSC MAUREEN', NULL, 1192, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1197, 'CALA PUMA', NULL, 1193, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1198, 'CALA PINGUINO', NULL, 1194, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1199, 'LU SHENG', NULL, 1195, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1200, 'LIBRA SANTOS', NULL, 1196, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1201, 'MSC MANU', NULL, 1197, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1202, 'DOOWOO BUSAN ', NULL, 1198, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1203, 'CMA CGM BUENOS AIRES', NULL, 1199, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1204, 'MANUELA', NULL, 1200, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1205, 'YM MOJI', NULL, 1201, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1206, 'APL KAOHSIUNG', NULL, 1202, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1207, 'CHAMPLAIN STRAIT', NULL, 1203, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1208, 'XIN RIN ZHAO 0049E', NULL, 1204, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1209, 'CLAN TRIBUNE', NULL, 1205, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1210, 'FORTUNIA ', NULL, 1206, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1211, 'HANJIN SEOUL', NULL, 1207, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1212, 'CLAN CHALLENGER', NULL, 1208, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1213, 'MSC KENYA', NULL, 1209, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1214, 'YUE HUI HAI 008', NULL, 1210, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1215, 'CSAV MARESIAS', NULL, 1211, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1216, 'NORACIA', NULL, 1212, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1217, 'CMA CGM CONDOR', NULL, 1213, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1218, 'DOOWOO BUSAN', NULL, 1214, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1219, 'ÀLIANCA EUROPA', NULL, 1215, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1220, 'FREDERIKSBORG', NULL, 1216, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1221, 'MAERSK DELMONT', NULL, 1217, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1222, 'MIN TAI YI HAO', NULL, 1218, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1223, 'SL PRIDE', NULL, 1219, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1224, 'COSCO BRISBNE', NULL, 1220, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1225, 'QI YUN HE', NULL, 1221, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1226, 'NORASIA ALYA', NULL, 1222, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1227, 'MLCU5307945', NULL, 1223, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1228, 'SL MOTIVATOR', NULL, 1224, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1229, 'AUGUSTE SCHULTE ', NULL, 1225, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1230, 'MSC NOA', NULL, 1226, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1231, 'MSC SILVANA', NULL, 1227, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1232, 'CSAV SAO PAULO', NULL, 1228, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1233, 'CSAV ROTTERDAM', NULL, 1229, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1234, 'ELSIBETH', NULL, 1230, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1235, 'APL BALBOA', NULL, 1231, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1236, 'MSC LAURA', NULL, 1232, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1237, 'MSC ORNELLA', NULL, 1233, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1238, 'NORASIA ALYA', NULL, 1234, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1239, 'CMA CGM ROMANIA', NULL, 1235, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1240, 'CAP CARMEL', NULL, 1236, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1241, 'WAN HAI 205', NULL, 1237, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1242, 'RONG DA', NULL, 1238, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1243, 'MSC VANESSA', NULL, 1239, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1244, 'MAERSK MYKONOS', NULL, 1240, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1245, 'ZHA QING HE', NULL, 1241, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1246, 'SHIN CHUN', NULL, 1242, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1247, 'ZHAO QING HE', NULL, 1243, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1248, 'GUAN HANG 299', NULL, 1244, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1249, 'CMA CGM CONTI SALOME', NULL, 1245, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1250, 'TS TOKYO', NULL, 1246, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1251, 'FRANKFURT EXPRESS', NULL, 1247, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1252, 'LONGAVI', NULL, 1248, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1253, 'LIBRA RIO ', NULL, 1249, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1254, 'MONTEVERDE', NULL, 1250, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1255, 'CSAV CARIBE', NULL, 1251, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1256, 'MOL ELBE ', NULL, 1252, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1257, 'SORDIUM ', NULL, 1253, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1258, 'MAERSK GATESHEAD', NULL, 1254, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1259, 'WESFALIA EXPRESS', NULL, 1255, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1260, 'WAN HAI 207', NULL, 1256, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1261, 'BLO MONTE VERDE', NULL, 1257, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1262, 'MSC SUKAYNA', NULL, 1258, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1263, 'WAN HAI 202', NULL, 1259, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1264, 'SHENG DA 2', NULL, 1260, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1265, 'APL ARABIA 45', NULL, 1261, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1266, 'NORASIA POLARIS', NULL, 1262, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1267, 'CMA CGM BELLINI', NULL, 1263, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1268, 'CMA CGM AZTECA', NULL, 1264, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1269, 'EVER GAINING', NULL, 1265, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1270, 'CMA CGM CORTES', NULL, 1266, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1271, 'WESFALIA EXPRESS', NULL, 1267, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1272, 'MOL AMBITION', NULL, 1268, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1273, 'H. GLORY', NULL, 1269, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1274, 'APL VIETNAM', NULL, 1270, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1275, 'APL BRAZIL', NULL, 1271, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1276, 'CMA CGM STRAUSS', NULL, 1272, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1277, 'MAERSK DIADEMA', NULL, 1273, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1278, 'VIRA BHUM', NULL, 1274, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1279, 'MARUBA IMPERATOR', NULL, 1275, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1280, 'APL MALASYA', NULL, 1276, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1281, 'CMA CGM BUENOS AIRES', NULL, 1277, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1282, 'CLAN CHALLENGER', NULL, 1278, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1283, 'NORASIA ALYA', NULL, 1279, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1284, 'ZHONG DA 01', NULL, 1280, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1285, 'AGUSTE SCHULTE', NULL, 1281, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1286, 'CMA CGM TUCANO', NULL, 1282, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1287, 'YA LU JIAN', NULL, 1283, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1288, 'MAGNAVIA VIA', NULL, 1284, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1289, 'ZIM VIRGINIA', NULL, 1285, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1290, 'CALA PANTERA', NULL, 1286, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1291, 'MSC AURELIE', NULL, 1287, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1292, 'GLORIA', NULL, 1288, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1293, 'MARUBA IMPERATOR', NULL, 1289, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1294, 'APL EGYPT', NULL, 1290, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1295, 'HENG CHAO', NULL, 1291, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1296, 'CMA CGM CONDOR', NULL, 1292, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1297, 'BHATRA BHUM', NULL, 1293, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1298, 'CSAV SANTOS', NULL, 1294, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1299, 'MARFRET DURANDE', NULL, 1295, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1300, 'CSAV VENEZUELA', NULL, 1296, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1301, 'APL JADE', NULL, 1297, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1302, 'CALA PANTANAL', NULL, 1298, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1303, 'CARIBBEAN SEA', NULL, 1299, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1304, 'ZIM NEW YORK', NULL, 1300, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1305, 'MSC NEW YORK', NULL, 1301, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1306, 'WISMAR', NULL, 1302, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1307, 'CMA CGM LIMON', NULL, 1303, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1308, 'MAERSK TANGIER', NULL, 1304, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1309, 'TAI YUE 218', NULL, 1305, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1310, 'MOL EXPLORER', NULL, 1306, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1311, 'MSC WISMAR', NULL, 1307, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1312, 'MSC SENA', NULL, 1308, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1313, 'CMA CGM CORTES', NULL, 1309, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1314, 'MIRA ', NULL, 1310, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1315, 'MSC JENNY', NULL, 1311, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1316, 'CMA CGM ROMANIA', NULL, 1312, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1317, 'MAERSK NARYSTOWN', NULL, 1313, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1318, 'MAERSK MARYSTOWN', NULL, 1314, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1319, 'MSC PRESTIGE', NULL, 1315, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1320, 'CALA PANCALDO', NULL, 1316, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1321, 'MOL INNOVATION', NULL, 1317, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1322, 'EWL CARIBBEAN', NULL, 1318, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1323, 'MAERSK DRYDEN', NULL, 1319, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1324, 'MAERSK DARTFORD', NULL, 1320, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1325, 'CMA CGM BARBADOS', NULL, 1321, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1326, 'CLAN TANGUN 741', NULL, 1322, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1327, 'CMA CGM TUCANO', NULL, 1323, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1328, 'SUN ROAD', NULL, 1324, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1329, 'MAERSK DERINCE', NULL, 1325, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1330, 'MAERSK DERINCE', NULL, 1326, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1331, 'MSC PERU', NULL, 1327, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1332, 'CSAV PAULO', NULL, 1328, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1333, 'GRASMERE MAERSK', NULL, 1329, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1334, 'SEA ALFA', NULL, 1330, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1335, 'MAERSK FLORENCE 0734', NULL, 1331, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1336, 'MAERSK FLORENCE', NULL, 1332, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1337, 'CSCL LIANYUNGANG', NULL, 1333, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1338, 'CMA CGM INTENS TY', NULL, 1334, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1339, 'CAP POLONIO', NULL, 1335, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1340, 'CONTI MALAGA', NULL, 1336, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1341, 'MARUBA EUROPA', NULL, 1337, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1342, 'CLAN CHALENGER', NULL, 1338, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1343, 'BAVARIA EXPRESS', NULL, 1339, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1344, 'CMA CGM INTENSITY', NULL, 1340, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1345, 'CMA CGM CORTES', NULL, 1341, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1346, 'MSC SUSANNA', NULL, 1342, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1347, 'SILVER OCEAN', NULL, 1343, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1348, 'EUROS PARIS', NULL, 1344, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1349, 'EXPRESS', NULL, 1345, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1350, 'MSC BENGAL', NULL, 1346, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1351, 'HANSA WISMAR', NULL, 1347, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1352, 'CSAV COLOMBIA ', NULL, 1348, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1353, 'VALPARAISO EXPRESS', NULL, 1349, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1354, 'CALA PANCALDO', NULL, 1350, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1355, 'OOCL XIAMEN', NULL, 1351, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1356, 'MAERSK DABOU', NULL, 1352, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1357, 'MSC PEGGY', NULL, 1353, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1358, 'MARUBA PAMPERO', NULL, 1354, b'1', 1, '2007-12-27 00:35:00', 1, 2, '2007-12-27 00:36:00', NULL),
(1359, 'TS KEELUNG', NULL, 1355, b'1', 1, '2008-01-21 17:06:00', 1, 2, '2008-01-21 17:06:00', NULL),
(1360, 'MARIO A', NULL, 1356, b'1', 18, '2008-01-22 20:40:00', 18, 2, '2008-01-22 20:40:00', NULL),
(1361, 'MARIO A', NULL, 1357, b'1', 19, '2008-01-22 22:11:00', 19, 2, '2008-01-22 22:11:00', NULL),
(1362, 'MAERSK DIEPPE', NULL, 1358, b'1', 18, '2008-01-24 19:10:00', 18, 2, '2008-01-24 19:10:00', NULL),
(1363, 'PACIFIC HIGHWAY ', NULL, 1359, b'1', 18, '2008-01-30 15:47:00', 18, 2, '2008-01-30 15:47:00', NULL),
(1364, 'CALA PULA', NULL, 1360, b'1', 18, '2008-01-30 16:24:00', 18, 2, '2008-01-30 16:24:00', NULL),
(1365, 'YE SHAN', NULL, 1361, b'1', 18, '2008-02-05 17:46:00', 18, 2, '2008-02-05 17:46:00', NULL),
(1366, 'SB EXPRESS', NULL, 1362, b'1', 18, '2008-02-06 20:52:00', 18, 2, '2008-02-06 20:52:00', NULL),
(1367, 'APL QUITO', NULL, 1363, b'1', 19, '2008-02-11 19:45:00', 19, 2, '2008-02-11 19:45:00', NULL),
(1368, 'AS PEGASUS', NULL, 1364, b'1', 19, '2008-02-28 19:34:00', 19, 2, '2008-02-28 19:34:00', NULL),
(1369, 'CMA PROVIDENCE', NULL, 1365, b'1', 19, '2008-03-07 23:16:00', 19, 2, '2008-03-07 23:16:00', NULL),
(1370, 'CMA CGM ESPERANZA', NULL, 1366, b'1', 19, '2008-03-10 16:51:00', 19, 2, '2008-03-10 16:51:00', NULL),
(1371, 'PANABO', NULL, 1367, b'1', 19, '2008-03-10 19:34:00', 19, 2, '2008-03-10 19:34:00', NULL),
(1372, 'ARCADIA HIGHWAY', NULL, 1368, b'1', 19, '2008-03-10 22:21:00', 19, 2, '2008-03-10 22:21:00', NULL),
(1373, 'HAMMONIA BEROLINA', NULL, 1369, b'1', 19, '2008-03-12 22:53:00', 19, 2, '2008-03-12 22:53:00', NULL),
(1374, 'APL COLIMA', NULL, 1370, b'1', 19, '2008-03-27 18:57:00', 19, 2, '2008-03-27 18:57:00', NULL),
(1375, 'CMA CGM FORTUNA', NULL, 1371, b'1', 19, '2008-03-27 19:04:00', 19, 2, '2008-03-27 19:04:00', NULL),
(1376, 'BVA LIBRA', NULL, 1372, b'1', 19, '2008-03-27 19:13:00', 19, 2, '2008-03-27 19:13:00', NULL),
(1377, 'MSC SICILY ', NULL, 1373, b'1', 19, '2008-03-27 21:29:00', 19, 2, '2008-03-27 21:29:00', NULL),
(1378, 'MSC BASEL', NULL, 1374, b'1', 19, '2008-03-27 21:38:00', 19, 2, '2008-03-27 21:38:00', NULL),
(1379, 'CSCL NAPOLI ', NULL, 1375, b'1', 19, '2008-04-02 22:00:00', 19, 2, '2008-04-02 22:00:00', NULL),
(1380, 'MARUBA ORION', NULL, 1376, b'1', 19, '2008-04-08 13:54:00', 19, 2, '2008-04-08 13:54:00', NULL),
(1381, 'VITALITY', NULL, 1377, b'1', 19, '2008-04-09 20:39:00', 19, 2, '2008-04-09 20:39:00', NULL),
(1382, 'MARIVIA', NULL, 1378, b'1', 19, '2008-04-16 19:40:00', 19, 2, '2008-04-16 19:40:00', NULL),
(1383, 'MAERSK DARTMOUTH', NULL, 1379, b'1', 18, '2008-04-25 17:13:00', 18, 2, '2008-04-25 17:13:00', NULL),
(1384, 'HYUNDAI VOYAGER', NULL, 1380, b'1', 19, '2008-05-02 19:38:00', 19, 2, '2008-05-02 19:38:00', NULL),
(1385, 'MSC MELISSA', NULL, 1381, b'1', 19, '2008-05-05 16:35:00', 19, 2, '2008-05-05 16:35:00', NULL),
(1386, 'ZIM SAVANNAH', NULL, 1382, b'1', 19, '2008-05-07 20:23:00', 19, 2, '2008-05-07 20:23:00', NULL),
(1387, 'SANTA CLARA', NULL, 1383, b'1', 19, '2008-05-08 21:52:00', 19, 2, '2008-05-08 21:52:00', NULL),
(1388, 'IBIZA R', NULL, 1384, b'1', 19, '2008-05-13 14:01:00', 19, 2, '2008-05-13 14:01:00', NULL),
(1389, 'CMA CMG PACIFICO', NULL, 1385, b'1', 19, '2008-05-15 01:37:00', 19, 2, '2008-05-15 01:37:00', NULL),
(1390, 'CMA CGM PACIFICO', NULL, 1386, b'1', 19, '2008-05-15 01:39:00', 19, 2, '2008-05-15 01:39:00', NULL),
(1391, 'APL MENDOZA', NULL, 1387, b'1', 19, '2008-05-15 01:46:00', 19, 2, '2008-05-15 01:46:00', NULL),
(1392, 'NYK CLARA', NULL, 1388, b'1', 19, '2008-05-20 21:31:00', 19, 2, '2008-05-20 21:31:00', NULL),
(1393, 'PEGAUS HIGHWAY ', NULL, 1389, b'1', 19, '2008-05-27 17:39:00', 19, 2, '2008-05-27 17:39:00', NULL),
(1394, 'CSCL FUZHOU', NULL, 1390, b'1', 19, '2008-06-05 01:54:00', 19, 2, '2008-06-05 01:54:00', NULL),
(1395, 'MAERSK  DANBURY', NULL, 1391, b'1', 19, '2008-06-05 19:49:00', 19, 2, '2008-06-05 19:49:00', NULL),
(1396, 'TEERA BHUM ', NULL, 1392, b'1', 19, '2008-06-16 19:10:00', 19, 2, '2008-06-16 19:10:00', NULL),
(1397, 'MOL PRESENCE ', NULL, 1393, b'1', 19, '2008-06-16 19:16:00', 19, 2, '2008-06-16 19:16:00', NULL),
(1398, 'H FREEDOM  ', NULL, 1394, b'1', 19, '2008-06-16 19:21:00', 19, 2, '2008-06-16 19:21:00', NULL),
(1399, 'MAERSK  MYTILINI', NULL, 1395, b'1', 19, '2008-06-19 15:17:00', 19, 2, '2008-06-19 15:17:00', NULL),
(1400, 'MSC VENEZUELA ', NULL, 1396, b'1', 19, '2008-06-23 16:05:00', 19, 2, '2008-06-23 16:05:00', NULL),
(1401, 'ALIOTH', NULL, 1397, b'1', 19, '2008-06-23 16:10:00', 19, 2, '2008-06-23 16:10:00', NULL),
(1402, 'MAERSK MATAME', NULL, 1398, b'1', 19, '2008-06-23 18:13:00', 19, 2, '2008-06-23 18:13:00', NULL),
(1403, 'OOCL SHANGHAI ', NULL, 1399, b'1', 19, '2008-06-23 18:23:00', 19, 2, '2008-06-23 18:23:00', NULL),
(1404, 'MSC IBIZA ', NULL, 1400, b'1', 19, '2008-07-01 18:27:00', 19, 2, '2008-07-01 18:27:00', NULL),
(1405, 'ZIM BEIJING ', NULL, 1401, b'1', 19, '2008-07-01 19:25:00', 19, 2, '2008-07-01 19:25:00', NULL),
(1406, 'SE VICTORY', NULL, 1402, b'1', 19, '2008-07-03 16:13:00', 19, 2, '2008-07-03 16:13:00', NULL),
(1407, 'HERMANN HESSE', NULL, 1403, b'1', 19, '2008-07-04 13:28:00', 19, 2, '2008-07-04 13:28:00', NULL),
(1408, 'NYK DANIELLA', NULL, 1404, b'1', 19, '2008-07-08 18:50:00', 19, 2, '2008-07-08 18:50:00', NULL),
(1409, 'CSAV TOTORAL', NULL, 1405, b'1', 19, '2008-07-10 01:01:00', 19, 2, '2008-07-10 01:01:00', NULL),
(1410, 'MAERSK TARROGONA', NULL, 1406, b'1', 19, '2008-07-10 01:04:00', 19, 2, '2008-07-10 01:04:00', NULL),
(1411, 'CFS PALENCIA', NULL, 1407, b'1', 19, '2008-07-14 13:18:00', 19, 2, '2008-07-14 13:18:00', NULL),
(1412, 'MSC TAMPA', NULL, 1408, b'1', 19, '2008-07-25 17:00:00', 19, 2, '2008-07-25 17:00:00', NULL),
(1413, 'CMA CGM MARINA', NULL, 1409, b'1', 19, '2008-08-14 18:06:00', 19, 2, '2008-08-14 18:06:00', NULL),
(1414, 'MSC PAOLA', NULL, 1410, b'1', 19, '2008-08-14 18:59:00', 19, 2, '2008-08-14 18:59:00', NULL),
(1415, 'MSC HEIDI', NULL, 1411, b'1', 19, '2008-08-14 18:59:00', 19, 2, '2008-08-14 18:59:00', NULL),
(1416, 'CAP EGMONT', NULL, 1412, b'1', 19, '2008-08-19 18:57:00', 19, 2, '2008-08-19 18:57:00', NULL),
(1417, 'NYK ESPIRITO', NULL, 1413, b'1', 19, '2008-08-22 19:23:00', 19, 2, '2008-08-22 19:23:00', NULL),
(1418, 'MSC VITTORA', NULL, 1414, b'1', 19, '2008-09-01 22:00:00', 19, 2, '2008-09-01 22:00:00', NULL),
(1419, 'APL GALAPAGOS', NULL, 1415, b'1', 19, '2008-09-02 19:59:00', 19, 2, '2008-09-02 19:59:00', NULL),
(1420, 'CCNI MANZANILLO ', NULL, 1416, b'1', 19, '2008-09-04 21:02:00', 19, 2, '2008-09-04 21:02:00', NULL),
(1421, 'HANSA AUGUSTENBURG', NULL, 1417, b'1', 19, '2008-09-08 17:42:00', 19, 2, '2008-09-08 17:42:00', NULL),
(1422, 'LT TRIESTE', NULL, 1418, b'1', 19, '2008-09-09 00:09:00', 19, 2, '2008-09-09 00:09:00', NULL),
(1423, 'MSC ALESSIA', NULL, 1419, b'1', 19, '2008-09-12 18:33:00', 119, 2, '2017-08-07 17:04:00', NULL),
(1424, 'CMA CGM OCEANO', NULL, 1420, b'1', 19, '2008-09-16 18:39:00', 19, 2, '2008-09-16 18:39:00', NULL),
(1425, 'IWASHIRO ', NULL, 1421, b'1', 18, '2008-09-18 17:03:00', 18, 2, '2008-09-18 17:03:00', NULL),
(1426, 'H HIGHNESS', NULL, 1422, b'1', 18, '2008-09-18 17:23:00', 18, 2, '2008-09-18 17:23:00', NULL),
(1427, 'MSC RACHELE', NULL, 1423, b'1', 18, '2008-09-18 17:58:00', 18, 2, '2008-09-18 17:58:00', NULL),
(1428, 'WESTERMUHLEN', NULL, 1424, b'1', 18, '2008-09-22 15:39:00', 18, 2, '2008-09-22 15:39:00', NULL),
(1429, 'APL SWEDEN ', NULL, 1425, b'1', 18, '2008-09-23 14:54:00', 18, 2, '2008-09-23 14:54:00', NULL),
(1430, 'ZHONG HANG ', NULL, 1426, b'1', 18, '2008-09-23 20:14:00', 18, 2, '2008-09-23 20:14:00', NULL),
(1431, 'ELB CARRIER', NULL, 1427, b'1', 18, '2008-09-25 16:21:00', 18, 2, '2008-09-25 16:21:00', NULL),
(1432, 'MSC URUGUAY', NULL, 1428, b'1', 18, '2008-09-26 19:12:00', 18, 2, '2008-09-26 19:12:00', NULL),
(1433, 'APL BELGIUM', NULL, 1429, b'1', 18, '2008-09-29 15:09:00', 18, 2, '2008-09-29 15:09:00', NULL),
(1434, 'APL INDIA', NULL, 1430, b'1', 18, '2008-09-29 21:38:00', 18, 2, '2008-09-29 21:38:00', NULL),
(1435, 'MSC BELGIUM DR', NULL, 1431, b'1', 18, '2008-09-29 22:26:00', 18, 2, '2008-09-29 22:26:00', NULL),
(1436, 'CAP BONAVISTA ', NULL, 1432, b'1', 18, '2008-09-30 16:04:00', 18, 2, '2008-09-30 16:04:00', NULL),
(1437, 'GUO MAO ', NULL, 1433, b'1', 18, '2008-10-01 14:50:00', 18, 2, '2008-10-01 14:50:00', NULL),
(1438, 'MARTRAVELLER', NULL, 1434, b'1', 18, '2008-10-01 20:51:00', 18, 2, '2008-10-01 20:51:00', NULL),
(1439, 'CMA CGM JAGUAR', NULL, 1435, b'1', 18, '2008-10-02 15:15:00', 18, 2, '2008-10-02 15:15:00', NULL),
(1440, 'APL CANADA', NULL, 1436, b'1', 18, '2008-10-03 15:26:00', 18, 2, '2008-10-03 15:26:00', NULL),
(1441, 'MAERSK MYTILINI ', NULL, 1437, b'1', 18, '2008-10-06 15:39:00', 18, 2, '2008-10-06 15:39:00', NULL),
(1442, 'MSC TOMOKO', NULL, 1438, b'1', 18, '2008-10-06 15:55:00', 18, 2, '2008-10-06 15:55:00', NULL),
(1443, 'NORFOLK EXPRESS', NULL, 1439, b'1', 18, '2008-10-07 15:44:00', 18, 2, '2008-10-07 15:44:00', NULL),
(1444, 'DONG PENG ', NULL, 1440, b'1', 18, '2008-10-07 16:09:00', 18, 2, '2008-10-07 16:09:00', NULL),
(1445, 'FOSHAN', NULL, 1441, b'1', 18, '2008-10-09 17:30:00', 18, 2, '2008-10-09 17:30:00', NULL),
(1446, 'MARUBA VICTORY ', NULL, 1442, b'1', 18, '2008-10-10 15:39:00', 18, 2, '2008-10-10 15:39:00', NULL),
(1447, 'CMA CGM PROVIDENCIA', NULL, 1443, b'1', 18, '2008-10-13 16:47:00', 18, 2, '2008-10-13 16:47:00', NULL),
(1448, 'MSC TUSCANY', NULL, 1444, b'1', 18, '2008-10-13 22:51:00', 18, 2, '2008-10-13 22:51:00', NULL),
(1449, 'K WIND', NULL, 1445, b'1', 18, '2008-10-15 15:01:00', 18, 2, '2008-10-15 15:01:00', NULL),
(1450, 'MSC MAEVA', NULL, 1446, b'1', 18, '2008-10-16 20:25:00', 18, 2, '2008-10-16 20:25:00', NULL),
(1451, 'MSC BALTIC', NULL, 1447, b'1', 18, '2008-10-16 20:31:00', 18, 2, '2008-10-16 20:31:00', NULL),
(1452, 'CCNI BUSAN', NULL, 1448, b'1', 18, '2008-10-22 16:24:00', 18, 2, '2008-10-22 16:24:00', NULL),
(1453, 'SCI VIJAY', NULL, 1449, b'1', 18, '2008-10-23 20:52:00', 18, 2, '2008-10-23 20:52:00', NULL),
(1454, 'SEABOARD INTREPID', NULL, 1450, b'1', 18, '2008-10-23 22:20:00', 18, 2, '2008-10-23 22:20:00', NULL),
(1455, 'MSC EVEREST', NULL, 1451, b'1', 18, '2008-10-31 21:13:00', 18, 2, '2008-10-31 21:13:00', NULL),
(1456, 'CAP BRETON', NULL, 1452, b'1', 18, '2008-11-05 16:22:00', 18, 2, '2008-11-05 16:22:00', NULL),
(1457, 'CROWN GARNET', NULL, 1453, b'1', 18, '2008-11-06 15:33:00', 18, 2, '2008-11-06 15:33:00', NULL),
(1458, 'CSCL SAO PAULO', NULL, 1454, b'1', 18, '2008-11-06 16:24:00', 18, 2, '2008-11-06 16:24:00', NULL),
(1459, 'PENDIENTE', NULL, 1455, b'1', 18, '2008-11-06 22:08:00', 18, 2, '2008-11-06 22:08:00', NULL),
(1460, 'NYK VESTA ', NULL, 1456, b'1', 18, '2008-11-10 21:15:00', 18, 2, '2008-11-10 21:15:00', NULL),
(1461, 'MANILA EXPRESS', NULL, 1457, b'1', 18, '2008-11-11 15:11:00', 18, 2, '2008-11-11 15:11:00', NULL),
(1462, 'OOCL MUMBAI', NULL, 1458, b'1', 18, '2008-11-12 16:17:00', 18, 2, '2008-11-12 16:17:00', NULL),
(1463, 'MARUBA ENTERPRISE', NULL, 1459, b'1', 18, '2008-11-13 15:09:00', 18, 2, '2008-11-13 15:09:00', NULL),
(1464, 'ZIM HAIFA', NULL, 1460, b'1', 18, '2008-11-13 17:19:00', 18, 2, '2008-11-13 17:19:00', NULL),
(1465, 'CAP VALIENTE', NULL, 1461, b'1', 18, '2008-11-14 15:44:00', 18, 2, '2008-11-14 15:44:00', NULL),
(1466, 'MSC DRESDEN', NULL, 1462, b'1', 18, '2008-11-14 20:24:00', 18, 2, '2008-11-14 20:24:00', NULL),
(1467, 'TERRESTRE', NULL, 1463, b'1', 18, '2008-11-17 21:21:00', 18, 2, '2008-11-17 21:21:00', NULL),
(1468, 'RIO DE JANEIRO', NULL, 1464, b'1', 18, '2008-11-19 16:21:00', 18, 2, '2008-11-19 16:21:00', NULL),
(1469, 'MSC NEDERLAND ', NULL, 1465, b'1', 18, '2008-11-20 14:22:00', 18, 2, '2008-11-20 14:22:00', NULL),
(1470, 'OOCL KEELUNG', NULL, 1466, b'1', 18, '2008-11-24 20:43:00', 18, 2, '2008-11-24 20:43:00', NULL),
(1471, 'CMA CGM IGUACU', NULL, 1467, b'1', 18, '2008-11-28 15:49:00', 18, 2, '2008-11-28 15:49:00', NULL),
(1472, 'ZIM QINGDAO ', NULL, 1468, b'1', 18, '2008-12-03 20:19:00', 18, 2, '2008-12-03 20:19:00', NULL),
(1473, 'CONTI SALOME ', NULL, 1469, b'1', 18, '2008-12-04 20:36:00', 18, 2, '2008-12-04 20:36:00', NULL),
(1474, 'MSC ALMERIA', NULL, 1470, b'1', 18, '2008-12-05 14:48:00', 18, 2, '2008-12-05 14:48:00', NULL),
(1475, 'CMA CGM DO BRASIL', NULL, 1471, b'1', 18, '2008-12-09 17:13:00', 18, 2, '2008-12-09 17:13:00', NULL),
(1476, 'GRETE MAERSK ', NULL, 1472, b'1', 18, '2008-12-12 21:00:00', 18, 2, '2008-12-12 21:00:00', NULL),
(1477, 'EVER REACH ', NULL, 1473, b'1', 18, '2008-12-16 17:47:00', 18, 2, '2008-12-16 17:47:00', NULL),
(1478, 'SOUTHAMPTON EXP', NULL, 1474, b'1', 18, '2008-12-17 16:38:00', 18, 2, '2008-12-17 16:38:00', NULL),
(1479, 'CMA CGM ALCAZAR', NULL, 1475, b'1', 18, '2008-12-22 18:07:00', 18, 2, '2008-12-22 18:07:00', NULL),
(1480, 'MAERSK ANTARES', NULL, 1476, b'1', 18, '2008-12-22 18:07:00', 18, 2, '2008-12-22 18:07:00', NULL),
(1481, 'SUN ROUND', NULL, 1477, b'1', 18, '2008-12-22 20:55:00', 18, 2, '2008-12-22 20:55:00', NULL),
(1482, 'ALBERT MAERSK ', NULL, 1478, b'1', 18, '2008-12-29 16:33:00', 18, 2, '2008-12-29 16:33:00', NULL),
(1483, 'OOCL SHENZHEN', NULL, 1479, b'1', 18, '2008-12-29 17:01:00', 18, 2, '2008-12-29 17:01:00', NULL),
(1484, 'CAPE ARAGO', NULL, 1480, b'1', 18, '2008-12-29 17:44:00', 18, 2, '2008-12-29 17:44:00', NULL),
(1485, 'AB STAR ', NULL, 1481, b'1', 18, '2009-01-02 15:44:00', 18, 2, '2009-01-02 15:44:00', NULL),
(1486, 'SAN FELIPE', NULL, 1482, b'1', 18, '2009-01-05 21:10:00', 18, 2, '2009-01-05 21:10:00', NULL),
(1487, 'EVER GIFTED', NULL, 1483, b'1', 18, '2009-01-06 17:29:00', 18, 2, '2009-01-06 17:29:00', NULL),
(1488, 'MSC CORDOBA', NULL, 1484, b'1', 18, '2009-01-07 16:41:00', 18, 2, '2009-01-07 16:41:00', NULL),
(1489, 'SOVEREIGN MAERSK', NULL, 1485, b'1', 18, '2009-01-07 17:02:00', 18, 2, '2009-01-07 17:02:00', NULL),
(1490, 'MAERSK SANTANA', NULL, 1486, b'1', 18, '2009-01-16 14:30:00', 18, 2, '2009-01-16 14:30:00', NULL),
(1491, 'LADY KORCULA', NULL, 1487, b'1', 18, '2009-01-16 21:11:00', 18, 2, '2009-01-16 21:11:00', NULL),
(1492, 'MSC CARINA', NULL, 1488, b'1', 18, '2009-01-21 15:21:00', 18, 2, '2009-01-21 15:21:00', NULL),
(1493, 'NYK ISABEL', NULL, 1489, b'1', 18, '2009-01-23 15:43:00', 18, 2, '2009-01-23 15:43:00', NULL),
(1494, 'K BREEZE', NULL, 1490, b'1', 18, '2009-01-26 18:16:00', 18, 2, '2009-01-26 18:16:00', NULL),
(1495, 'MSC SEATTLE', NULL, 1491, b'1', 18, '2009-01-29 22:13:00', 18, 2, '2009-01-29 22:13:00', NULL),
(1496, 'MSC ANIELLO', NULL, 1492, b'1', 18, '2009-02-03 15:23:00', 18, 2, '2009-02-03 15:23:00', NULL),
(1497, 'ANDRE RICKMERS', NULL, 1493, b'1', 18, '2009-02-06 17:20:00', 18, 2, '2009-02-06 17:20:00', NULL),
(1498, 'PACIFIC HAWK', NULL, 1494, b'1', 18, '2009-02-10 17:50:00', 18, 2, '2009-02-10 17:50:00', NULL),
(1499, 'GJERTRUD MAERSK', NULL, 1495, b'1', 18, '2009-02-11 20:42:00', 18, 2, '2009-02-11 20:42:00', NULL),
(1500, 'APL DENMARK', NULL, 1496, b'1', 18, '2009-02-12 14:24:00', 18, 2, '2009-02-12 14:24:00', NULL),
(1501, 'MSC ENGLAND', NULL, 1497, b'1', 18, '2009-02-13 15:12:00', 18, 2, '2009-02-13 15:12:00', NULL),
(1502, 'NORASIA ALPS', NULL, 1498, b'1', 18, '2009-02-17 16:50:00', 18, 2, '2009-02-17 16:50:00', NULL),
(1503, 'CMA CGM AEGEAN', NULL, 1499, b'1', 18, '2009-02-18 15:53:00', 18, 2, '2009-02-18 15:53:00', NULL);
INSERT INTO `barco` (`id_barco`, `nombre`, `bandera`, `idBarco`, `Estado`, `idUsuario`, `fechaIngreso`, `idUsuarioModifica`, `id_sucursal`, `fechamodificacion`, `tipo`) VALUES
(1504, 'CMA CGM EXCELLENCE ', NULL, 1500, b'1', 18, '2009-03-11 21:48:00', 18, 2, '2009-03-11 21:48:00', NULL),
(1505, 'NYK LAURA', NULL, 1501, b'1', 18, '2009-03-12 15:55:00', 18, 2, '2009-03-12 15:55:00', NULL),
(1506, 'MOL COMPETENCE', NULL, 1502, b'1', 18, '2009-03-17 16:55:00', 18, 2, '2009-03-17 16:55:00', NULL),
(1507, 'HUI WAN ', NULL, 1503, b'1', 18, '2009-03-20 17:45:00', 18, 2, '2009-03-20 17:45:00', NULL),
(1508, 'MSC SOPHIE', NULL, 1504, b'1', 18, '2009-03-20 20:21:00', 18, 2, '2009-03-20 20:21:00', NULL),
(1509, 'MAERSK DURHAM', NULL, 1505, b'1', 18, '2009-03-23 15:13:00', 18, 2, '2009-03-23 15:13:00', NULL),
(1510, 'EN YUN', NULL, 1506, b'1', 14, '2009-03-30 16:27:00', 14, 2, '2009-03-30 16:27:00', NULL),
(1511, 'SINAR SANGIR', NULL, 1507, b'1', 14, '2009-03-30 21:13:00', 14, 2, '2009-03-30 21:13:00', NULL),
(1512, 'CAP BALANCHE', NULL, 1508, b'1', 14, '2009-04-01 17:01:00', 14, 2, '2009-04-01 17:01:00', NULL),
(1513, 'CHASTINE MAERSK', NULL, 1509, b'1', 14, '2009-04-01 18:33:00', 14, 2, '2009-04-01 18:33:00', NULL),
(1514, 'CCNI VADO LIGURE', NULL, 1510, b'1', 14, '2009-04-02 19:16:00', 14, 2, '2009-04-02 19:16:00', NULL),
(1515, 'CFS PARADERO', NULL, 1511, b'1', 14, '2009-04-06 15:32:00', 14, 2, '2009-04-06 15:32:00', NULL),
(1516, 'CAP GILBERT', NULL, 1512, b'1', 14, '2009-04-06 17:01:00', 14, 2, '2009-04-06 17:01:00', NULL),
(1517, 'APL COLOMBIA', NULL, 1513, b'1', 14, '2009-04-06 19:01:00', 14, 2, '2009-04-06 19:01:00', NULL),
(1518, 'HUI HAI LONG', NULL, 1514, b'1', 18, '2009-04-13 15:01:00', 18, 2, '2009-04-13 15:01:00', NULL),
(1519, 'APL MANAGUA', NULL, 1515, b'1', 18, '2009-04-13 16:20:00', 18, 2, '2009-04-13 16:20:00', NULL),
(1520, 'SALLY MAERSK', NULL, 1516, b'1', 18, '2009-04-14 17:45:00', 18, 2, '2009-04-14 17:45:00', NULL),
(1521, 'MAERSK KOTKA', NULL, 1517, b'1', 18, '2009-04-14 17:51:00', 18, 2, '2009-04-14 17:51:00', NULL),
(1522, 'SEOUL TOWER', NULL, 1518, b'1', 18, '2009-04-15 17:06:00', 18, 2, '2009-04-15 17:06:00', NULL),
(1523, 'VALPARAISO CHILE', NULL, 1519, b'1', 18, '2009-04-17 16:41:00', 18, 2, '2009-04-17 16:41:00', NULL),
(1524, 'MSC VIENNA', NULL, 1520, b'1', 18, '2009-04-20 20:37:00', 18, 2, '2009-04-20 20:37:00', NULL),
(1525, 'ALGERIAN EXPRESS', NULL, 1521, b'1', 14, '2009-04-24 17:40:00', 14, 2, '2009-04-24 17:40:00', NULL),
(1526, 'CLEMENTINE MAERSK', NULL, 1522, b'1', 14, '2009-04-24 21:36:00', 14, 2, '2009-04-24 21:36:00', NULL),
(1527, 'CALA PINO', NULL, 1523, b'1', 18, '2009-04-28 14:52:00', 18, 2, '2009-04-28 14:52:00', NULL),
(1528, 'MAERSK KYRENIA', NULL, 1524, b'1', 18, '2009-04-28 16:39:00', 18, 2, '2009-04-28 16:39:00', NULL),
(1529, 'MARUBA ASIA', NULL, 1525, b'1', 18, '2009-04-30 19:41:00', 18, 2, '2009-04-30 19:41:00', NULL),
(1530, 'MSC SWEDEN', NULL, 1526, b'1', 18, '2009-05-04 15:47:00', 18, 2, '2009-05-04 15:47:00', NULL),
(1531, 'NYK JOANNA', NULL, 1527, b'1', 18, '2009-05-04 16:11:00', 18, 2, '2009-05-04 16:11:00', NULL),
(1532, 'SAFMARINE KARIBA', NULL, 1528, b'1', 18, '2009-05-07 15:05:00', 18, 2, '2009-05-07 15:05:00', NULL),
(1533, 'EVER DEVOTE ', NULL, 1529, b'1', 18, '2009-05-11 19:02:00', 18, 2, '2009-05-11 19:02:00', NULL),
(1534, 'NYK MARIA', NULL, 1530, b'1', 18, '2009-05-12 14:40:00', 18, 2, '2009-05-12 14:40:00', NULL),
(1535, 'BAHIA', NULL, 1531, b'1', 18, '2009-05-12 17:00:00', 18, 2, '2009-05-12 17:00:00', NULL),
(1536, 'EMMA MAERSK', NULL, 1532, b'1', 18, '2009-05-12 17:39:00', 18, 2, '2009-05-12 17:39:00', NULL),
(1537, 'MSC MONICA', NULL, 1533, b'1', 18, '2009-05-13 14:49:00', 18, 2, '2009-05-13 14:49:00', NULL),
(1538, 'HAMMONIA PACIFICUM', NULL, 1534, b'1', 18, '2009-05-18 14:57:00', 18, 2, '2009-05-18 14:57:00', NULL),
(1539, 'BAHIA LAURA', NULL, 1535, b'1', 18, '2009-05-19 15:13:00', 18, 2, '2009-05-19 15:13:00', NULL),
(1540, 'MAERSK DONEGAL', NULL, 1536, b'1', 18, '2009-05-20 15:39:00', 18, 2, '2009-05-20 15:39:00', NULL),
(1541, 'CAP MANUEL', NULL, 1537, b'1', 18, '2009-05-27 16:24:00', 18, 2, '2009-05-27 16:24:00', NULL),
(1542, 'MSC MARTA', NULL, 1538, b'1', 18, '2009-05-27 21:05:00', 18, 2, '2009-05-27 21:05:00', NULL),
(1543, 'YOKOHAMA ', NULL, 1539, b'1', 18, '2009-05-28 21:19:00', 18, 2, '2009-05-28 21:19:00', NULL),
(1544, 'BAHIA CASTILLO', NULL, 1540, b'1', 18, '2009-05-29 14:28:00', 18, 2, '2009-05-29 14:28:00', NULL),
(1545, 'MSC ROSSELLA ', NULL, 1541, b'1', 18, '2009-06-01 15:15:00', 18, 2, '2009-06-01 15:15:00', NULL),
(1546, 'CCNI SHENZHEN', NULL, 1542, b'1', 18, '2009-06-01 15:26:00', 18, 2, '2009-06-01 15:26:00', NULL),
(1547, 'NYK FLORESTA', NULL, 1543, b'1', 18, '2009-06-02 15:40:00', 18, 2, '2009-06-02 15:40:00', NULL),
(1548, 'APL TEXAS', NULL, 1544, b'1', 18, '2009-06-03 15:25:00', 18, 2, '2009-06-03 15:25:00', NULL),
(1549, 'MAERSK KAWASAKI', NULL, 1545, b'1', 18, '2009-06-04 14:50:00', 18, 2, '2009-06-04 14:50:00', NULL),
(1550, 'CAP GREGORY', NULL, 1546, b'1', 18, '2009-06-04 20:20:00', 18, 2, '2009-06-04 20:20:00', NULL),
(1551, 'CITY OF XIAMEN ', NULL, 1547, b'1', 18, '2009-06-11 20:17:00', 18, 2, '2009-06-11 20:17:00', NULL),
(1552, 'ARTHUR MAERSK', NULL, 1548, b'1', 18, '2009-06-11 20:41:00', 18, 2, '2009-06-11 20:41:00', NULL),
(1553, 'CAP HARALD', NULL, 1549, b'1', 18, '2009-06-19 14:28:00', 18, 2, '2009-06-19 14:28:00', NULL),
(1554, 'TUCANA J', NULL, 1550, b'1', 18, '2009-06-19 16:58:00', 18, 2, '2009-06-19 16:58:00', NULL),
(1555, 'MSC SARAH', NULL, 1551, b'1', 18, '2009-06-22 20:33:00', 18, 2, '2009-06-22 20:33:00', NULL),
(1556, 'MAERSK TARRAGONA ', NULL, 1552, b'1', 18, '2009-06-23 14:49:00', 18, 2, '2009-06-23 14:49:00', NULL),
(1557, 'CAP HAMILTON', NULL, 1553, b'1', 18, '2009-06-23 15:37:00', 18, 2, '2009-06-23 15:37:00', NULL),
(1558, 'CMA CGM LA BOUSSOLE', NULL, 1554, b'1', 18, '2009-06-24 22:30:00', 18, 2, '2009-06-24 22:30:00', NULL),
(1559, 'MSC COLOMBIA', NULL, 1555, b'1', 18, '2009-06-24 22:45:00', 18, 2, '2009-06-24 22:45:00', NULL),
(1560, 'MOL INTEGRITY', NULL, 1556, b'1', 18, '2009-06-25 14:25:00', 18, 2, '2009-06-25 14:25:00', NULL),
(1561, 'SVENDBORG MAERSK', NULL, 1557, b'1', 14, '2009-06-29 18:50:00', 14, 2, '2009-06-29 18:50:00', NULL),
(1562, 'CCNI MEJILLONES', NULL, 1558, b'1', 18, '2009-07-01 16:22:00', 18, 2, '2009-07-01 16:22:00', NULL),
(1563, 'APL LIBERTY ', NULL, 1559, b'1', 18, '2009-07-06 15:59:00', 18, 2, '2009-07-06 15:59:00', NULL),
(1564, 'APL ILLINOIS', NULL, 1560, b'1', 18, '2009-07-07 16:00:00', 18, 2, '2009-07-07 16:00:00', NULL),
(1565, 'CAP GRAHAM', NULL, 1561, b'1', 18, '2009-07-07 16:21:00', 18, 2, '2009-07-07 16:21:00', NULL),
(1566, 'MSC ANGELA', NULL, 1562, b'1', 18, '2009-07-08 16:32:00', 18, 2, '2009-07-08 16:32:00', NULL),
(1567, 'APL HONG KONG', NULL, 1563, b'1', 18, '2009-07-09 15:46:00', 18, 2, '2009-07-09 15:46:00', NULL),
(1568, 'H TOKYO', NULL, 1564, b'1', 18, '2009-07-10 17:47:00', 18, 2, '2009-07-10 17:47:00', NULL),
(1569, 'MAERSK STRALSUND', NULL, 1565, b'1', 18, '2009-07-10 20:16:00', 18, 2, '2009-07-10 20:16:00', NULL),
(1570, 'ADRIAN MAERSK', NULL, 1566, b'1', 18, '2009-07-15 17:08:00', 18, 2, '2009-07-15 17:08:00', NULL),
(1571, 'MAERSK KARLSKRONA', NULL, 1567, b'1', 18, '2009-07-20 16:31:00', 18, 2, '2009-07-20 16:31:00', NULL),
(1572, 'HANOI', NULL, 1568, b'1', 18, '2009-07-22 16:30:00', 18, 2, '2009-07-22 16:30:00', NULL),
(1573, 'APL SARDONIX', NULL, 1569, b'1', 18, '2009-07-24 17:41:00', 18, 2, '2009-07-24 17:41:00', NULL),
(1574, 'MSC VALENCIA', NULL, 1570, b'1', 18, '2009-07-27 17:36:00', 18, 2, '2009-07-27 17:36:00', NULL),
(1575, 'MSC OSLO', NULL, 1571, b'1', 18, '2009-07-29 15:39:00', 18, 2, '2009-07-29 15:39:00', NULL),
(1576, 'APL FRANCE', NULL, 1572, b'1', 18, '2009-07-30 16:33:00', 18, 2, '2009-07-30 16:33:00', NULL),
(1577, 'MSC RONIT', NULL, 1573, b'1', 18, '2009-07-30 17:45:00', 18, 2, '2009-07-30 17:45:00', NULL),
(1578, 'FIRST LINE ', NULL, 1574, b'1', 18, '2009-07-30 22:49:00', 18, 2, '2009-07-30 22:49:00', NULL),
(1579, 'MSC JOANNA', NULL, 1575, b'1', 18, '2009-08-14 20:20:00', 18, 2, '2009-08-14 20:20:00', NULL),
(1580, 'BREMEN EXPRESS', NULL, 1576, b'1', 14, '2009-08-18 21:41:00', 14, 2, '2009-08-18 21:41:00', NULL),
(1581, 'FREMANTLE EXPRESS', NULL, 1577, b'1', 18, '2009-08-19 17:17:00', 18, 2, '2009-08-19 17:17:00', NULL),
(1582, 'CAPE FORBY', NULL, 1578, b'1', 14, '2009-08-24 19:18:00', 14, 2, '2009-08-24 19:18:00', NULL),
(1583, 'MSC TOLEDO', NULL, 1579, b'1', 18, '2009-09-08 14:53:00', 18, 2, '2009-09-08 14:53:00', NULL),
(1584, 'BAHIA BLANCA ', NULL, 1580, b'1', 18, '2009-09-08 15:42:00', 18, 2, '2009-09-08 15:42:00', NULL),
(1585, 'ESTEBROKER', NULL, 1581, b'1', 18, '2009-09-08 15:54:00', 18, 2, '2009-09-08 15:54:00', NULL),
(1586, 'SITC TIANJIN', NULL, 1582, b'1', 18, '2009-09-11 20:15:00', 18, 2, '2009-09-11 20:15:00', NULL),
(1587, 'SYDNEY EXPRESS ', NULL, 1583, b'1', 18, '2009-09-14 16:02:00', 18, 2, '2009-09-14 16:02:00', NULL),
(1588, 'LANTAU BAY', NULL, 1584, b'1', 18, '2009-09-22 15:57:00', 18, 2, '2009-09-22 15:57:00', NULL),
(1589, 'HS HUMBOLDT', NULL, 1585, b'1', 18, '2009-09-22 21:59:00', 18, 2, '2009-09-22 21:59:00', NULL),
(1590, 'LOS ANGELES EXPRESS', NULL, 1586, b'1', 18, '2009-09-23 15:35:00', 18, 2, '2009-09-23 15:35:00', NULL),
(1591, 'APL ATLANTA', NULL, 1587, b'1', 18, '2009-09-25 15:29:00', 18, 2, '2009-09-25 15:29:00', NULL),
(1592, 'NYK PAULA', NULL, 1588, b'1', 18, '2009-09-25 16:06:00', 18, 2, '2009-09-25 16:06:00', NULL),
(1593, 'MAERSK DANVILLE', NULL, 1589, b'1', 18, '2009-09-28 16:30:00', 18, 2, '2009-09-28 16:30:00', NULL),
(1594, 'DUESSELDORF EXPRESS', NULL, 1590, b'1', 18, '2009-09-28 16:48:00', 18, 2, '2009-09-28 16:48:00', NULL),
(1595, 'MAERSK DENVER', NULL, 1591, b'1', 18, '2009-10-02 15:37:00', 18, 2, '2009-10-02 15:37:00', NULL),
(1596, 'CMA CGM AUCKLAND ', NULL, 1592, b'1', 18, '2009-10-06 15:36:00', 18, 2, '2009-10-06 15:36:00', NULL),
(1597, 'ZHONG CHENG', NULL, 1593, b'1', 18, '2009-10-06 20:27:00', 18, 2, '2009-10-06 20:27:00', NULL),
(1598, 'LISBON EXPRESS', NULL, 1594, b'1', 18, '2009-10-08 21:00:00', 18, 2, '2009-10-08 21:00:00', NULL),
(1599, 'NYK ROSA ', NULL, 1595, b'1', 18, '2009-10-14 19:11:00', 18, 2, '2009-10-14 19:11:00', NULL),
(1600, 'WELLINGTON EXPRESS', NULL, 1596, b'1', 18, '2009-10-16 21:58:00', 18, 2, '2009-10-16 21:58:00', NULL),
(1601, 'SAVANNAH EXPRESS', NULL, 1597, b'1', 18, '2009-10-16 22:12:00', 18, 2, '2009-10-16 22:12:00', NULL),
(1602, 'MAERKS RECIFE', NULL, 1598, b'1', 18, '2009-10-19 17:41:00', 18, 2, '2009-10-19 17:41:00', NULL),
(1603, 'MSC AUSTRIA ', NULL, 1599, b'1', 18, '2009-10-19 21:54:00', 18, 2, '2009-10-19 21:54:00', NULL),
(1604, 'VALENTINA', NULL, 1600, b'1', 18, '2009-10-26 14:57:00', 18, 2, '2009-10-26 14:57:00', NULL),
(1605, 'CHICAGO EXPRESS', NULL, 1601, b'1', 18, '2009-10-27 19:39:00', 18, 2, '2009-10-27 19:39:00', NULL),
(1606, 'NYK SILVIA', NULL, 1602, b'1', 18, '2009-11-10 16:37:00', 18, 2, '2009-11-10 16:37:00', NULL),
(1607, 'BANGKOK EXPRESS', NULL, 1603, b'1', 18, '2009-11-12 16:36:00', 18, 2, '2009-11-12 16:36:00', NULL),
(1608, 'JIN LONG ', NULL, 1604, b'1', 18, '2009-11-13 21:11:00', 18, 2, '2009-11-13 21:11:00', NULL),
(1609, 'MAERSK JAMBI', NULL, 1605, b'1', 18, '2009-11-17 20:12:00', 18, 2, '2009-11-17 20:12:00', NULL),
(1610, 'MAERSK TAURUS', NULL, 1606, b'1', 18, '2009-11-20 15:25:00', 18, 2, '2009-11-20 15:25:00', NULL),
(1611, 'CONTI EMDEN', NULL, 1607, b'1', 18, '2009-11-20 15:43:00', 18, 2, '2009-11-20 15:43:00', NULL),
(1612, 'MAERSK KOKURA', NULL, 1608, b'1', 18, '2009-11-20 16:37:00', 18, 2, '2009-11-20 16:37:00', NULL),
(1613, 'CSAV LONQUIMAY', NULL, 1609, b'1', 18, '2009-11-20 20:20:00', 18, 2, '2009-11-20 20:20:00', NULL),
(1614, 'JIANG HAI TONG', NULL, 1610, b'1', 18, '2009-11-24 20:43:00', 18, 2, '2009-11-24 20:43:00', NULL),
(1615, 'MSC ANCONA', NULL, 1611, b'1', 18, '2009-11-24 20:58:00', 18, 2, '2009-11-24 20:58:00', NULL),
(1616, 'MAERSK DHAHRAN ', NULL, 1612, b'1', 18, '2009-11-25 17:03:00', 18, 2, '2009-11-25 17:03:00', NULL),
(1617, 'SINGAPORE EXPRESS', NULL, 1613, b'1', 18, '2009-11-25 17:17:00', 18, 2, '2009-11-25 17:17:00', NULL),
(1618, 'CACL SAO PAULO', NULL, 1614, b'1', 18, '2009-11-26 15:37:00', 18, 2, '2009-11-26 15:37:00', NULL),
(1619, 'NYK VERONICA ', NULL, 1615, b'1', 18, '2009-11-27 21:36:00', 18, 2, '2009-11-27 21:36:00', NULL),
(1620, 'MAERSK SAVANNAH', NULL, 1616, b'1', 18, '2009-12-01 20:32:00', 18, 2, '2009-12-01 20:32:00', NULL),
(1621, 'MAERSK DRURY', NULL, 1617, b'1', 18, '2009-12-03 20:36:00', 18, 2, '2009-12-03 20:36:00', NULL),
(1622, 'CMA CGM BOUSSOLE ', NULL, 1618, b'1', 18, '2009-12-03 20:50:00', 18, 2, '2009-12-03 20:50:00', NULL),
(1623, 'MAERSK STEPNICA', NULL, 1619, b'1', 18, '2009-12-18 18:44:00', 18, 2, '2009-12-18 18:44:00', NULL),
(1624, 'HYUNDAI CHALLENGER', NULL, 1620, b'1', 18, '2009-12-28 20:47:00', 18, 2, '2009-12-28 20:47:00', NULL),
(1625, 'HYUNDAI PROGRESS', NULL, 1621, b'1', 18, '2009-12-30 16:38:00', 18, 2, '2009-12-30 16:38:00', NULL),
(1626, 'STUTTGART EXPRESS', NULL, 1622, b'1', 24, '2010-01-04 14:29:00', 24, 2, '2010-01-04 14:29:00', NULL),
(1627, 'CAP ROCA', NULL, 1623, b'1', 24, '2010-01-05 20:40:00', 24, 2, '2010-01-05 20:40:00', NULL),
(1628, 'MARUBA KOREA', NULL, 1624, b'1', 18, '2010-01-13 16:13:00', 18, 2, '2010-01-13 16:13:00', NULL),
(1629, 'THEA S', NULL, 1625, b'1', 18, '2010-01-19 16:05:00', 18, 2, '2010-01-19 16:05:00', NULL),
(1630, 'VEGA', NULL, 1626, b'1', 18, '2010-01-19 17:07:00', 18, 2, '2010-01-19 17:07:00', NULL),
(1631, 'APL IRELAND', NULL, 1627, b'1', 18, '2010-01-21 16:53:00', 18, 2, '2010-01-21 16:53:00', NULL),
(1632, 'YONG SHI FENG', NULL, 1628, b'1', 18, '2010-01-26 20:06:00', 18, 2, '2010-01-26 20:06:00', NULL),
(1633, 'MAERSK DALLAS', NULL, 1629, b'1', 18, '2010-02-02 19:38:00', 18, 2, '2010-02-02 19:38:00', NULL),
(1634, 'CAPE MOLLINI', NULL, 1630, b'1', 18, '2010-02-08 17:47:00', 18, 2, '2010-02-08 17:47:00', NULL),
(1635, 'WESTERDIEK', NULL, 1631, b'1', 18, '2010-02-09 19:58:00', 18, 2, '2010-02-09 19:58:00', NULL),
(1636, 'ULF RITSCHER ', NULL, 1632, b'1', 18, '2010-02-11 15:25:00', 18, 2, '2010-02-11 15:25:00', NULL),
(1637, 'CAPE MAGNUS', NULL, 1633, b'1', 18, '2010-02-12 16:21:00', 18, 2, '2010-02-12 16:21:00', NULL),
(1638, 'MARE THRACIUM', NULL, 1634, b'1', 24, '2010-02-19 17:24:00', 24, 2, '2010-02-19 17:24:00', NULL),
(1639, 'MSC MANDRAKI', NULL, 1635, b'1', 18, '2010-02-26 16:33:00', 18, 2, '2010-02-26 16:33:00', NULL),
(1640, 'BAO XING', NULL, 1636, b'1', 18, '2010-02-26 21:07:00', 18, 2, '2010-02-26 21:07:00', NULL),
(1641, 'NAJADE', NULL, 1637, b'1', 18, '2010-03-01 14:27:00', 18, 2, '2010-03-01 14:27:00', NULL),
(1642, 'NANGANG', NULL, 1638, b'1', 18, '2010-03-04 21:14:00', 18, 2, '2010-03-04 21:14:00', NULL),
(1643, 'CARINA STAR ', NULL, 1639, b'1', 18, '2010-03-11 17:49:00', 18, 2, '2010-03-11 17:49:00', NULL),
(1644, 'RONG JING ', NULL, 1640, b'1', 18, '2010-03-15 20:35:00', 18, 2, '2010-03-15 20:35:00', NULL),
(1645, 'MAERSK DAMIETTA ', NULL, 1641, b'1', 18, '2010-03-18 16:15:00', 18, 2, '2010-03-18 16:15:00', NULL),
(1646, 'MAERKS NAJADE', NULL, 1642, b'1', 24, '2010-03-19 15:18:00', 24, 2, '2010-03-19 15:18:00', NULL),
(1647, 'MAERSK NAJADE', NULL, 1643, b'1', 24, '2010-03-19 15:19:00', 24, 2, '2010-03-19 15:19:00', NULL),
(1648, 'GLASGOW EXPRESS ', NULL, 1644, b'1', 24, '2010-03-22 16:57:00', 24, 2, '2010-03-22 16:57:00', NULL),
(1649, 'VLIET TRADER ', NULL, 1645, b'1', 18, '2010-03-23 15:36:00', 18, 2, '2010-03-23 15:36:00', NULL),
(1650, 'ROME EXPRESS', NULL, 1646, b'1', 18, '2010-03-23 15:44:00', 18, 2, '2010-03-23 15:44:00', NULL),
(1651, 'MAERSK ROUBAIX', NULL, 1647, b'1', 18, '2010-03-23 16:02:00', 18, 2, '2010-03-23 16:02:00', NULL),
(1652, 'CMA CGM COMOE', NULL, 1648, b'1', 18, '2010-03-24 17:36:00', 18, 2, '2010-03-24 17:36:00', NULL),
(1653, 'VARAMO', NULL, 1649, b'1', 18, '2010-03-25 17:37:00', 18, 2, '2010-03-25 17:37:00', NULL),
(1654, 'APL GERMANY', NULL, 1650, b'1', 18, '2010-04-05 17:26:00', 18, 2, '2010-04-05 17:26:00', NULL),
(1655, 'NEDLLOYD TASMAN', NULL, 1651, b'1', 18, '2010-04-06 16:25:00', 18, 2, '2010-04-06 16:25:00', NULL),
(1656, 'CAP ISABEL', NULL, 1652, b'1', 24, '2010-04-08 18:42:00', 24, 2, '2010-04-08 18:42:00', NULL),
(1657, 'ND', NULL, 1653, b'1', 18, '2010-04-19 21:58:00', 18, 2, '2010-04-19 21:58:00', NULL),
(1658, 'CSCI PANAMA', NULL, 1654, b'1', 18, '2010-04-26 21:05:00', 18, 2, '2010-04-26 21:05:00', NULL),
(1659, 'HAMMONIA ROMA', NULL, 1655, b'1', 18, '2010-04-29 15:38:00', 18, 2, '2010-04-29 15:38:00', NULL),
(1660, 'CAP INES', NULL, 1656, b'1', 18, '2010-04-29 15:57:00', 18, 2, '2010-04-29 15:57:00', NULL),
(1661, 'CAP SAN AGUSTIN', NULL, 1657, b'1', 18, '2010-05-04 20:17:00', 18, 2, '2010-05-04 20:17:00', NULL),
(1662, 'NYK LIBRA', NULL, 1658, b'1', 18, '2010-05-07 17:52:00', 18, 2, '2010-05-07 17:52:00', NULL),
(1663, 'SEOUL EXPRESS', NULL, 1659, b'1', 18, '2010-05-07 18:02:00', 18, 2, '2010-05-07 18:02:00', NULL),
(1664, 'BALTRUM TRADER', NULL, 1660, b'1', 18, '2010-05-13 17:42:00', 18, 2, '2010-05-13 17:42:00', NULL),
(1665, 'HAMMONIA MASSILIA', NULL, 1661, b'1', 18, '2010-05-18 17:48:00', 18, 2, '2010-05-18 17:48:00', NULL),
(1666, 'MSC FLORIDA', NULL, 1662, b'1', 18, '2010-05-19 17:04:00', 18, 2, '2010-05-19 17:04:00', NULL),
(1667, 'MSC WASHINGTON', NULL, 1663, b'1', 18, '2010-05-21 16:21:00', 18, 2, '2010-05-21 16:21:00', NULL),
(1668, 'COLOMBO EXPRESS', NULL, 1664, b'1', 18, '2010-05-24 18:02:00', 18, 2, '2010-05-24 18:02:00', NULL),
(1669, 'MSC MARA', NULL, 1665, b'1', 18, '2010-06-02 19:42:00', 18, 2, '2010-06-02 19:42:00', NULL),
(1670, 'CHIEF', NULL, 1666, b'1', 18, '2010-06-03 21:46:00', 18, 2, '2010-06-03 21:46:00', NULL),
(1671, 'PING YE', NULL, 1667, b'1', 18, '2010-06-04 21:17:00', 18, 2, '2010-06-04 21:17:00', NULL),
(1672, 'CSAV LINGUE', NULL, 1668, b'1', 18, '2010-06-08 19:14:00', 18, 2, '2010-06-08 19:14:00', NULL),
(1673, 'MARIE SCHULTE', NULL, 1669, b'1', 18, '2010-06-08 19:20:00', 18, 2, '2010-06-08 19:20:00', NULL),
(1674, 'HAMMONIA POMERENIA', NULL, 1670, b'1', 18, '2010-06-10 15:44:00', 18, 2, '2010-06-10 15:44:00', NULL),
(1675, 'LIMARI', NULL, 1671, b'1', 18, '2010-06-10 22:35:00', 18, 2, '2010-06-10 22:35:00', NULL),
(1676, 'OSAKA EXPRESS', NULL, 1672, b'1', 18, '2010-06-14 21:24:00', 18, 2, '2010-06-14 21:24:00', NULL),
(1677, 'CAP SAN ANTONIO', NULL, 1673, b'1', 18, '2010-06-15 16:55:00', 18, 2, '2010-06-15 16:55:00', NULL),
(1678, 'ANTJE SCHULTE', NULL, 1674, b'1', 18, '2010-06-15 22:21:00', 18, 2, '2010-06-15 22:21:00', NULL),
(1679, 'MEDBAYKAL', NULL, 1675, b'1', 18, '2010-06-17 17:28:00', 18, 2, '2010-06-17 17:28:00', NULL),
(1680, 'OTANA BHUM', NULL, 1676, b'1', 18, '2010-06-17 20:31:00', 18, 2, '2010-06-17 20:31:00', NULL),
(1681, 'ALGARROBO', NULL, 1677, b'1', 18, '2010-06-18 15:24:00', 18, 2, '2010-06-18 15:24:00', NULL),
(1682, 'WESTERMOOR', NULL, 1678, b'1', 18, '2010-06-18 15:31:00', 18, 2, '2010-06-18 15:31:00', NULL),
(1683, 'OCTAVIA ', NULL, 1679, b'1', 18, '2010-06-18 20:17:00', 18, 2, '2010-06-18 20:17:00', NULL),
(1684, 'CMA CGM ROSSINI', NULL, 1680, b'1', 18, '2010-06-22 20:13:00', 18, 2, '2010-06-22 20:13:00', NULL),
(1685, 'MSC VOYAGER', NULL, 1681, b'1', 18, '2010-06-25 19:23:00', 18, 2, '2010-06-25 19:23:00', NULL),
(1686, 'BRAVO', NULL, 1682, b'1', 18, '2010-06-29 15:46:00', 18, 2, '2010-06-29 15:46:00', NULL),
(1687, 'HAMMONIA BAVARIA', NULL, 1683, b'1', 18, '2010-07-01 20:43:00', 18, 2, '2010-07-01 20:43:00', NULL),
(1688, 'ZHONG KAI', NULL, 1684, b'1', 18, '2010-07-06 16:26:00', 18, 2, '2010-07-06 16:26:00', NULL),
(1689, 'BONNY ', NULL, 1685, b'1', 18, '2010-07-06 16:42:00', 18, 2, '2010-07-06 16:42:00', NULL),
(1690, 'MARIAKATRARINA', NULL, 1686, b'1', 18, '2010-07-07 22:29:00', 18, 2, '2010-07-07 22:29:00', NULL),
(1691, 'CSAV LLUTA', NULL, 1687, b'1', 18, '2010-07-09 22:47:00', 18, 2, '2010-07-09 22:47:00', NULL),
(1692, 'MSC LAUSANNE', NULL, 1688, b'1', 18, '2010-07-09 23:04:00', 18, 2, '2010-07-09 23:04:00', NULL),
(1693, 'HEUNGAMANILA', NULL, 1689, b'1', 18, '2010-07-12 15:34:00', 18, 2, '2010-07-12 15:34:00', NULL),
(1694, 'KAM WUI', NULL, 1690, b'1', 18, '2010-07-13 16:18:00', 18, 2, '2010-07-13 16:18:00', NULL),
(1695, 'APL PALATIA ', NULL, 1691, b'1', 18, '2010-07-14 16:37:00', 18, 2, '2010-07-14 16:37:00', NULL),
(1696, 'AS PALATIA', NULL, 1692, b'1', 18, '2010-07-14 16:38:00', 18, 2, '2010-07-14 16:38:00', NULL),
(1697, 'DELMAS BRAZZAVILLE', NULL, 1693, b'1', 18, '2010-07-15 21:36:00', 18, 2, '2010-07-15 21:36:00', NULL),
(1698, 'CSAV LONQUEN ', NULL, 1694, b'1', 4, '2010-07-20 22:01:00', 4, 2, '2010-07-20 22:01:00', NULL),
(1699, 'ANKE RITSCHER ', NULL, 1695, b'1', 4, '2010-07-26 19:21:00', 4, 2, '2010-07-26 19:21:00', NULL),
(1700, 'CAP SAN NICOLAS ', NULL, 1696, b'1', 4, '2010-07-27 20:34:00', 4, 2, '2010-07-27 20:34:00', NULL),
(1701, 'MOL BRAVERY', NULL, 1697, b'1', 4, '2010-07-28 18:11:00', 4, 2, '2010-07-28 18:11:00', NULL),
(1702, 'HUA HANG ', NULL, 1698, b'1', 4, '2010-07-29 17:19:00', 4, 2, '2010-07-29 17:19:00', NULL),
(1703, 'FU YUE', NULL, 1699, b'1', 4, '2010-07-30 17:30:00', 4, 2, '2010-07-30 17:30:00', NULL),
(1704, 'HAI LONG ', NULL, 1700, b'1', 4, '2010-08-02 17:09:00', 4, 2, '2010-08-02 17:09:00', NULL),
(1705, 'HS DISCOVERER', NULL, 1701, b'1', 4, '2010-08-02 17:51:00', 4, 2, '2010-08-02 17:51:00', NULL),
(1706, 'STADT KOELN', NULL, 1702, b'1', 4, '2010-08-03 15:58:00', 4, 2, '2010-08-03 15:58:00', NULL),
(1707, 'MOL WISH ', NULL, 1703, b'1', 4, '2010-08-03 16:15:00', 4, 2, '2010-08-03 16:15:00', NULL),
(1708, 'CHINA EXPRESS', NULL, 1704, b'1', 4, '2010-08-05 22:29:00', 4, 2, '2010-08-05 22:29:00', NULL),
(1709, 'BUDAPEST EXPRESS ', NULL, 1705, b'1', 4, '2010-08-06 17:06:00', 4, 2, '2010-08-06 17:06:00', NULL),
(1710, 'COOPER RIVER BRIDGE', NULL, 1706, b'1', 4, '2010-08-10 16:04:00', 4, 2, '2010-08-10 16:04:00', NULL),
(1711, 'MCC JAKARTA', NULL, 1707, b'1', 4, '2010-08-11 15:04:00', 4, 2, '2010-08-11 15:04:00', NULL),
(1712, 'SHI YUN', NULL, 1708, b'1', 4, '2010-08-11 16:22:00', 4, 2, '2010-08-11 16:22:00', NULL),
(1713, 'EMS TRADER ', NULL, 1709, b'1', 4, '2010-08-11 16:33:00', 4, 2, '2010-08-11 16:33:00', NULL),
(1714, 'HUGO SCHULTE', NULL, 1710, b'1', 4, '2010-08-11 16:42:00', 4, 2, '2010-08-11 16:42:00', NULL),
(1715, 'MAERSK DELANO', NULL, 1711, b'1', 4, '2010-08-11 16:51:00', 4, 2, '2010-08-11 16:51:00', NULL),
(1716, 'MSC LORETTA', NULL, 1712, b'1', 4, '2010-08-11 20:49:00', 4, 2, '2010-08-11 20:49:00', NULL),
(1717, 'RUDOLF SCHEPERS ', NULL, 1713, b'1', 4, '2010-08-16 16:30:00', 4, 2, '2010-08-16 16:30:00', NULL),
(1718, 'MSC FORTUNATE ', NULL, 1714, b'1', 4, '2010-08-17 15:15:00', 4, 2, '2010-08-17 15:15:00', NULL),
(1719, 'IJIU', NULL, 1715, b'1', 4, '2010-08-17 15:43:00', 4, 2, '2010-08-17 15:43:00', NULL),
(1720, 'WEHR KOBLENZ', NULL, 1716, b'1', 4, '2010-08-20 20:27:00', 4, 2, '2010-08-20 20:27:00', NULL),
(1721, 'MOL EARNEST', NULL, 1717, b'1', 4, '2010-08-31 17:24:00', 4, 2, '2010-08-31 17:24:00', NULL),
(1722, 'MOL SEABREEZE', NULL, 1718, b'1', 4, '2010-09-01 15:58:00', 4, 2, '2010-09-01 15:58:00', NULL),
(1723, 'MAERSK WAKAMATSU', NULL, 1719, b'1', 4, '2010-09-01 20:03:00', 4, 2, '2010-09-01 20:03:00', NULL),
(1724, 'SANTA CAROLINA ', NULL, 1720, b'1', 18, '2010-09-03 17:34:00', 18, 2, '2010-09-03 17:34:00', NULL),
(1725, 'LOS ANDES BRIDGE', NULL, 1721, b'1', 4, '2010-09-07 21:26:00', 4, 2, '2010-09-07 21:26:00', NULL),
(1726, 'JPO TUCANA ', NULL, 1722, b'1', 4, '2010-09-14 17:46:00', 4, 2, '2010-09-14 17:46:00', NULL),
(1727, 'EURO OSLO', NULL, 1723, b'1', 4, '2010-09-20 23:19:00', 4, 2, '2010-09-20 23:19:00', NULL),
(1728, 'CAP SAN MARCO', NULL, 1724, b'1', 4, '2010-09-21 17:32:00', 4, 2, '2010-09-21 17:32:00', NULL),
(1729, 'AS ANDALUSIA', NULL, 1725, b'1', 4, '2010-09-22 17:24:00', 4, 2, '2010-09-22 17:24:00', NULL),
(1730, 'VALENCIA BRIDGE', NULL, 1726, b'1', 4, '2010-09-28 15:50:00', 4, 2, '2010-09-28 15:50:00', NULL),
(1731, 'VERRAZANO BRIDGE ', NULL, 1727, b'1', 4, '2010-09-28 17:54:00', 4, 2, '2010-09-28 17:54:00', NULL),
(1732, 'WARNOW CARP ', NULL, 1728, b'1', 4, '2010-09-29 20:00:00', 4, 2, '2010-09-29 20:00:00', NULL),
(1733, 'MSC ESTHI', NULL, 1729, b'1', 4, '2010-10-05 22:16:00', 4, 2, '2010-10-05 22:16:00', NULL),
(1734, 'AS ALICANTE', NULL, 1730, b'1', 4, '2010-10-07 21:14:00', 4, 2, '2010-10-07 21:14:00', NULL),
(1735, 'SEABOARD PRIDE', NULL, 1731, b'1', 4, '2010-10-11 15:13:00', 4, 2, '2010-10-11 15:13:00', NULL),
(1736, 'ALVSOBORG BRIDGE ', NULL, 1732, b'1', 4, '2010-10-11 22:22:00', 4, 2, '2010-10-11 22:22:00', NULL),
(1737, 'MAERSK WILLEMSTAD', NULL, 1733, b'1', 4, '2010-10-13 19:50:00', 4, 2, '2010-10-13 19:50:00', NULL),
(1738, 'ARICA BRIDGE', NULL, 1734, b'1', 4, '2010-10-18 22:57:00', 4, 2, '2010-10-18 22:57:00', NULL),
(1739, 'MOL SASTACTION', NULL, 1735, b'1', 4, '2010-10-19 20:46:00', 4, 2, '2010-10-19 20:46:00', NULL),
(1740, 'KYOTO EXPRESS', NULL, 1736, b'1', 4, '2010-10-21 20:20:00', 4, 2, '2010-10-21 20:20:00', NULL),
(1741, 'AMBASSADOR BRIDGE', NULL, 1737, b'1', 18, '2010-11-02 20:02:00', 18, 2, '2010-11-02 20:02:00', NULL),
(1742, 'CORVETTE', NULL, 1738, b'1', 18, '2010-11-05 17:40:00', 18, 2, '2010-11-05 17:40:00', NULL),
(1743, 'TAGUS', NULL, 1739, b'1', 18, '2010-11-09 21:02:00', 18, 2, '2010-11-09 21:02:00', NULL),
(1744, 'NORTHERN PRELUDE', NULL, 1740, b'1', 18, '2010-11-11 16:24:00', 18, 2, '2010-11-11 16:24:00', NULL),
(1745, 'HEUNGA DRAGON', NULL, 1741, b'1', 18, '2010-11-17 20:53:00', 18, 2, '2010-11-17 20:53:00', NULL),
(1746, 'HOUSTON EXPRESS', NULL, 1742, b'1', 18, '2010-11-17 21:08:00', 18, 2, '2010-11-17 21:08:00', NULL),
(1747, 'VINCENT THOMAS BRIDGE', NULL, 1743, b'1', 18, '2010-11-18 19:30:00', 18, 2, '2010-11-18 19:30:00', NULL),
(1748, 'SB VICTORY', NULL, 1744, b'1', 18, '2010-11-19 15:27:00', 18, 2, '2010-11-19 15:27:00', NULL),
(1749, 'MATE', NULL, 1745, b'1', 18, '2010-11-23 19:13:00', 18, 2, '2010-11-23 19:13:00', NULL),
(1750, 'MAERSK WESTPORT', NULL, 1746, b'1', 18, '2010-11-23 20:24:00', 18, 2, '2010-11-23 20:24:00', NULL),
(1751, 'HAMBURG EXPRESS', NULL, 1747, b'1', 18, '2010-11-23 20:33:00', 18, 2, '2010-11-23 20:33:00', NULL),
(1752, 'CAPE FARO', NULL, 1748, b'1', 18, '2010-11-23 20:41:00', 18, 2, '2010-11-23 20:41:00', NULL),
(1753, 'TUCANA', NULL, 1749, b'1', 19, '2010-11-26 22:18:00', 19, 2, '2010-11-26 22:18:00', NULL),
(1754, 'NEDLLOYD JULIANA', NULL, 1750, b'1', 18, '2010-11-30 15:32:00', 18, 2, '2010-11-30 15:32:00', NULL),
(1755, 'LUEN WING', NULL, 1751, b'1', 18, '2010-12-02 16:49:00', 18, 2, '2010-12-02 16:49:00', NULL),
(1756, 'CAP SAN LORENZO', NULL, 1752, b'1', 18, '2010-12-07 22:26:00', 18, 2, '2010-12-07 22:26:00', NULL),
(1757, 'MOL SATISFACTION', NULL, 1753, b'1', 18, '2010-12-13 17:35:00', 18, 2, '2010-12-13 17:35:00', NULL),
(1758, 'EVER RADIANT', NULL, 1754, b'1', 18, '2010-12-20 21:40:00', 18, 2, '2010-12-20 21:40:00', NULL),
(1759, 'CALAPANTERA ', NULL, 1755, b'1', 18, '2010-12-21 21:11:00', 18, 2, '2010-12-21 21:11:00', NULL),
(1760, 'CMA CGM TOGO', NULL, 1756, b'1', 79, '2010-12-23 15:09:00', 79, 2, '2010-12-23 15:09:00', NULL),
(1761, 'EVEN RADIANT', NULL, 1757, b'1', 79, '2010-12-28 16:56:00', 79, 2, '2010-12-28 16:56:00', NULL),
(1762, 'BOSTON', NULL, 1758, b'1', 79, '2010-12-28 17:10:00', 79, 2, '2010-12-28 17:10:00', NULL),
(1763, 'CCNI ANDES', NULL, 1759, b'1', 79, '2010-12-28 18:34:00', 79, 2, '2010-12-28 18:34:00', NULL),
(1764, 'SANTA ROSANNA', NULL, 1760, b'1', 79, '2011-01-03 20:57:00', 79, 2, '2011-01-03 20:57:00', NULL),
(1765, 'VEGALAND', NULL, 1761, b'1', 79, '2011-01-04 19:44:00', 79, 2, '2011-01-04 19:44:00', NULL),
(1766, 'KANWAY GLOBAL', NULL, 1762, b'1', 18, '2011-01-05 15:58:00', 18, 2, '2011-01-05 15:58:00', NULL),
(1767, 'VECCHIO BRIDGE', NULL, 1763, b'1', 18, '2011-01-12 22:09:00', 18, 2, '2011-01-12 22:09:00', NULL),
(1768, 'JUPITER ', NULL, 1764, b'1', 18, '2011-01-14 15:41:00', 18, 2, '2011-01-14 15:41:00', NULL),
(1769, 'MSC KIM', NULL, 1765, b'1', 18, '2011-01-24 16:26:00', 18, 2, '2011-01-24 16:26:00', NULL),
(1770, 'HAI BANG DA', NULL, 1766, b'1', 18, '2011-01-25 19:26:00', 18, 2, '2011-01-25 19:26:00', NULL),
(1771, 'NYK METEOR', NULL, 1767, b'1', 18, '2011-01-26 17:48:00', 18, 2, '2011-01-26 17:48:00', NULL),
(1772, 'CRISTINA STAR', NULL, 1768, b'1', 18, '2011-01-27 21:01:00', 18, 2, '2011-01-27 21:01:00', NULL),
(1773, 'MSC PRAGUE', NULL, 1769, b'1', 87, '2011-01-27 21:21:00', 87, 2, '2011-01-27 21:21:00', NULL),
(1774, 'MAERSK WOLFSBURG', NULL, 1770, b'1', 18, '2011-01-28 21:59:00', 18, 2, '2011-01-28 21:59:00', NULL),
(1775, 'WADI ALRAYAN', NULL, 1771, b'1', 18, '2011-02-07 19:38:00', 18, 2, '2011-02-07 19:38:00', NULL),
(1776, 'POSEN', NULL, 1772, b'1', 18, '2011-02-08 17:35:00', 18, 2, '2011-02-08 17:35:00', NULL),
(1777, 'CAP PASLEY', NULL, 1773, b'1', 18, '2011-02-14 17:41:00', 18, 2, '2011-02-14 17:41:00', NULL),
(1778, 'EVER DEVELOP', NULL, 1774, b'1', 18, '2011-02-21 16:09:00', 18, 2, '2011-02-21 16:09:00', NULL),
(1779, 'HS MOZART LTD', NULL, 1775, b'1', 18, '2011-02-24 17:26:00', 18, 2, '2011-02-24 17:26:00', NULL),
(1780, 'BARRY', NULL, 1776, b'1', 18, '2011-02-24 17:37:00', 18, 2, '2011-02-24 17:37:00', NULL),
(1781, 'CAP PORTLAND', NULL, 1777, b'1', 18, '2011-02-28 17:07:00', 18, 2, '2011-02-28 17:07:00', NULL),
(1782, 'ID ASIA', NULL, 1778, b'1', 18, '2011-03-04 22:15:00', 18, 2, '2011-03-04 22:15:00', NULL),
(1783, 'RIO CHICAGO', NULL, 1779, b'1', 18, '2011-03-07 17:01:00', 18, 2, '2011-03-07 17:01:00', NULL),
(1784, 'ARISARA ', NULL, 1780, b'1', 18, '2011-03-07 17:53:00', 18, 2, '2011-03-07 17:53:00', NULL),
(1785, 'MARIA KATHARINA', NULL, 1781, b'1', 18, '2011-03-10 20:57:00', 18, 2, '2011-03-10 20:57:00', NULL),
(1786, 'CAP PATTON', NULL, 1782, b'1', 18, '2011-03-11 20:35:00', 18, 2, '2011-03-11 20:35:00', NULL),
(1787, 'MSC LUCIANA ', NULL, 1783, b'1', 18, '2011-03-17 18:48:00', 18, 2, '2011-03-17 18:48:00', NULL),
(1788, 'CSAV LIRQUEN', NULL, 1784, b'1', 18, '2011-03-23 20:43:00', 18, 2, '2011-03-23 20:43:00', NULL),
(1789, 'OOCL CHICAGO ', NULL, 1785, b'1', 18, '2011-03-28 20:33:00', 18, 2, '2011-03-28 20:33:00', NULL),
(1790, 'MASOVIA', NULL, 1786, b'1', 24, '2011-03-29 17:16:00', 24, 2, '2011-03-29 17:16:00', NULL),
(1791, 'HYUNDAI JAKARTA', NULL, 1787, b'1', 18, '2011-03-30 21:12:00', 18, 2, '2011-03-30 21:12:00', NULL),
(1792, 'COSCO FUKUYAMA ', NULL, 1788, b'1', 18, '2011-04-14 16:03:00', 18, 2, '2011-04-14 16:03:00', NULL),
(1793, 'BAGHIRA', NULL, 1789, b'1', 87, '2011-04-19 18:06:00', 87, 2, '2011-04-19 18:06:00', NULL),
(1794, 'AMSTERDAM BRIDGE', NULL, 1790, b'1', 18, '2011-04-25 18:02:00', 18, 2, '2011-04-25 18:02:00', NULL),
(1795, 'NYK GALAXY', NULL, 1791, b'1', 18, '2011-04-25 20:02:00', 18, 2, '2011-04-25 20:02:00', NULL),
(1796, 'CCNI CONSTITUCION ', NULL, 1792, b'1', 18, '2011-04-25 20:39:00', 18, 2, '2011-04-25 20:39:00', NULL),
(1797, 'ER DARWING', NULL, 1793, b'1', 18, '2011-04-28 15:33:00', 18, 2, '2011-04-28 15:33:00', NULL),
(1798, 'MSC MOZAMBIQUE', NULL, 1794, b'1', 18, '2011-04-28 20:28:00', 18, 2, '2011-04-28 20:28:00', NULL),
(1799, 'KUO CHANG', NULL, 1795, b'1', 18, '2011-04-29 17:37:00', 18, 2, '2011-04-29 17:37:00', NULL),
(1800, 'CSAV LLANQUIHUE', NULL, 1796, b'1', 18, '2011-04-29 21:18:00', 18, 2, '2011-04-29 21:18:00', NULL),
(1801, 'CSCL MONTEVIDEO', NULL, 1797, b'1', 18, '2011-05-03 19:20:00', 18, 2, '2011-05-03 19:20:00', NULL),
(1802, 'ATHENS BRIDGE ', NULL, 1798, b'1', 18, '2011-05-03 19:57:00', 18, 2, '2011-05-03 19:57:00', NULL),
(1803, 'MSC UKRAINE ', NULL, 1799, b'1', 18, '2011-05-03 20:34:00', 18, 2, '2011-05-03 20:34:00', NULL),
(1804, 'CMA CGM AZURE', NULL, 1800, b'1', 18, '2011-05-04 19:39:00', 18, 2, '2011-05-04 19:39:00', NULL),
(1805, 'CMA CGM TURQUOISE', NULL, 1801, b'1', 18, '2011-05-04 19:45:00', 18, 2, '2011-05-04 19:45:00', NULL),
(1806, 'CSAV LUMACO', NULL, 1802, b'1', 18, '2011-05-05 21:38:00', 18, 2, '2011-05-05 21:38:00', NULL),
(1807, 'KOTA LAYANG ', NULL, 1803, b'1', 18, '2011-05-11 21:16:00', 18, 2, '2011-05-11 21:16:00', NULL),
(1808, 'SEABOARD CARIBE ', NULL, 1804, b'1', 18, '2011-05-11 22:10:00', 18, 2, '2011-05-11 22:10:00', NULL),
(1809, 'APL HAMBURG', NULL, 1805, b'1', 18, '2011-05-13 21:10:00', 18, 2, '2011-05-13 21:10:00', NULL),
(1810, 'MAERKS JEDDAH', NULL, 1806, b'1', 18, '2011-05-16 17:09:00', 18, 2, '2011-05-16 17:09:00', NULL),
(1811, 'KUO YU', NULL, 1807, b'1', 18, '2011-05-17 16:06:00', 18, 2, '2011-05-17 16:06:00', NULL),
(1812, 'MING FEN', NULL, 1808, b'1', 18, '2011-05-17 16:13:00', 18, 2, '2011-05-17 16:13:00', NULL),
(1813, 'MSC POH LIN', NULL, 1809, b'1', 18, '2011-05-17 21:40:00', 18, 2, '2011-05-17 21:40:00', NULL),
(1814, 'MOL WISDOM', NULL, 1810, b'1', 24, '2011-05-18 17:26:00', 24, 2, '2011-05-18 17:26:00', NULL),
(1815, 'SEABOARD MARINE', NULL, 1811, b'1', 18, '2011-05-25 20:31:00', 18, 2, '2011-05-25 20:31:00', NULL),
(1816, 'SHIPPAN ISLAND', NULL, 1812, b'1', 18, '2011-05-25 20:32:00', 18, 2, '2011-05-25 20:32:00', NULL),
(1817, 'KUO CHIA', NULL, 1813, b'1', 18, '2011-05-30 17:08:00', 18, 2, '2011-05-30 17:08:00', NULL),
(1818, 'MSC MELATILDE', NULL, 1814, b'1', 24, '2011-06-02 18:21:00', 24, 2, '2011-06-02 18:21:00', NULL),
(1819, 'NORDSTRAND', NULL, 1815, b'1', 18, '2011-06-07 20:02:00', 18, 2, '2011-06-07 20:02:00', NULL),
(1820, 'CMA CGM LAPIS', NULL, 1816, b'1', 24, '2011-06-08 16:37:00', 24, 2, '2011-06-08 16:37:00', NULL),
(1821, 'LEVERKUZEN EXP', NULL, 1817, b'1', 24, '2011-06-09 16:55:00', 24, 2, '2011-06-09 16:55:00', NULL),
(1822, 'LEVERKUSEN EXP', NULL, 1818, b'1', 24, '2011-06-09 16:58:00', 24, 2, '2011-06-09 16:58:00', NULL),
(1823, 'LEVERKUSEN EXPRESS', NULL, 1819, b'1', 24, '2011-06-09 17:15:00', 24, 2, '2011-06-09 17:15:00', NULL),
(1824, 'APL LOS ANGELES', NULL, 1820, b'1', 18, '2011-06-10 15:43:00', 18, 2, '2011-06-10 15:43:00', NULL),
(1825, 'PEGASUS ', NULL, 1821, b'1', 24, '2011-06-13 15:14:00', 24, 2, '2011-06-13 15:14:00', NULL),
(1826, 'MSC SONIA', NULL, 1822, b'1', 18, '2011-06-13 17:09:00', 18, 2, '2011-06-13 17:09:00', NULL),
(1827, 'MAERSK SARNIA', NULL, 1823, b'1', 18, '2011-06-14 15:56:00', 18, 2, '2011-06-14 15:56:00', NULL),
(1828, 'BILBAO BRIDGE ', NULL, 1824, b'1', 18, '2011-06-22 16:37:00', 18, 2, '2011-06-22 16:37:00', NULL),
(1829, 'KING OCEAN', NULL, 1825, b'1', 18, '2011-06-27 22:35:00', 18, 2, '2011-06-27 22:35:00', NULL),
(1830, 'AGROS', NULL, 1826, b'1', 18, '2011-06-30 14:45:00', 18, 2, '2011-06-30 14:45:00', NULL),
(1831, 'LINGE TRADER', NULL, 1827, b'1', 18, '2011-07-05 17:40:00', 18, 2, '2011-07-05 17:40:00', NULL),
(1832, 'CLOU ISLAND', NULL, 1828, b'1', 18, '2011-07-05 19:10:00', 18, 2, '2011-07-05 19:10:00', NULL),
(1833, 'MSC TERESA', NULL, 1829, b'1', 18, '2011-07-05 19:48:00', 18, 2, '2011-07-05 19:48:00', NULL),
(1834, 'ANCON CHALLENGE', NULL, 1830, b'1', 18, '2011-07-05 21:30:00', 18, 2, '2011-07-05 21:30:00', NULL),
(1835, 'E R KOBE', NULL, 1831, b'1', 18, '2011-07-07 21:40:00', 18, 2, '2011-07-07 21:40:00', NULL),
(1836, 'SAN ALESSIO', NULL, 1832, b'1', 18, '2011-07-08 17:35:00', 18, 2, '2011-07-08 17:35:00', NULL),
(1837, 'MSC BETTINA', NULL, 1833, b'1', 18, '2011-07-12 17:58:00', 18, 2, '2011-07-12 17:58:00', NULL),
(1838, 'MSC BEATRICE', NULL, 1834, b'1', 18, '2011-07-12 20:02:00', 18, 2, '2011-07-12 20:02:00', NULL),
(1839, 'RONGJING', NULL, 1835, b'1', 18, '2011-07-12 20:18:00', 18, 2, '2011-07-12 20:18:00', NULL),
(1840, 'NYK FUTAGO', NULL, 1836, b'1', 87, '2011-07-13 16:31:00', 87, 2, '2011-07-13 16:31:00', NULL),
(1841, 'MARATHOMAS', NULL, 1837, b'1', 87, '2011-07-13 20:01:00', 87, 2, '2011-07-13 20:01:00', NULL),
(1842, 'KARMEN ', NULL, 1838, b'1', 18, '2011-07-14 20:52:00', 18, 2, '2011-07-14 20:52:00', NULL),
(1843, 'HYUNDAI TIANJIN', NULL, 1839, b'1', 18, '2011-07-15 19:11:00', 18, 2, '2011-07-15 19:11:00', NULL),
(1844, 'BEAR MOUNTAIN BRDGE', NULL, 1840, b'1', 18, '2011-07-15 19:48:00', 18, 2, '2011-07-15 19:48:00', NULL),
(1845, 'RIO VALIENTE', NULL, 1841, b'1', 18, '2011-07-21 20:52:00', 18, 2, '2011-07-21 20:52:00', NULL),
(1846, 'HYUNDAI HIGHNESS', NULL, 1842, b'1', 18, '2011-07-25 17:28:00', 18, 2, '2011-07-25 17:28:00', NULL),
(1847, 'CAP SAN RAPHAEL ', NULL, 1843, b'1', 90, '2011-07-26 20:11:00', 90, 2, '2011-07-26 20:11:00', NULL),
(1848, 'KOTA LAHIR ', NULL, 1844, b'1', 18, '2011-08-01 19:18:00', 18, 2, '2011-08-01 19:18:00', NULL),
(1849, 'CANBERRA EXPRESS', NULL, 1845, b'1', 18, '2011-08-01 21:59:00', 18, 2, '2011-08-01 21:59:00', NULL),
(1850, 'MSC FEDERICA', NULL, 1846, b'1', 90, '2011-08-02 17:57:00', 90, 2, '2011-08-02 17:57:00', NULL),
(1851, 'MOL ENDOWMENT', NULL, 1847, b'1', 90, '2011-08-03 17:07:00', 90, 2, '2011-08-03 17:07:00', NULL),
(1852, 'CSAV LICANTEN', NULL, 1848, b'1', 90, '2011-08-04 17:57:00', 90, 2, '2011-08-04 17:57:00', NULL),
(1853, 'MSC BREMEN', NULL, 1849, b'1', 90, '2011-08-04 18:37:00', 90, 2, '2011-08-04 18:37:00', NULL),
(1854, 'NYK FUJI', NULL, 1850, b'1', 90, '2011-08-04 18:49:00', 90, 2, '2011-08-04 18:49:00', NULL),
(1855, 'MAERKS WISMAR', NULL, 1851, b'1', 90, '2011-08-05 14:32:00', 90, 2, '2011-08-05 14:32:00', NULL),
(1856, 'MSC LINZIE', NULL, 1852, b'1', 90, '2011-08-08 20:41:00', 90, 2, '2011-08-08 20:41:00', NULL),
(1857, 'SC FABIENNE', NULL, 1853, b'1', 90, '2011-08-09 14:26:00', 90, 2, '2011-08-09 14:26:00', NULL),
(1858, 'FRITZ REUTER', NULL, 1854, b'1', 90, '2011-08-10 18:19:00', 90, 2, '2011-08-10 18:19:00', NULL),
(1859, 'MSC LESOTHO', NULL, 1855, b'1', 90, '2011-08-23 17:18:00', 90, 2, '2011-08-23 17:18:00', NULL),
(1860, 'OLUF MAERKS', NULL, 1856, b'1', 90, '2011-08-23 17:37:00', 90, 2, '2011-08-23 17:37:00', NULL),
(1861, 'MSC LORENA', NULL, 1857, b'1', 90, '2011-08-23 17:58:00', 90, 2, '2011-08-23 17:58:00', NULL),
(1862, 'WESTERHAMM', NULL, 1858, b'1', 90, '2011-08-24 16:22:00', 90, 2, '2011-08-24 16:22:00', NULL),
(1863, 'BAI CHAY BRIDGE', NULL, 1859, b'1', 18, '2011-08-26 16:31:00', 18, 2, '2011-08-26 16:31:00', NULL),
(1864, 'EVER DIVINE', NULL, 1860, b'1', 90, '2011-08-29 21:02:00', 90, 2, '2011-08-29 21:02:00', NULL),
(1865, 'HANSA ATLANTIC', NULL, 1861, b'1', 90, '2011-08-31 16:05:00', 90, 2, '2011-08-31 16:05:00', NULL),
(1866, 'MOL DIRECTION', NULL, 1862, b'1', 18, '2011-09-01 20:32:00', 18, 2, '2011-09-01 20:32:00', NULL),
(1867, 'NYK COSMOS', NULL, 1863, b'1', 90, '2011-09-05 20:12:00', 90, 2, '2011-09-05 20:12:00', NULL),
(1868, 'COLUMBA', NULL, 1864, b'1', 90, '2011-09-06 14:33:00', 90, 2, '2011-09-06 14:33:00', NULL),
(1869, 'MAERKS DALLAS', NULL, 1865, b'1', 90, '2011-09-12 18:31:00', 90, 2, '2011-09-12 18:31:00', NULL),
(1870, 'SEVILLIA', NULL, 1866, b'1', 18, '2011-09-12 21:02:00', 18, 2, '2011-09-12 21:02:00', NULL),
(1871, 'KOTA LAYAR', NULL, 1867, b'1', 90, '2011-09-14 14:46:00', 90, 2, '2011-09-14 14:46:00', NULL),
(1872, 'JAPAN', NULL, 1868, b'1', 90, '2011-09-16 14:46:00', 90, 2, '2011-09-16 14:46:00', NULL),
(1873, 'ORION', NULL, 1869, b'1', 18, '2011-09-16 22:15:00', 18, 2, '2011-09-16 22:15:00', NULL),
(1874, 'MSC PARIS', NULL, 1870, b'1', 90, '2011-09-21 14:44:00', 90, 2, '2011-09-21 14:44:00', NULL),
(1875, 'BRUSSELS BRIDGE', NULL, 1871, b'1', 90, '2011-09-21 15:01:00', 90, 2, '2011-09-21 15:01:00', NULL),
(1876, 'MOL DIGNITY', NULL, 1872, b'1', 90, '2011-09-22 15:58:00', 90, 2, '2011-09-22 15:58:00', NULL),
(1877, 'MOL DEVOTION', NULL, 1873, b'1', 90, '2011-09-26 15:02:00', 90, 2, '2011-09-26 15:02:00', NULL),
(1878, 'MSC SWAZILAND', NULL, 1874, b'1', 90, '2011-09-27 15:00:00', 90, 2, '2011-09-27 15:00:00', NULL),
(1879, 'HANOVER EXPRESS', NULL, 1875, b'1', 90, '2011-09-27 16:34:00', 90, 2, '2011-09-27 16:34:00', NULL),
(1880, 'SUI HAI YUN', NULL, 1876, b'1', 90, '2011-09-27 18:42:00', 90, 2, '2011-09-27 18:42:00', NULL),
(1881, 'DENEBJ', NULL, 1877, b'1', 18, '2011-10-04 20:11:00', 17, 2, '2014-07-28 17:45:00', NULL),
(1882, 'EVER REWARD', NULL, 1878, b'1', 90, '2011-10-05 16:36:00', 90, 2, '2011-10-05 16:36:00', NULL),
(1883, 'MSC CARMEN', NULL, 1879, b'1', 90, '2011-10-13 16:25:00', 90, 2, '2011-10-13 16:25:00', NULL),
(1884, 'SEATTLE EXPRESS ', NULL, 1880, b'1', 90, '2011-10-13 17:02:00', 90, 2, '2011-10-13 17:02:00', NULL),
(1885, 'PUSAN', NULL, 1881, b'1', 90, '2011-10-17 16:22:00', 90, 2, '2011-10-17 16:22:00', NULL),
(1886, 'BUNGA SEROJA DUA', NULL, 1882, b'1', 90, '2011-10-18 15:49:00', 90, 2, '2011-10-18 15:49:00', NULL),
(1887, 'BUDAPEST BRIDGE', NULL, 1883, b'1', 90, '2011-10-28 16:21:00', 90, 2, '2011-10-28 16:21:00', NULL),
(1888, 'MAERKS TAIKUNG', NULL, 1884, b'1', 90, '2011-10-28 16:38:00', 90, 2, '2011-10-28 16:38:00', NULL),
(1889, 'CAP SCOTT ', NULL, 1885, b'1', 18, '2011-11-03 19:20:00', 18, 2, '2011-11-03 19:20:00', NULL),
(1890, 'PUELO', NULL, 1886, b'1', 18, '2011-11-04 21:23:00', 18, 2, '2011-11-04 21:23:00', NULL),
(1891, 'CRUX J', NULL, 1887, b'1', 18, '2011-11-07 19:07:00', 18, 2, '2011-11-07 19:07:00', NULL),
(1892, 'BERLIN BRIDGE', NULL, 1888, b'1', 18, '2011-11-14 16:16:00', 18, 2, '2011-11-14 16:16:00', NULL),
(1893, 'MAERSK KELSO', NULL, 1889, b'1', 18, '2011-11-21 16:59:00', 18, 2, '2011-11-21 16:59:00', NULL),
(1894, 'MAERSK SANA', NULL, 1890, b'1', 18, '2011-11-29 15:26:00', 18, 2, '2011-11-29 15:26:00', NULL),
(1895, 'MSC CANBERRA', NULL, 1891, b'1', 18, '2011-11-30 21:32:00', 18, 2, '2011-11-30 21:32:00', NULL),
(1896, 'RDO CONCORD', NULL, 1892, b'1', 18, '2011-12-06 16:53:00', 18, 2, '2011-12-06 16:53:00', NULL),
(1897, 'MARCAJAMA', NULL, 1893, b'1', 18, '2011-12-13 16:04:00', 18, 2, '2011-12-13 16:04:00', NULL),
(1898, 'STADT EMDEN', NULL, 1894, b'1', 18, '2011-12-16 14:52:00', 18, 2, '2011-12-16 14:52:00', NULL),
(1899, 'APL DENVER', NULL, 1895, b'1', 18, '2011-12-16 20:42:00', 18, 2, '2011-12-16 20:42:00', NULL),
(1900, 'ILLER TRADER', NULL, 1896, b'1', 87, '2011-12-19 20:12:00', 87, 2, '2011-12-19 20:12:00', NULL),
(1901, 'CMA CGM RABELAIS', NULL, 1897, b'1', 18, '2011-12-20 14:43:00', 18, 2, '2011-12-20 14:43:00', NULL),
(1902, 'NAVEGANTES EXPRESS', NULL, 1898, b'1', 18, '2011-12-20 21:29:00', 18, 2, '2011-12-20 21:29:00', NULL),
(1903, 'MSC BILBAO', NULL, 1899, b'1', 18, '2011-12-22 17:47:00', 18, 2, '2011-12-22 17:47:00', NULL),
(1904, 'DA CHENG', NULL, 1900, b'1', 18, '2012-01-04 16:16:00', 18, 2, '2012-01-04 16:16:00', NULL),
(1905, 'CAPE MOHAN', NULL, 1901, b'1', 18, '2012-01-04 16:32:00', 18, 2, '2012-01-04 16:32:00', NULL),
(1906, 'ISLANDIA', NULL, 1902, b'1', 18, '2012-01-04 16:41:00', 18, 2, '2012-01-04 16:41:00', NULL),
(1907, 'XIN YAN TAI ', NULL, 1903, b'1', 18, '2012-01-04 17:40:00', 18, 2, '2012-01-04 17:40:00', NULL),
(1908, 'MAERSK STOCKHOLM', NULL, 1904, b'1', 18, '2012-01-05 16:16:00', 18, 2, '2012-01-05 16:16:00', NULL),
(1909, 'MAERSK DRAMMEN', NULL, 1905, b'1', 18, '2012-01-05 16:21:00', 18, 2, '2012-01-05 16:21:00', NULL),
(1910, 'BALTIC', NULL, 1906, b'1', 18, '2012-01-18 21:18:00', 18, 2, '2012-01-18 21:18:00', NULL),
(1911, 'NOTHERN JAMBOREE', NULL, 1907, b'1', 18, '2012-01-19 15:53:00', 18, 2, '2012-01-19 15:53:00', NULL),
(1912, 'KAPPELN', NULL, 1908, b'1', 18, '2012-01-23 22:32:00', 18, 2, '2012-01-23 22:32:00', NULL),
(1913, 'CSAV PETORCA', NULL, 1909, b'1', 18, '2012-01-30 16:17:00', 18, 2, '2012-01-30 16:17:00', NULL),
(1914, 'BASLINE TIANJIN', NULL, 1910, b'1', 18, '2012-02-02 21:41:00', 18, 2, '2012-02-02 21:41:00', NULL),
(1915, 'BROOKLYN BRIDGE V-9003E', NULL, 1911, b'1', 18, '2012-02-06 15:10:00', 18, 2, '2012-02-06 15:10:00', NULL),
(1916, 'PETROHUE', NULL, 1912, b'1', 18, '2012-02-06 16:21:00', 18, 2, '2012-02-06 16:21:00', NULL),
(1917, 'ZENG SHUN YUN', NULL, 1913, b'1', 18, '2012-02-13 17:24:00', 18, 2, '2012-02-13 17:24:00', NULL),
(1918, 'NORTHERN JUPITER', NULL, 1914, b'1', 18, '2012-02-21 15:18:00', 18, 2, '2012-02-21 15:18:00', NULL),
(1919, 'CORAL BAY ', NULL, 1915, b'1', 18, '2012-02-21 15:59:00', 18, 2, '2012-02-21 15:59:00', NULL),
(1920, 'MAERSK MALACCA', NULL, 1916, b'1', 18, '2012-02-23 15:17:00', 18, 2, '2012-02-23 15:17:00', NULL),
(1921, 'GUANG BO YUN', NULL, 1917, b'1', 18, '2012-02-23 15:26:00', 18, 2, '2012-02-23 15:26:00', NULL),
(1922, 'ARSOS UA', NULL, 1918, b'1', 18, '2012-02-28 17:15:00', 18, 2, '2012-02-28 17:15:00', NULL),
(1923, 'ANNABELLE SCHULTE', NULL, 1919, b'1', 18, '2012-02-29 19:47:00', 18, 2, '2012-02-29 19:47:00', NULL),
(1924, 'DOVER STRAIT', NULL, 1920, b'1', 18, '2012-03-05 16:48:00', 18, 2, '2012-03-05 16:48:00', NULL),
(1925, 'HANG XUN ', NULL, 1921, b'1', 18, '2012-03-06 16:34:00', 18, 2, '2012-03-06 16:34:00', NULL),
(1926, 'FRISIA LISSABON', NULL, 1922, b'1', 18, '2012-03-09 19:19:00', 18, 2, '2012-03-09 19:19:00', NULL),
(1927, 'EVER DYNAMIC', NULL, 1923, b'1', 18, '2012-03-09 19:30:00', 18, 2, '2012-03-09 19:30:00', NULL),
(1928, 'MONTE TAMARO', NULL, 1924, b'1', 18, '2012-03-13 16:48:00', 18, 2, '2012-03-13 16:48:00', NULL),
(1929, 'SONG YUN HE', NULL, 1925, b'1', 18, '2012-03-14 16:36:00', 18, 2, '2012-03-14 16:36:00', NULL),
(1930, 'STADT CADIZ', NULL, 1926, b'1', 18, '2012-03-14 21:01:00', 18, 2, '2012-03-14 21:01:00', NULL),
(1931, 'CSAV PIRQUE', NULL, 1927, b'1', 18, '2012-03-15 14:50:00', 18, 2, '2012-03-15 14:50:00', NULL),
(1932, ' MAERSK MERLION', NULL, 1928, b'1', 60, '2012-03-19 17:04:00', 60, 2, '2012-03-19 17:04:00', NULL),
(1933, 'HYUNDAI FORWARD', NULL, 1929, b'1', 60, '2012-03-20 15:39:00', 60, 2, '2012-03-20 15:39:00', NULL),
(1934, 'CAPE MAYOR', NULL, 1930, b'1', 60, '2012-03-20 17:34:00', 60, 2, '2012-03-20 17:34:00', NULL),
(1935, 'HYUNDAY HIGHNESS', NULL, 1931, b'1', 60, '2012-03-21 15:17:00', 60, 2, '2012-03-21 15:17:00', NULL),
(1936, 'MAERSK DELLYS', NULL, 1932, b'1', 87, '2012-03-21 20:09:00', 87, 2, '2012-03-21 20:09:00', NULL),
(1937, 'MOL INCA', NULL, 1933, b'1', 87, '2012-03-21 21:28:00', 87, 2, '2012-03-21 21:28:00', NULL),
(1938, 'CMA CGM VOLTAIRE', NULL, 1934, b'1', 60, '2012-03-27 18:47:00', 60, 2, '2012-03-27 18:47:00', NULL),
(1939, 'MAERSK TAIKUNG', NULL, 1935, b'1', 60, '2012-03-30 22:32:00', 60, 2, '2012-03-30 22:32:00', NULL),
(1940, 'ATLANTIC VOYAGER', NULL, 1936, b'1', 93, '2012-04-03 14:55:00', 93, 2, '2012-04-03 14:55:00', NULL),
(1941, 'CAP PALLISER', NULL, 1937, b'1', 93, '2012-04-03 15:44:00', 93, 2, '2012-04-03 15:44:00', NULL),
(1942, 'SCHUBERT', NULL, 1938, b'1', 60, '2012-04-03 15:49:00', 60, 2, '2012-04-03 15:49:00', NULL),
(1943, 'HS SCHUBERT ', NULL, 1939, b'1', 60, '2012-04-03 15:52:00', 60, 2, '2012-04-03 15:52:00', NULL),
(1944, 'CORNELIUS MAERSK', NULL, 1940, b'1', 60, '2012-04-03 16:28:00', 60, 2, '2012-04-03 16:28:00', NULL),
(1945, 'AP MOLLER', NULL, 1941, b'1', 60, '2012-04-03 22:44:00', 60, 2, '2012-04-03 22:44:00', NULL),
(1946, 'LORRAINE', NULL, 1942, b'1', 60, '2012-04-04 16:28:00', 60, 2, '2012-04-04 16:28:00', NULL),
(1947, 'CAP PALMERSTON', NULL, 1943, b'1', 17, '2012-04-09 15:29:00', 17, 2, '2012-04-09 15:29:00', NULL),
(1948, 'MAERSK JAIPUR', NULL, 1944, b'1', 18, '2012-04-09 17:26:00', 18, 2, '2012-04-09 17:26:00', NULL),
(1949, 'WILLIAM SHAKESPEARE', NULL, 1945, b'1', 18, '2012-04-09 17:58:00', 18, 2, '2012-04-09 17:58:00', NULL),
(1950, 'CONSTANTIN S', NULL, 1946, b'1', 93, '2012-04-10 17:13:00', 93, 2, '2012-04-10 17:13:00', NULL),
(1951, 'FENG FA', NULL, 1947, b'1', 18, '2012-04-10 21:14:00', 18, 2, '2012-04-10 21:14:00', NULL),
(1952, 'HENRIETTE SCHULTE', NULL, 1948, b'1', 17, '2012-04-11 20:42:00', 17, 2, '2012-04-11 20:42:00', NULL),
(1953, 'ELBELLA', NULL, 1949, b'1', 17, '2012-04-12 17:55:00', 17, 2, '2012-04-12 17:55:00', NULL),
(1954, 'RIO VERDE', NULL, 1950, b'1', 17, '2012-04-13 22:22:00', 17, 2, '2012-04-13 22:22:00', NULL),
(1955, 'MSC BEIJING', NULL, 1951, b'1', 18, '2012-04-17 21:20:00', 18, 2, '2012-04-17 21:20:00', NULL),
(1956, 'LETO', NULL, 1952, b'1', 60, '2012-04-19 14:18:00', 60, 2, '2012-04-19 14:18:00', NULL),
(1957, 'RHL AGILITAS', NULL, 1953, b'1', 17, '2012-04-19 17:03:00', 17, 2, '2012-04-19 17:03:00', NULL),
(1958, 'E R CALAIS', NULL, 1954, b'1', 18, '2012-04-19 18:39:00', 18, 2, '2012-04-19 18:39:00', NULL),
(1959, 'DRESDEN EXPRESS', NULL, 1955, b'1', 18, '2012-04-19 22:29:00', 18, 2, '2012-04-19 22:29:00', NULL),
(1960, 'RIO CARDIFF', NULL, 1956, b'1', 18, '2012-04-20 21:43:00', 18, 2, '2012-04-20 21:43:00', NULL),
(1961, 'CSAV PUYEHUE', NULL, 1957, b'1', 18, '2012-04-20 21:58:00', 18, 2, '2012-04-20 21:58:00', NULL),
(1962, 'BUSAN EXPRESS', NULL, 1958, b'1', 18, '2012-04-24 16:17:00', 18, 2, '2012-04-24 16:17:00', NULL),
(1963, 'CSAV APPENNINI', NULL, 1959, b'1', 18, '2012-04-25 13:53:00', 18, 2, '2012-04-25 13:53:00', NULL),
(1964, 'DA XIN ', NULL, 1960, b'1', 18, '2012-04-25 18:28:00', 18, 2, '2012-04-25 18:28:00', NULL),
(1965, 'HELENE S', NULL, 1961, b'1', 93, '2012-04-25 21:59:00', 93, 2, '2012-04-25 21:59:00', NULL),
(1966, 'SANTA BIANCA', NULL, 1962, b'1', 18, '2012-04-25 23:25:00', 18, 2, '2012-04-25 23:25:00', NULL),
(1967, 'MERCS JAFFNA', NULL, 1963, b'1', 90, '2012-04-26 18:35:00', 90, 2, '2012-04-26 18:35:00', NULL),
(1968, 'SOFIA SCHULTE', NULL, 1964, b'1', 18, '2012-05-04 14:00:00', 18, 2, '2012-05-04 14:00:00', NULL),
(1969, 'CSAV PAPUDO', NULL, 1965, b'1', 18, '2012-05-04 17:17:00', 18, 2, '2012-05-04 17:17:00', NULL),
(1970, 'ATLANTA EXPRESS ', NULL, 1966, b'1', 18, '2012-05-07 21:49:00', 18, 2, '2012-05-07 21:49:00', NULL),
(1971, 'SANTA PELAGIA ', NULL, 1967, b'1', 18, '2012-05-17 19:16:00', 18, 2, '2012-05-17 19:16:00', NULL),
(1972, 'MONTE OLIVIA', NULL, 1968, b'1', 18, '2012-05-17 21:04:00', 18, 2, '2012-05-17 21:04:00', NULL),
(1973, 'MOL PROSPERITY', NULL, 1969, b'1', 60, '2012-05-18 20:41:00', 60, 2, '2012-05-18 20:41:00', NULL),
(1974, 'PANCON CHALLENGE', NULL, 1970, b'1', 18, '2012-05-21 20:14:00', 18, 2, '2012-05-21 20:14:00', NULL),
(1975, 'SAN FRANCISCO EXPRESS', NULL, 1971, b'1', 18, '2012-05-21 22:55:00', 18, 2, '2012-05-21 22:55:00', NULL),
(1976, 'MONTE PASCOAL', NULL, 1972, b'1', 18, '2012-05-22 23:16:00', 18, 2, '2012-05-22 23:16:00', NULL),
(1977, 'MSC KYOTO', NULL, 1973, b'1', 18, '2012-05-24 16:38:00', 18, 2, '2012-05-24 16:38:00', NULL),
(1978, 'J I HANG ', NULL, 1974, b'1', 18, '2012-05-29 17:15:00', 18, 2, '2012-05-29 17:15:00', NULL),
(1979, 'NORTHERN JAMBOREE', NULL, 1975, b'1', 18, '2012-05-31 15:52:00', 18, 2, '2012-05-31 15:52:00', NULL),
(1980, 'SVEND MAERSK', NULL, 1976, b'1', 18, '2012-06-01 18:42:00', 18, 2, '2012-06-01 18:42:00', NULL),
(1981, 'AKERDIJK', NULL, 1977, b'1', 18, '2012-06-01 19:14:00', 18, 2, '2012-06-01 19:14:00', NULL),
(1982, 'CAPE MELVILLE', NULL, 1978, b'1', 18, '2012-06-04 18:59:00', 18, 2, '2012-06-04 18:59:00', NULL),
(1983, 'NYK LODESTAR', NULL, 1979, b'1', 18, '2012-06-05 14:37:00', 18, 2, '2012-06-05 14:37:00', NULL),
(1984, 'MSC BRIANNA', NULL, 1980, b'1', 18, '2012-06-13 19:09:00', 18, 2, '2012-06-13 19:09:00', NULL),
(1985, 'NO APLICA', NULL, 1981, b'1', 18, '2012-06-14 22:53:00', 18, 2, '2012-06-14 22:53:00', NULL),
(1986, 'MOL PACE', NULL, 1982, b'1', 18, '2012-06-20 16:23:00', 18, 2, '2012-06-20 16:23:00', NULL),
(1987, 'SCT ZURICH', NULL, 1983, b'1', 18, '2012-06-20 16:39:00', 18, 2, '2012-06-20 16:39:00', NULL),
(1988, 'MSC JUDITH', NULL, 1984, b'1', 18, '2012-06-26 20:12:00', 18, 2, '2012-06-26 20:12:00', NULL);
INSERT INTO `barco` (`id_barco`, `nombre`, `bandera`, `idBarco`, `Estado`, `idUsuario`, `fechaIngreso`, `idUsuarioModifica`, `id_sucursal`, `fechamodificacion`, `tipo`) VALUES
(1989, 'VIOLET', NULL, 1985, b'1', 18, '2012-06-26 20:30:00', 18, 2, '2012-06-26 20:30:00', NULL),
(1990, 'CARSTEN MAERSK', NULL, 1986, b'1', 18, '2012-06-27 20:32:00', 18, 2, '2012-06-27 20:32:00', NULL),
(1991, 'CP HARBURG', NULL, 1987, b'1', 18, '2012-06-27 20:57:00', 18, 2, '2012-06-27 20:57:00', NULL),
(1992, 'CAROLINE MAERSK', NULL, 1988, b'1', 18, '2012-06-28 16:07:00', 18, 2, '2012-06-28 16:07:00', NULL),
(1993, 'NYK TERRA', NULL, 1989, b'1', 18, '2012-06-28 17:21:00', 18, 2, '2012-06-28 17:21:00', NULL),
(1994, 'BROOKLYN BRIDGE', NULL, 1990, b'1', 18, '2012-06-29 21:23:00', 18, 2, '2012-06-29 21:23:00', NULL),
(1995, 'CMA CGM MIMOSA', NULL, 1991, b'1', 18, '2012-07-05 18:55:00', 18, 2, '2012-07-05 18:55:00', NULL),
(1996, 'COSCO DURBAN', NULL, 1992, b'1', 18, '2012-07-05 18:58:00', 18, 2, '2012-07-05 18:58:00', NULL),
(1997, 'AUTUM E', NULL, 1993, b'1', 18, '2012-07-05 20:47:00', 18, 2, '2012-07-05 20:47:00', NULL),
(1998, 'ALGOL', NULL, 1994, b'1', 17, '2012-07-09 21:51:00', 17, 2, '2012-07-09 21:51:00', NULL),
(1999, 'SUAPE EXPRESS', NULL, 1995, b'1', 18, '2012-07-10 22:38:00', 18, 2, '2012-07-10 22:38:00', NULL),
(2000, 'SUSANNE SCHULTE', NULL, 1996, b'1', 1, '2012-07-16 14:05:00', 1, 2, '2012-07-16 14:05:00', NULL),
(2001, 'PAC KALIMANTAN', NULL, 1997, b'1', 18, '2012-07-16 17:31:00', 18, 2, '2012-07-16 17:31:00', NULL),
(2002, 'GEORGE WASHINGTON BRIDGE', NULL, 1998, b'1', 18, '2012-07-20 20:44:00', 18, 2, '2012-07-20 20:44:00', NULL),
(2003, 'MAERSK NOTTINGHAM', NULL, 1999, b'1', 93, '2012-07-23 14:20:00', 93, 2, '2012-07-23 14:20:00', NULL),
(2004, 'BF IPANEMA', NULL, 2000, b'1', 96, '2012-07-27 15:54:00', 96, 2, '2012-07-27 15:54:00', NULL),
(2005, 'MONTEVIDEO EXPRESS', NULL, 2001, b'1', 18, '2012-08-01 15:25:00', 18, 2, '2012-08-01 15:25:00', NULL),
(2006, 'NYK AQUARIUS', NULL, 2002, b'1', 18, '2012-08-01 17:50:00', 18, 2, '2012-08-01 17:50:00', NULL),
(2007, 'TESSA', NULL, 2003, b'1', 18, '2012-08-03 20:44:00', 18, 2, '2012-08-03 20:44:00', NULL),
(2008, 'ALEXANDRA P', NULL, 2004, b'1', 18, '2012-08-07 20:54:00', 18, 2, '2012-08-07 20:54:00', NULL),
(2009, 'TASCO', NULL, 2005, b'1', 18, '2012-08-08 20:42:00', 18, 2, '2012-08-08 20:42:00', NULL),
(2010, 'CAP CASTILLO', NULL, 2006, b'1', 18, '2012-08-14 17:33:00', 18, 2, '2012-08-14 17:33:00', NULL),
(2011, 'YONG DA', NULL, 2007, b'1', 18, '2012-08-20 16:38:00', 18, 2, '2012-08-20 16:38:00', NULL),
(2012, 'KING ADRIAN', NULL, 2008, b'1', 18, '2012-08-21 17:02:00', 18, 2, '2012-08-21 17:02:00', NULL),
(2013, 'MOL PRECISION ', NULL, 2009, b'1', 18, '2012-08-27 16:09:00', 18, 2, '2012-08-27 16:09:00', NULL),
(2014, 'BAI FU ', NULL, 2010, b'1', 18, '2012-08-31 16:17:00', 18, 2, '2012-08-31 16:17:00', NULL),
(2015, 'ANDES', NULL, 2011, b'1', 18, '2012-09-03 16:58:00', 18, 2, '2012-09-03 16:58:00', NULL),
(2016, 'SCT SANTIAGO', NULL, 2012, b'1', 18, '2012-09-07 16:32:00', 18, 2, '2012-09-07 16:32:00', NULL),
(2017, 'UNIPATRIOT', NULL, 2013, b'1', 18, '2012-09-07 18:19:00', 18, 2, '2012-09-07 18:19:00', NULL),
(2018, 'OLIVIA', NULL, 2014, b'1', 18, '2012-09-11 18:45:00', 18, 2, '2012-09-11 18:45:00', NULL),
(2019, 'MAERSK KENSINGTON', NULL, 2015, b'1', 18, '2012-09-14 16:56:00', 18, 2, '2012-09-14 16:56:00', NULL),
(2020, 'XIN HAI XIN ', NULL, 2016, b'1', 18, '2012-09-14 17:12:00', 18, 2, '2012-09-14 17:12:00', NULL),
(2021, 'RUN FA CHANG HONG', NULL, 2017, b'1', 18, '2012-09-17 17:00:00', 18, 2, '2012-09-17 17:00:00', NULL),
(2022, 'SAN FRANCISCO BRIDGE', NULL, 2018, b'1', 18, '2012-09-18 15:43:00', 18, 2, '2012-09-18 15:43:00', NULL),
(2023, 'MONTE ACONCAGUA', NULL, 2019, b'1', 18, '2012-09-18 16:41:00', 18, 2, '2012-09-18 16:41:00', NULL),
(2024, 'NYK LYNX', NULL, 2020, b'1', 18, '2012-09-18 17:04:00', 18, 2, '2012-09-18 17:04:00', NULL),
(2025, 'SINE MAERSK', NULL, 2021, b'1', 18, '2012-09-20 16:41:00', 18, 2, '2012-09-20 16:41:00', NULL),
(2026, 'WAN HAI 511', NULL, 2022, b'1', 18, '2012-09-21 20:07:00', 1, 2, '2013-06-04 19:30:00', NULL),
(2027, 'SOROE MAERSK', NULL, 2023, b'1', 18, '2012-09-21 22:19:00', 18, 2, '2012-09-21 22:19:00', NULL),
(2028, 'CSAV ROMERAL', NULL, 2024, b'1', 18, '2012-09-21 22:41:00', 18, 2, '2012-09-21 22:41:00', NULL),
(2029, 'CALANDRA', NULL, 2025, b'1', 18, '2012-09-25 17:02:00', 18, 2, '2012-09-25 17:02:00', NULL),
(2030, 'GREENWICH BRIDGE', NULL, 2026, b'1', 18, '2012-09-25 17:33:00', 18, 2, '2012-09-25 17:33:00', NULL),
(2031, 'CSAV PORVENIR', NULL, 2027, b'1', 18, '2012-10-01 17:03:00', 18, 2, '2012-10-01 17:03:00', NULL),
(2032, 'PAVO J', NULL, 2028, b'1', 18, '2012-10-03 21:28:00', 18, 2, '2012-10-03 21:28:00', NULL),
(2033, 'CAMELLIA', NULL, 2029, b'1', 18, '2012-10-04 16:36:00', 18, 2, '2012-10-04 16:36:00', NULL),
(2034, 'EVERT DAINTY', NULL, 2030, b'1', 18, '2012-10-10 22:44:00', 18, 2, '2012-10-10 22:44:00', NULL),
(2035, 'EVER DAINTY', NULL, 2031, b'1', 18, '2012-10-10 22:45:00', 18, 2, '2012-10-10 22:45:00', NULL),
(2036, 'CCNI ARAUCO', NULL, 2032, b'1', 18, '2012-10-10 23:07:00', 18, 2, '2012-10-10 23:07:00', NULL),
(2037, 'HANJIN HELSINKI', NULL, 2033, b'1', 18, '2012-10-11 17:28:00', 18, 2, '2012-10-11 17:28:00', NULL),
(2038, 'CMA CGM WAGNER', NULL, 2034, b'1', 18, '2012-10-15 17:49:00', 18, 2, '2012-10-15 17:49:00', NULL),
(2039, 'WARNOW ORCA', NULL, 2035, b'1', 17, '2012-10-15 20:32:00', 17, 2, '2012-10-15 20:32:00', NULL),
(2040, 'STADT GERA', NULL, 2036, b'1', 18, '2012-10-17 14:15:00', 18, 2, '2012-10-17 14:15:00', NULL),
(2041, 'EURUS LISBON ', NULL, 2037, b'1', 18, '2012-10-17 21:38:00', 18, 2, '2012-10-17 21:38:00', NULL),
(2042, 'SEALAND NEW YORK ', NULL, 2038, b'1', 4, '2012-10-22 16:05:00', 4, 2, '2012-10-22 16:05:00', NULL),
(2043, 'SEABOARD OCEAN', NULL, 2039, b'1', 18, '2012-10-23 15:14:00', 18, 2, '2012-10-23 15:14:00', NULL),
(2044, 'LAURA SCHULTE', NULL, 2040, b'1', 4, '2012-10-25 22:53:00', 4, 2, '2012-10-25 22:53:00', NULL),
(2045, 'NYK LIRA', NULL, 2041, b'1', 4, '2012-10-26 17:29:00', 4, 2, '2012-10-26 17:29:00', NULL),
(2046, 'OM AGARUM', NULL, 2042, b'1', 93, '2012-10-29 17:00:00', 93, 2, '2012-10-29 17:00:00', NULL),
(2047, 'LESOTHO', NULL, 2043, b'1', 18, '2012-10-30 21:17:00', 18, 2, '2012-10-30 21:17:00', NULL),
(2048, 'CMA CGM LA TRAVIATA', NULL, 2044, b'1', 18, '2012-10-31 20:49:00', 18, 2, '2012-10-31 20:49:00', NULL),
(2049, 'MSC BARCELONA', NULL, 2045, b'1', 18, '2012-11-02 16:27:00', 18, 2, '2012-11-02 16:27:00', NULL),
(2050, 'SZCZECIN TRADE', NULL, 2046, b'1', 18, '2012-11-02 17:53:00', 18, 2, '2012-11-02 17:53:00', NULL),
(2051, 'CHILOE ISLAND', NULL, 2047, b'1', 18, '2012-11-05 16:42:00', 18, 2, '2012-11-05 16:42:00', NULL),
(2052, 'ZIM CHICAGO', NULL, 2048, b'1', 18, '2012-11-06 18:18:00', 18, 2, '2012-11-06 18:18:00', NULL),
(2053, 'ZAMBIA', NULL, 2049, b'1', 18, '2012-11-07 19:31:00', 18, 2, '2012-11-07 19:31:00', NULL),
(2054, 'MSC ALICANTE', NULL, 2050, b'1', 18, '2012-11-09 21:49:00', 18, 2, '2012-11-09 21:49:00', NULL),
(2055, 'MSC CARACAS', NULL, 2051, b'1', 93, '2012-11-12 14:37:00', 93, 2, '2012-11-12 14:37:00', NULL),
(2056, 'CONRAD S', NULL, 2052, b'1', 18, '2012-11-13 21:02:00', 18, 2, '2012-11-13 21:02:00', NULL),
(2057, 'APL LONDON', NULL, 2053, b'1', 18, '2012-11-15 17:29:00', 18, 2, '2012-11-15 17:29:00', NULL),
(2058, 'SCOTIA PANAMA', NULL, 2054, b'1', 1, '2012-11-16 17:41:00', 1, 2, '2012-11-16 17:41:00', NULL),
(2059, 'APL SALVADOR', NULL, 2055, b'1', 1, '2012-11-16 17:43:00', 1, 2, '2012-11-19 15:18:00', NULL),
(2060, 'APL SAN SA', NULL, 2056, b'1', 1, '2012-11-19 16:23:00', 1, 2, '2012-11-19 16:31:00', NULL),
(2061, 'CAROLINE SCHULTE', NULL, 2057, b'1', 18, '2012-11-19 23:45:00', 18, 2, '2012-11-19 23:45:00', NULL),
(2062, 'ANGOL', NULL, 2058, b'1', 18, '2012-11-29 21:29:00', 18, 2, '2012-11-29 21:29:00', NULL),
(2063, 'JIA XING', NULL, 2059, b'1', 18, '2012-11-30 17:34:00', 18, 2, '2012-11-30 17:34:00', NULL),
(2064, 'MOL WINTER', NULL, 2060, b'1', 18, '2012-12-04 21:24:00', 18, 2, '2012-12-04 21:24:00', NULL),
(2065, 'MAERSK KENDAL', NULL, 2061, b'1', 18, '2012-12-05 22:22:00', 18, 2, '2012-12-05 22:22:00', NULL),
(2066, 'APL OREGON', NULL, 2062, b'1', 18, '2012-12-10 16:32:00', 18, 2, '2012-12-10 16:32:00', NULL),
(2067, 'BOXFORD ', NULL, 2063, b'1', 93, '2012-12-11 21:24:00', 93, 2, '2012-12-11 21:24:00', NULL),
(2068, 'MADELEINE RICKMERS', NULL, 2064, b'1', 18, '2012-12-13 14:42:00', 18, 2, '2012-12-13 14:42:00', NULL),
(2069, 'ACAPULCO', NULL, 2065, b'1', 93, '2012-12-13 22:37:00', 93, 2, '2012-12-13 22:37:00', NULL),
(2070, 'TAMINA', NULL, 2066, b'1', 18, '2012-12-14 20:00:00', 18, 2, '2012-12-14 20:00:00', NULL),
(2071, 'MAERSK WINNIPEG', NULL, 2067, b'1', 98, '2012-12-18 13:43:00', 98, 2, '2012-12-18 13:43:00', NULL),
(2072, 'MAERKS WINNIPG', NULL, 2068, b'1', 98, '2012-12-18 13:51:00', 98, 2, '2012-12-18 13:51:00', NULL),
(2073, 'SARA SCHULTE', NULL, 2069, b'1', 18, '2012-12-18 18:22:00', 18, 2, '2012-12-18 18:22:00', NULL),
(2074, 'ITALY EXPRESS', NULL, 2070, b'1', 18, '2012-12-27 13:52:00', 98, 2, '2012-12-27 21:09:00', NULL),
(2075, 'HANSA COBURG', NULL, 2071, b'1', 98, '2013-01-02 15:28:00', 98, 2, '2013-01-02 15:28:00', NULL),
(2076, 'SAWASDEE SINGAPORE', NULL, 2072, b'1', 18, '2013-01-08 17:43:00', 18, 2, '2013-01-08 17:43:00', NULL),
(2077, 'CAPE MANILA', NULL, 2073, b'1', 18, '2013-01-14 23:56:00', 18, 2, '2013-01-14 23:56:00', NULL),
(2078, 'CAP SPENCER', NULL, 2074, b'1', 18, '2013-01-16 15:04:00', 18, 2, '2013-01-16 15:04:00', NULL),
(2079, 'XIN HAI XIU', NULL, 2075, b'1', 18, '2013-01-16 20:01:00', 18, 2, '2013-01-16 20:01:00', NULL),
(2080, 'APL NORWAY', NULL, 2076, b'1', 18, '2013-01-18 15:47:00', 18, 2, '2013-01-18 15:47:00', NULL),
(2081, 'SINAR BIAK', NULL, 2077, b'1', 18, '2013-01-18 19:06:00', 18, 2, '2013-01-18 19:06:00', NULL),
(2082, 'MAERSK KOLKATA', NULL, 2078, b'1', 18, '2013-01-18 20:03:00', 18, 2, '2013-01-18 20:03:00', NULL),
(2083, 'SANTA PHILLIPA', NULL, 2079, b'1', 18, '2013-01-21 22:59:00', 18, 2, '2013-01-21 22:59:00', NULL),
(2084, 'MONTE ALEGRE', NULL, 2080, b'1', 18, '2013-01-24 22:43:00', 18, 2, '2013-01-24 22:43:00', NULL),
(2085, 'SANTA REBECCA ', NULL, 2081, b'1', 18, '2013-02-06 15:50:00', 18, 2, '2013-02-06 15:50:00', NULL),
(2086, 'VULKAN', NULL, 2082, b'1', 18, '2013-02-08 20:54:00', 18, 2, '2013-02-08 20:54:00', NULL),
(2087, 'MSC SOCOTRA', NULL, 2083, b'1', 18, '2013-02-12 16:08:00', 18, 2, '2013-02-12 16:08:00', NULL),
(2088, 'HANSA KIRKENES ', NULL, 2084, b'1', 18, '2013-02-14 20:26:00', 18, 2, '2013-02-14 20:26:00', NULL),
(2089, 'VEGA BETA', NULL, 2085, b'1', 18, '2013-02-15 23:09:00', 18, 2, '2013-02-15 23:09:00', NULL),
(2090, 'PENGALIA', NULL, 2086, b'1', 4, '2013-02-18 22:14:00', 4, 2, '2013-02-18 22:14:00', NULL),
(2091, 'AS CATALANIA', NULL, 2087, b'1', 18, '2013-02-19 14:44:00', 18, 2, '2013-02-19 14:44:00', NULL),
(2092, 'CARIBBEAN SINA', NULL, 2088, b'1', 93, '2013-02-20 14:37:00', 93, 2, '2013-02-20 14:37:00', NULL),
(2093, 'MOL ABILITY', NULL, 2089, b'1', 18, '2013-02-20 15:52:00', 18, 2, '2013-02-20 15:52:00', NULL),
(2094, 'WAMOW DOLPHIN', NULL, 2090, b'1', 18, '2013-02-20 20:10:00', 18, 2, '2013-02-20 20:10:00', NULL),
(2095, 'APL TOKYO', NULL, 2091, b'1', 18, '2013-02-22 14:44:00', 18, 2, '2013-02-22 14:44:00', NULL),
(2096, 'CMA CGM OTELLO', NULL, 2092, b'1', 18, '2013-02-25 15:58:00', 18, 2, '2013-02-25 15:58:00', NULL),
(2097, 'MSC SHANGHAI ', NULL, 2093, b'1', 18, '2013-02-26 20:02:00', 18, 2, '2013-02-26 20:02:00', NULL),
(2098, 'NORTHERN DELIGHT', NULL, 2094, b'1', 19, '2013-02-27 17:33:00', 19, 2, '2013-02-27 17:33:00', NULL),
(2099, 'BANGKOK THAILAND', NULL, 2095, b'1', 105, '2013-03-04 15:48:00', 105, 2, '2013-03-04 15:48:00', NULL),
(2100, 'CAP MORETON', NULL, 2096, b'1', 105, '2013-03-06 21:10:00', 105, 2, '2013-03-06 21:10:00', NULL),
(2101, 'E R SWEDEN ', NULL, 2097, b'1', 105, '2013-03-13 16:56:00', 105, 2, '2013-03-13 16:56:00', NULL),
(2102, 'ZHONG SHENG HAI', NULL, 2098, b'1', 105, '2013-03-13 22:54:00', 105, 2, '2013-03-13 22:54:00', NULL),
(2103, 'OOCL ASIA', NULL, 2099, b'1', 105, '2013-03-19 19:41:00', 105, 2, '2013-03-19 19:41:00', NULL),
(2104, 'NYK APHRODITE', NULL, 2100, b'1', 105, '2013-03-20 15:32:00', 105, 2, '2013-03-20 15:32:00', NULL),
(2105, 'ANTWERPEN', NULL, 2101, b'1', 105, '2013-03-22 16:50:00', 105, 2, '2013-03-22 16:50:00', NULL),
(2106, 'APL INDONESIA', NULL, 2102, b'1', 105, '2013-03-25 19:56:00', 105, 2, '2013-03-25 19:56:00', NULL),
(2107, 'MSC INGRID', NULL, 2103, b'1', 105, '2013-03-26 21:35:00', 105, 2, '2013-03-26 21:35:00', NULL),
(2108, 'STADT FREIBURG', NULL, 2104, b'1', 105, '2013-03-26 22:10:00', 105, 2, '2013-03-26 22:10:00', NULL),
(2109, 'TALASSA', NULL, 2105, b'1', 105, '2013-03-26 22:19:00', 105, 2, '2013-03-26 22:19:00', NULL),
(2110, 'SEASPAN DALIAN ', NULL, 2106, b'1', 105, '2013-04-01 20:04:00', 105, 2, '2013-04-01 20:04:00', NULL),
(2111, 'CAPE FLINT ', NULL, 2107, b'1', 105, '2013-04-01 20:34:00', 105, 2, '2013-04-01 20:34:00', NULL),
(2112, 'MAERSK DUBROVNIK', NULL, 2108, b'1', 105, '2013-04-02 15:35:00', 105, 2, '2013-04-02 15:35:00', NULL),
(2113, 'TENO', NULL, 2109, b'1', 105, '2013-04-05 21:52:00', 105, 2, '2013-04-05 21:52:00', NULL),
(2114, 'GEORGIA', NULL, 2110, b'1', 93, '2013-04-08 14:06:00', 93, 2, '2013-04-08 14:06:00', NULL),
(2115, 'MSC  TOKYO', NULL, 2111, b'1', 105, '2013-04-10 17:18:00', 105, 2, '2013-04-10 17:18:00', NULL),
(2116, 'SEASPAN FELIXSTONE ', NULL, 2112, b'1', 105, '2013-04-11 21:12:00', 105, 2, '2013-04-11 21:12:00', NULL),
(2117, 'SINAR BUTON', NULL, 2113, b'1', 105, '2013-04-16 19:53:00', 105, 2, '2013-04-16 19:53:00', NULL),
(2118, 'BF COPACABANA', NULL, 2114, b'1', 105, '2013-04-17 16:37:00', 105, 2, '2013-04-17 16:37:00', NULL),
(2119, 'VANCOUVER EXPRESS ', NULL, 2115, b'1', 105, '2013-04-23 20:25:00', 105, 2, '2013-04-23 20:25:00', NULL),
(2120, 'SZCZECIN TRADER', NULL, 2116, b'1', 105, '2013-04-23 20:43:00', 105, 2, '2013-04-23 20:43:00', NULL),
(2121, 'KOTA WISATA', NULL, 2117, b'1', 105, '2013-04-23 20:57:00', 105, 2, '2013-04-23 20:57:00', NULL),
(2122, 'CAPA PULA', NULL, 2118, b'1', 105, '2013-04-25 18:18:00', 105, 2, '2013-04-25 18:18:00', NULL),
(2123, 'HANSA KRISTIANSAND', NULL, 2119, b'1', 1, '2013-04-26 17:22:00', 1, 2, '2013-04-26 17:22:00', NULL),
(2124, 'OBERON ', NULL, 2120, b'1', 105, '2013-04-29 16:09:00', 105, 2, '2013-04-29 16:09:00', NULL),
(2125, 'AMERICAN PRESIDENT', NULL, 2121, b'1', 103, '2013-05-03 20:39:00', 103, 2, '2013-05-03 20:39:00', NULL),
(2126, 'PAULA SHUTTLE', NULL, 2122, b'1', 103, '2013-05-07 15:56:00', 103, 2, '2013-05-07 15:56:00', NULL),
(2127, 'CHIQUITA SCHWEIZ', NULL, 2123, b'1', 103, '2013-05-14 14:45:00', 103, 2, '2013-05-14 14:45:00', NULL),
(2128, 'MANHATTAN', NULL, 2124, b'1', 103, '2013-05-17 15:19:00', 103, 2, '2013-05-17 15:19:00', NULL),
(2129, 'JONA', NULL, 2125, b'1', 103, '2013-05-17 15:39:00', 103, 2, '2013-05-17 15:39:00', NULL),
(2130, 'PRAGUE EXPRESS ', NULL, 2126, b'1', 103, '2013-05-17 22:07:00', 103, 2, '2013-05-17 22:07:00', NULL),
(2131, 'ER CALARIS', NULL, 2127, b'1', 103, '2013-05-20 20:35:00', 103, 2, '2013-05-20 20:35:00', NULL),
(2132, 'ER CALAIS', NULL, 2128, b'1', 105, '2013-05-24 14:53:00', 105, 2, '2013-05-24 14:53:00', NULL),
(2133, 'PETKUM', NULL, 2129, b'1', 93, '2013-05-27 16:00:00', 93, 2, '2013-05-27 16:00:00', NULL),
(2134, 'SEATTLE BRIDGE ', NULL, 2130, b'1', 4, '2013-05-27 22:06:00', 4, 2, '2013-05-27 22:06:00', NULL),
(2135, 'LIWIA P', NULL, 2131, b'1', 103, '2013-05-29 23:10:00', 103, 2, '2013-05-29 23:10:00', NULL),
(2136, 'CNP ILO', NULL, 2132, b'1', 103, '2013-05-30 17:45:00', 103, 2, '2013-05-30 17:45:00', NULL),
(2137, 'ANTOFAGASTA', NULL, 2133, b'1', 103, '2013-05-30 19:21:00', 103, 2, '2013-05-30 19:21:00', NULL),
(2138, 'ENA', NULL, 2134, b'1', 93, '2013-05-31 16:57:00', 93, 2, '2013-05-31 16:57:00', NULL),
(2139, 'HELENA SCHULTE ', NULL, 2135, b'1', 4, '2013-05-31 21:23:00', 4, 2, '2013-05-31 21:23:00', NULL),
(2140, 'MAERSK KINLOSS', NULL, 2136, b'1', 103, '2013-06-04 17:18:00', 103, 2, '2013-06-04 17:18:00', NULL),
(2141, 'CONTI TIANJIN', NULL, 2137, b'1', 103, '2013-06-04 17:47:00', 103, 2, '2013-06-04 17:47:00', NULL),
(2142, 'ER WILHEMSHAVEN', NULL, 2138, b'1', 103, '2013-06-06 22:06:00', 103, 2, '2013-06-06 22:06:00', NULL),
(2143, 'VEGA  SAGITTARIUS ', NULL, 2139, b'1', 103, '2013-06-10 13:39:00', 103, 2, '2013-06-10 13:39:00', NULL),
(2144, 'APL MELBOURNE', NULL, 2140, b'1', 103, '2013-06-10 14:27:00', 103, 2, '2013-06-10 14:27:00', NULL),
(2145, 'OSAKA CFS', NULL, 2141, b'1', 103, '2013-06-10 20:01:00', 103, 2, '2013-06-10 20:01:00', NULL),
(2146, 'MAERSK COTONOU', NULL, 2142, b'1', 103, '2013-06-11 17:17:00', 103, 2, '2013-06-11 17:17:00', NULL),
(2147, 'MAERSK NIAGARA', NULL, 2143, b'1', 4, '2013-06-14 21:28:00', 4, 2, '2013-06-14 21:28:00', NULL),
(2148, 'WAN HAI 516', NULL, 2144, b'1', 19, '2013-06-14 21:32:00', 19, 2, '2013-06-14 21:32:00', NULL),
(2149, 'SINAR BIMA', NULL, 2145, b'1', 24, '2013-06-18 21:55:00', 24, 2, '2013-06-18 21:55:00', NULL),
(2150, 'VIENNA EXPRESS', NULL, 2146, b'1', 4, '2013-06-20 01:15:00', 4, 2, '2013-06-20 01:15:00', NULL),
(2151, 'SINAR BRANI', NULL, 2147, b'1', 4, '2013-06-22 01:09:00', 4, 2, '2013-06-22 01:09:00', NULL),
(2152, 'VEGA SAGITTARIUS ', NULL, 2148, b'1', 4, '2013-06-22 01:26:00', 4, 2, '2013-06-22 01:26:00', NULL),
(2153, 'STADT AACHEN', NULL, 2149, b'1', 24, '2013-06-25 17:59:00', 24, 2, '2013-06-25 17:59:00', NULL),
(2154, 'IKARIA', NULL, 2150, b'1', 4, '2013-06-27 16:11:00', 4, 2, '2013-06-27 16:11:00', NULL),
(2155, 'MSC FIAMMETA ', NULL, 2151, b'1', 4, '2013-06-27 21:11:00', 4, 2, '2013-06-27 21:11:00', NULL),
(2156, 'PINARA ', NULL, 2152, b'1', 4, '2013-06-27 21:53:00', 4, 2, '2013-06-27 21:53:00', NULL),
(2157, 'BOTSWANA', NULL, 2153, b'1', 4, '2013-06-28 17:17:00', 4, 2, '2013-06-28 17:17:00', NULL),
(2158, 'HS SMETANA', NULL, 2154, b'1', 19, '2013-07-01 22:33:00', 19, 2, '2013-07-01 22:33:00', NULL),
(2159, 'O G AGARUM', NULL, 2155, b'1', 4, '2013-07-03 22:39:00', 4, 2, '2013-07-03 22:39:00', NULL),
(2160, 'MSC SAMANTHA', NULL, 2156, b'1', 4, '2013-07-05 21:49:00', 4, 2, '2013-07-05 21:49:00', NULL),
(2161, 'PANDORA', NULL, 2157, b'1', 93, '2013-07-10 20:51:00', 93, 2, '2013-07-10 20:51:00', NULL),
(2162, 'WAN HAI', NULL, 2158, b'1', 4, '2013-07-10 22:45:00', 4, 2, '2013-07-10 22:45:00', NULL),
(2163, 'ENSENADA EXPRESS', NULL, 2159, b'1', 105, '2013-07-15 15:22:00', 105, 2, '2013-07-15 15:22:00', NULL),
(2164, 'CHARLES DICKENS', NULL, 2160, b'1', 105, '2013-07-15 17:18:00', 105, 2, '2013-07-15 17:18:00', NULL),
(2165, 'VANCOUVER BRIDGE', NULL, 2161, b'1', 105, '2013-07-22 22:09:00', 105, 2, '2013-07-22 22:09:00', NULL),
(2166, 'MAERSK KALAMATA', NULL, 2162, b'1', 105, '2013-07-23 22:47:00', 105, 2, '2013-07-23 22:47:00', NULL),
(2167, 'AUN NO HAY', NULL, 2163, b'1', 4, '2013-07-23 23:03:00', 4, 2, '2013-07-23 23:03:00', NULL),
(2168, 'SAN DIEGO BRIDGE', NULL, 2164, b'1', 105, '2013-07-24 21:26:00', 105, 2, '2013-07-24 21:26:00', NULL),
(2169, 'MEDPEARL', NULL, 2165, b'1', 105, '2013-07-24 22:27:00', 105, 2, '2013-07-24 22:27:00', NULL),
(2170, 'WAN HAI 517', NULL, 2166, b'1', 93, '2013-07-25 19:35:00', 93, 2, '2013-07-25 19:35:00', NULL),
(2171, 'CCNI AQUILES', NULL, 2167, b'1', 105, '2013-07-25 20:08:00', 105, 2, '2013-07-25 20:08:00', NULL),
(2172, 'KAPITAN MASLOV', NULL, 2168, b'1', 105, '2013-07-30 17:16:00', 105, 2, '2013-07-30 17:16:00', NULL),
(2173, 'TIRUA', NULL, 2169, b'1', 4, '2013-07-30 18:38:00', 4, 2, '2013-07-30 18:38:00', NULL),
(2174, 'STJERNEBORG', NULL, 2170, b'1', 105, '2013-07-31 18:06:00', 105, 2, '2013-07-31 18:06:00', NULL),
(2175, 'SARAH SCHULTE', NULL, 2171, b'1', 105, '2013-08-01 19:38:00', 105, 2, '2013-08-01 19:38:00', NULL),
(2176, 'CALA PEDRIA', NULL, 2172, b'1', 105, '2013-08-02 17:35:00', 105, 2, '2013-08-02 17:35:00', NULL),
(2177, 'EURUS LIMA', NULL, 2173, b'1', 105, '2013-08-02 20:46:00', 105, 2, '2013-08-02 20:46:00', NULL),
(2178, 'SOFIA EXPRESS', NULL, 2174, b'1', 105, '2013-08-06 21:49:00', 105, 2, '2013-08-06 21:49:00', NULL),
(2179, 'SHAN HE', NULL, 2175, b'1', 105, '2013-08-07 19:17:00', 105, 2, '2013-08-07 19:17:00', NULL),
(2180, 'MSC FIAMMETTA', NULL, 2176, b'1', 105, '2013-08-08 17:06:00', 105, 2, '2013-08-08 17:06:00', NULL),
(2181, 'SL ILLINOIS', NULL, 2177, b'1', 105, '2013-08-08 22:42:00', 105, 2, '2013-08-08 22:42:00', NULL),
(2182, 'ZE YUAN', NULL, 2178, b'1', 105, '2013-08-12 19:51:00', 105, 2, '2013-08-12 19:51:00', NULL),
(2183, 'VEGA FYNEN', NULL, 2179, b'1', 105, '2013-08-12 19:58:00', 105, 2, '2013-08-12 19:58:00', NULL),
(2184, 'SINAR BITUNG', NULL, 2180, b'1', 105, '2013-08-12 20:18:00', 105, 2, '2013-08-12 20:18:00', NULL),
(2185, 'EURUS LONDON ', NULL, 2181, b'1', 4, '2013-08-14 22:51:00', 4, 2, '2013-08-14 22:51:00', NULL),
(2186, 'PANGAL', NULL, 2182, b'1', 105, '2013-08-16 16:35:00', 105, 2, '2013-08-16 16:35:00', NULL),
(2187, 'KOTA LAMBAI', NULL, 2183, b'1', 105, '2013-08-16 16:56:00', 105, 2, '2013-08-16 16:56:00', NULL),
(2188, 'MAERSK KOBE', NULL, 2184, b'1', 105, '2013-08-19 22:00:00', 105, 2, '2013-08-19 22:00:00', NULL),
(2189, 'H. KRISTIANSAND', NULL, 2185, b'1', 93, '2013-08-22 19:24:00', 93, 2, '2013-08-22 19:24:00', NULL),
(2190, 'ISODORO', NULL, 2186, b'1', 93, '2013-08-26 21:04:00', 93, 2, '2013-08-26 21:04:00', NULL),
(2191, 'AO TONG ', NULL, 2187, b'1', 105, '2013-09-02 17:08:00', 105, 2, '2013-09-02 17:08:00', NULL),
(2192, 'SAFMARINE BANDAMA', NULL, 2188, b'1', 17, '2013-09-02 21:33:00', 17, 2, '2013-09-02 21:33:00', NULL),
(2193, 'FIRST LINE NO. 6', NULL, 2189, b'1', 93, '2013-09-06 15:38:00', 93, 2, '2013-09-06 15:38:00', NULL),
(2194, 'JOANNA', NULL, 2190, b'1', 93, '2013-09-09 15:21:00', 93, 2, '2013-09-09 15:21:00', NULL),
(2195, 'CHANGHANGJIYUN', NULL, 2191, b'1', 105, '2013-09-09 19:40:00', 105, 2, '2013-09-09 19:40:00', NULL),
(2196, 'ISODORA', NULL, 2192, b'1', 17, '2013-09-10 22:41:00', 17, 2, '2013-09-10 22:41:00', NULL),
(2197, 'VEGA VIRGO ', NULL, 2193, b'1', 4, '2013-09-13 22:27:00', 4, 2, '2013-09-13 22:27:00', NULL),
(2198, 'WARNOW DOLPHIN', NULL, 2194, b'1', 105, '2013-09-16 16:33:00', 105, 2, '2013-09-16 16:33:00', NULL),
(2199, 'SMART HILL', NULL, 2195, b'1', 105, '2013-09-16 19:33:00', 105, 2, '2013-09-16 19:33:00', NULL),
(2200, 'KOTA LARIS', NULL, 2196, b'1', 105, '2013-09-18 21:08:00', 105, 2, '2013-09-18 21:08:00', NULL),
(2201, 'CTP FORTUNE', NULL, 2197, b'1', 105, '2013-09-19 16:39:00', 105, 2, '2013-09-19 16:39:00', NULL),
(2202, 'ITAL LIBERA', NULL, 2198, b'1', 93, '2013-09-23 19:26:00', 93, 2, '2013-09-23 19:26:00', NULL),
(2203, 'ZHONG CHENG 99', NULL, 2199, b'1', 93, '2013-09-24 20:19:00', 93, 2, '2013-09-24 20:19:00', NULL),
(2204, 'APL ROTTERDAM', NULL, 2200, b'1', 105, '2013-09-26 21:51:00', 105, 2, '2013-09-26 21:51:00', NULL),
(2205, 'HALCYON ', NULL, 2201, b'1', 17, '2013-10-02 19:03:00', 17, 2, '2013-10-02 19:03:00', NULL),
(2206, 'WAN HAI 515', NULL, 2202, b'1', 93, '2013-10-04 16:05:00', 93, 2, '2013-10-04 16:05:00', NULL),
(2207, 'ZHONG CHENG 66', NULL, 2203, b'1', 93, '2013-10-04 20:09:00', 93, 2, '2013-10-04 20:09:00', NULL),
(2208, 'CHANGHANGJIYUN0328', NULL, 2204, b'1', 93, '2013-10-04 20:13:00', 93, 2, '2013-10-04 20:13:00', NULL),
(2209, 'ANU BHUM', NULL, 2205, b'1', 105, '2013-10-04 22:40:00', 105, 2, '2013-10-04 22:40:00', NULL),
(2210, 'CMA CGM MANET', NULL, 2206, b'1', 105, '2013-10-04 23:38:00', 105, 2, '2013-10-04 23:38:00', NULL),
(2211, 'SANTA RAFAELA', NULL, 2207, b'1', 105, '2013-10-08 15:11:00', 105, 2, '2013-10-08 15:11:00', NULL),
(2212, 'SWAZILAND', NULL, 2208, b'1', 105, '2013-10-11 21:25:00', 105, 2, '2013-10-11 21:25:00', NULL),
(2213, 'VILANO', NULL, 2209, b'1', 105, '2013-10-11 22:56:00', 105, 2, '2013-10-11 22:56:00', NULL),
(2214, 'KOTA LOCENG', NULL, 2210, b'1', 105, '2013-10-18 15:54:00', 105, 2, '2013-10-18 15:54:00', NULL),
(2215, 'COSCO SURABAYA', NULL, 2211, b'1', 105, '2013-10-21 20:36:00', 105, 2, '2013-10-21 20:36:00', NULL),
(2216, 'OCEAN EMERALD ', NULL, 2212, b'1', 17, '2013-10-22 21:37:00', 17, 2, '2013-10-22 21:37:00', NULL),
(2217, 'MEDFRISIA', NULL, 2213, b'1', 105, '2013-10-24 13:50:00', 105, 2, '2013-10-24 13:50:00', NULL),
(2218, 'KOTA LUMBA', NULL, 2214, b'1', 105, '2013-10-24 14:03:00', 105, 2, '2013-10-24 14:03:00', NULL),
(2219, 'SEALAND ILLINOIS', NULL, 2215, b'1', 105, '2013-10-25 21:05:00', 105, 2, '2013-10-25 21:05:00', NULL),
(2220, 'COSCO ADEN', NULL, 2216, b'1', 105, '2013-10-28 21:07:00', 105, 2, '2013-10-28 21:07:00', NULL),
(2221, 'ESTHER SCHULTE', NULL, 2217, b'1', 93, '2013-10-29 15:04:00', 93, 2, '2013-10-29 15:04:00', NULL),
(2222, 'CHACABUCO', NULL, 2218, b'1', 105, '2013-11-04 15:07:00', 105, 2, '2013-11-04 15:07:00', NULL),
(2223, 'SANTA ROBERTA', NULL, 2219, b'1', 105, '2013-11-05 21:45:00', 105, 2, '2013-11-05 21:45:00', NULL),
(2224, 'BERULAN', NULL, 2220, b'1', 105, '2013-11-07 20:47:00', 105, 2, '2013-11-07 20:47:00', NULL),
(2225, 'WARNOW BOATSWAIN', NULL, 2221, b'1', 105, '2013-11-08 20:20:00', 105, 2, '2013-11-08 20:20:00', NULL),
(2226, 'NORTHERN GLEAM', NULL, 2222, b'1', 105, '2013-11-14 14:30:00', 105, 2, '2013-11-14 14:30:00', NULL),
(2227, 'MSC ADRIATIC', NULL, 2223, b'1', 110, '2013-11-19 14:40:00', 110, 2, '2013-11-19 14:40:00', NULL),
(2228, 'CAP HATTERAS', NULL, 2224, b'1', 110, '2013-11-20 17:02:00', 110, 2, '2013-11-20 17:02:00', NULL),
(2229, 'COSCO ISTANBUL', NULL, 2225, b'1', 110, '2013-11-27 15:22:00', 110, 2, '2013-11-27 15:22:00', NULL),
(2230, 'HYUNDAI PLATINUM', NULL, 2226, b'1', 110, '2013-11-27 16:56:00', 110, 2, '2013-11-27 16:56:00', NULL),
(2231, 'MOL PRIORITY', NULL, 2227, b'1', 110, '2013-12-09 14:47:00', 110, 2, '2013-12-09 14:47:00', NULL),
(2232, 'EVER URANUS', NULL, 2228, b'1', 110, '2013-12-10 14:42:00', 110, 2, '2013-12-10 14:42:00', NULL),
(2233, 'MSC CAROLINA', NULL, 2229, b'1', 110, '2013-12-11 19:30:00', 110, 2, '2013-12-11 19:30:00', NULL),
(2234, 'HYUNDAI VANCOUVER', NULL, 2230, b'1', 110, '2013-12-16 15:07:00', 110, 2, '2013-12-16 15:07:00', NULL),
(2235, 'GUAN HANG ', NULL, 2231, b'1', 4, '2013-12-26 17:40:00', 4, 2, '2013-12-26 17:40:00', NULL),
(2236, 'HANSA ARENDAL', NULL, 2232, b'1', 4, '2013-12-27 19:06:00', 4, 2, '2013-12-27 19:06:00', NULL),
(2237, 'MONTE VERDE', NULL, 2233, b'1', 4, '2013-12-27 22:18:00', 4, 2, '2013-12-27 22:18:00', NULL),
(2238, 'CARLOTA STAR', NULL, 2234, b'1', 110, '2014-01-03 14:24:00', 110, 2, '2014-01-03 14:24:00', NULL),
(2239, 'NOBLE RIGEL', NULL, 2235, b'1', 110, '2014-01-09 14:54:00', 110, 2, '2014-01-09 14:54:00', NULL),
(2240, 'COSCO TIANJIN', NULL, 2236, b'1', 110, '2014-01-09 19:21:00', 110, 2, '2014-01-09 19:21:00', NULL),
(2241, 'NYK DEMETER', NULL, 2237, b'1', 110, '2014-01-10 14:34:00', 110, 2, '2014-01-10 14:34:00', NULL),
(2242, 'FOUMA', NULL, 2238, b'1', 17, '2014-01-13 18:42:00', 17, 2, '2014-01-13 18:42:00', NULL),
(2243, 'MOL PRESTIGE', NULL, 2239, b'1', 110, '2014-01-14 16:09:00', 110, 2, '2014-01-14 16:09:00', NULL),
(2244, 'MSC SAVONA', NULL, 2240, b'1', 110, '2014-01-14 16:32:00', 110, 2, '2014-01-14 16:32:00', NULL),
(2245, 'MSC DYMPHNA', NULL, 2241, b'1', 110, '2014-01-21 15:24:00', 110, 2, '2014-01-21 15:24:00', NULL),
(2246, 'SEASPAN HAMBURG', NULL, 2242, b'1', 110, '2014-02-05 19:44:00', 110, 2, '2014-02-05 19:44:00', NULL),
(2247, 'CONTI BASEL', NULL, 2243, b'1', 110, '2014-02-10 19:43:00', 110, 2, '2014-02-10 19:43:00', NULL),
(2248, 'CITY OF HANOI ', NULL, 2244, b'1', 17, '2014-02-11 17:35:00', 17, 2, '2014-02-11 17:35:00', NULL),
(2249, 'APL CALIFORNIA', NULL, 2245, b'1', 110, '2014-02-12 14:04:00', 110, 2, '2014-02-12 14:04:00', NULL),
(2250, 'EVER USEFUL', NULL, 2246, b'1', 110, '2014-02-27 14:23:00', 110, 2, '2014-02-27 14:23:00', NULL),
(2251, 'BUXCOAST', NULL, 2247, b'1', 110, '2014-02-28 16:26:00', 110, 2, '2014-02-28 16:26:00', NULL),
(2252, 'HUI JIN QIAO 183', NULL, 2248, b'1', 110, '2014-03-17 22:03:00', 17, 2, '2014-04-15 21:28:00', NULL),
(2253, 'DIANA', NULL, 2249, b'1', 110, '2014-03-18 20:21:00', 110, 2, '2014-03-18 20:21:00', NULL),
(2254, 'HANSA REGENSBURG', NULL, 2250, b'1', 93, '2014-03-18 21:13:00', 93, 2, '2014-03-18 21:13:00', NULL),
(2255, 'RIO TAKU', NULL, 2251, b'1', 110, '2014-03-20 20:18:00', 110, 2, '2014-03-20 20:18:00', NULL),
(2256, 'HYUNDAI INTEGRAL', NULL, 2252, b'1', 110, '2014-04-01 13:30:00', 110, 2, '2014-04-01 13:30:00', NULL),
(2257, 'HS BAFFIN', NULL, 2253, b'1', 110, '2014-04-01 20:59:00', 110, 2, '2014-04-01 20:59:00', NULL),
(2258, 'HEIKE P', NULL, 2254, b'1', 110, '2014-04-03 16:02:00', 110, 2, '2014-04-03 16:02:00', NULL),
(2259, 'MSC SHAULA', NULL, 2255, b'1', 110, '2014-04-03 16:45:00', 110, 2, '2014-04-03 16:45:00', NULL),
(2260, 'APL FLORIDA', NULL, 2256, b'1', 110, '2014-04-04 22:09:00', 110, 2, '2014-04-04 22:09:00', NULL),
(2261, 'HUELVA', NULL, 2257, b'1', 110, '2014-04-08 15:52:00', 110, 2, '2014-04-08 15:52:00', NULL),
(2262, 'SPIRIT OF HAMBURG', NULL, 2258, b'1', 110, '2014-04-09 22:53:00', 110, 2, '2014-04-09 22:53:00', NULL),
(2263, 'SRI LANKA', NULL, 2259, b'1', 110, '2014-04-21 22:15:00', 110, 2, '2014-04-21 22:15:00', NULL),
(2264, 'SEALAND MICHIGAN', NULL, 2260, b'1', 110, '2014-04-21 23:10:00', 110, 2, '2014-04-21 23:10:00', NULL),
(2265, 'CONTI HARMONY', NULL, 2261, b'1', 110, '2014-04-22 14:10:00', 110, 2, '2014-04-22 14:10:00', NULL),
(2266, 'ANNA SCHULTE', NULL, 2262, b'1', 110, '2014-04-24 22:01:00', 110, 2, '2014-04-24 22:01:00', NULL),
(2267, 'HEINRICH SIBUM', NULL, 2263, b'1', 110, '2014-04-25 20:01:00', 110, 2, '2014-04-25 20:01:00', NULL),
(2268, 'HYUNDAI DYNASTY', NULL, 2264, b'1', 110, '2014-04-30 15:03:00', 110, 2, '2014-04-30 15:03:00', NULL),
(2269, 'SANTA CATARINA', NULL, 2265, b'1', 110, '2014-05-06 15:43:00', 110, 2, '2014-05-06 15:43:00', NULL),
(2270, 'EVER DELIGHT', NULL, 2266, b'1', 110, '2014-05-09 22:14:00', 110, 2, '2014-05-09 22:14:00', NULL),
(2271, 'MAERSK SEMBAWANG', NULL, 2267, b'1', 110, '2014-12-06 14:10:00', 110, 2, '2014-12-06 14:10:00', NULL),
(2272, 'NORTHERN DIAMOND', NULL, 2268, b'1', 110, '2014-12-06 14:22:00', 110, 2, '2014-12-06 14:22:00', NULL),
(2273, 'OCEAN PROMISE', NULL, 2269, b'1', 93, '2014-05-14 20:30:00', 93, 2, '2014-05-14 20:30:00', NULL),
(2274, 'APL SHANGHAI', NULL, 2270, b'1', 110, '2014-05-19 20:26:00', 110, 2, '2014-05-19 20:26:00', NULL),
(2275, 'GABRIEL SCHULTE', NULL, 2271, b'1', 110, '2014-05-22 19:46:00', 110, 2, '2014-05-22 19:46:00', NULL),
(2276, 'HS COLON', NULL, 2272, b'1', 110, '2014-05-22 22:17:00', 110, 2, '2014-05-22 22:17:00', NULL),
(2277, 'PUELCHE', NULL, 2273, b'1', 110, '2014-05-23 16:09:00', 110, 2, '2014-05-23 16:09:00', NULL),
(2278, 'BARBARA P', NULL, 2274, b'1', 110, '2014-06-02 20:36:00', 110, 2, '2014-06-02 20:36:00', NULL),
(2279, 'CNP PAITA', NULL, 2275, b'1', 110, '2014-06-02 20:51:00', 110, 2, '2014-06-02 20:51:00', NULL),
(2280, 'MSC FABIENNE', NULL, 2276, b'1', 110, '2014-06-03 18:00:00', 110, 2, '2014-06-03 18:00:00', NULL),
(2281, 'EVER DELUXE', NULL, 2277, b'1', 110, '2014-06-10 16:34:00', 110, 2, '2014-06-10 16:34:00', NULL),
(2282, 'MEHUIN', NULL, 2278, b'1', 110, '2014-06-16 13:53:00', 110, 2, '2014-06-16 13:53:00', NULL),
(2283, 'EM CORFU', NULL, 2279, b'1', 110, '2014-06-20 15:49:00', 110, 2, '2014-06-20 15:49:00', NULL),
(2284, 'CONTI ARABELLA', NULL, 2280, b'1', 110, '2014-07-03 18:57:00', 110, 2, '2014-07-03 18:57:00', NULL),
(2285, 'SPIRIT OF AUCKLAND', NULL, 2281, b'1', 110, '2014-07-07 23:24:00', 110, 2, '2014-07-07 23:24:00', NULL),
(2286, 'ARIANA', NULL, 2282, b'1', 110, '2014-07-08 22:17:00', 110, 2, '2014-07-08 22:17:00', NULL),
(2287, 'HS MARCO POLO', NULL, 2283, b'1', 110, '2014-07-09 13:26:00', 110, 2, '2014-07-09 13:26:00', NULL),
(2288, 'SHI TAI 1888', NULL, 2284, b'1', 110, '2014-07-09 14:57:00', 110, 2, '2014-07-09 14:57:00', NULL),
(2289, 'HUI JIN QIAO 168', NULL, 2285, b'1', 112, '2014-07-15 17:46:00', 112, 2, '2014-07-15 17:46:00', NULL),
(2290, 'MAERSK SEMARANG', NULL, 2286, b'1', 110, '2014-07-17 18:07:00', 110, 2, '2014-07-17 18:07:00', NULL),
(2291, 'ARCHIMIDIS', NULL, 2287, b'1', 110, '2014-07-17 19:38:00', 110, 2, '2014-07-17 19:38:00', NULL),
(2292, 'MOL MAGNIFICENCE', NULL, 2288, b'1', 110, '2014-07-17 20:31:00', 110, 2, '2014-07-17 20:31:00', NULL),
(2293, 'BINGANG', NULL, 2289, b'1', 110, '2014-07-24 23:38:00', 110, 2, '2014-07-24 23:38:00', NULL),
(2294, 'STADT COBURG', NULL, 2290, b'1', 110, '2014-07-28 19:35:00', 110, 2, '2014-07-28 19:35:00', NULL),
(2295, 'SEROJA LIMA', NULL, 2291, b'1', 110, '2014-07-29 17:50:00', 110, 2, '2014-07-29 17:50:00', NULL),
(2296, 'WAN HAI 266', NULL, 2292, b'1', 112, '2014-07-31 01:47:00', 112, 2, '2014-07-31 01:47:00', NULL),
(2297, 'MAERSK LONDRINA', NULL, 2293, b'1', 110, '2014-07-31 23:16:00', 110, 2, '2014-07-31 23:16:00', NULL),
(2298, 'EVER UNITY', NULL, 2294, b'1', 110, '2014-08-07 19:50:00', 110, 2, '2014-08-07 19:50:00', NULL),
(2299, 'TIMS', NULL, 2295, b'1', 110, '2014-08-08 19:39:00', 110, 2, '2014-08-08 19:39:00', NULL),
(2300, 'MARCHASER', NULL, 2296, b'1', 110, '2014-08-11 18:03:00', 110, 2, '2014-08-11 18:03:00', NULL),
(2301, 'HS EVEREST', NULL, 2297, b'1', 110, '2014-08-14 19:46:00', 110, 2, '2014-08-14 19:46:00', NULL),
(2302, 'MAERSK LOTA', NULL, 2298, b'1', 110, '2014-08-19 19:34:00', 110, 2, '2014-08-19 19:34:00', NULL),
(2303, 'TUO YUAN', NULL, 2299, b'1', 110, '2014-08-19 20:06:00', 110, 2, '2014-08-19 20:06:00', NULL),
(2304, 'MSC ROMANOS', NULL, 2300, b'1', 110, '2014-08-21 19:59:00', 110, 2, '2014-08-21 19:59:00', NULL),
(2305, 'MARIANNE SCHULTE', NULL, 2301, b'1', 110, '2014-08-25 19:35:00', 110, 2, '2014-08-25 19:35:00', NULL),
(2306, 'BOX QUEEN', NULL, 2302, b'1', 110, '2014-08-25 21:00:00', 110, 2, '2014-08-25 21:00:00', NULL),
(2307, 'ITALIAN EXPRESS', NULL, 2303, b'1', 110, '2014-08-28 17:21:00', 110, 2, '2014-08-28 17:21:00', NULL),
(2308, 'KMTC MUMBAI', NULL, 2304, b'1', 110, '2014-09-02 17:44:00', 110, 2, '2014-09-02 17:44:00', NULL),
(2309, 'MAERSK SEVILLE', NULL, 2305, b'1', 111, '2014-09-02 18:27:00', 111, 2, '2014-09-02 18:27:00', NULL),
(2310, 'HANJIN MANILA', NULL, 2306, b'1', 111, '2014-09-03 21:47:00', 111, 2, '2014-09-03 21:47:00', NULL),
(2311, 'CAP TRAFALGAR', NULL, 2307, b'1', 110, '2014-09-05 19:28:00', 110, 2, '2014-09-05 19:28:00', NULL),
(2312, 'CFS PACORA', NULL, 2308, b'1', 111, '2014-09-08 14:03:00', 111, 2, '2014-09-08 14:03:00', NULL),
(2313, 'JIANG PENG 6', NULL, 2309, b'1', 105, '2014-09-10 14:01:00', 112, 2, '2014-09-19 15:13:00', NULL),
(2314, 'FRISIA NUERNBERG', NULL, 2310, b'1', 105, '2014-09-11 18:00:00', 105, 2, '2014-09-11 18:00:00', NULL),
(2315, 'CSAV TRANCURA', NULL, 2311, b'1', 105, '2014-09-17 17:50:00', 105, 2, '2014-09-17 17:50:00', NULL),
(2316, 'MOL MATRIX', NULL, 2312, b'1', 105, '2014-09-19 17:37:00', 105, 2, '2014-09-19 17:37:00', NULL),
(2317, 'APL NEW JERSEY ', NULL, 2313, b'1', 105, '2014-09-19 19:50:00', 105, 2, '2014-09-19 19:50:00', NULL),
(2318, 'WESTER HAVEN', NULL, 2314, b'1', 105, '2014-09-29 16:54:00', 105, 2, '2014-09-29 16:54:00', NULL),
(2319, 'APL TURKEY', NULL, 2315, b'1', 105, '2014-10-14 15:34:00', 105, 2, '2014-10-14 15:34:00', NULL),
(2320, 'HANSA RONNEBURG', NULL, 2316, b'1', 105, '2014-10-15 21:52:00', 105, 2, '2014-10-15 21:52:00', NULL),
(2321, 'HEUNGA SINGAPORE', NULL, 2317, b'1', 105, '2014-10-17 19:31:00', 105, 2, '2014-10-17 19:31:00', NULL),
(2322, 'ORIENT SPIRIT', NULL, 2318, b'1', 105, '2014-10-24 22:17:00', 105, 2, '2014-10-24 22:17:00', NULL),
(2323, 'JIANG XIA XING', NULL, 2319, b'1', 105, '2014-11-03 19:52:00', 105, 2, '2014-11-03 19:52:00', NULL),
(2324, 'RUN DA HANG HAI', NULL, 2320, b'1', 105, '2014-11-03 21:30:00', 105, 2, '2014-11-03 21:30:00', NULL),
(2325, 'PEGASUS J', NULL, 2321, b'1', 93, '2014-11-04 21:00:00', 93, 2, '2014-11-04 21:00:00', NULL),
(2326, 'HANSA MEERBURG', NULL, 2322, b'1', 17, '2014-11-04 22:51:00', 17, 2, '2014-11-04 22:51:00', NULL),
(2327, 'IOULIA', NULL, 2323, b'1', 111, '2014-11-06 16:45:00', 111, 2, '2014-11-06 16:45:00', NULL),
(2328, 'YM LOS ANGELES', NULL, 2324, b'1', 105, '2014-11-10 22:42:00', 105, 2, '2014-11-10 22:42:00', NULL),
(2329, 'CMA CGM BAUDELAIRE', NULL, 2325, b'1', 105, '2014-11-12 15:47:00', 105, 2, '2014-11-12 15:47:00', NULL),
(2330, 'DIANA J', NULL, 2326, b'1', 93, '2014-11-13 18:09:00', 93, 2, '2014-11-13 18:09:00', NULL),
(2331, 'EVER UNISON', NULL, 2327, b'1', 105, '2014-11-17 19:31:00', 105, 2, '2014-11-17 19:31:00', NULL),
(2332, 'HAMMONIA HUSUM', NULL, 2328, b'1', 105, '2014-11-17 20:39:00', 105, 2, '2014-11-17 20:39:00', NULL),
(2333, 'MALLECO', NULL, 2329, b'1', 105, '2014-11-18 17:57:00', 105, 2, '2014-11-18 17:57:00', NULL),
(2334, 'APL MINNESOTA', NULL, 2330, b'1', 105, '2014-11-19 16:19:00', 105, 2, '2014-11-19 16:19:00', NULL),
(2335, 'HANSA FREYBURG', NULL, 2331, b'1', 105, '2014-11-20 22:08:00', 105, 2, '2014-11-20 22:08:00', NULL),
(2336, 'ALIDRA', NULL, 2332, b'1', 105, '2014-11-20 22:31:00', 105, 2, '2014-11-20 22:31:00', NULL),
(2337, 'HAMMONIA EMDEN', NULL, 2333, b'1', 105, '2014-11-20 22:46:00', 105, 2, '2014-11-20 22:46:00', NULL),
(2338, 'WAN HAI 513', NULL, 2334, b'1', 17, '2014-11-24 15:08:00', 17, 2, '2014-11-24 15:08:00', NULL),
(2339, 'MAERSK SALALAH', NULL, 2335, b'1', 105, '2014-11-25 17:47:00', 105, 2, '2014-11-25 17:47:00', NULL),
(2340, 'CMA CGM CORNEILLE', NULL, 2336, b'1', 105, '2014-12-08 17:17:00', 105, 2, '2014-12-08 17:17:00', NULL),
(2341, 'ALEXIA ', NULL, 2337, b'1', 105, '2014-12-09 19:29:00', 105, 2, '2014-12-09 19:29:00', NULL),
(2342, 'MSC MYKONOS', NULL, 2338, b'1', 111, '2014-12-10 20:46:00', 111, 2, '2014-12-10 20:46:00', NULL),
(2343, 'AS PATRIA', NULL, 2339, b'1', 93, '2014-12-11 18:58:00', 93, 2, '2014-12-11 18:58:00', NULL),
(2344, 'SANTA RICARDA ', NULL, 2340, b'1', 105, '2014-12-11 20:29:00', 105, 2, '2014-12-11 20:29:00', NULL),
(2345, 'CAP TALBOT ', NULL, 2341, b'1', 105, '2014-12-11 21:16:00', 105, 2, '2014-12-11 21:16:00', NULL),
(2346, 'KOTA LEKAS ', NULL, 2342, b'1', 105, '2014-12-15 14:35:00', 105, 2, '2014-12-15 14:35:00', NULL),
(2347, 'XIN NING BO', NULL, 2343, b'1', 105, '2014-12-16 19:25:00', 105, 2, '2014-12-16 19:25:00', NULL),
(2348, 'EVRIDIKI G', NULL, 2344, b'1', 105, '2014-12-16 19:35:00', 105, 2, '2014-12-16 19:35:00', NULL),
(2349, 'HYUNDAI GOODWILL', NULL, 2345, b'1', 111, '2014-12-18 23:45:00', 111, 2, '2014-12-18 23:45:00', NULL),
(2350, 'RHL CONSTANTIA ', NULL, 2346, b'1', 105, '2015-01-05 16:49:00', 105, 2, '2015-01-05 16:49:00', NULL),
(2351, 'EVER ULTRA', NULL, 2347, b'1', 111, '2015-01-05 18:05:00', 111, 2, '2015-01-05 18:05:00', NULL),
(2352, 'WILLINGTON EXPRESS ', NULL, 2348, b'1', 105, '2015-01-05 21:01:00', 105, 2, '2015-01-05 21:01:00', NULL),
(2353, 'MOL PARAMOUNT', NULL, 2349, b'1', 111, '2015-01-06 18:09:00', 111, 2, '2015-01-06 18:09:00', NULL),
(2354, 'HUI JIN QIAO', NULL, 2350, b'1', 111, '2015-01-06 18:20:00', 111, 2, '2015-01-06 18:20:00', NULL),
(2355, 'ASPIRATION', NULL, 2351, b'1', 111, '2015-01-06 18:44:00', 111, 2, '2015-01-06 18:44:00', NULL),
(2356, 'HANJIN MUNDRA', NULL, 2352, b'1', 24, '2015-01-17 16:55:00', 24, 2, '2015-01-17 16:55:00', NULL),
(2357, 'HS ROME', NULL, 2353, b'1', 24, '2015-01-17 18:24:00', 24, 2, '2015-01-17 18:24:00', NULL),
(2358, 'HYUNDAI COURAGE', NULL, 2354, b'1', 118, '2015-01-21 19:45:00', 118, 2, '2015-01-21 19:45:00', NULL),
(2359, 'KOTA LEGIT ', NULL, 2355, b'1', 118, '2015-01-22 15:03:00', 118, 2, '2015-01-22 15:03:00', NULL),
(2360, 'SEROJA EMPAT', NULL, 2356, b'1', 118, '2015-01-22 20:37:00', 118, 2, '2015-01-22 20:37:00', NULL),
(2361, 'KOTA LUKIS ', NULL, 2357, b'1', 118, '2015-01-27 19:27:00', 118, 2, '2015-01-27 19:27:00', NULL),
(2362, 'LOULIA', NULL, 2358, b'1', 118, '2015-01-29 21:36:00', 118, 2, '2015-01-29 21:36:00', NULL),
(2363, 'MSC KORONI', NULL, 2359, b'1', 118, '2015-02-02 17:24:00', 118, 2, '2015-02-02 17:24:00', NULL),
(2364, 'APL AUSTRIA ', NULL, 2360, b'1', 118, '2015-02-05 14:18:00', 118, 2, '2015-02-05 14:18:00', NULL),
(2365, 'CHARLOTTE MAERSK', NULL, 2361, b'1', 118, '2015-02-05 17:10:00', 118, 2, '2015-02-05 17:10:00', NULL),
(2366, 'HUI JIN QIAO 187', NULL, 2362, b'1', 93, '2015-02-09 14:49:00', 93, 2, '2015-02-09 14:49:00', NULL),
(2367, 'FRISIA ROTTERDAM', NULL, 2363, b'1', 93, '2015-02-09 21:25:00', 93, 2, '2015-02-09 21:25:00', NULL),
(2368, 'AROSIA', NULL, 2364, b'1', 93, '2015-02-11 21:27:00', 93, 2, '2015-02-11 21:27:00', NULL),
(2369, 'COSCO FELIXSTOWE', NULL, 2365, b'1', 118, '2015-02-12 19:44:00', 118, 2, '2015-02-12 19:44:00', NULL),
(2370, 'CARDIFF TRADER', NULL, 2366, b'1', 93, '2015-02-23 16:52:00', 93, 2, '2015-02-23 16:52:00', NULL),
(2371, 'MSC PILAR ', NULL, 2367, b'1', 118, '2015-03-04 22:22:00', 118, 2, '2015-03-04 22:22:00', NULL),
(2372, 'E R CAEN', NULL, 2368, b'1', 118, '2015-03-06 14:24:00', 118, 2, '2015-03-06 14:24:00', NULL),
(2373, 'BUENAVENTURA COLOMBIA ', NULL, 2369, b'1', 118, '2015-03-11 22:32:00', 118, 2, '2015-03-11 22:32:00', NULL),
(2374, 'MATAQUITO ', NULL, 2370, b'1', 118, '2015-03-12 23:32:00', 118, 2, '2015-03-12 23:32:00', NULL),
(2375, 'MSC ZEBRA', NULL, 2371, b'1', 112, '2015-03-16 20:57:00', 112, 2, '2015-03-16 20:57:00', NULL),
(2376, 'E R DENMARK', NULL, 2372, b'1', 118, '2015-03-17 17:11:00', 118, 2, '2015-03-17 17:11:00', NULL),
(2377, 'MAIPO', NULL, 2373, b'1', 118, '2015-03-20 14:42:00', 118, 2, '2015-03-20 14:42:00', NULL),
(2378, 'JIAN GONG', NULL, 2374, b'1', 118, '2015-03-26 20:17:00', 118, 2, '2015-03-26 20:17:00', NULL),
(2379, 'KRISTINA ', NULL, 2375, b'1', 118, '2015-03-30 20:21:00', 118, 2, '2015-03-30 20:21:00', NULL),
(2380, 'JING HE ', NULL, 2376, b'1', 118, '2015-03-31 15:53:00', 118, 2, '2015-03-31 15:53:00', NULL),
(2381, 'BOMAR JULIANA', NULL, 2377, b'1', 93, '2015-04-06 15:34:00', 93, 2, '2015-04-06 15:34:00', NULL),
(2382, 'MAIRA', NULL, 2378, b'1', 118, '2015-04-08 17:03:00', 118, 2, '2015-04-08 17:03:00', NULL),
(2383, 'MAULLIN', NULL, 2379, b'1', 118, '2015-04-08 17:36:00', 118, 2, '2015-04-08 17:36:00', NULL),
(2384, 'ATLANTIC', NULL, 2380, b'1', 118, '2015-04-10 14:01:00', 118, 2, '2015-04-10 14:01:00', NULL),
(2385, 'MANDO ', NULL, 2381, b'1', 118, '2015-04-13 14:57:00', 118, 2, '2015-04-13 14:57:00', NULL),
(2386, 'SEABORD ATLANTIC ', NULL, 2382, b'1', 118, '2015-04-13 17:29:00', 118, 2, '2015-04-13 17:29:00', NULL),
(2387, 'MAERSK SELETAR ', NULL, 2383, b'1', 118, '2015-04-14 15:35:00', 118, 2, '2015-04-14 15:35:00', NULL),
(2388, 'MAERKS SALINA ', NULL, 2384, b'1', 118, '2015-04-16 19:53:00', 118, 2, '2015-04-16 19:53:00', NULL),
(2389, 'BLACKPOOL TOWER', NULL, 2385, b'1', 118, '2015-04-23 17:46:00', 118, 2, '2015-04-23 17:46:00', NULL),
(2390, 'JIAN GONG 178', NULL, 2386, b'1', 93, '2015-04-24 15:40:00', 93, 2, '2015-04-24 15:40:00', NULL),
(2391, 'BUXHARMONY', NULL, 2387, b'1', 118, '2015-04-30 16:00:00', 118, 2, '2015-04-30 16:00:00', NULL),
(2392, 'GERHAD SCHULTE', NULL, 2388, b'1', 118, '2015-05-04 15:01:00', 118, 2, '2015-05-04 15:01:00', NULL),
(2393, 'SPIRIT OF SYDNEY ', NULL, 2389, b'1', 118, '2015-05-05 15:11:00', 118, 2, '2015-05-05 15:11:00', NULL),
(2394, 'HANJIN NEWPORT ', NULL, 2390, b'1', 118, '2015-05-06 16:46:00', 118, 2, '2015-05-06 16:46:00', NULL),
(2395, 'HYUNDAI ADVANCE ', NULL, 2391, b'1', 118, '2015-05-11 16:43:00', 118, 2, '2015-05-11 16:43:00', NULL),
(2396, 'CHIQUITA BELGIE ', NULL, 2392, b'1', 118, '2015-05-12 17:16:00', 118, 2, '2015-05-12 17:16:00', NULL),
(2397, 'QIAOTAI', NULL, 2393, b'1', 118, '2015-05-13 19:27:00', 118, 2, '2015-05-13 19:27:00', NULL),
(2398, 'ITAL LIRICA', NULL, 2394, b'1', 118, '2015-05-15 14:07:00', 118, 2, '2015-05-15 14:07:00', NULL),
(2399, 'E R BERLIN', NULL, 2395, b'1', 118, '2015-05-21 19:38:00', 118, 2, '2015-05-21 19:38:00', NULL),
(2400, 'WAN HAI 512', NULL, 2396, b'1', 93, '2015-05-29 16:20:00', 93, 2, '2015-05-29 16:20:00', NULL),
(2401, 'CHASER ', NULL, 2397, b'1', 118, '2015-06-01 20:46:00', 118, 2, '2015-06-01 20:46:00', NULL),
(2402, 'SAN ALESSION', NULL, 2398, b'1', 93, '2015-06-02 14:58:00', 93, 2, '2015-06-02 14:58:00', NULL),
(2403, 'SEA LAND LIGHTING', NULL, 2399, b'1', 118, '2015-06-03 14:14:00', 118, 2, '2015-06-03 14:14:00', NULL),
(2404, 'E.R. CALAIS', NULL, 2400, b'1', 93, '2015-06-04 16:12:00', 93, 2, '2015-06-04 16:12:00', NULL),
(2405, 'MAERSK WAKAYAMA', NULL, 2401, b'1', 118, '2015-06-08 20:32:00', 118, 2, '2015-06-08 20:32:00', NULL),
(2406, 'EVER UBERTY', NULL, 2402, b'1', 118, '2015-06-17 15:38:00', 118, 2, '2015-06-17 15:38:00', NULL),
(2407, 'SEA-LAND LIGHTNING', NULL, 2403, b'1', 101, '2015-06-17 21:04:00', 101, 2, '2015-06-17 21:04:00', NULL),
(2408, 'CLIFFORD MAERSK ', NULL, 2404, b'1', 118, '2015-06-18 16:13:00', 118, 2, '2015-06-18 16:13:00', NULL),
(2409, 'E R  FRANCE ', NULL, 2405, b'1', 118, '2015-06-18 16:49:00', 118, 2, '2015-06-18 16:49:00', NULL),
(2410, 'CEZANNE', NULL, 2406, b'1', 118, '2015-06-18 20:47:00', 118, 2, '2015-06-18 20:47:00', NULL),
(2411, 'MAERSK CUNENE', NULL, 2407, b'1', 118, '2015-06-19 20:11:00', 118, 2, '2015-06-19 20:11:00', NULL),
(2412, 'X-PRESS TAJUMULCO', NULL, 2408, b'1', 112, '2015-06-24 14:02:00', 112, 2, '2015-06-24 14:02:00', NULL),
(2413, 'HAMMONIA HOLSATIA ', NULL, 2409, b'1', 118, '2015-06-26 17:59:00', 118, 2, '2015-06-26 17:59:00', NULL),
(2414, 'APL SPAIN', NULL, 2410, b'1', 118, '2015-07-03 21:27:00', 118, 2, '2015-07-03 21:27:00', NULL),
(2415, 'MAERSK CABO VERDE ', NULL, 2411, b'1', 118, '2015-07-07 14:37:00', 118, 2, '2015-07-07 14:37:00', NULL),
(2416, 'COPIAPO', NULL, 2412, b'1', 118, '2015-07-13 22:07:00', 118, 2, '2015-07-13 22:07:00', NULL),
(2417, 'HANSA ALESSUN', NULL, 2413, b'1', 118, '2015-07-13 23:21:00', 118, 2, '2015-07-13 23:21:00', NULL),
(2418, 'E.R. CAEN', NULL, 2414, b'1', 101, '2015-07-14 21:52:00', 101, 2, '2015-07-14 21:52:00', NULL),
(2419, 'KOTA SABAS ', NULL, 2415, b'1', 118, '2015-07-17 17:17:00', 118, 2, '2015-07-17 17:17:00', NULL),
(2420, 'CAPE CHRONOS', NULL, 2416, b'1', 111, '2015-07-24 16:33:00', 111, 2, '2015-07-24 16:33:00', NULL),
(2421, 'KOTA LEMBAH', NULL, 2417, b'1', 118, '2015-07-30 16:13:00', 118, 2, '2015-07-30 16:13:00', NULL),
(2422, 'HS PARIS', NULL, 2418, b'1', 118, '2015-08-05 14:11:00', 118, 2, '2015-08-05 14:11:00', NULL),
(2423, 'HANSA AALESUND ', NULL, 2419, b'1', 101, '2015-08-10 14:29:00', 101, 2, '2015-08-10 14:29:00', NULL),
(2424, 'GENOA BRIDGE', NULL, 2420, b'1', 118, '2015-08-10 15:27:00', 118, 2, '2015-08-10 15:27:00', NULL),
(2425, 'MOL PREMIUM ', NULL, 2421, b'1', 118, '2015-08-10 21:05:00', 118, 2, '2015-08-10 21:05:00', NULL),
(2426, 'MONTE CERVANTES ', NULL, 2422, b'1', 118, '2015-08-11 21:38:00', 118, 2, '2015-08-11 21:38:00', NULL),
(2427, 'MOL GRANDEUR', NULL, 2423, b'1', 118, '2015-08-13 16:48:00', 118, 2, '2015-08-13 16:48:00', NULL),
(2428, 'HUI GANG TONG   ', NULL, 2424, b'1', 118, '2015-08-18 14:23:00', 118, 2, '2015-08-18 14:23:00', NULL),
(2429, 'OOCL TIANJIN ', NULL, 2425, b'1', 118, '2015-08-18 17:39:00', 118, 2, '2015-08-18 17:39:00', NULL),
(2430, 'CMA CGM FLORIDA ', NULL, 2426, b'1', 118, '2015-08-19 15:22:00', 118, 2, '2015-08-19 15:22:00', NULL),
(2431, 'WIDUKIND', NULL, 2427, b'1', 118, '2015-08-19 19:25:00', 118, 2, '2015-08-19 19:25:00', NULL),
(2432, 'KATRIN', NULL, 2428, b'1', 111, '2015-08-25 21:05:00', 111, 2, '2015-08-25 21:05:00', NULL),
(2433, 'MAERSK KLEVEN ', NULL, 2429, b'1', 118, '2015-08-28 23:30:00', 118, 2, '2015-08-28 23:30:00', NULL),
(2434, 'EVER UNIQUE ', NULL, 2430, b'1', 118, '2015-09-02 14:56:00', 118, 2, '2015-09-02 14:56:00', NULL),
(2435, 'VIRGINIA TRADER', NULL, 2431, b'1', 111, '2015-09-03 15:34:00', 111, 2, '2015-09-03 15:34:00', NULL),
(2436, 'HANSA FLENSBURG', NULL, 2432, b'1', 119, '2015-09-09 16:55:00', 119, 2, '2015-09-09 16:55:00', NULL),
(2437, 'MAERSK SALINA', NULL, 2433, b'1', 118, '2015-09-09 20:28:00', 118, 2, '2015-09-09 20:28:00', NULL),
(2438, 'DOLPHIN II', NULL, 2434, b'1', 118, '2015-09-18 21:40:00', 118, 2, '2015-09-18 21:40:00', NULL),
(2439, 'CORCOVADO', NULL, 2435, b'1', 111, '2015-09-28 18:38:00', 111, 2, '2015-09-28 18:38:00', NULL),
(2440, 'COCHRANE', NULL, 2436, b'1', 118, '2015-09-29 20:30:00', 118, 2, '2015-09-29 20:30:00', NULL),
(2441, 'MIRAMARIN', NULL, 2437, b'1', 118, '2015-10-05 14:05:00', 118, 2, '2015-10-05 14:05:00', NULL),
(2442, 'MAERSK CONGO ', NULL, 2438, b'1', 118, '2015-10-13 15:44:00', 118, 2, '2015-10-13 15:44:00', NULL),
(2443, 'MAERSK NEWHAVEN', NULL, 2439, b'1', 119, '2015-10-16 18:40:00', 119, 2, '2015-10-16 18:40:00', NULL),
(2444, 'CSAV TRAIGUEN ', NULL, 2440, b'1', 118, '2015-10-21 15:53:00', 118, 2, '2015-10-21 15:53:00', NULL),
(2445, 'SEABOARD ATLANTIC ', NULL, 2441, b'1', 118, '2015-10-21 17:37:00', 118, 2, '2015-10-21 17:37:00', NULL),
(2446, 'SKAGEN MAERSK ', NULL, 2442, b'1', 118, '2015-10-23 15:54:00', 118, 2, '2015-10-23 15:54:00', NULL),
(2447, 'ULYSSES ', NULL, 2443, b'1', 118, '2015-10-23 18:26:00', 118, 2, '2015-10-23 18:26:00', NULL),
(2448, 'CMA CGM L ETOILE', NULL, 2444, b'1', 118, '2015-10-27 14:37:00', 112, 2, '2018-11-22 17:32:00', NULL),
(2449, 'EVER  LIVELY', NULL, 2445, b'1', 118, '2015-10-28 21:58:00', 118, 2, '2015-10-28 21:58:00', NULL),
(2450, 'SOFIE MAERSK', NULL, 2446, b'1', 118, '2015-10-28 23:32:00', 118, 2, '2015-10-28 23:32:00', NULL),
(2451, 'MOL PARADISE', NULL, 2447, b'1', 118, '2015-10-29 00:12:00', 118, 2, '2015-10-29 00:12:00', NULL),
(2452, 'BARCELONA BCN ', NULL, 2448, b'1', 118, '2015-10-30 15:13:00', 118, 2, '2015-10-30 15:13:00', NULL),
(2453, 'DUBAI EXPRESS', NULL, 2449, b'1', 118, '2015-10-30 15:13:00', 118, 2, '2015-10-30 15:13:00', NULL),
(2454, 'NHAVA SHEVA', NULL, 2450, b'1', 118, '2015-11-03 20:54:00', 118, 2, '2015-11-03 20:54:00', NULL),
(2455, 'KEA', NULL, 2451, b'1', 118, '2015-11-03 20:54:00', 118, 2, '2015-11-03 20:54:00', NULL),
(2456, 'EVER DIAMOND ', NULL, 2452, b'1', 118, '2015-11-04 23:04:00', 118, 2, '2015-11-04 23:04:00', NULL),
(2457, 'E R SEOUL', NULL, 2453, b'1', 118, '2015-11-09 16:21:00', 118, 2, '2015-11-09 16:21:00', NULL),
(2458, 'VALENCIA ', NULL, 2454, b'1', 118, '2015-11-11 20:48:00', 118, 2, '2015-11-11 20:48:00', NULL),
(2459, 'SEASPAN CHIWAN', NULL, 2455, b'1', 118, '2015-11-11 20:49:00', 118, 2, '2015-11-11 20:49:00', NULL),
(2460, 'ADRIAN SCHULTE', NULL, 2456, b'1', 118, '2015-11-12 00:11:00', 118, 2, '2015-11-12 00:11:00', NULL),
(2461, 'SKY ORION ', NULL, 2457, b'1', 118, '2015-11-12 14:35:00', 118, 2, '2015-11-12 14:35:00', NULL),
(2462, 'EVER DIADEM', NULL, 2458, b'1', 118, '2015-11-17 22:02:00', 118, 2, '2015-11-17 22:02:00', NULL),
(2463, 'SUSAN MAERSK ', NULL, 2459, b'1', 118, '2015-11-18 15:30:00', 118, 2, '2015-11-18 15:30:00', NULL),
(2464, 'CMA CGM TIGRIS ', NULL, 2460, b'1', 118, '2015-11-19 20:56:00', 118, 2, '2015-11-19 20:56:00', NULL),
(2465, 'MSC CAROLE ', NULL, 2461, b'1', 118, '2015-11-23 19:12:00', 118, 2, '2015-11-23 19:12:00', NULL),
(2466, 'MAERSK WALVIS', NULL, 2462, b'1', 118, '2015-11-24 15:59:00', 118, 2, '2015-11-24 15:59:00', NULL),
(2467, 'HYUNDAI BUSAN ', NULL, 2463, b'1', 118, '2015-11-26 14:47:00', 118, 2, '2015-11-26 14:47:00', NULL);
INSERT INTO `barco` (`id_barco`, `nombre`, `bandera`, `idBarco`, `Estado`, `idUsuario`, `fechaIngreso`, `idUsuarioModifica`, `id_sucursal`, `fechamodificacion`, `tipo`) VALUES
(2468, 'ZANTE', NULL, 2464, b'1', 118, '2015-11-30 15:12:00', 118, 2, '2015-11-30 15:12:00', NULL),
(2469, 'SANTA TERESA', NULL, 2465, b'1', 118, '2015-12-02 20:31:00', 118, 2, '2015-12-02 20:31:00', NULL),
(2470, 'BAVARIA ', NULL, 2466, b'1', 118, '2015-12-04 17:03:00', 118, 2, '2015-12-04 17:03:00', NULL),
(2471, 'COSCO SINGAPORE ', NULL, 2467, b'1', 118, '2015-12-08 20:09:00', 118, 2, '2015-12-08 20:09:00', NULL),
(2472, 'SAINT NIKOLAOS', NULL, 2468, b'1', 93, '2015-12-10 21:59:00', 93, 2, '2015-12-10 21:59:00', NULL),
(2473, 'MAIRA XL ', NULL, 2469, b'1', 118, '2015-12-15 15:46:00', 118, 2, '2015-12-15 15:46:00', NULL),
(2474, 'EVER UNION ', NULL, 2470, b'1', 118, '2015-12-15 17:47:00', 118, 2, '2015-12-15 17:47:00', NULL),
(2475, 'MAERSK ELBA', NULL, 2471, b'1', 118, '2015-12-15 20:40:00', 118, 2, '2015-12-15 20:40:00', NULL),
(2476, 'NORTHHAMPTON', NULL, 2472, b'1', 118, '2015-12-17 17:02:00', 118, 2, '2015-12-17 17:02:00', NULL),
(2477, 'HYUNDAI HONGKONG', NULL, 2473, b'1', 111, '2015-12-23 17:27:00', 111, 2, '2015-12-23 17:27:00', NULL),
(2478, 'CAP SAN LAZARO ', NULL, 2474, b'1', 111, '2015-12-23 19:06:00', 111, 2, '2015-12-23 19:06:00', NULL),
(2479, 'NEPTUNE LEADER ', NULL, 2475, b'1', 118, '2015-12-29 14:45:00', 118, 2, '2015-12-29 14:45:00', NULL),
(2480, 'MSC ANS', NULL, 2476, b'1', 118, '2015-12-30 17:18:00', 118, 2, '2015-12-30 17:18:00', NULL),
(2481, 'JIHAI CHANG ', NULL, 2477, b'1', 118, '2016-01-04 22:30:00', 118, 2, '2016-01-04 22:30:00', NULL),
(2482, 'RIO THOMPSON ', NULL, 2478, b'1', 118, '2016-01-07 16:12:00', 118, 2, '2016-01-07 16:12:00', NULL),
(2483, 'LUTETIA', NULL, 2479, b'1', 118, '2016-01-07 16:57:00', 118, 2, '2016-01-07 16:57:00', NULL),
(2484, 'ITAL MASSIMA ', NULL, 2480, b'1', 118, '2016-01-07 22:28:00', 118, 2, '2016-01-07 22:28:00', NULL),
(2485, 'MSC FLORENTINA', NULL, 2481, b'1', 119, '2016-01-08 13:43:00', 119, 2, '2016-01-08 13:43:00', NULL),
(2486, 'YM NEW JERSEY ', NULL, 2482, b'1', 118, '2016-01-08 20:51:00', 118, 2, '2016-01-08 20:51:00', NULL),
(2487, 'CAUTIN ', NULL, 2483, b'1', 118, '2016-01-08 22:33:00', 118, 2, '2016-01-08 22:33:00', NULL),
(2488, 'NORTHAMPTON', NULL, 2484, b'1', 101, '2016-01-14 18:37:00', 101, 2, '2016-01-14 18:37:00', NULL),
(2489, 'CAUQUENES ', NULL, 2485, b'1', 118, '2016-01-19 18:08:00', 118, 2, '2016-01-19 18:08:00', NULL),
(2490, 'MSC ROSARIA ', NULL, 2486, b'1', 118, '2016-01-20 17:21:00', 118, 2, '2016-01-20 17:21:00', NULL),
(2491, 'MOL COURAGE', NULL, 2487, b'1', 118, '2016-01-21 20:11:00', 118, 2, '2016-01-21 20:11:00', NULL),
(2492, 'HYUNDAI PARAMOUNT', NULL, 2488, b'1', 118, '2016-01-26 15:16:00', 118, 2, '2016-01-26 15:16:00', NULL),
(2493, 'HYUNDAI NEW YORK ', NULL, 2489, b'1', 118, '2016-01-26 15:22:00', 118, 2, '2016-01-26 15:22:00', NULL),
(2494, 'LION', NULL, 2490, b'1', 93, '2016-01-26 19:58:00', 93, 2, '2016-01-26 19:58:00', NULL),
(2495, 'THASOS ', NULL, 2491, b'1', 118, '2016-01-27 16:19:00', 118, 2, '2016-01-27 16:19:00', NULL),
(2496, 'SHI TAI ', NULL, 2492, b'1', 118, '2016-02-08 15:44:00', 118, 2, '2016-02-08 15:44:00', NULL),
(2497, 'MAIKE D', NULL, 2493, b'1', 118, '2016-02-09 21:19:00', 118, 2, '2016-02-09 21:19:00', NULL),
(2498, 'ELISABETH S ', NULL, 2494, b'1', 118, '2016-02-11 22:30:00', 118, 2, '2016-02-11 22:30:00', NULL),
(2499, 'CMA CGM AMERICA', NULL, 2495, b'1', 118, '2016-02-16 23:01:00', 118, 2, '2016-02-16 23:01:00', NULL),
(2500, 'ANDRONIKOS ', NULL, 2496, b'1', 118, '2016-02-19 19:30:00', 118, 2, '2016-02-19 19:30:00', NULL),
(2501, 'MSC NERISSA', NULL, 2497, b'1', 118, '2016-02-29 22:28:00', 118, 2, '2016-02-29 22:28:00', NULL),
(2502, 'BIRIK', NULL, 2498, b'1', 118, '2016-03-04 22:31:00', 118, 2, '2016-03-04 22:31:00', NULL),
(2503, 'EVER UNIFIC ', NULL, 2499, b'1', 118, '2016-03-08 16:33:00', 118, 2, '2016-03-08 16:33:00', NULL),
(2504, 'HYUNDAI TOKIO ', NULL, 2500, b'1', 118, '2016-03-11 20:21:00', 118, 2, '2016-03-11 20:21:00', NULL),
(2505, 'HAI CHUAN ', NULL, 2501, b'1', 118, '2016-03-11 20:32:00', 118, 2, '2016-03-11 20:32:00', NULL),
(2506, 'MARINER ', NULL, 2502, b'1', 101, '2016-03-15 16:41:00', 101, 2, '2016-03-15 16:41:00', NULL),
(2507, 'HANJ IN ROME', NULL, 2503, b'1', 118, '2016-03-16 19:42:00', 118, 2, '2016-03-16 19:42:00', NULL),
(2508, 'CALA PALMA', NULL, 2504, b'1', 118, '2016-03-16 19:56:00', 118, 2, '2016-03-16 19:56:00', NULL),
(2509, 'MOL EMINENCE', NULL, 2505, b'1', 111, '2016-03-18 20:15:00', 111, 2, '2016-03-18 20:15:00', NULL),
(2510, 'TAJUMULCO ', NULL, 2506, b'1', 118, '2016-03-21 22:22:00', 118, 2, '2016-03-21 22:22:00', NULL),
(2511, 'HANJIN ROME', NULL, 2507, b'1', 118, '2016-03-22 00:20:00', 118, 2, '2016-03-22 00:20:00', NULL),
(2512, 'CMACGM FORT ST PIERRE ', NULL, 2508, b'1', 118, '2016-03-22 22:06:00', 118, 2, '2016-03-22 22:06:00', NULL),
(2513, 'CMA CGM FORT ST PIERRE', NULL, 2509, b'1', 118, '2016-03-22 22:08:00', 118, 2, '2016-03-22 22:08:00', NULL),
(2514, 'E.R. CANADA ', NULL, 2510, b'1', 118, '2016-03-28 20:23:00', 101, 2, '2016-06-10 16:30:00', NULL),
(2515, 'APL OMAN', NULL, 2511, b'1', 118, '2016-03-28 21:00:00', 118, 2, '2016-03-28 21:00:00', NULL),
(2516, 'ITAL MODERNA', NULL, 2512, b'1', 118, '2016-03-28 23:01:00', 118, 2, '2016-03-28 23:01:00', NULL),
(2517, 'HAMMONIA ISTRIA', NULL, 2513, b'1', 118, '2016-03-29 15:03:00', 118, 2, '2016-03-29 15:03:00', NULL),
(2518, 'HYUNDAI LONG BEACH ', NULL, 2514, b'1', 118, '2016-03-29 23:22:00', 118, 2, '2016-03-29 23:22:00', NULL),
(2519, 'SAN ADRIANO', NULL, 2515, b'1', 93, '2016-03-31 13:35:00', 93, 2, '2016-03-31 13:35:00', NULL),
(2520, 'DANAE C ', NULL, 2516, b'1', 101, '2016-03-31 15:55:00', 101, 2, '2016-03-31 15:55:00', NULL),
(2521, 'MINERVA', NULL, 2517, b'1', 93, '2016-04-07 19:26:00', 93, 2, '2016-04-07 19:26:00', NULL),
(2522, 'KIEL TRADER', NULL, 2518, b'1', 118, '2016-04-07 21:36:00', 118, 2, '2016-04-07 21:36:00', NULL),
(2523, 'MARIA-KATHARINA S', NULL, 2519, b'1', 93, '2016-04-13 18:04:00', 93, 2, '2016-04-13 18:04:00', NULL),
(2524, 'STADT SEVILLA ', NULL, 2520, b'1', 118, '2016-04-14 17:46:00', 118, 2, '2016-04-14 17:46:00', NULL),
(2525, 'OOCL TAIPEI ', NULL, 2521, b'1', 118, '2016-04-21 20:21:00', 118, 2, '2016-04-21 20:21:00', NULL),
(2526, 'LONDON EXPRESS', NULL, 2522, b'1', 118, '2016-04-22 19:41:00', 118, 2, '2016-04-22 19:41:00', NULL),
(2527, 'HANNAH SCHULTE', NULL, 2523, b'1', 112, '2016-04-27 18:32:00', 112, 2, '2016-04-27 18:32:00', NULL),
(2528, 'XINCHANGFENG', NULL, 2524, b'1', 118, '2016-04-28 01:23:00', 118, 2, '2016-04-28 01:23:00', NULL),
(2529, 'SAN AMERIGO', NULL, 2525, b'1', 93, '2016-05-02 17:30:00', 93, 2, '2016-05-02 17:30:00', NULL),
(2530, 'PLUTO LEADER', NULL, 2526, b'1', 118, '2016-05-03 18:33:00', 118, 2, '2016-05-03 18:33:00', NULL),
(2531, 'CISNES', NULL, 2527, b'1', 118, '2016-05-04 14:00:00', 118, 2, '2016-05-04 14:00:00', NULL),
(2532, 'MORTEN MAERSK ', NULL, 2528, b'1', 118, '2016-05-05 00:14:00', 118, 2, '2016-05-05 00:14:00', NULL),
(2533, 'CHOAPA TRADER ', NULL, 2529, b'1', 118, '2016-05-09 15:07:00', 118, 2, '2016-05-09 15:07:00', NULL),
(2534, 'EVER DECENT', NULL, 2530, b'1', 118, '2016-05-12 14:22:00', 118, 2, '2016-05-12 14:22:00', NULL),
(2535, 'MAERSK SEOUL', NULL, 2531, b'1', 118, '2016-05-13 22:28:00', 118, 2, '2016-05-13 22:28:00', NULL),
(2536, 'MONTE SARMIENTO ', NULL, 2532, b'1', 118, '2016-05-16 17:21:00', 118, 2, '2016-05-16 17:21:00', NULL),
(2537, 'CC FORT ST PIERRE', NULL, 2533, b'1', 118, '2016-05-25 23:04:00', 118, 2, '2016-05-25 23:04:00', NULL),
(2538, 'MAERSK WALVIS BAY ', NULL, 2534, b'1', 101, '2016-05-27 20:01:00', 101, 2, '2016-05-27 20:01:00', NULL),
(2539, 'KOTA LATIF', NULL, 2535, b'1', 93, '2016-05-27 20:02:00', 93, 2, '2016-05-27 20:02:00', NULL),
(2540, 'RIO BARROW', NULL, 2536, b'1', 118, '2016-05-30 19:50:00', 118, 2, '2016-05-30 19:50:00', NULL),
(2541, 'WAN HE', NULL, 2537, b'1', 118, '2016-05-30 22:29:00', 118, 2, '2016-05-30 22:29:00', NULL),
(2542, 'XPRESS ANNAPURNA', NULL, 2538, b'1', 118, '2016-05-30 22:50:00', 118, 2, '2016-05-30 22:50:00', NULL),
(2543, 'ALLEGORIA ', NULL, 2539, b'1', 101, '2016-06-06 16:25:00', 101, 2, '2016-06-06 16:25:00', NULL),
(2544, 'SEALAND MANZANILLO', NULL, 2540, b'1', 93, '2016-06-08 21:09:00', 93, 2, '2016-06-08 21:09:00', NULL),
(2545, 'SEALAND BALBOA ', NULL, 2541, b'1', 101, '2016-06-13 19:23:00', 101, 2, '2016-06-13 19:23:00', NULL),
(2546, 'EVER URBAN', NULL, 2542, b'1', 118, '2016-06-13 19:33:00', 118, 2, '2016-06-13 19:33:00', NULL),
(2547, 'CMA CGM FORT ST GEORGES', NULL, 2543, b'1', 118, '2016-06-13 20:11:00', 101, 2, '2016-07-12 19:45:00', NULL),
(2548, 'OOCL SAN FRANCISCO', NULL, 2544, b'1', 118, '2016-06-13 21:31:00', 118, 2, '2016-06-13 21:31:00', NULL),
(2549, 'MAERSK FINDHOVEN', NULL, 2545, b'1', 118, '2016-06-14 15:41:00', 118, 2, '2016-06-14 15:41:00', NULL),
(2550, 'E.R. SWEDEN', NULL, 2546, b'1', 101, '2016-06-22 16:16:00', 101, 2, '2016-06-22 16:16:00', NULL),
(2551, 'SANTA BARBARA', NULL, 2547, b'1', 118, '2016-06-22 20:43:00', 118, 2, '2016-06-22 20:43:00', NULL),
(2552, 'ROTTERDAM EXPRESS', NULL, 2548, b'1', 118, '2016-06-23 15:14:00', 118, 2, '2016-06-23 15:14:00', NULL),
(2553, 'ZHI HANG ', NULL, 2549, b'1', 118, '2016-06-23 17:52:00', 118, 2, '2016-06-23 17:52:00', NULL),
(2554, 'CMA CGM WHITE SHARK', NULL, 2550, b'1', 118, '2016-06-24 17:33:00', 118, 2, '2016-06-24 17:33:00', NULL),
(2555, 'MAERSK EINDHOVEN ', NULL, 2551, b'1', 101, '2016-06-24 20:45:00', 101, 2, '2016-06-24 20:45:00', NULL),
(2556, 'APL TOURMALINE', NULL, 2552, b'1', 119, '2016-06-24 23:01:00', 119, 2, '2016-06-24 23:01:00', NULL),
(2557, 'YM GREEN', NULL, 2553, b'1', 118, '2016-06-27 20:28:00', 118, 2, '2016-06-27 20:28:00', NULL),
(2558, 'CAP JACKSON', NULL, 2554, b'1', 118, '2016-06-28 22:51:00', 118, 2, '2016-06-28 22:51:00', NULL),
(2559, 'EVER STEADY', NULL, 2555, b'1', 118, '2016-07-05 17:37:00', 118, 2, '2016-07-05 17:37:00', NULL),
(2560, 'NYK LINE', NULL, 2556, b'1', 118, '2016-07-06 19:28:00', 118, 2, '2016-07-06 19:28:00', NULL),
(2561, 'XIANGFU ', NULL, 2557, b'1', 118, '2016-07-06 20:03:00', 118, 2, '2016-07-06 20:03:00', NULL),
(2562, 'XIN HONG', NULL, 2558, b'1', 118, '2016-07-11 15:59:00', 118, 2, '2016-07-11 15:59:00', NULL),
(2563, 'XIN HONG KONG', NULL, 2559, b'1', 118, '2016-07-11 15:59:00', 118, 2, '2016-07-11 15:59:00', NULL),
(2564, 'ILSE WULFF', NULL, 2560, b'1', 118, '2016-07-12 14:14:00', 118, 2, '2016-07-12 14:14:00', NULL),
(2565, 'CORDOVADO', NULL, 2561, b'1', 118, '2016-07-12 15:37:00', 118, 2, '2016-07-12 15:37:00', NULL),
(2566, 'DUSSELFORF', NULL, 2562, b'1', 118, '2016-07-14 15:19:00', 118, 2, '2016-07-14 15:19:00', NULL),
(2567, 'CMA CGM FORT STE MARIE', NULL, 2563, b'1', 93, '2016-07-15 22:16:00', 93, 2, '2016-07-15 22:16:00', NULL),
(2568, 'DUSSELDORF EXPRESS', NULL, 2564, b'1', 119, '2016-07-15 22:28:00', 119, 2, '2016-07-15 22:28:00', NULL),
(2569, 'CC FORT STE MARIE', NULL, 2565, b'1', 118, '2016-07-15 22:40:00', 118, 2, '2016-07-15 22:40:00', NULL),
(2570, 'CC FORT ST MARIE', NULL, 2566, b'1', 118, '2016-07-15 22:40:00', 118, 2, '2016-07-15 22:40:00', NULL),
(2571, 'NYK LYNS ', NULL, 2567, b'1', 118, '2016-07-15 23:23:00', 118, 2, '2016-07-15 23:23:00', NULL),
(2572, 'SAN FELIX', NULL, 2568, b'1', 118, '2016-07-19 21:54:00', 118, 2, '2016-07-19 21:54:00', NULL),
(2573, 'HYUNDAI EARTH', NULL, 2569, b'1', 118, '2016-07-19 23:02:00', 118, 2, '2016-07-19 23:02:00', NULL),
(2574, 'ER CANADA', NULL, 2570, b'1', 118, '2016-07-20 21:28:00', 118, 2, '2016-07-20 21:28:00', NULL),
(2575, 'BANAK', NULL, 2571, b'1', 118, '2016-07-20 23:33:00', 118, 2, '2016-07-20 23:33:00', NULL),
(2576, 'ANTON SCHULTE', NULL, 2572, b'1', 118, '2016-07-29 17:02:00', 118, 2, '2016-07-29 17:02:00', NULL),
(2577, 'ERATO', NULL, 2573, b'1', 118, '2016-08-01 16:25:00', 118, 2, '2016-08-01 16:25:00', NULL),
(2578, 'NORTHERN MAJESTIC', NULL, 2574, b'1', 118, '2016-08-03 14:05:00', 118, 2, '2016-08-03 14:05:00', NULL),
(2579, 'HANGZHOU BAY BRIDGE', NULL, 2575, b'1', 118, '2016-08-03 19:23:00', 118, 2, '2016-08-03 19:23:00', NULL),
(2580, 'LLOYD DON GIOVANNI', NULL, 2576, b'1', 118, '2016-08-03 19:54:00', 118, 2, '2016-08-03 19:54:00', NULL),
(2581, 'SEASPAN NINGBO', NULL, 2577, b'1', 118, '2016-08-11 13:32:00', 118, 2, '2016-08-11 13:32:00', NULL),
(2582, 'COSCO INDONESIA', NULL, 2578, b'1', 118, '2016-08-11 19:39:00', 118, 2, '2016-08-11 19:39:00', NULL),
(2583, 'ALIANCA SANTA FE', NULL, 2579, b'1', 119, '2016-08-12 15:01:00', 119, 2, '2016-08-12 15:01:00', NULL),
(2584, 'BELLA SCHULTE', NULL, 2580, b'1', 118, '2016-08-16 14:10:00', 118, 2, '2016-08-16 14:10:00', NULL),
(2585, 'PAXI', NULL, 2581, b'1', 118, '2016-08-16 16:10:00', 118, 2, '2016-08-16 16:10:00', NULL),
(2586, 'CMA CGM FORT ST LOUIS', NULL, 2582, b'1', 93, '2016-08-16 19:57:00', 93, 2, '2016-08-16 19:57:00', NULL),
(2587, 'FRISIA LOGA', NULL, 2583, b'1', 118, '2016-08-23 19:53:00', 118, 2, '2016-08-23 19:53:00', NULL),
(2588, 'EVER EAGLE', NULL, 2584, b'1', 118, '2016-08-26 15:05:00', 118, 2, '2016-08-26 15:05:00', NULL),
(2589, 'EVER ETHIC', NULL, 2585, b'1', 118, '2016-08-26 20:33:00', 118, 2, '2016-08-26 20:33:00', NULL),
(2590, 'HANJIN CROATIA', NULL, 2586, b'1', 118, '2016-08-26 20:57:00', 118, 2, '2016-08-26 20:57:00', NULL),
(2591, 'FORT STE MARIE', NULL, 2587, b'1', 118, '2016-08-29 13:54:00', 118, 2, '2016-08-29 13:54:00', NULL),
(2592, 'CSCL URANUS', NULL, 2588, b'1', 118, '2016-08-29 14:25:00', 118, 2, '2016-08-29 14:25:00', NULL),
(2593, 'GALAXY LEADER', NULL, 2589, b'1', 118, '2016-09-02 21:05:00', 118, 2, '2016-09-02 21:05:00', NULL),
(2594, 'CMA CGM KERGUELEN', NULL, 2590, b'1', 118, '2016-09-02 21:31:00', 118, 2, '2016-09-02 21:31:00', NULL),
(2595, 'MSC SOFIA CELESTE', NULL, 2591, b'1', 118, '2016-09-02 21:55:00', 118, 2, '2016-09-02 21:55:00', NULL),
(2596, 'MSC AGRIGENTO', NULL, 2592, b'1', 118, '2016-09-02 22:03:00', 118, 2, '2016-09-02 22:03:00', NULL),
(2597, 'MSC TRIESTE', NULL, 2593, b'1', 118, '2016-09-06 19:38:00', 118, 2, '2016-09-06 19:38:00', NULL),
(2598, 'EVER EXCEL', NULL, 2594, b'1', 118, '2016-09-06 21:51:00', 118, 2, '2016-09-06 21:51:00', NULL),
(2599, 'SANTA ISABEL', NULL, 2595, b'1', 118, '2016-09-07 15:06:00', 118, 2, '2016-09-07 15:06:00', NULL),
(2600, 'CMA CGM RIO GRANDE', NULL, 2596, b'1', 118, '2016-09-07 16:51:00', 118, 2, '2016-09-07 16:51:00', NULL),
(2601, 'SAN ANDRES ', NULL, 2597, b'1', 101, '2016-09-07 17:40:00', 101, 2, '2016-09-07 17:40:00', NULL),
(2602, 'SPIRIT OF MANILA', NULL, 2598, b'1', 118, '2016-09-07 17:44:00', 118, 2, '2016-09-07 17:44:00', NULL),
(2603, 'SEALAND GUAYAQUIL', NULL, 2599, b'1', 118, '2016-09-07 19:25:00', 118, 2, '2016-09-07 19:25:00', NULL),
(2604, 'XIN SHANGHAI', NULL, 2600, b'1', 118, '2016-09-13 16:31:00', 118, 2, '2016-09-13 16:31:00', NULL),
(2605, 'SEALAND PHILADELPHIA', NULL, 2601, b'1', 101, '2016-09-19 18:51:00', 101, 2, '2016-09-19 18:51:00', NULL),
(2606, 'CAP JERVIS', NULL, 2602, b'1', 118, '2016-09-19 21:38:00', 118, 2, '2016-09-19 21:38:00', NULL),
(2607, 'ATACAMA', NULL, 2603, b'1', 93, '2016-09-20 15:19:00', 93, 2, '2016-09-20 15:19:00', NULL),
(2608, 'TEXAS TRADER', NULL, 2604, b'1', 118, '2016-09-20 16:47:00', 118, 2, '2016-09-20 16:47:00', NULL),
(2609, 'SEATTLE WA US', NULL, 2605, b'1', 118, '2016-09-20 17:13:00', 118, 2, '2016-09-20 17:13:00', NULL),
(2610, 'MSC CORINNA ', NULL, 2606, b'1', 118, '2016-09-20 20:41:00', 118, 2, '2016-09-20 20:41:00', NULL),
(2611, 'LOA', NULL, 2607, b'1', 118, '2016-09-23 16:29:00', 118, 2, '2016-09-23 16:29:00', NULL),
(2612, 'SANTA ROSA', NULL, 2608, b'1', 118, '2016-09-23 16:57:00', 118, 2, '2016-09-23 16:57:00', NULL),
(2613, 'CMA CGM JACQUES JUNIOR', NULL, 2609, b'1', 118, '2016-09-26 15:13:00', 118, 2, '2016-09-26 15:13:00', NULL),
(2614, 'SANTOS  SP BR', NULL, 2610, b'1', 118, '2016-09-27 16:02:00', 118, 2, '2016-09-27 16:02:00', NULL),
(2615, 'APL LATVIA', NULL, 2611, b'1', 118, '2016-09-30 14:58:00', 118, 2, '2016-09-30 14:58:00', NULL),
(2616, 'YM UPWARD', NULL, 2612, b'1', 118, '2016-10-04 14:35:00', 118, 2, '2016-10-04 14:35:00', NULL),
(2617, 'COSCO KOREA', NULL, 2613, b'1', 118, '2016-10-07 21:38:00', 118, 2, '2016-10-07 21:38:00', NULL),
(2618, 'RIO THELON', NULL, 2614, b'1', 118, '2016-10-07 21:52:00', 118, 2, '2016-10-07 21:52:00', NULL),
(2619, 'CMA CGM NABUCCO', NULL, 2615, b'1', 118, '2016-10-10 16:41:00', 118, 2, '2016-10-10 16:41:00', NULL),
(2620, 'HANSA RUNNEBURG', NULL, 2616, b'1', 1, '2016-10-10 21:09:00', 1, 2, '2016-10-10 21:09:00', NULL),
(2621, 'MSC WESER', NULL, 2617, b'1', 118, '2016-10-21 14:48:00', 118, 2, '2016-10-21 14:48:00', NULL),
(2622, 'SEALAND LOS ANGELES', NULL, 2618, b'1', 118, '2016-10-24 15:33:00', 118, 2, '2016-10-24 15:33:00', NULL),
(2623, 'SAFMARINE NOKWANDA', NULL, 2619, b'1', 118, '2016-10-25 16:04:00', 118, 2, '2016-10-25 16:04:00', NULL),
(2624, 'NEW YORK NY', NULL, 2620, b'1', 118, '2016-10-25 16:50:00', 118, 2, '2016-10-25 16:50:00', NULL),
(2625, 'AOTEA MAERSK', NULL, 2621, b'1', 118, '2016-10-25 20:02:00', 118, 2, '2016-10-25 20:02:00', NULL),
(2626, 'MAERKS WALVIS BAY', NULL, 2622, b'1', 118, '2016-10-26 14:14:00', 118, 2, '2016-10-26 14:14:00', NULL),
(2627, 'CSCL LONG BEACH', NULL, 2623, b'1', 118, '2016-10-27 19:37:00', 118, 2, '2016-10-27 19:37:00', NULL),
(2628, 'BUXLINK', NULL, 2624, b'1', 101, '2016-10-31 19:45:00', 101, 2, '2016-10-31 19:45:00', NULL),
(2629, 'ETE N', NULL, 2625, b'1', 118, '2016-11-02 17:08:00', 118, 2, '2016-11-02 17:08:00', NULL),
(2630, 'MOL  CREATION', NULL, 2626, b'1', 118, '2016-11-10 20:05:00', 118, 2, '2016-11-10 20:05:00', NULL),
(2631, 'FLEUR', NULL, 2627, b'1', 118, '2016-11-17 15:23:00', 118, 2, '2016-11-17 15:23:00', NULL),
(2632, 'MSC ANTALYA', NULL, 2628, b'1', 118, '2016-11-21 15:41:00', 118, 2, '2016-11-21 15:41:00', NULL),
(2633, 'SIRIUS LEADER', NULL, 2629, b'1', 118, '2016-11-21 15:59:00', 118, 2, '2016-11-21 15:59:00', NULL),
(2634, 'ER DENMARK', NULL, 2630, b'1', 118, '2016-11-23 13:57:00', 118, 2, '2016-11-23 13:57:00', NULL),
(2635, 'BULXLINK', NULL, 2631, b'1', 1, '2016-11-25 19:09:00', 1, 2, '2016-11-25 19:09:00', NULL),
(2636, 'VEGA SCORPIO', NULL, 2632, b'1', 119, '2016-12-02 21:59:00', 119, 2, '2016-12-02 21:59:00', NULL),
(2637, 'EVER SALUTE', NULL, 2633, b'1', 118, '2016-12-06 23:29:00', 118, 2, '2016-12-06 23:29:00', NULL),
(2638, 'CMA CGMLOIRE', NULL, 2634, b'1', 118, '2016-12-12 14:06:00', 118, 2, '2016-12-12 14:06:00', NULL),
(2639, 'MSC FAUSTINA', NULL, 2635, b'1', 118, '2016-12-12 14:34:00', 118, 2, '2016-12-12 14:34:00', NULL),
(2640, 'MSC KATYA', NULL, 2636, b'1', 118, '2016-12-12 20:50:00', 118, 2, '2016-12-12 20:50:00', NULL),
(2641, 'CMA CGM LOIRE', NULL, 2637, b'1', 118, '2016-12-13 20:37:00', 118, 2, '2016-12-13 20:37:00', NULL),
(2642, 'E.R. DENMARK', NULL, 2638, b'1', 93, '2016-12-14 15:26:00', 93, 2, '2016-12-14 15:26:00', NULL),
(2643, 'XIN LOS ANGELES', NULL, 2639, b'1', 118, '2016-12-15 20:17:00', 118, 2, '2016-12-15 20:17:00', NULL),
(2644, 'A SER AVISADO', NULL, 2640, b'1', 118, '2016-12-19 18:20:00', 118, 2, '2016-12-19 18:20:00', NULL),
(2645, 'CONTSHIP  HUS', NULL, 2641, b'1', 118, '2016-12-20 20:59:00', 118, 2, '2016-12-20 20:59:00', NULL),
(2646, 'NILEDUTCH ORCA', NULL, 2642, b'1', 118, '2016-12-20 21:21:00', 118, 2, '2016-12-20 21:21:00', NULL),
(2647, 'MAS VAISHNAVI R', NULL, 2643, b'1', 118, '2016-12-21 15:02:00', 118, 2, '2016-12-21 15:02:00', NULL),
(2648, 'MSC VAISNAVI R', NULL, 2644, b'1', 118, '2016-12-21 15:03:00', 118, 2, '2016-12-21 15:03:00', NULL),
(2649, 'JPO CAPRICORNUS', NULL, 2645, b'1', 118, '2016-12-22 15:20:00', 118, 2, '2016-12-22 15:20:00', NULL),
(2650, 'SEASPAN', NULL, 2646, b'1', 1, '2016-12-23 14:14:00', 1, 2, '2016-12-23 14:14:00', NULL),
(2651, 'MSC KATYA R.', NULL, 2647, b'1', 93, '2016-12-26 15:52:00', 93, 2, '2016-12-26 15:52:00', NULL),
(2652, 'CONT SHIP HUB ', NULL, 2648, b'1', 101, '2016-12-27 18:01:00', 101, 2, '2016-12-27 18:01:00', NULL),
(2653, 'ITAL LUNARE', NULL, 2649, b'1', 118, '2016-12-29 16:02:00', 118, 2, '2016-12-29 16:02:00', NULL),
(2654, 'YM EXPRESS', NULL, 2650, b'1', 118, '2016-12-29 16:50:00', 118, 2, '2016-12-29 16:50:00', NULL),
(2655, 'MSC VIDISHAR', NULL, 2651, b'1', 118, '2017-01-04 15:15:00', 118, 2, '2017-01-04 15:15:00', NULL),
(2656, 'MSC FLAVIA', NULL, 2652, b'1', 118, '2017-01-09 19:15:00', 118, 2, '2017-01-09 19:15:00', NULL),
(2657, 'APOLLON D', NULL, 2653, b'1', 118, '2017-01-11 23:38:00', 118, 2, '2017-01-11 23:38:00', NULL),
(2658, 'NORTHERN JUVENILE ', NULL, 2654, b'1', 118, '2017-01-12 15:48:00', 118, 2, '2017-01-12 15:48:00', NULL),
(2659, 'MSC VAISHNAVI R.', NULL, 2655, b'1', 119, '2017-01-16 23:22:00', 119, 2, '2017-01-16 23:22:00', NULL),
(2660, 'MSC RAPALLO', NULL, 2656, b'1', 118, '2017-01-17 22:41:00', 118, 2, '2017-01-17 22:41:00', NULL),
(2661, 'MSC BERYL', NULL, 2657, b'1', 118, '2017-01-20 13:52:00', 118, 2, '2017-01-20 13:52:00', NULL),
(2662, 'COYHAIQUE', NULL, 2658, b'1', 118, '2017-01-23 15:23:00', 118, 2, '2017-01-23 15:23:00', NULL),
(2663, 'DUBLIN EXPRESS', NULL, 2659, b'1', 118, '2017-01-24 20:52:00', 118, 2, '2017-01-24 20:52:00', NULL),
(2664, 'HYUNDAI JUPITER', NULL, 2660, b'1', 118, '2017-01-26 13:54:00', 118, 2, '2017-01-26 13:54:00', NULL),
(2665, 'EVER SUPERB', NULL, 2661, b'1', 118, '2017-01-26 19:49:00', 118, 2, '2017-01-26 19:49:00', NULL),
(2666, 'PACON', NULL, 2662, b'1', 118, '2017-01-30 13:47:00', 118, 2, '2017-01-30 13:47:00', NULL),
(2667, 'BALTHASAR SCHULTE', NULL, 2663, b'1', 118, '2017-02-07 14:56:00', 118, 2, '2017-02-07 14:56:00', NULL),
(2668, 'MOL BELIEF', NULL, 2664, b'1', 118, '2017-02-07 15:53:00', 118, 2, '2017-02-07 15:53:00', NULL),
(2669, 'COSCO MALAYSIA', NULL, 2665, b'1', 118, '2017-02-09 13:21:00', 118, 2, '2017-02-09 13:21:00', NULL),
(2670, 'SANTA CRUZ', NULL, 2666, b'1', 118, '2017-02-17 16:43:00', 118, 2, '2017-02-17 16:43:00', NULL),
(2671, 'CMA CGM NIAGARA', NULL, 2667, b'1', 118, '2017-02-17 17:25:00', 118, 2, '2017-02-17 17:25:00', NULL),
(2672, 'APL DANUBE ', NULL, 2668, b'1', 118, '2017-02-21 14:01:00', 118, 2, '2017-02-21 14:01:00', NULL),
(2673, 'MAERSK WEYMOUTH', NULL, 2669, b'1', 118, '2017-02-27 21:18:00', 118, 2, '2017-02-27 21:18:00', NULL),
(2674, 'LIMA PERU ', NULL, 2670, b'1', 101, '2017-03-01 17:44:00', 101, 2, '2017-03-01 17:44:00', NULL),
(2675, 'MSC ORIANE', NULL, 2671, b'1', 118, '2017-03-01 21:36:00', 118, 2, '2017-03-01 21:36:00', NULL),
(2676, 'XIN YA ZHOU', NULL, 2672, b'1', 118, '2017-03-08 17:03:00', 118, 2, '2017-03-08 17:03:00', NULL),
(2677, 'HS LISZT', NULL, 2673, b'1', 101, '2017-03-10 14:38:00', 101, 2, '2017-03-10 14:38:00', NULL),
(2678, 'GODSPEED', NULL, 2674, b'1', 118, '2017-03-13 14:39:00', 118, 2, '2017-03-13 14:39:00', NULL),
(2679, 'MSC SILVIA', NULL, 2675, b'1', 118, '2017-03-15 16:34:00', 118, 2, '2017-03-15 16:34:00', NULL),
(2680, 'CMA CGM THAMES', NULL, 2676, b'1', 118, '2017-03-15 20:27:00', 118, 2, '2017-03-15 20:27:00', NULL),
(2681, 'NORTHERN MAGNITUDE', NULL, 2677, b'1', 118, '2017-03-17 14:46:00', 118, 2, '2017-03-17 14:46:00', NULL),
(2682, 'NYK DELPHINUS', NULL, 2678, b'1', 118, '2017-03-17 20:25:00', 118, 2, '2017-03-17 20:25:00', NULL),
(2683, 'MSC JULIE', NULL, 2679, b'1', 118, '2017-03-23 19:55:00', 118, 2, '2017-03-23 19:55:00', NULL),
(2684, 'CAP SAN TAINARO', NULL, 2680, b'1', 118, '2017-04-05 17:52:00', 118, 2, '2017-04-05 17:52:00', NULL),
(2685, 'STARSHIP LEO', NULL, 2681, b'1', 118, '2017-04-07 19:38:00', 118, 2, '2017-04-07 19:38:00', NULL),
(2686, 'PARADERO', NULL, 2682, b'1', 118, '2017-04-10 19:13:00', 118, 2, '2017-04-10 19:13:00', NULL),
(2687, 'BO YUN', NULL, 2683, b'1', 118, '2017-04-19 13:53:00', 118, 2, '2017-04-19 13:53:00', NULL),
(2688, 'OOCL CHONGQING', NULL, 2684, b'1', 118, '2017-04-20 16:18:00', 118, 2, '2017-04-20 16:18:00', NULL),
(2689, 'JPO VULPECULA ', NULL, 2685, b'1', 118, '2017-04-20 16:31:00', 118, 2, '2017-04-20 16:31:00', NULL),
(2690, 'TAMMO', NULL, 2686, b'1', 118, '2017-04-21 16:38:00', 118, 2, '2017-04-21 16:38:00', NULL),
(2691, 'JPO LIBRA', NULL, 2687, b'1', 118, '2017-04-25 14:07:00', 118, 2, '2017-04-25 14:07:00', NULL),
(2692, 'HONG KONG BRIDGE', NULL, 2688, b'1', 118, '2017-05-03 16:52:00', 118, 2, '2017-05-03 16:52:00', NULL),
(2693, 'ZHONG TAI  ', NULL, 2689, b'1', 118, '2017-05-04 20:00:00', 118, 2, '2017-05-04 20:00:00', NULL),
(2694, 'ER BERLIN', NULL, 2690, b'1', 118, '2017-05-12 22:34:00', 118, 2, '2017-05-12 22:34:00', NULL),
(2695, 'XIN BEIJING', NULL, 2691, b'1', 118, '2017-05-12 22:58:00', 118, 2, '2017-05-12 22:58:00', NULL),
(2696, 'BALTIMORE MD US', NULL, 2692, b'1', 118, '2017-05-17 22:10:00', 118, 2, '2017-05-17 22:10:00', NULL),
(2697, 'YM PLUM', NULL, 2693, b'1', 118, '2017-05-18 22:48:00', 118, 2, '2017-05-18 22:48:00', NULL),
(2698, 'MAERSK ALFIRX', NULL, 2694, b'1', 118, '2017-05-18 23:04:00', 118, 2, '2017-05-18 23:04:00', NULL),
(2699, 'MAERSK ALFIRK', NULL, 2695, b'1', 118, '2017-05-18 23:10:00', 118, 2, '2017-05-18 23:10:00', NULL),
(2700, 'SANTA RITA', NULL, 2696, b'1', 118, '2017-05-19 18:06:00', 118, 2, '2017-05-19 18:06:00', NULL),
(2701, 'MSC CHANNE', NULL, 2697, b'1', 118, '2017-05-19 21:23:00', 118, 2, '2017-05-19 21:23:00', NULL),
(2702, 'MSC CAPELLA', NULL, 2698, b'1', 118, '2017-05-19 22:28:00', 118, 2, '2017-05-19 22:28:00', NULL),
(2703, 'CHIQUITA PROGRESS', NULL, 2699, b'1', 118, '2017-05-25 14:19:00', 118, 2, '2017-05-25 14:19:00', NULL),
(2704, 'HAMMERSMITH BRIDGE', NULL, 2700, b'1', 118, '2017-05-25 16:07:00', 118, 2, '2017-05-25 16:07:00', NULL),
(2705, 'MSC ARBATRAX', NULL, 2701, b'1', 118, '2017-05-29 21:53:00', 118, 2, '2017-05-29 21:53:00', NULL),
(2706, 'YM EXCELLENCE', NULL, 2702, b'1', 118, '2017-06-02 16:50:00', 118, 2, '2017-06-02 16:50:00', NULL),
(2707, 'AUGUST', NULL, 2703, b'1', 119, '2017-06-06 15:41:00', 119, 2, '2017-06-06 15:41:00', NULL),
(2708, 'MAERSK NIJMEGEN', NULL, 2704, b'1', 118, '2017-06-06 23:27:00', 118, 2, '2017-06-06 23:27:00', NULL),
(2709, 'MAERKS NIJMEGEN', NULL, 2705, b'1', 118, '2017-06-06 23:28:00', 118, 2, '2017-06-06 23:28:00', NULL),
(2710, 'CMA CGM TANYA', NULL, 2706, b'1', 118, '2017-06-13 17:48:00', 118, 2, '2017-06-13 17:48:00', NULL),
(2711, 'ER FELIXSTOWE ', NULL, 2707, b'1', 118, '2017-06-14 16:36:00', 118, 2, '2017-06-14 16:36:00', NULL),
(2712, 'SLS MANZANILLO', NULL, 2708, b'1', 118, '2017-06-16 19:51:00', 118, 2, '2017-06-16 19:51:00', NULL),
(2713, 'OTEA MAERSK', NULL, 2709, b'1', 118, '2017-06-16 20:47:00', 118, 2, '2017-06-16 20:47:00', NULL),
(2714, 'MSC ARBATAX ', NULL, 2710, b'1', 101, '2017-06-20 13:45:00', 101, 2, '2017-06-20 13:45:00', NULL),
(2715, 'ANASSA', NULL, 2711, b'1', 93, '2017-06-20 14:27:00', 93, 2, '2017-06-20 14:27:00', NULL),
(2716, 'SM NEW YORK', NULL, 2712, b'1', 118, '2017-06-21 21:13:00', 118, 2, '2017-06-21 21:13:00', NULL),
(2717, 'SAN CLEMENTE', NULL, 2713, b'1', 118, '2017-06-22 15:19:00', 118, 2, '2017-06-22 15:19:00', NULL),
(2718, 'EVER CHIVALRY', NULL, 2714, b'1', 118, '2017-06-23 18:50:00', 118, 2, '2017-06-23 18:50:00', NULL),
(2719, 'CSCL WINTER', NULL, 2715, b'1', 118, '2017-06-26 13:49:00', 118, 2, '2017-06-26 13:49:00', NULL),
(2720, 'EVER CONQUEST', NULL, 2716, b'1', 118, '2017-06-29 15:19:00', 118, 2, '2017-06-29 15:19:00', NULL),
(2721, 'TIANJIN', NULL, 2717, b'1', 118, '2017-07-03 19:51:00', 118, 2, '2017-07-03 19:51:00', NULL),
(2722, 'CONSTANTIN', NULL, 2718, b'1', 1, '2017-07-06 15:27:00', 1, 2, '2017-07-06 15:27:00', NULL),
(2723, 'CMA CGM MEKONG', NULL, 2719, b'1', 118, '2017-07-13 17:55:00', 118, 2, '2017-07-13 17:55:00', NULL),
(2724, 'HUN JIN QIAO', NULL, 2720, b'1', 118, '2017-07-13 20:44:00', 118, 2, '2017-07-13 20:44:00', NULL),
(2725, 'NTHN JUPITER ', NULL, 2721, b'1', 118, '2017-07-18 19:33:00', 118, 2, '2017-07-18 19:33:00', NULL),
(2726, 'NYK DAEDALUS', NULL, 2722, b'1', 118, '2017-07-19 15:29:00', 118, 2, '2017-07-19 15:29:00', NULL),
(2727, 'GUAYAQUIL EXPRESS', NULL, 2723, b'1', 118, '2017-07-24 23:36:00', 118, 2, '2017-07-24 23:36:00', NULL),
(2728, 'SEDEF', NULL, 2724, b'1', 118, '2017-08-01 13:52:00', 118, 2, '2017-08-01 13:52:00', NULL),
(2729, 'YM WINNER', NULL, 2725, b'1', 118, '2017-08-01 15:11:00', 118, 2, '2017-08-01 15:11:00', NULL),
(2730, 'CMA CGM MISSISSIPPI', NULL, 2726, b'1', 118, '2017-08-01 16:27:00', 118, 2, '2017-08-01 16:27:00', NULL),
(2731, 'EVER LYRIC', NULL, 2727, b'1', 118, '2017-08-01 18:07:00', 118, 2, '2017-08-01 18:07:00', NULL),
(2732, 'CHONGLUNJ', NULL, 2728, b'1', 118, '2017-08-04 22:55:00', 118, 2, '2017-08-04 22:55:00', NULL),
(2733, 'CMA CGM HYDRA', NULL, 2729, b'1', 118, '2017-08-07 14:16:00', 118, 2, '2017-08-07 14:16:00', NULL),
(2734, 'OAKLAND  EXPRESS', NULL, 2730, b'1', 118, '2017-08-07 14:56:00', 118, 2, '2017-08-07 14:58:00', NULL),
(2735, 'PINE VALLEY KON', NULL, 2731, b'1', 118, '2017-08-07 18:08:00', 118, 2, '2017-08-07 18:08:00', NULL),
(2736, 'MARY', NULL, 2732, b'1', 118, '2017-08-09 20:55:00', 118, 2, '2017-08-09 20:55:00', NULL),
(2737, 'DIMITRIS C', NULL, 2733, b'1', 118, '2017-08-16 19:34:00', 118, 2, '2017-08-16 19:34:00', NULL),
(2738, 'ALDEBARAN', NULL, 2734, b'1', 118, '2017-08-16 20:30:00', 118, 2, '2017-08-16 20:30:00', NULL),
(2739, 'CMA CGM TALASSA', NULL, 2735, b'1', 118, '2017-08-21 22:15:00', 118, 2, '2017-08-21 22:15:00', NULL),
(2740, 'CMA CGM MAGDAL', NULL, 2736, b'1', 118, '2017-08-23 20:57:00', 118, 2, '2017-08-23 20:57:00', NULL),
(2741, 'HALIFAX EXPRESS', NULL, 2737, b'1', 118, '2017-08-25 00:01:00', 118, 2, '2017-08-25 00:01:00', NULL),
(2742, 'CMA CGM GANGES', NULL, 2738, b'1', 118, '2017-08-28 22:07:00', 118, 2, '2017-08-28 22:07:00', NULL),
(2743, 'BOMAR RESILIENT', NULL, 2739, b'1', 118, '2017-08-29 21:49:00', 118, 2, '2017-08-29 21:49:00', NULL),
(2744, 'DALLAS EXPRESS', NULL, 2740, b'1', 118, '2017-09-04 16:57:00', 118, 2, '2017-09-04 16:57:00', NULL),
(2745, 'YUE FU LONG', NULL, 2741, b'1', 118, '2017-09-06 20:57:00', 118, 2, '2017-09-06 20:57:00', NULL),
(2746, 'SPIRIT OF LISBON', NULL, 2742, b'1', 118, '2017-09-14 22:48:00', 118, 2, '2017-09-14 22:48:00', NULL),
(2747, 'ER SEOUL', NULL, 2743, b'1', 118, '2017-09-19 13:56:00', 118, 2, '2017-09-19 13:56:00', NULL),
(2748, 'CC COLUMBIA', NULL, 2744, b'1', 118, '2017-09-21 21:25:00', 118, 2, '2017-09-21 21:25:00', NULL),
(2749, 'MAERKS SENANG', NULL, 2745, b'1', 118, '2017-09-21 22:58:00', 118, 2, '2017-09-21 22:58:00', NULL),
(2750, 'HUN GANG TONG', NULL, 2746, b'1', 118, '2017-09-25 22:37:00', 118, 2, '2017-09-25 22:37:00', NULL),
(2751, 'VANTAGE', NULL, 2747, b'1', 118, '2017-09-28 21:38:00', 118, 2, '2017-09-28 21:38:00', NULL),
(2752, 'MAERSK IYO', NULL, 2748, b'1', 93, '2017-09-29 17:33:00', 93, 2, '2017-09-29 17:33:00', NULL),
(2753, 'ITAL CONTESSA', NULL, 2749, b'1', 118, '2017-10-04 00:12:00', 118, 2, '2017-10-04 00:12:00', NULL),
(2754, 'CALLAO EXPRESS', NULL, 2750, b'1', 118, '2017-10-05 17:26:00', 118, 2, '2017-10-05 17:26:00', NULL),
(2755, 'MSC BELLE ', NULL, 2751, b'1', 101, '2017-10-06 14:03:00', 101, 2, '2017-10-06 14:03:00', NULL),
(2756, 'MAERSK GANGES', NULL, 2752, b'1', 118, '2017-10-10 19:27:00', 118, 2, '2017-10-10 19:27:00', NULL),
(2757, 'CC JULES VERNE', NULL, 2753, b'1', 118, '2017-10-10 19:42:00', 118, 2, '2017-10-10 19:42:00', NULL),
(2758, 'EVER UNITED', NULL, 2754, b'1', 118, '2017-10-19 22:15:00', 118, 2, '2017-10-19 22:15:00', NULL),
(2759, 'MOL MOTIVATOR', NULL, 2755, b'1', 118, '2017-10-19 23:04:00', 118, 2, '2017-10-19 23:04:00', NULL),
(2760, 'CONTI DARWIN', NULL, 2756, b'1', 118, '2017-10-25 16:06:00', 118, 2, '2017-10-25 16:06:00', NULL),
(2761, 'ESPERANZA', NULL, 2757, b'1', 118, '2017-10-27 16:20:00', 118, 2, '2017-10-27 16:20:00', NULL),
(2762, 'MSC MICHELA', NULL, 2758, b'1', 118, '2017-10-31 16:59:00', 118, 2, '2017-10-31 16:59:00', NULL),
(2763, 'CC CORTE REAL', NULL, 2759, b'1', 118, '2017-10-31 19:10:00', 118, 2, '2017-10-31 19:10:00', NULL),
(2764, 'RHL CONCORDIA', NULL, 2760, b'1', 118, '2017-11-03 15:55:00', 118, 2, '2017-11-03 15:55:00', NULL),
(2765, 'CAPE PIONEER', NULL, 2761, b'1', 118, '2017-11-03 16:37:00', 118, 2, '2017-11-03 16:37:00', NULL),
(2766, 'K STORM', NULL, 2762, b'1', 101, '2017-11-06 16:58:00', 101, 2, '2017-11-06 16:58:00', NULL),
(2767, 'CSCL VENUS', NULL, 2763, b'1', 118, '2017-11-09 22:22:00', 118, 2, '2017-11-09 22:22:00', NULL),
(2768, 'YUE HONG JI 918 ', NULL, 2764, b'1', 118, '2017-11-09 22:44:00', 118, 2, '2017-11-09 22:44:00', NULL),
(2769, 'CMA CGM OHIO', NULL, 2765, b'1', 118, '2017-11-15 17:42:00', 118, 2, '2017-11-15 17:42:00', NULL),
(2770, 'MOL PARTNER', NULL, 2766, b'1', 118, '2017-11-15 21:06:00', 118, 2, '2017-11-15 21:06:00', NULL),
(2771, 'HUI GANG TONG 07', NULL, 2767, b'1', 131, '2017-11-17 20:38:00', 131, 2, '2017-11-17 20:38:00', NULL),
(2772, 'COSCO ANTWERP', NULL, 2768, b'1', 118, '2017-11-20 16:50:00', 118, 2, '2017-11-20 16:50:00', NULL),
(2773, 'YUE JIN LUN', NULL, 2769, b'1', 118, '2017-11-21 20:29:00', 118, 2, '2017-11-21 20:29:00', NULL),
(2774, 'CMA CGM ATTILA ', NULL, 2770, b'1', 118, '2017-11-23 22:02:00', 118, 2, '2017-11-23 22:02:00', NULL),
(2775, 'FO HANG 903', NULL, 2771, b'1', 118, '2017-12-11 21:09:00', 118, 2, '2017-12-11 21:09:00', NULL),
(2776, 'HENRY HUDSON BRINDGE', NULL, 2772, b'1', 118, '2017-12-12 21:24:00', 118, 2, '2017-12-12 21:24:00', NULL),
(2777, 'SAN ALVARO', NULL, 2773, b'1', 101, '2017-12-15 17:30:00', 101, 2, '2017-12-15 17:30:00', NULL),
(2778, 'ZHONG CHENG 89', NULL, 2774, b'1', 131, '2017-12-19 20:34:00', 131, 2, '2017-12-19 20:34:00', NULL),
(2779, 'LAURA ANN', NULL, 2775, b'1', 118, '2017-12-21 17:42:00', 118, 2, '2017-12-21 17:42:00', NULL),
(2780, 'SANTA LORETA', NULL, 2776, b'1', 118, '2017-12-21 19:48:00', 118, 2, '2017-12-21 19:48:00', NULL),
(2781, 'WAN HAI 162', NULL, 2777, b'1', 131, '2017-12-22 15:17:00', 131, 2, '2017-12-22 15:17:00', NULL),
(2782, 'YM WELCOME', NULL, 2778, b'1', 118, '2017-12-26 17:04:00', 118, 2, '2017-12-26 17:04:00', NULL),
(2783, 'HAMBURG', NULL, 2779, b'1', 118, '2017-12-26 19:27:00', 118, 2, '2017-12-26 19:27:00', NULL),
(2784, 'VALPARAISO EXPRES', NULL, 2780, b'1', 131, '2017-12-27 21:54:00', 131, 2, '2017-12-27 21:54:00', NULL),
(2785, 'SANTA LORETTA', NULL, 2781, b'1', 131, '2017-12-29 17:34:00', 131, 2, '2017-12-29 17:34:00', NULL),
(2786, 'OOCL ATLANTA', NULL, 2782, b'1', 118, '2018-01-04 16:06:00', 118, 2, '2018-01-04 16:06:00', NULL),
(2787, 'EXPRESS BERLIN', NULL, 2783, b'1', 118, '2018-01-08 21:18:00', 118, 2, '2018-01-08 21:18:00', NULL),
(2788, 'MSC CATERINA', NULL, 2784, b'1', 118, '2018-01-16 20:39:00', 118, 2, '2018-01-16 20:39:00', NULL),
(2789, 'MSC PERLE', NULL, 2785, b'1', 118, '2018-01-22 17:30:00', 118, 2, '2018-01-22 17:30:00', NULL),
(2790, 'MSC MARGARITA', NULL, 2786, b'1', 118, '2018-01-22 20:12:00', 118, 2, '2018-01-22 20:12:00', NULL),
(2791, 'CHIQUITA VENTURE', NULL, 2787, b'1', 118, '2018-01-29 19:43:00', 118, 2, '2018-01-29 19:43:00', NULL),
(2792, 'CAP SAN SOUNIO', NULL, 2788, b'1', 118, '2018-02-02 16:59:00', 118, 2, '2018-02-02 16:59:00', NULL),
(2793, 'LI JING', NULL, 2789, b'1', 118, '2018-02-14 17:39:00', 118, 2, '2018-02-14 17:39:00', NULL),
(2794, 'MAERSK WEYMOUNTH', NULL, 2790, b'1', 118, '2018-02-15 22:39:00', 118, 2, '2018-02-15 22:39:00', NULL),
(2795, 'HATSU CRYSTAL', NULL, 2791, b'1', 118, '2018-02-16 15:49:00', 118, 2, '2018-02-16 15:49:00', NULL),
(2796, 'TONG DA', NULL, 2792, b'1', 118, '2018-02-16 16:26:00', 118, 2, '2018-02-16 16:26:00', NULL),
(2797, 'NARITA AIRPORT, JAPAN ', NULL, 2793, b'1', 101, '2018-02-27 17:16:00', 101, 2, '2018-02-27 17:16:00', NULL),
(2798, 'JPO TAURUS ', NULL, 2794, b'1', 118, '2018-02-27 17:16:00', 118, 2, '2018-02-27 17:16:00', NULL),
(2799, 'SHANGQING7HAO', NULL, 2795, b'1', 118, '2018-03-01 17:06:00', 118, 2, '2018-03-01 17:06:00', NULL),
(2800, 'CMA CGM DALILA', NULL, 2796, b'1', 118, '2018-03-01 17:26:00', 118, 2, '2018-03-01 17:26:00', NULL),
(2801, 'NATAL', NULL, 2797, b'1', 118, '2018-03-01 22:04:00', 118, 2, '2018-03-01 22:04:00', NULL),
(2802, 'MSC KATIE', NULL, 2798, b'1', 118, '2018-03-16 15:34:00', 118, 2, '2018-03-16 15:34:00', NULL),
(2803, 'WAN HAI 305', NULL, 2799, b'1', 118, '2018-03-21 16:41:00', 118, 2, '2018-03-21 16:41:00', NULL),
(2804, 'AS VEGA', NULL, 2800, b'1', 101, '2018-04-02 15:35:00', 101, 2, '2018-04-02 15:35:00', NULL),
(2805, 'EVER LIFTING', NULL, 2801, b'1', 118, '2018-04-02 19:19:00', 118, 2, '2018-04-02 19:19:00', NULL),
(2806, 'X-PRESS COTOPAXI ', NULL, 2802, b'1', 101, '2018-04-13 21:13:00', 101, 2, '2018-04-13 21:13:00', NULL),
(2807, 'MAERSK DAKAR', NULL, 2803, b'1', 118, '2018-04-16 15:47:00', 118, 2, '2018-04-16 15:47:00', NULL),
(2808, 'AENEAS', NULL, 2804, b'1', 118, '2018-04-16 16:43:00', 118, 2, '2018-04-16 16:43:00', NULL),
(2809, 'CAP SAN MALEAS', NULL, 2805, b'1', 118, '2018-04-17 21:33:00', 118, 2, '2018-04-17 21:33:00', NULL),
(2810, 'CZECH', NULL, 2806, b'1', 118, '2018-04-17 22:06:00', 118, 2, '2018-04-17 22:06:00', NULL),
(2811, 'MAERSK WILMINGTON', NULL, 2807, b'1', 118, '2018-04-18 22:07:00', 118, 2, '2018-04-18 22:07:00', NULL),
(2812, 'CLAIRE A', NULL, 2808, b'1', 118, '2018-04-23 15:19:00', 118, 2, '2018-04-23 15:19:00', NULL),
(2813, 'MOL BENEFACTOR', NULL, 2809, b'1', 118, '2018-04-23 16:15:00', 118, 2, '2018-04-23 16:15:00', NULL),
(2814, 'MSC MICHAELA', NULL, 2810, b'1', 118, '2018-04-23 16:43:00', 118, 2, '2018-04-23 16:43:00', NULL),
(2815, 'TIGER', NULL, 2811, b'1', 118, '2018-04-24 22:09:00', 118, 2, '2018-04-24 22:09:00', NULL),
(2816, 'MSC CADIZ', NULL, 2812, b'1', 118, '2018-04-25 21:14:00', 118, 2, '2018-04-25 21:14:00', NULL),
(2817, 'FOLEGANDROS ', NULL, 2813, b'1', 118, '2018-04-27 15:46:00', 118, 2, '2018-04-27 15:46:00', NULL),
(2818, 'ALEXANDRA ', NULL, 2814, b'1', 131, '2018-05-02 18:57:00', 131, 2, '2018-05-02 18:57:00', NULL),
(2819, 'COSCO NINGBO', NULL, 2815, b'1', 118, '2018-05-10 14:38:00', 118, 2, '2018-05-10 14:38:00', NULL),
(2820, 'UNI ACTIVE', NULL, 2816, b'1', 118, '2018-05-21 14:10:00', 156, 2, '2020-04-14 17:58:00', NULL),
(2821, 'CARTAGENA EXPRESS', NULL, 2817, b'1', 118, '2018-05-21 17:57:00', 118, 2, '2018-05-21 17:57:00', NULL),
(2822, 'MSC INGY', NULL, 2818, b'1', 118, '2018-05-22 21:34:00', 118, 2, '2018-05-22 21:34:00', NULL),
(2823, 'LLOYD DON PASCUALE', NULL, 2819, b'1', 118, '2018-05-22 22:16:00', 118, 2, '2018-05-22 22:16:00', NULL),
(2824, 'CSCL SAN JOSE ', NULL, 2820, b'1', 101, '2018-05-23 16:49:00', 101, 2, '2018-05-23 16:49:00', NULL),
(2825, 'MSC NATASHA', NULL, 2821, b'1', 118, '2018-05-29 21:22:00', 118, 2, '2018-05-29 21:22:00', NULL),
(2826, 'CHANGXING', NULL, 2822, b'1', 118, '2018-05-29 21:38:00', 118, 2, '2018-05-29 21:38:00', NULL),
(2827, 'MAERSK GUAYAQUIL', NULL, 2823, b'1', 118, '2018-05-29 21:56:00', 118, 2, '2018-05-29 21:56:00', NULL),
(2828, 'ZHU CUAN 2003', NULL, 2824, b'1', 118, '2018-06-05 22:33:00', 118, 2, '2018-06-05 22:33:00', NULL),
(2829, 'ZHU CHUAN 2003', NULL, 2825, b'1', 118, '2018-06-05 22:33:00', 118, 2, '2018-06-05 22:33:00', NULL),
(2830, 'CMA CGM PORT ST LOUIS', NULL, 2826, b'1', 118, '2018-06-05 23:12:00', 118, 2, '2018-06-05 23:12:00', NULL),
(2831, 'MOL BEYOND', NULL, 2827, b'1', 118, '2018-06-08 15:27:00', 118, 2, '2018-06-08 15:27:00', NULL),
(2832, 'E.R. BERLIN', NULL, 2828, b'1', 118, '2018-06-11 19:18:00', 118, 2, '2018-06-11 19:18:00', NULL),
(2833, 'ZIM KINGSTON', NULL, 2829, b'1', 118, '2018-06-12 16:28:00', 118, 2, '2018-06-12 16:28:00', NULL),
(2834, 'KIM KINGSTON', NULL, 2830, b'1', 118, '2018-06-12 16:29:00', 118, 2, '2018-06-12 16:29:00', NULL),
(2835, 'DIAPOROS', NULL, 2831, b'1', 133, '2018-06-12 17:01:00', 133, 2, '2018-06-12 17:01:00', NULL),
(2836, 'COSCO HAMBURG', NULL, 2832, b'1', 118, '2018-06-14 15:53:00', 118, 2, '2018-06-14 15:53:00', NULL),
(2837, 'KURE', NULL, 2833, b'1', 118, '2018-06-14 16:58:00', 118, 2, '2018-06-14 16:58:00', NULL),
(2838, 'BRIGHTON', NULL, 2834, b'1', 118, '2018-06-18 22:24:00', 118, 2, '2018-06-18 22:24:00', NULL),
(2839, 'MATAR N', NULL, 2835, b'1', 118, '2018-06-21 17:25:00', 118, 2, '2018-06-21 17:25:00', NULL),
(2840, 'PARSIFAL', NULL, 2836, b'1', 118, '2018-06-22 14:15:00', 118, 2, '2018-06-22 14:15:00', NULL),
(2841, 'BARTOLOMEU DIAS', NULL, 2837, b'1', 118, '2018-06-22 14:49:00', 118, 2, '2018-06-22 14:49:00', NULL),
(2842, 'KOBE EXPRESS', NULL, 2838, b'1', 118, '2018-06-25 19:56:00', 118, 2, '2018-06-25 19:56:00', NULL),
(2843, 'DERBY D', NULL, 2839, b'1', 118, '2018-06-25 20:54:00', 118, 2, '2018-06-25 20:54:00', NULL),
(2844, 'MOL BRAVO', NULL, 2840, b'1', 118, '2018-06-25 21:04:00', 118, 2, '2018-06-25 21:04:00', NULL),
(2845, 'WAN HAI 310', NULL, 2841, b'1', 118, '2018-06-26 22:04:00', 118, 2, '2018-06-26 22:04:00', NULL),
(2846, 'PEGASUS PRIME', NULL, 2842, b'1', 118, '2018-07-04 16:06:00', 118, 2, '2018-07-04 16:06:00', NULL),
(2847, 'MOL BELLWETHER', NULL, 2843, b'1', 118, '2018-07-04 22:37:00', 118, 2, '2018-07-04 22:37:00', NULL),
(2848, 'AS LEONA', NULL, 2844, b'1', 118, '2018-07-05 19:17:00', 118, 2, '2018-07-05 19:17:00', NULL),
(2849, 'TAMPA TRADER', NULL, 2845, b'1', 93, '2018-07-06 15:03:00', 93, 2, '2018-07-06 15:03:00', NULL),
(2850, 'MARSEILLE MAERSK', NULL, 2846, b'1', 118, '2018-07-10 14:41:00', 118, 2, '2018-07-10 14:41:00', NULL),
(2851, 'MSC AMBITION', NULL, 2847, b'1', 118, '2018-07-10 14:56:00', 118, 2, '2018-07-10 14:56:00', NULL),
(2852, 'NYK NEBULA', NULL, 2848, b'1', 118, '2018-07-10 17:37:00', 118, 2, '2018-07-10 17:37:00', NULL),
(2853, 'AGIOS MINAS ', NULL, 2849, b'1', 133, '2018-07-20 16:28:00', 133, 2, '2018-07-20 16:28:00', NULL),
(2854, 'CMA CGM GEMINI', NULL, 2850, b'1', 118, '2018-07-24 14:24:00', 118, 2, '2018-07-24 14:24:00', NULL),
(2855, 'FO HANG 906', NULL, 2851, b'1', 118, '2018-07-24 15:05:00', 118, 2, '2018-07-24 15:05:00', NULL),
(2856, 'SANTA REGULA', NULL, 2852, b'1', 118, '2018-07-26 16:18:00', 118, 2, '2018-07-26 16:18:00', NULL),
(2857, 'BAO FENG 999', NULL, 2853, b'1', 118, '2018-07-26 17:49:00', 118, 2, '2018-07-26 17:49:00', NULL),
(2858, 'MSC BENEDETTA', NULL, 2854, b'1', 118, '2018-07-26 20:11:00', 118, 2, '2018-07-26 20:11:00', NULL),
(2859, 'AS PETULIA ', NULL, 2855, b'1', 118, '2018-07-27 16:57:00', 142, 2, '2019-06-21 20:57:00', NULL),
(2860, 'SATIE', NULL, 2856, b'1', 101, '2018-07-30 13:51:00', 101, 2, '2018-07-30 13:51:00', NULL),
(2861, 'HAMMONIA SAPPHIRE', NULL, 2857, b'1', 118, '2018-08-07 23:08:00', 118, 2, '2018-08-07 23:08:00', NULL),
(2862, 'AS PAULINA', NULL, 2858, b'1', 118, '2018-08-08 21:45:00', 118, 2, '2018-08-08 21:45:00', NULL),
(2863, 'KOTA SEJARAH', NULL, 2859, b'1', 118, '2018-08-13 21:12:00', 118, 2, '2018-08-13 21:12:00', NULL),
(2864, 'MOL MAJESTY', NULL, 2860, b'1', 118, '2018-08-14 21:51:00', 118, 2, '2018-08-14 21:51:00', NULL),
(2865, 'MIN CHUAN', NULL, 2861, b'1', 118, '2018-08-14 22:05:00', 118, 2, '2018-08-14 22:05:00', NULL),
(2866, 'KOTA CARUM', NULL, 2862, b'1', 118, '2018-08-14 22:19:00', 118, 2, '2018-08-14 22:19:00', NULL),
(2867, 'LIVERPOLL EXPRESS', NULL, 2863, b'1', 118, '2018-08-14 22:41:00', 118, 2, '2018-08-14 22:41:00', NULL),
(2868, 'TRF PESCARA', NULL, 2864, b'1', 118, '2018-08-16 20:16:00', 118, 2, '2018-08-16 20:16:00', NULL),
(2869, 'YONGYUE11', NULL, 2865, b'1', 118, '2018-08-27 15:19:00', 118, 2, '2018-08-27 15:19:00', NULL),
(2870, 'HLS NIKE', NULL, 2866, b'1', 118, '2018-08-28 20:16:00', 118, 2, '2018-08-28 20:16:00', NULL),
(2871, 'HSL NIKE', NULL, 2867, b'1', 118, '2018-08-28 20:16:00', 118, 2, '2018-08-28 20:16:00', NULL),
(2872, 'HONG JING', NULL, 2868, b'1', 118, '2018-08-30 19:25:00', 118, 2, '2018-08-30 19:25:00', NULL),
(2873, 'WAN HAI 303', NULL, 2869, b'1', 118, '2018-09-04 22:32:00', 118, 2, '2018-09-04 22:32:00', NULL),
(2874, 'DOOWOO FAMILY', NULL, 2870, b'1', 118, '2018-09-06 19:07:00', 118, 2, '2018-09-06 19:07:00', NULL),
(2875, 'EVER LUNAR', NULL, 2871, b'1', 118, '2018-09-06 19:36:00', 118, 2, '2018-09-06 19:36:00', NULL),
(2876, 'SKYROS ', NULL, 2872, b'1', 101, '2018-09-06 22:16:00', 101, 2, '2018-09-06 22:16:00', NULL),
(2877, 'IRENES WAVE', NULL, 2873, b'1', 118, '2018-09-06 22:56:00', 118, 2, '2018-09-06 22:56:00', NULL),
(2878, 'LING JING 5', NULL, 2874, b'1', 93, '2018-09-07 14:55:00', 93, 2, '2018-09-07 14:55:00', NULL),
(2879, 'BSL CAPE TOWN', NULL, 2875, b'1', 118, '2018-09-10 16:19:00', 118, 2, '2018-09-10 16:19:00', NULL),
(2880, 'MSC SPAIN', NULL, 2876, b'1', 118, '2018-09-12 23:10:00', 118, 2, '2018-09-12 23:10:00', NULL),
(2881, 'MARKSK SINGAPORE', NULL, 2877, b'1', 118, '2018-09-12 23:47:00', 118, 2, '2018-09-12 23:47:00', NULL),
(2882, 'CMA CGM JEAN GABRIEL', NULL, 2878, b'1', 118, '2018-09-14 14:53:00', 118, 2, '2018-09-14 14:53:00', NULL),
(2883, 'BOMAR RESOLUTE', NULL, 2879, b'1', 131, '2018-09-14 17:04:00', 131, 2, '2018-09-14 17:04:00', NULL),
(2884, 'KOTA HADIAH', NULL, 2880, b'1', 118, '2018-09-18 21:04:00', 118, 2, '2018-09-18 21:04:00', NULL),
(2885, 'COLETTE', NULL, 2881, b'1', 118, '2018-09-20 20:05:00', 118, 2, '2018-09-20 20:05:00', NULL),
(2886, 'MSC MARIA SAVERIA', NULL, 2882, b'1', 118, '2018-09-25 20:05:00', 118, 2, '2018-09-25 20:05:00', NULL),
(2887, 'STELLAR WALVIS  BAY', NULL, 2883, b'1', 118, '2018-09-27 20:16:00', 118, 2, '2018-09-27 20:16:00', NULL),
(2888, 'CAPRICORN ', NULL, 2884, b'1', 118, '2018-09-27 22:32:00', 118, 2, '2018-09-27 22:32:00', NULL),
(2889, 'KOTA CABAR', NULL, 2885, b'1', 118, '2018-10-03 17:15:00', 118, 2, '2018-10-03 17:15:00', NULL),
(2890, 'FU XING DA', NULL, 2886, b'1', 118, '2018-10-09 19:37:00', 118, 2, '2018-10-09 19:37:00', NULL),
(2891, 'MSC RENEE', NULL, 2887, b'1', 118, '2018-10-10 17:26:00', 118, 2, '2018-10-10 17:26:00', NULL),
(2892, 'MAERSK SINGAPORE ', NULL, 2888, b'1', 101, '2018-10-12 16:05:00', 101, 2, '2018-10-12 16:05:00', NULL),
(2893, 'MSC LAUREN', NULL, 2889, b'1', 118, '2018-10-15 17:01:00', 118, 2, '2018-10-15 17:01:00', NULL),
(2894, 'CROWLEY', NULL, 2890, b'1', 118, '2018-10-16 20:45:00', 118, 2, '2018-10-16 20:45:00', NULL),
(2895, 'WAN HAI 509', NULL, 2891, b'1', 118, '2018-10-17 15:25:00', 118, 2, '2018-10-17 15:25:00', NULL),
(2896, 'LUCIE SCHULTE', NULL, 2892, b'1', 118, '2018-10-23 22:31:00', 118, 2, '2018-10-23 22:31:00', NULL),
(2897, 'HYUNDAI HONOUR', NULL, 2893, b'1', 118, '2018-10-23 23:17:00', 118, 2, '2018-10-23 23:17:00', NULL),
(2898, 'EVER BEADY', NULL, 2894, b'1', 118, '2018-11-05 20:44:00', 118, 2, '2018-11-05 20:44:00', NULL),
(2899, 'VIOLETA B', NULL, 2895, b'1', 118, '2018-11-06 21:24:00', 118, 2, '2018-11-06 21:24:00', NULL),
(2900, 'NORDBALTIC', NULL, 2896, b'1', 118, '2018-11-07 17:04:00', 118, 2, '2018-11-07 17:04:00', NULL),
(2901, 'CHANG XING 1668', NULL, 2897, b'1', 118, '2018-11-07 17:36:00', 118, 2, '2018-11-07 17:36:00', NULL),
(2902, 'KOTA HASIL', NULL, 2898, b'1', 118, '2018-11-13 21:54:00', 118, 2, '2018-11-13 21:54:00', NULL),
(2903, 'WAN HAI 613 ', NULL, 2899, b'1', 101, '2018-11-13 23:09:00', 101, 2, '2018-11-13 23:09:00', NULL),
(2904, 'X-PRESS ANNAPURNA', NULL, 2900, b'1', 118, '2018-11-14 23:10:00', 118, 2, '2018-11-14 23:10:00', NULL),
(2905, 'HYUNDAI VICTORY', NULL, 2901, b'1', 118, '2018-11-21 23:06:00', 118, 2, '2018-11-21 23:06:00', NULL),
(2906, 'FANG ZHOU 19', NULL, 2902, b'1', 118, '2018-11-22 19:27:00', 118, 2, '2018-11-22 19:27:00', NULL),
(2907, 'JIANGJIYUN 1263', NULL, 2903, b'1', 118, '2018-11-28 22:24:00', 118, 2, '2018-11-28 22:24:00', NULL),
(2908, 'AUSTRAL', NULL, 2904, b'1', 118, '2018-11-28 23:16:00', 118, 2, '2018-11-28 23:16:00', NULL),
(2909, 'HYUNDAI HOPE', NULL, 2905, b'1', 118, '2018-11-30 16:34:00', 118, 2, '2018-11-30 16:34:00', NULL),
(2910, 'HMM BLESSING', NULL, 2906, b'1', 118, '2018-12-10 19:30:00', 118, 2, '2018-12-10 19:30:00', NULL),
(2911, 'PEARL RIVER BRIDGE', NULL, 2907, b'1', 118, '2018-12-10 23:35:00', 118, 2, '2018-12-10 23:35:00', NULL),
(2912, 'HYUNDAI DREAM', NULL, 2908, b'1', 118, '2018-12-13 17:11:00', 118, 2, '2018-12-13 17:11:00', NULL),
(2913, 'MOL BRIGHTNESS', NULL, 2909, b'1', 118, '2018-12-14 15:11:00', 118, 2, '2018-12-14 15:11:00', NULL),
(2914, 'XIN WING ZHOU', NULL, 2910, b'1', 118, '2018-12-14 15:55:00', 118, 2, '2018-12-14 15:55:00', NULL),
(2915, 'EVER ENVOY', NULL, 2911, b'1', 118, '2018-12-14 16:58:00', 118, 2, '2018-12-14 16:58:00', NULL),
(2916, 'NORDBALTIC 6', NULL, 2912, b'1', 93, '2018-12-20 13:31:00', 93, 2, '2018-12-20 13:31:00', NULL),
(2917, 'KOTA CEPAT', NULL, 2913, b'1', 118, '2018-12-20 21:19:00', 118, 2, '2018-12-20 21:19:00', NULL),
(2918, 'KMTC MANILA', NULL, 2914, b'1', 118, '2018-12-21 14:13:00', 118, 2, '2018-12-21 14:13:00', NULL),
(2919, 'GULBENIZ A/SF', NULL, 2915, b'1', 118, '2018-12-26 19:17:00', 118, 2, '2018-12-26 19:17:00', NULL),
(2920, 'HYUNDAI PRIDE ', NULL, 2916, b'1', 118, '2019-01-02 15:49:00', 118, 2, '2019-01-02 15:49:00', NULL),
(2921, 'NING TONG 938', NULL, 2917, b'1', 118, '2019-01-02 16:43:00', 118, 2, '2019-01-02 16:43:00', NULL),
(2922, 'TAIPINGYANG11', NULL, 2918, b'1', 118, '2019-01-03 17:54:00', 118, 2, '2019-01-03 17:54:00', NULL),
(2923, 'SUI FU HANG 628', NULL, 2919, b'1', 118, '2019-01-11 23:31:00', 118, 2, '2019-01-11 23:31:00', NULL),
(2924, 'MAERSK INVERNESS', NULL, 2920, b'1', 118, '2019-01-16 13:58:00', 118, 2, '2019-01-16 13:58:00', NULL),
(2925, 'FENG DA', NULL, 2921, b'1', 118, '2019-01-18 16:04:00', 118, 2, '2019-01-18 16:04:00', NULL),
(2926, 'CONTI LYON', NULL, 2922, b'1', 118, '2019-01-21 15:20:00', 118, 2, '2019-01-21 15:20:00', NULL),
(2927, 'MSC CRISTINA', NULL, 2923, b'1', 118, '2019-01-21 15:36:00', 118, 2, '2019-01-21 15:36:00', NULL),
(2928, 'MOL BREEZE', NULL, 2924, b'1', 118, '2019-01-22 17:14:00', 118, 2, '2019-01-22 17:14:00', NULL),
(2929, 'CHANGXING1668', NULL, 2925, b'1', 118, '2019-01-22 17:46:00', 118, 2, '2019-01-22 17:46:00', NULL),
(2930, 'XIN OU ZHOU', NULL, 2926, b'1', 118, '2019-01-29 17:31:00', 118, 2, '2019-01-29 17:31:00', NULL),
(2931, 'MAX SCHULTE', NULL, 2927, b'1', 101, '2019-01-31 19:54:00', 101, 2, '2019-01-31 19:54:00', NULL),
(2932, 'SPIRIT OF TOKYO', NULL, 2928, b'1', 118, '2019-02-05 14:18:00', 112, 2, '2019-02-15 15:36:00', NULL),
(2933, 'NYK ATLAS', NULL, 2929, b'1', 118, '2019-02-06 00:07:00', 118, 2, '2019-02-06 00:07:00', NULL),
(2934, 'MAERKS INNOSHIMA', NULL, 2930, b'1', 118, '2019-02-08 20:51:00', 118, 2, '2019-02-08 20:51:00', NULL),
(2935, 'HONOLULU BRIDGE ', NULL, 2931, b'1', 118, '2019-02-12 19:29:00', 118, 2, '2019-02-12 19:29:00', NULL),
(2936, 'NEW YORK TRADER ', NULL, 2932, b'1', 101, '2019-02-19 22:22:00', 101, 2, '2019-02-19 22:22:00', NULL),
(2937, 'NORBALTIC', NULL, 2933, b'1', 118, '2019-02-20 21:27:00', 118, 2, '2019-02-20 21:27:00', NULL),
(2938, 'MSC PAMELA', NULL, 2934, b'1', 118, '2019-02-27 14:57:00', 118, 2, '2019-02-27 14:57:00', NULL),
(2939, 'MSC RUBY', NULL, 2935, b'1', 118, '2019-03-01 21:44:00', 118, 2, '2019-03-01 21:44:00', NULL),
(2940, 'MV KOTA HARTA', NULL, 2936, b'1', 118, '2019-03-05 20:01:00', 118, 2, '2019-03-05 20:01:00', NULL),
(2941, 'MSC NADRIELY', NULL, 2937, b'1', 93, '2019-03-07 13:54:00', 93, 2, '2019-03-07 13:54:00', NULL);
INSERT INTO `barco` (`id_barco`, `nombre`, `bandera`, `idBarco`, `Estado`, `idUsuario`, `fechaIngreso`, `idUsuarioModifica`, `id_sucursal`, `fechamodificacion`, `tipo`) VALUES
(2942, 'CHIQUITA BEACH', NULL, 2938, b'1', 118, '2019-03-07 19:29:00', 118, 2, '2019-03-07 19:29:00', NULL),
(2943, 'CONTI ANNAPURNA', NULL, 2939, b'1', 118, '2019-03-07 20:47:00', 118, 2, '2019-03-07 20:47:00', NULL),
(2944, 'X-PRESS IRAZU', NULL, 2940, b'1', 93, '2019-03-13 19:32:00', 93, 2, '2019-03-13 19:32:00', NULL),
(2945, 'KOTA SEGAR', NULL, 2941, b'1', 118, '2019-03-15 17:32:00', 118, 2, '2019-03-15 17:32:00', NULL),
(2946, 'CMA CGM POINTE', NULL, 2942, b'1', 118, '2019-03-19 20:38:00', 118, 2, '2019-03-19 20:38:00', NULL),
(2947, 'MSC ZLATA R.', NULL, 2943, b'1', 118, '2019-03-20 17:09:00', 118, 2, '2019-03-20 17:09:00', NULL),
(2948, 'XINOU17', NULL, 2944, b'1', 118, '2019-03-22 20:52:00', 118, 2, '2019-03-22 20:52:00', NULL),
(2949, 'CMA CGM POINTE DES COLIBRIS', NULL, 2945, b'1', 93, '2019-03-27 14:41:00', 93, 2, '2019-03-27 14:41:00', NULL),
(2950, 'CHONGLUNJI3012', NULL, 2946, b'1', 93, '2019-04-01 17:48:00', 93, 2, '2019-04-01 17:48:00', NULL),
(2951, 'HAOHANG1006', NULL, 2947, b'1', 118, '2019-04-04 17:42:00', 118, 2, '2019-04-04 17:42:00', NULL),
(2952, 'SPIRIT OF SHANGHAI', NULL, 2948, b'1', 118, '2019-04-11 20:54:00', 118, 2, '2019-04-11 20:54:00', NULL),
(2953, 'AS CLEOPATRA', NULL, 2949, b'1', 142, '2019-04-16 21:51:00', 142, 2, '2019-04-16 21:51:00', NULL),
(2954, 'GH MELTEMI', NULL, 2950, b'1', 118, '2019-04-23 21:02:00', 118, 2, '2019-04-23 21:02:00', NULL),
(2955, 'CC POINTE DES COLIBRIS', NULL, 2951, b'1', 118, '2019-04-23 21:13:00', 118, 2, '2019-04-23 21:13:00', NULL),
(2956, 'KOTA CANTIK', NULL, 2952, b'1', 118, '2019-04-24 20:27:00', 118, 2, '2019-04-24 20:27:00', NULL),
(2957, 'FANG ZOHOU 23', NULL, 2953, b'1', 118, '2019-04-25 16:27:00', 118, 2, '2019-04-25 16:27:00', NULL),
(2958, 'SAN CHRISTOBAL', NULL, 2954, b'1', 118, '2019-04-25 19:20:00', 118, 2, '2019-04-25 19:20:00', NULL),
(2959, 'MSC REGULUS', NULL, 2955, b'1', 118, '2019-05-08 20:19:00', 118, 2, '2019-05-08 20:19:00', NULL),
(2960, 'MOLLY  SCHULTE', NULL, 2956, b'1', 142, '2019-05-09 20:37:00', 142, 2, '2019-05-09 20:37:00', NULL),
(2961, 'MAERSK PUELO', NULL, 2957, b'1', 118, '2019-05-13 15:10:00', 118, 2, '2019-05-13 15:10:00', NULL),
(2962, 'SM TACOMA', NULL, 2958, b'1', 118, '2019-05-22 17:16:00', 118, 2, '2019-05-22 17:16:00', NULL),
(2963, 'XIEHAIMINGZHOU', NULL, 2959, b'1', 118, '2019-05-24 20:22:00', 118, 2, '2019-05-24 20:22:00', NULL),
(2964, 'CATHERINE ', NULL, 2960, b'1', 103, '2019-05-29 20:17:00', 103, 2, '2019-05-29 20:17:00', NULL),
(2965, 'ACX PERL', NULL, 2961, b'1', 103, '2019-06-06 16:28:00', 103, 2, '2019-06-06 16:28:00', NULL),
(2966, 'COSCO ROTEERDAM', NULL, 2962, b'1', 103, '2019-06-12 15:43:00', 103, 2, '2019-06-12 15:43:00', NULL),
(2967, 'XIN PU DONG', NULL, 2963, b'1', 103, '2019-06-14 13:56:00', 103, 2, '2019-06-14 13:56:00', NULL),
(2968, 'KOTA CAHAYA ', NULL, 2964, b'1', 118, '2019-06-26 20:38:00', 118, 2, '2019-06-26 20:38:00', NULL),
(2969, 'MSC SARISKA', NULL, 2965, b'1', 118, '2019-06-28 21:17:00', 118, 2, '2019-06-28 21:17:00', NULL),
(2970, 'MH HAMBURG', NULL, 2966, b'1', 103, '2019-07-03 14:41:00', 103, 2, '2019-07-03 14:41:00', NULL),
(2971, 'TUBUL', NULL, 2967, b'1', 103, '2019-07-03 16:07:00', 103, 2, '2019-07-03 16:07:00', NULL),
(2972, 'KOTA CEMPAKA', NULL, 2968, b'1', 103, '2019-07-03 16:49:00', 103, 2, '2019-07-03 16:49:00', NULL),
(2973, 'SEASPAN BRAVO', NULL, 2969, b'1', 103, '2019-07-03 20:34:00', 103, 2, '2019-07-03 20:34:00', NULL),
(2974, 'PUCON', NULL, 2970, b'1', 103, '2019-07-11 15:45:00', 103, 2, '2019-07-11 15:45:00', NULL),
(2975, 'CHIQUITA TRADER', NULL, 2971, b'1', 118, '2019-07-16 19:44:00', 118, 2, '2019-07-16 19:44:00', NULL),
(2976, 'LAURA MAERSK', NULL, 2972, b'1', 118, '2019-07-31 20:58:00', 118, 2, '2019-07-31 20:58:00', NULL),
(2977, 'CONTSHIP NEW', NULL, 2973, b'1', 142, '2019-08-01 21:23:00', 142, 2, '2019-08-01 21:23:00', NULL),
(2978, 'BERNHARD SCHULTE ', NULL, 2974, b'1', 142, '2019-08-02 22:17:00', 142, 2, '2019-08-02 22:19:00', NULL),
(2979, 'NAUTIC TWIN', NULL, 2975, b'1', 103, '2019-08-06 14:28:00', 103, 2, '2019-08-06 14:28:00', NULL),
(2980, 'YI HANG 668', NULL, 2976, b'1', 103, '2019-08-06 17:09:00', 103, 2, '2019-08-06 17:09:00', NULL),
(2981, 'APL LION CITY', NULL, 2977, b'1', 103, '2019-08-07 16:53:00', 103, 2, '2019-08-07 16:53:00', NULL),
(2982, 'HAMBURG TRADER ', NULL, 2978, b'1', 142, '2019-08-07 17:57:00', 142, 2, '2019-08-07 17:57:00', NULL),
(2983, 'JIAN GONG 238', NULL, 2979, b'1', 152, '2019-08-08 18:31:00', 152, 2, '2019-08-08 18:31:00', NULL),
(2984, 'ANTWERP TRADER', NULL, 2980, b'1', 142, '2019-08-16 20:21:00', 142, 2, '2019-08-16 20:21:00', NULL),
(2985, 'MCS SOLA', NULL, 2981, b'1', 103, '2019-08-20 15:12:00', 103, 2, '2019-08-20 15:12:00', NULL),
(2986, 'MSC SOLA', NULL, 2982, b'1', 103, '2019-08-20 15:13:00', 103, 2, '2019-08-20 15:13:00', NULL),
(2987, 'BOMAR PRAIA', NULL, 2983, b'1', 103, '2019-08-20 15:22:00', 103, 2, '2019-08-20 15:22:00', NULL),
(2988, 'CMA CGM SALINAS', NULL, 2984, b'1', 142, '2019-08-21 15:50:00', 142, 2, '2019-08-21 15:50:00', NULL),
(2989, 'CMA CGM JACQUES JOSEPH ', NULL, 2985, b'1', 155, '2019-08-26 19:41:00', 155, 2, '2019-08-26 19:41:00', NULL),
(2990, 'BOMAR VICTORY', NULL, 2986, b'1', 103, '2019-08-29 16:12:00', 103, 2, '2019-08-29 16:12:00', NULL),
(2991, 'CONTI COURAGE', NULL, 2987, b'1', 103, '2019-09-02 17:12:00', 103, 2, '2019-09-02 17:12:00', NULL),
(2992, 'RACHA BHUM', NULL, 2988, b'1', 118, '2019-09-09 20:34:00', 118, 2, '2019-09-09 20:34:00', NULL),
(2993, 'GABRIELLE', NULL, 2989, b'1', 103, '2019-09-09 22:05:00', 103, 2, '2019-09-09 22:05:00', NULL),
(2994, 'MSC YASHI', NULL, 2990, b'1', 103, '2019-09-16 20:14:00', 103, 2, '2019-09-16 20:14:00', NULL),
(2995, 'SEADREAM ', NULL, 2991, b'1', 103, '2019-09-26 22:17:00', 103, 2, '2019-09-26 22:17:00', NULL),
(2996, 'NORDISABELLA', NULL, 2992, b'1', 142, '2019-09-27 14:24:00', 142, 2, '2019-09-27 14:24:00', NULL),
(2997, 'MSC SORAYA', NULL, 2993, b'1', 103, '2019-09-30 20:12:00', 103, 2, '2019-09-30 20:12:00', NULL),
(2998, 'GENOVA', NULL, 2994, b'1', 103, '2019-09-30 21:05:00', 103, 2, '2019-09-30 21:05:00', NULL),
(2999, 'ACTUARIA', NULL, 2995, b'1', 103, '2019-09-30 21:35:00', 103, 2, '2019-09-30 21:35:00', NULL),
(3000, 'MSC SHREYA', NULL, 2996, b'1', 103, '2019-10-01 16:54:00', 103, 2, '2019-10-01 16:54:00', NULL),
(3001, 'GUARAN F', NULL, 2997, b'1', 103, '2019-10-03 19:58:00', 103, 2, '2019-10-03 19:58:00', NULL),
(3002, 'GUARAN F 504', NULL, 2998, b'1', 155, '2019-10-07 18:57:00', 155, 2, '2019-10-07 18:57:00', NULL),
(3003, 'SINAR SOLO', NULL, 2999, b'1', 103, '2019-10-11 23:38:00', 103, 2, '2019-10-11 23:38:00', NULL),
(3004, 'HUI HONG 803', NULL, 3000, b'1', 118, '2019-10-18 14:34:00', 118, 2, '2019-10-18 14:34:00', NULL),
(3005, 'ZHI HANG 007', NULL, 3001, b'1', 118, '2019-10-18 14:42:00', 118, 2, '2019-10-18 14:42:00', NULL),
(3006, 'AS FABIANA', NULL, 3002, b'1', 142, '2019-10-18 16:49:00', 142, 2, '2019-10-18 16:49:00', NULL),
(3007, 'ZARAGOZA', NULL, 3003, b'1', 103, '2019-10-18 22:36:00', 103, 2, '2019-10-18 22:36:00', NULL),
(3008, 'MSC AMERICA', NULL, 3004, b'1', 103, '2019-10-22 17:04:00', 103, 2, '2019-10-22 17:04:00', NULL),
(3009, 'MSC DAMLA', NULL, 3005, b'1', 103, '2019-10-22 17:36:00', 103, 2, '2019-10-22 17:36:00', NULL),
(3010, 'LOS ANGELES TRADER', NULL, 3006, b'1', 103, '2019-10-23 15:07:00', 103, 2, '2019-10-23 15:07:00', NULL),
(3011, 'WARNOW BELUGA', NULL, 3007, b'1', 155, '2019-10-23 18:53:00', 155, 2, '2019-10-23 18:53:00', NULL),
(3012, 'SUI HAI YUN 698', NULL, 3008, b'1', 118, '2019-10-28 15:30:00', 118, 2, '2019-10-28 15:30:00', NULL),
(3013, 'ZHI HANG 58', NULL, 3009, b'1', 118, '2019-10-30 15:36:00', 118, 2, '2019-10-30 15:36:00', NULL),
(3014, 'MSC FAITH', NULL, 3010, b'1', 118, '2019-10-30 16:07:00', 118, 2, '2019-10-30 16:07:00', NULL),
(3015, 'MSC ELISA', NULL, 3011, b'1', 118, '2019-11-04 22:29:00', 118, 2, '2019-11-04 22:29:00', NULL),
(3016, 'CLEMENS SCHULTE', NULL, 3012, b'1', 103, '2019-11-05 17:00:00', 103, 2, '2019-11-05 17:00:00', NULL),
(3017, 'LONG BEACH', NULL, 3013, b'1', 103, '2019-11-07 17:10:00', 103, 2, '2019-11-07 17:10:00', NULL),
(3018, 'SKIATHOS', NULL, 3014, b'1', 103, '2019-11-08 14:46:00', 103, 2, '2019-11-08 14:46:00', NULL),
(3019, 'TORRENTE', NULL, 3015, b'1', 118, '2019-11-12 14:46:00', 118, 2, '2019-11-12 14:46:00', NULL),
(3020, 'MSC GAYANE', NULL, 3016, b'1', 118, '2019-11-12 15:08:00', 118, 2, '2019-11-12 15:08:00', NULL),
(3021, 'MSC MAGAYANE', NULL, 3017, b'1', 118, '2019-11-12 15:09:00', 118, 2, '2019-11-12 15:09:00', NULL),
(3022, 'MSC METHONI', NULL, 3018, b'1', 118, '2019-11-13 17:15:00', 118, 2, '2019-11-13 17:15:00', NULL),
(3023, 'IRENES ROSE', NULL, 3019, b'1', 118, '2019-11-13 22:03:00', 118, 2, '2019-11-13 22:03:00', NULL),
(3024, 'EVER ULYSSES', NULL, 3020, b'1', 118, '2019-11-14 13:50:00', 118, 2, '2019-11-14 13:50:00', NULL),
(3025, 'ZHEN DONG 993', NULL, 3021, b'1', 118, '2019-11-14 16:55:00', 118, 2, '2019-11-14 16:55:00', NULL),
(3026, 'LICA MAERSK', NULL, 3022, b'1', 103, '2019-11-15 16:36:00', 103, 2, '2019-11-15 16:36:00', NULL),
(3027, 'EVER PEARL', NULL, 3023, b'1', 103, '2019-11-18 21:42:00', 103, 2, '2019-11-18 21:42:00', NULL),
(3028, 'CALAIS TRADER', NULL, 3024, b'1', 103, '2019-11-28 17:02:00', 103, 2, '2019-11-28 17:02:00', NULL),
(3029, 'COSCO HAIFA', NULL, 3025, b'1', 103, '2019-11-28 20:05:00', 103, 2, '2019-11-28 20:05:00', NULL),
(3030, 'MAERSK BERMUDA', NULL, 3026, b'1', 142, '2019-12-03 18:40:00', 142, 2, '2019-12-03 18:40:00', NULL),
(3031, 'MV CAPE FLORES', NULL, 3027, b'1', 103, '2019-12-03 21:19:00', 103, 2, '2019-12-03 21:19:00', NULL),
(3032, 'COSCO SHIPPING', NULL, 3028, b'1', 103, '2019-12-05 18:01:00', 103, 2, '2019-12-05 18:01:00', NULL),
(3033, 'GREEN CLARITY', NULL, 3029, b'1', 103, '2019-12-05 21:34:00', 103, 2, '2019-12-05 21:34:00', NULL),
(3034, 'MSC ALGHERO', NULL, 3030, b'1', 103, '2019-12-05 22:00:00', 103, 2, '2019-12-05 22:00:00', NULL),
(3035, 'ZHU CHUAN 2005', NULL, 3031, b'1', 103, '2019-12-11 17:27:00', 103, 2, '2019-12-11 17:27:00', NULL),
(3036, 'TUTICORIN', NULL, 3032, b'1', 103, '2019-12-11 17:49:00', 103, 2, '2019-12-11 17:49:00', NULL),
(3037, 'CAPE NEMO', NULL, 3033, b'1', 103, '2019-12-11 17:49:00', 103, 2, '2019-12-11 17:49:00', NULL),
(3038, 'COCL AMERICA', NULL, 3034, b'1', 103, '2019-12-16 22:12:00', 103, 2, '2019-12-16 22:12:00', NULL),
(3039, 'LAUST MAERKS', NULL, 3035, b'1', 103, '2019-12-19 20:49:00', 103, 2, '2019-12-19 20:49:00', NULL),
(3040, 'XINDE KEELUNG', NULL, 3036, b'1', 118, '2019-12-20 15:10:00', 118, 2, '2019-12-20 15:10:00', NULL),
(3041, 'HONG AN TAI 333', NULL, 3037, b'1', 118, '2019-12-20 15:19:00', 118, 2, '2019-12-20 15:19:00', NULL),
(3042, 'COSCO SHIPPING DANUBE', NULL, 3038, b'1', 155, '2019-12-30 17:48:00', 155, 2, '2019-12-30 17:48:00', NULL),
(3043, 'CALYPSO', NULL, 3039, b'1', 155, '2020-01-06 15:28:00', 155, 2, '2020-01-06 15:28:00', NULL),
(3044, 'YM WONDROUS', NULL, 3040, b'1', 103, '2020-01-08 16:58:00', 103, 2, '2020-01-08 16:58:00', NULL),
(3045, 'MSC ALTAIR', NULL, 3041, b'1', 103, '2020-01-08 18:00:00', 103, 2, '2020-01-08 18:00:00', NULL),
(3046, 'MSC MARGRIT', NULL, 3042, b'1', 103, '2020-01-08 22:07:00', 103, 2, '2020-01-08 22:07:00', NULL),
(3047, 'YM WREATH', NULL, 3043, b'1', 103, '2020-01-09 15:19:00', 103, 2, '2020-01-09 15:19:00', NULL),
(3048, 'TOLTEN', NULL, 3044, b'1', 103, '2020-01-13 21:26:00', 103, 2, '2020-01-13 21:26:00', NULL),
(3049, 'MSC MADRID', NULL, 3045, b'1', 103, '2020-01-20 22:01:00', 103, 2, '2020-01-20 22:01:00', NULL),
(3050, 'LUNA MAERKS', NULL, 3046, b'1', 103, '2020-01-21 13:38:00', 103, 2, '2020-01-21 13:38:00', NULL),
(3051, 'OOCL EGYPT', NULL, 3047, b'1', 103, '2020-01-21 17:27:00', 103, 2, '2020-01-21 17:27:00', NULL),
(3052, 'JIN HUI', NULL, 3048, b'1', 103, '2020-01-23 21:59:00', 103, 2, '2020-01-23 21:59:00', NULL),
(3053, 'LONG BEACH TRADER', NULL, 3049, b'1', 155, '2020-02-03 14:13:00', 155, 2, '2020-02-03 14:13:00', NULL),
(3054, 'MV SINAR BALI', NULL, 3050, b'1', 103, '2020-02-04 15:55:00', 103, 2, '2020-02-04 15:55:00', NULL),
(3055, 'LETAVIA', NULL, 3051, b'1', 118, '2020-02-07 21:51:00', 118, 2, '2020-02-07 21:51:00', NULL),
(3056, 'MSC MARS', NULL, 3052, b'1', 103, '2020-02-13 22:33:00', 103, 2, '2020-02-13 22:33:00', NULL),
(3057, 'YM WINDOW', NULL, 3053, b'1', 103, '2020-02-21 23:15:00', 103, 2, '2020-02-21 23:15:00', NULL),
(3058, 'MOL EMISSARY', NULL, 3054, b'1', 103, '2020-02-24 15:00:00', 103, 2, '2020-02-24 15:00:00', NULL),
(3059, 'HUMEN BRIDGE', NULL, 3055, b'1', 24, '2020-03-02 18:13:00', 24, 2, '2020-03-02 18:13:00', NULL),
(3060, 'WAN HAI 172', NULL, 3056, b'1', 103, '2020-03-04 15:06:00', 103, 2, '2020-03-04 15:06:00', NULL),
(3061, 'TUCAPEL', NULL, 3057, b'1', 103, '2020-03-04 15:56:00', 103, 2, '2020-03-04 15:56:00', NULL),
(3062, 'TEMPANOS', NULL, 3058, b'1', 103, '2020-03-04 16:13:00', 103, 2, '2020-03-04 16:13:00', NULL),
(3063, 'SINAR BALI', NULL, 3059, b'1', 103, '2020-03-05 17:13:00', 103, 2, '2020-03-05 17:13:00', NULL),
(3064, 'MSC ALIYA', NULL, 3060, b'1', 103, '2020-03-05 18:01:00', 103, 2, '2020-03-05 18:01:00', NULL),
(3065, 'GALANI', NULL, 3061, b'1', 156, '2020-03-06 14:31:00', 156, 2, '2020-03-06 14:31:00', NULL),
(3066, 'HONG TAI', NULL, 3062, b'1', 103, '2020-03-09 20:17:00', 103, 2, '2020-03-09 20:17:00', NULL),
(3067, 'YUE HUA XUN', NULL, 3063, b'1', 103, '2020-03-10 21:00:00', 103, 2, '2020-03-10 21:00:00', NULL),
(3068, 'YUE HUA XUN 28 HAO', NULL, 3064, b'1', 103, '2020-03-10 21:01:00', 103, 2, '2020-03-10 21:01:00', NULL),
(3069, 'MAERSK BROOKLYN', NULL, 3065, b'1', 103, '2020-03-16 17:39:00', 103, 2, '2020-03-16 17:39:00', NULL),
(3070, 'NADJA', NULL, 3066, b'1', 24, '2020-03-26 16:22:00', 24, 2, '2020-03-26 16:22:00', NULL),
(3071, 'RONJIANG012', NULL, 3067, b'1', 103, '2020-03-27 17:58:00', 103, 2, '2020-03-27 17:58:00', NULL),
(3072, 'EVER LIVING', NULL, 3068, b'1', 103, '2020-03-27 21:05:00', 103, 2, '2020-03-27 21:05:00', NULL),
(3073, 'WINNER', NULL, 3069, b'1', 103, '2020-03-30 17:15:00', 103, 2, '2020-03-30 17:15:00', NULL),
(3074, 'SAFMARINE BAYETE', NULL, 3070, b'1', 103, '2020-03-31 17:18:00', 103, 2, '2020-03-31 17:18:00', NULL),
(3075, 'JENNIFER SCHEPERS', NULL, 3071, b'1', 155, '2020-03-31 19:50:00', 155, 2, '2020-03-31 19:50:00', NULL),
(3076, 'FO SHAN 7 HAO', NULL, 3072, b'1', 103, '2020-03-31 23:52:00', 103, 2, '2020-03-31 23:52:00', NULL),
(3077, 'RHODOS ', NULL, 3073, b'1', 103, '2020-04-01 23:31:00', 103, 2, '2020-04-01 23:31:00', NULL),
(3078, 'MARGARETE SCHULTE ', NULL, 3074, b'1', 155, '2020-04-03 14:43:00', 155, 2, '2020-04-03 14:43:00', NULL),
(3079, 'MAERSK NEWCASTLE', NULL, 3075, b'1', 103, '2020-04-07 00:55:00', 103, 2, '2020-04-07 00:55:00', NULL),
(3080, 'MAERSK NORTHAMPTON', NULL, 3076, b'1', 155, '2020-04-08 12:35:00', 155, 2, '2020-04-08 12:35:00', NULL),
(3081, 'CMA CGM TUTICORIN', NULL, 3077, b'1', 103, '2020-04-24 18:49:00', 103, 2, '2020-04-24 18:49:00', NULL),
(3082, 'RONG HANG 558', NULL, 3078, b'1', 103, '2020-04-28 00:21:00', 103, 2, '2020-04-28 00:21:00', NULL),
(3083, 'WIKING', NULL, 3079, b'1', 103, '2020-04-28 22:33:00', 103, 2, '2020-04-28 22:33:00', NULL),
(3084, 'YM WORLD ', NULL, 3080, b'1', 103, '2020-05-05 23:44:00', 103, 2, '2020-05-05 23:44:00', NULL),
(3085, 'AGAMEMNON', NULL, 3081, b'1', 103, '2020-05-07 22:47:00', 103, 2, '2020-05-07 22:47:00', NULL),
(3086, 'MP THE EDELMAN', NULL, 3082, b'1', 103, '2020-05-13 19:29:00', 103, 2, '2020-05-13 19:29:00', NULL),
(3087, 'MSC KANOKO', NULL, 3083, b'1', 103, '2020-05-13 19:42:00', 103, 2, '2020-05-13 19:42:00', NULL),
(3088, 'GREEN STAR', NULL, 3084, b'1', 142, '2020-05-16 17:03:00', 142, 2, '2020-05-16 17:03:00', NULL),
(3089, 'GREEN FOREST', NULL, 3085, b'1', 142, '2020-05-21 02:32:00', 142, 2, '2020-05-21 02:32:00', NULL),
(3090, 'YUE AN YUN 33', NULL, 3086, b'1', 103, '2020-05-21 16:07:00', 103, 2, '2020-05-21 16:07:00', NULL),
(3091, 'CMA CGM ESTELLE', NULL, 3087, b'1', 103, '2020-05-21 17:30:00', 103, 2, '2020-05-21 17:30:00', NULL),
(3092, 'MERIDIAN', NULL, 3088, b'1', 103, '2020-05-22 16:23:00', 103, 2, '2020-05-22 16:23:00', NULL),
(3093, 'GLOVIS SUNRISE', NULL, 3089, b'1', 103, '2020-05-22 16:41:00', 103, 2, '2020-05-22 16:41:00', NULL),
(3094, 'MSC BHAVYA', NULL, 3090, b'1', 103, '2020-05-26 18:46:00', 103, 2, '2020-05-26 18:46:00', NULL),
(3095, 'BALTIC SOUTH', NULL, 3091, b'1', 103, '2020-05-26 19:04:00', 103, 2, '2020-05-26 19:04:00', NULL),
(3096, 'NORTHERN PRACTISE', NULL, 3092, b'1', 103, '2020-05-26 23:24:00', 103, 2, '2020-05-26 23:24:00', NULL),
(3097, 'GALLOWAY', NULL, 3093, b'1', 103, '2020-05-29 18:00:00', 103, 2, '2020-05-29 18:00:00', NULL),
(3098, 'ULSAN EXPRESS ', NULL, 3094, b'1', 103, '2020-06-03 17:59:00', 103, 2, '2020-06-03 17:59:00', NULL),
(3099, 'MINPING929', NULL, 3095, b'1', 103, '2020-06-03 22:10:00', 103, 2, '2020-06-03 22:10:00', NULL),
(3100, 'ONE HONOLULU ', NULL, 3096, b'1', 103, '2020-06-04 17:11:00', 103, 2, '2020-06-04 17:11:00', NULL),
(3101, 'YM WISH', NULL, 3097, b'1', 103, '2020-06-11 23:01:00', 103, 2, '2020-06-11 23:01:00', NULL),
(3102, 'SEASPAN BELIEF', NULL, 3098, b'1', 103, '2020-06-16 21:14:00', 103, 2, '2020-06-16 21:14:00', NULL),
(3103, 'VALIANT', NULL, 3099, b'1', 103, '2020-06-17 19:23:00', 103, 2, '2020-06-17 19:23:00', NULL),
(3104, 'JOSE', NULL, 3100, b'1', 103, '2020-07-06 19:48:00', 103, 2, '2020-07-06 19:48:00', NULL),
(3105, 'TSINGTAO EXPRESS', NULL, 3101, b'1', 103, '2020-07-07 14:01:00', 103, 2, '2020-07-07 14:01:00', NULL),
(3106, 'MAERSK YANGTZE ', NULL, 3102, b'1', 103, '2020-07-16 16:45:00', 103, 2, '2020-07-16 16:45:00', NULL),
(3107, 'CADIF', NULL, 3103, b'1', 103, '2020-07-22 03:53:00', 103, 2, '2020-07-22 03:53:00', NULL),
(3108, 'CREENCIA SEASPAN', NULL, 3104, b'1', 155, '2020-07-23 15:56:00', 155, 2, '2020-07-23 15:56:00', NULL),
(3109, 'EVER LEGANCY', NULL, 3105, b'1', 103, '2020-07-30 21:58:00', 103, 2, '2020-07-30 21:58:00', NULL),
(3110, 'EVER LEGACY', NULL, 3106, b'1', 155, '2020-07-31 21:42:00', 155, 2, '2020-07-31 21:42:00', NULL),
(3111, 'KOTA LANGSAR', NULL, 3107, b'1', 103, '2020-08-03 16:20:00', 103, 2, '2020-08-03 16:20:00', NULL),
(3112, 'VALOR ', NULL, 3108, b'1', 103, '2020-08-04 18:49:00', 103, 2, '2020-08-04 18:49:00', NULL),
(3113, 'EVER LIVELY', NULL, 3109, b'1', 103, '2020-08-04 19:12:00', 103, 2, '2020-08-04 19:12:00', NULL),
(3114, 'VALUE', NULL, 3110, b'1', 103, '2020-08-04 21:12:00', 103, 2, '2020-08-04 21:12:00', NULL),
(3115, 'SEASPAN BEAUTY ', NULL, 3111, b'1', 103, '2020-08-11 16:18:00', 103, 2, '2020-08-11 16:18:00', NULL),
(3116, 'MAERSK BUTON', NULL, 3112, b'1', 103, '2020-08-12 19:07:00', 103, 2, '2020-08-12 19:07:00', NULL),
(3117, 'PUENTE DE SAN FRANCISCO', NULL, 3113, b'1', 155, '2020-08-13 21:08:00', 155, 2, '2020-08-13 21:08:00', NULL),
(3118, 'MSC JEWEL', NULL, 3114, b'1', 103, '2020-08-20 14:38:00', 103, 2, '2020-08-20 14:38:00', NULL),
(3119, 'EVER ELITE ', NULL, 3115, b'1', 103, '2020-08-20 16:00:00', 103, 2, '2020-08-20 16:00:00', NULL),
(3120, 'MED SAMSUN', NULL, 3116, b'1', 103, '2020-08-21 18:29:00', 103, 2, '2020-08-21 18:29:00', NULL),
(3121, 'AS FAUSTINA', NULL, 3117, b'1', 142, '2020-08-25 15:13:00', 142, 2, '2020-08-25 15:13:00', NULL),
(3122, 'HYUNDAI SHANGHAI', NULL, 3118, b'1', 103, '2020-08-26 00:38:00', 103, 2, '2020-08-26 00:38:00', NULL),
(3123, 'CROATIA', NULL, 3119, b'1', 103, '2020-08-28 16:57:00', 103, 2, '2020-08-28 16:57:00', NULL),
(3124, 'EVER UTILE', NULL, 3120, b'1', 103, '2020-08-28 18:26:00', 103, 2, '2020-08-28 18:26:00', NULL),
(3125, 'AS PETRA', NULL, 3121, b'1', 155, '2020-08-28 20:03:00', 155, 2, '2020-08-28 20:03:00', NULL),
(3126, 'SEASPAN CALICANTO', NULL, 3122, b'1', 103, '2020-09-04 00:51:00', 103, 2, '2020-09-04 00:51:00', NULL),
(3127, 'MSC ASYA', NULL, 3123, b'1', 103, '2020-09-04 16:05:00', 103, 2, '2020-09-04 16:05:00', NULL),
(3128, 'SINE A', NULL, 3124, b'1', 103, '2020-09-04 19:23:00', 103, 2, '2020-09-04 19:23:00', NULL),
(3129, 'YM WORTH', NULL, 3125, b'1', 103, '2020-09-09 03:21:00', 103, 2, '2020-09-09 03:21:00', NULL),
(3130, 'MSC VEGA', NULL, 3126, b'1', 103, '2020-09-17 22:16:00', 103, 2, '2020-09-17 22:16:00', NULL),
(3131, 'BREVIK BRIDGE', NULL, 3127, b'1', 103, '2020-09-21 22:12:00', 103, 2, '2020-09-21 22:12:00', NULL),
(3132, 'HOUDE8', NULL, 3128, b'1', 103, '2020-10-13 23:04:00', 103, 2, '2020-10-13 23:04:00', NULL),
(3133, 'TERPORT', NULL, 3129, b'1', 103, '2020-10-16 23:02:00', 103, 2, '2020-10-16 23:02:00', NULL),
(3134, 'ODYSSEUS', NULL, 3130, b'1', 103, '2020-10-16 23:17:00', 103, 2, '2020-10-16 23:17:00', NULL),
(3135, 'CAP ANDREAS', NULL, 3131, b'1', 142, '2020-10-19 15:19:00', 142, 2, '2020-10-19 15:19:00', NULL),
(3136, 'ALEXIS', NULL, 3132, b'1', 103, '2020-10-22 22:24:00', 103, 2, '2020-10-22 22:24:00', NULL),
(3137, 'MSC KATRINA', NULL, 3133, b'1', 103, '2020-10-23 14:17:00', 103, 2, '2020-10-23 14:17:00', NULL),
(3138, 'COSCO SHANGHAI', NULL, 3134, b'1', 103, '2020-10-26 16:55:00', 103, 2, '2020-10-26 16:55:00', NULL),
(3139, 'SONGA NUERNBERG', NULL, 3135, b'1', 103, '2020-10-27 21:16:00', 103, 2, '2020-10-27 21:16:00', NULL),
(3140, 'VADO LIGURE', NULL, 3136, b'1', 103, '2020-10-27 22:04:00', 103, 2, '2020-10-27 22:04:00', NULL),
(3141, 'SAINT LOUIS', NULL, 3137, b'1', 103, '2020-10-28 18:26:00', 103, 2, '2020-10-28 18:26:00', NULL),
(3142, 'POLAR BRASIL', NULL, 3138, b'1', 103, '2020-11-05 18:18:00', 103, 2, '2020-11-05 18:18:00', NULL),
(3143, 'XING HANG', NULL, 3139, b'1', 103, '2020-11-05 19:38:00', 103, 2, '2020-11-05 19:38:00', NULL),
(3144, 'MSC TOPAZ', NULL, 3140, b'1', 103, '2020-11-05 22:55:00', 103, 2, '2020-11-05 22:55:00', NULL),
(3145, 'Vessel, Containerized', NULL, 3141, b'1', 103, '2020-11-06 19:09:00', 103, 2, '2020-11-06 19:09:00', NULL),
(3146, 'MOL BEACON', NULL, 3142, b'1', 103, '2020-11-09 15:11:00', 103, 2, '2020-11-09 15:11:00', NULL),
(3147, 'ACX DIAMON', NULL, 3143, b'1', 103, '2020-11-09 15:55:00', 103, 2, '2020-11-09 15:55:00', NULL),
(3148, 'SEASPAN BELLWETHER', NULL, 3144, b'1', 103, '2020-11-09 16:11:00', 103, 2, '2020-11-09 16:11:00', NULL),
(3149, 'HMM BENDICION', NULL, 3145, b'1', 155, '2020-11-09 18:22:00', 155, 2, '2020-11-09 18:22:00', NULL),
(3150, 'COSCO ASHDOD ', NULL, 3146, b'1', 103, '2020-11-11 22:23:00', 103, 2, '2020-11-11 22:23:00', NULL),
(3151, 'FALMOUTH', NULL, 3147, b'1', 142, '2020-11-13 15:26:00', 142, 2, '2020-11-13 15:26:00', NULL),
(3152, 'JIANGMEN', NULL, 3148, b'1', 103, '2020-11-16 21:06:00', 103, 2, '2020-11-16 21:06:00', NULL),
(3153, 'DANIELLA', NULL, 3149, b'1', 103, '2020-11-16 21:07:00', 103, 2, '2020-11-16 21:07:00', NULL),
(3154, 'SUI DE YANG 288', NULL, 3150, b'1', 103, '2020-11-16 22:08:00', 103, 2, '2020-11-16 22:08:00', NULL),
(3155, 'K STORM/', NULL, 3151, b'1', 103, '2020-11-17 23:00:00', 103, 2, '2020-11-17 23:00:00', NULL),
(3156, 'NAXOS', NULL, 3152, b'1', 103, '2020-11-21 22:18:00', 103, 2, '2020-11-21 22:18:00', NULL),
(3157, 'MAERSK NESTON', NULL, 3153, b'1', 142, '2020-11-23 18:30:00', 142, 2, '2020-11-23 18:30:00', NULL),
(3158, 'ACX DIAMOND', NULL, 3154, b'1', 103, '2020-11-25 19:11:00', 103, 2, '2020-11-25 19:11:00', NULL),
(3159, 'HUA CHANG HAI', NULL, 3155, b'1', 103, '2020-11-25 19:31:00', 103, 2, '2020-11-25 19:31:00', NULL),
(3160, 'AS FABRIZIA', NULL, 3156, b'1', 155, '2020-12-01 15:51:00', 155, 2, '2020-12-01 15:51:00', NULL),
(3161, 'HSL SHEFFIELD', NULL, 3157, b'1', 103, '2020-12-01 17:29:00', 103, 2, '2020-12-01 17:29:00', NULL),
(3162, 'Containerized', NULL, 3158, b'1', 103, '2020-12-03 21:40:00', 103, 2, '2020-12-03 21:40:00', NULL),
(3163, 'BF LETICIA', NULL, 3159, b'1', 142, '2020-12-03 21:54:00', 142, 2, '2020-12-03 21:54:00', NULL),
(3164, 'CMA CGM ARKANSAS', NULL, 3160, b'1', 103, '2020-12-08 03:20:00', 103, 2, '2020-12-08 03:20:00', NULL),
(3165, 'DENEB J', NULL, 3161, b'1', 155, '2020-12-08 22:44:00', 155, 2, '2020-12-08 22:44:00', NULL),
(3166, 'ALS MARS', NULL, 3162, b'1', 103, '2020-12-15 14:09:00', 103, 2, '2020-12-15 14:09:00', NULL),
(3167, 'JULIUS', NULL, 3163, b'1', 103, '2020-12-15 18:45:00', 103, 2, '2020-12-15 18:45:00', NULL),
(3168, 'LOG-IN RESILIENTE', NULL, 3164, b'1', 103, '2020-12-15 19:15:00', 103, 2, '2020-12-15 19:15:00', NULL),
(3169, 'ST BLUE', NULL, 3165, b'1', 103, '2020-12-15 22:21:00', 103, 2, '2020-12-15 22:21:00', NULL),
(3170, 'CROACIA', NULL, 3166, b'1', 155, '2020-12-15 23:16:00', 155, 2, '2020-12-15 23:16:00', NULL),
(3171, 'KOTA GADANG', NULL, 3167, b'1', 103, '2020-12-17 15:26:00', 103, 2, '2020-12-17 15:26:00', NULL),
(3172, 'XIANG FU', NULL, 3168, b'1', 103, '2020-12-17 18:57:00', 103, 2, '2020-12-17 18:57:00', NULL),
(3173, 'NORDMARSH', NULL, 3169, b'1', 157, '2020-12-18 15:18:00', 157, 2, '2020-12-18 15:18:00', NULL),
(3174, 'EXPRESS BRASIL', NULL, 3170, b'1', 103, '2020-12-23 15:37:00', 103, 2, '2020-12-23 15:37:00', NULL),
(3175, 'VALENCE', NULL, 3171, b'1', 103, '2020-12-23 15:56:00', 103, 2, '2020-12-23 15:56:00', NULL),
(3176, 'CHECA', NULL, 3172, b'1', 155, '2020-12-23 18:37:00', 155, 2, '2020-12-23 18:37:00', NULL),
(3177, 'MSC NAOMI', NULL, 3173, b'1', 103, '2020-12-23 19:42:00', 103, 2, '2020-12-23 19:42:00', NULL),
(3178, 'HANSA OSTERBURG', NULL, 3174, b'1', 155, '2020-12-28 15:23:00', 155, 2, '2020-12-28 15:23:00', NULL),
(3179, 'MSC IVANA', NULL, 3175, b'1', 103, '2020-12-28 15:47:00', 103, 2, '2020-12-28 15:47:00', NULL),
(3180, 'CMA CGM MUNDRA', NULL, 3176, b'1', 24, '2020-12-30 16:21:00', 24, 2, '2020-12-30 16:21:00', NULL),
(3181, 'XINCHANGFENG727', NULL, 3177, b'1', 103, '2021-01-05 12:57:00', 103, 2, '2021-01-05 12:57:00', NULL),
(3182, 'HANOI BRIDGE', NULL, 3178, b'1', 103, '2021-01-05 14:14:00', 103, 2, '2021-01-05 14:14:00', NULL),
(3183, 'CONTI CONTESSA ', NULL, 3179, b'1', 103, '2021-01-05 18:28:00', 103, 2, '2021-01-05 18:28:00', NULL),
(3184, 'PACE', NULL, 3180, b'1', 155, '2021-01-06 21:41:00', 155, 2, '2021-01-06 21:41:00', NULL),
(3185, 'LEXA MAERSK', NULL, 3181, b'1', 103, '2021-01-12 13:50:00', 103, 2, '2021-01-12 13:50:00', NULL),
(3186, 'MAERSK NORTHWOOD', NULL, 3182, b'1', 155, '2021-01-12 15:54:00', 155, 2, '2021-01-12 15:54:00', NULL),
(3187, 'WAN HAI 612', NULL, 3183, b'1', 142, '2021-01-12 16:52:00', 142, 2, '2021-01-12 16:52:00', NULL),
(3188, 'ZHONG YI ZE TAI', NULL, 3184, b'1', 103, '2021-01-13 23:00:00', 103, 2, '2021-01-13 23:00:00', NULL),
(3189, 'NYK CONSTELLATION', NULL, 3185, b'1', 103, '2021-01-13 23:27:00', 103, 2, '2021-01-13 23:27:00', NULL),
(3190, 'BUENOS AIRES EXPRESS', NULL, 3186, b'1', 24, '2021-01-15 21:52:00', 24, 2, '2021-01-15 21:52:00', NULL),
(3191, 'HYUNDAI LOYALTY', NULL, 3187, b'1', 103, '2021-01-19 15:24:00', 103, 2, '2021-01-19 15:24:00', NULL),
(3192, 'FANG ZHOU 15', NULL, 3188, b'1', 103, '2021-01-20 13:48:00', 103, 2, '2021-01-20 13:48:00', NULL),
(3193, 'WAN HAI 103', NULL, 3189, b'1', 103, '2021-01-20 16:21:00', 103, 2, '2021-01-20 16:21:00', NULL),
(3194, 'BALAO', NULL, 3190, b'1', 103, '2021-01-22 20:28:00', 103, 2, '2021-01-22 20:28:00', NULL),
(3195, 'CARL SCHULTE', NULL, 3191, b'1', 103, '2021-01-22 23:38:00', 103, 2, '2021-01-22 23:38:00', NULL),
(3196, 'ST AZUL', NULL, 3192, b'1', 142, '2021-01-26 21:53:00', 142, 2, '2021-01-26 21:53:00', NULL),
(3197, 'CONTI CONQUEST', NULL, 3193, b'1', 103, '2021-01-27 23:52:00', 103, 2, '2021-01-27 23:52:00', NULL),
(3198, 'TONYO EXPRESS', NULL, 3194, b'1', 103, '2021-01-28 23:22:00', 103, 2, '2021-01-28 23:22:00', NULL),
(3199, 'TONGHAI558', NULL, 3195, b'1', 103, '2021-02-04 14:06:00', 103, 2, '2021-02-04 14:06:00', NULL),
(3200, 'JINHUI139', NULL, 3196, b'1', 103, '2021-02-04 14:36:00', 103, 2, '2021-02-04 14:36:00', NULL),
(3201, 'HAOHANG1005', NULL, 3197, b'1', 103, '2021-02-04 21:23:00', 103, 2, '2021-02-04 21:23:00', NULL),
(3202, 'SINAR SUNDA', NULL, 3198, b'1', 103, '2021-02-04 21:57:00', 103, 2, '2021-02-04 21:57:00', NULL),
(3203, 'MSC GAIA', NULL, 3199, b'1', 103, '2021-02-05 17:24:00', 103, 2, '2021-02-05 17:24:00', NULL),
(3204, 'CORONADO BAY', NULL, 3200, b'1', 103, '2021-02-08 22:02:00', 103, 2, '2021-02-08 22:02:00', NULL),
(3205, 'WANBANGFUXING', NULL, 3201, b'1', 103, '2021-02-11 00:44:00', 103, 2, '2021-02-11 00:44:00', NULL),
(3206, 'MERATUS MEDAN 5', NULL, 3202, b'1', 103, '2021-02-11 01:00:00', 103, 2, '2021-02-11 01:00:00', NULL),
(3207, 'TORONTO TRADER', NULL, 3203, b'1', 142, '2021-02-11 15:14:00', 142, 2, '2021-02-11 15:14:00', NULL),
(3208, 'MSC BOSPHORUS', NULL, 3204, b'1', 103, '2021-02-11 18:23:00', 103, 2, '2021-02-11 18:23:00', NULL),
(3209, 'HANSA GRANITE', NULL, 3205, b'1', 103, '2021-02-12 18:21:00', 103, 2, '2021-02-12 18:21:00', NULL),
(3210, 'XIN FU ZHOU', NULL, 3206, b'1', 142, '2021-02-15 14:59:00', 142, 2, '2021-02-15 14:59:00', NULL),
(3211, 'RHINE MAERSK', NULL, 3207, b'1', 103, '2021-02-15 22:19:00', 103, 2, '2021-02-15 22:19:00', NULL),
(3212, 'CMA CGM LOTUS', NULL, 3208, b'1', 103, '2021-02-24 00:19:00', 103, 2, '2021-02-24 00:19:00', NULL),
(3213, 'ONE HOUSTON ', NULL, 3209, b'1', 103, '2021-03-01 11:58:00', 103, 2, '2021-03-01 11:58:00', NULL),
(3214, 'BALBOA', NULL, 3210, b'1', 103, '2021-03-03 12:28:00', 103, 2, '2021-03-03 12:28:00', NULL),
(3215, 'MAERSK LAUNCESTON', NULL, 3211, b'1', 103, '2021-03-07 19:54:00', 103, 2, '2021-03-07 19:54:00', NULL),
(3216, 'SEASPAN BREEZE', NULL, 3212, b'1', 112, '2021-03-11 17:36:00', 112, 2, '2021-03-11 17:36:00', NULL),
(3217, 'TBA', NULL, 3213, b'1', 103, '2021-03-11 23:45:00', 103, 2, '2021-03-11 23:45:00', NULL),
(3218, 'SHUN YI', NULL, 3214, b'1', 103, '2021-03-23 15:10:00', 103, 2, '2021-03-23 15:10:00', NULL),
(3219, 'CONTI CHIVALRY', NULL, 3215, b'1', 155, '2021-03-25 17:43:00', 155, 2, '2021-03-25 17:43:00', NULL),
(3220, 'CMA CGM EIFFEL', NULL, 3216, b'1', 103, '2021-03-30 14:46:00', 103, 2, '2021-03-30 14:46:00', NULL),
(3221, 'SEAMAX WESTPORT', NULL, 3217, b'1', 103, '2021-03-30 19:25:00', 103, 2, '2021-03-30 19:25:00', NULL),
(3222, 'DOLE PACIFIC', NULL, 3218, b'1', 103, '2021-04-06 20:00:00', 103, 2, '2021-04-06 20:00:00', NULL),
(3223, 'CARIBBEAN EXPRESS', NULL, 3219, b'1', 142, '2021-04-07 18:01:00', 142, 2, '2021-04-07 18:01:00', NULL),
(3224, 'HOBBY HUNTER', NULL, 3220, b'1', 103, '2021-04-08 13:12:00', 103, 2, '2021-04-08 13:12:00', NULL),
(3225, 'KALAMANTA TRADER', NULL, 3221, b'1', 142, '2021-04-15 16:45:00', 142, 2, '2021-04-15 16:45:00', NULL),
(3226, 'HMM PROMISSE', NULL, 3222, b'1', 103, '2021-04-15 21:13:00', 103, 2, '2021-04-15 21:13:00', NULL),
(3227, 'SEASPAN LAHORE', NULL, 3223, b'1', 103, '2021-04-20 18:09:00', 103, 2, '2021-04-20 18:09:00', NULL),
(3228, 'KATHERINE', NULL, 3224, b'1', 103, '2021-04-20 20:00:00', 103, 2, '2021-04-20 20:00:00', NULL),
(3229, 'SEASPAN BEYOND', NULL, 3225, b'1', 103, '2021-04-26 19:54:00', 103, 2, '2021-04-26 19:54:00', NULL),
(3230, 'CMA CGM COCHIN', NULL, 3226, b'1', 103, '2021-04-29 14:38:00', 103, 2, '2021-04-29 14:38:00', NULL),
(3231, 'BEETHOVEN', NULL, 3227, b'1', 103, '2021-04-29 16:11:00', 103, 2, '2021-04-29 16:11:00', NULL),
(3232, 'MAERKS GATESHEAD', NULL, 3228, b'1', 103, '2021-04-30 14:35:00', 103, 2, '2021-04-30 14:35:00', NULL),
(3233, 'CMA CGM NEVADA', NULL, 3229, b'1', 24, '2021-05-05 21:40:00', 24, 2, '2021-05-05 21:40:00', NULL),
(3234, 'XINMINGZHOU80', NULL, 3230, b'1', 24, '2021-05-05 22:35:00', 24, 2, '2021-05-05 22:35:00', NULL),
(3235, 'SCORPIUS', NULL, 3231, b'1', 142, '2021-05-07 16:20:00', 142, 2, '2021-05-07 16:20:00', NULL),
(3236, 'XIN MEI ZHOU', NULL, 3232, b'1', 103, '2021-05-08 00:28:00', 103, 2, '2021-05-08 00:28:00', NULL),
(3237, 'CMA CGM CHOCHIN', NULL, 3233, b'1', 103, '2021-05-08 00:52:00', 103, 2, '2021-05-08 00:52:00', NULL),
(3238, 'YM WONDERLAND ', NULL, 3234, b'1', 103, '2021-05-08 01:37:00', 103, 2, '2021-05-08 01:37:00', NULL),
(3239, 'BAO HANG YUN', NULL, 3235, b'1', 103, '2021-05-08 02:16:00', 103, 2, '2021-05-08 02:16:00', NULL),
(3240, 'HYUNDAI SATURN', NULL, 3236, b'1', 155, '2021-05-10 14:16:00', 155, 2, '2021-05-10 14:16:00', NULL),
(3241, 'MAERSK HURON', NULL, 3237, b'1', 24, '2021-05-10 18:04:00', 24, 2, '2021-05-10 18:04:00', NULL),
(3242, 'SAN ALBERTO', NULL, 3238, b'1', 142, '2021-05-14 22:19:00', 142, 2, '2021-05-14 22:19:00', NULL),
(3243, 'WAN HAI 325', NULL, 3239, b'1', 112, '2021-05-17 17:44:00', 112, 2, '2021-05-17 17:44:00', NULL),
(3244, 'GH LESTE ', NULL, 3240, b'1', 103, '2021-05-18 13:32:00', 103, 2, '2021-05-18 13:32:00', NULL),
(3245, 'MSC AINO', NULL, 3241, b'1', 103, '2021-05-27 22:03:00', 103, 2, '2021-05-27 22:03:00', NULL),
(3246, 'HYUNDAI SMART ', NULL, 3242, b'1', 103, '2021-05-31 16:00:00', 103, 2, '2021-05-31 16:00:00', NULL),
(3247, 'AS FEDERICA', NULL, 3243, b'1', 142, '2021-06-04 21:51:00', 142, 2, '2021-06-04 21:51:00', NULL),
(3248, 'BOMAR HAMBURD', NULL, 3244, b'1', 103, '2021-06-07 15:33:00', 103, 2, '2021-06-07 15:33:00', NULL),
(3249, 'NORA MAERSK', NULL, 3245, b'1', 103, '2021-06-07 18:35:00', 103, 2, '2021-06-07 18:35:00', NULL),
(3250, 'EVER LEADING', NULL, 3246, b'1', 103, '2021-06-07 22:13:00', 103, 2, '2021-06-07 22:13:00', NULL),
(3251, 'SEASPAN BRILLANCE', NULL, 3247, b'1', 103, '2021-06-08 18:47:00', 103, 2, '2021-06-08 18:47:00', NULL),
(3252, 'CALIDRIS', NULL, 3248, b'1', 103, '2021-06-09 20:32:00', 103, 2, '2021-06-09 20:32:00', NULL),
(3253, 'ZHONG YI RUN', NULL, 3249, b'1', 103, '2021-06-10 00:50:00', 103, 2, '2021-06-10 00:50:00', NULL),
(3254, 'SEASPAN BRIGHTNESS ', NULL, 3250, b'1', 103, '2021-06-12 22:07:00', 103, 2, '2021-06-12 22:07:00', NULL),
(3255, 'TORRANCE', NULL, 3251, b'1', 103, '2021-06-16 20:28:00', 103, 2, '2021-06-16 20:28:00', NULL),
(3256, 'KOTA MEGAH', NULL, 3252, b'1', 103, '2021-06-21 16:01:00', 103, 2, '2021-06-21 16:01:00', NULL),
(3257, 'YM WELLSPRING', NULL, 3253, b'1', 103, '2021-06-24 11:49:00', 103, 2, '2021-06-24 11:49:00', NULL),
(3258, 'CONFIDENCE', NULL, 3254, b'1', 103, '2021-06-24 20:19:00', 103, 2, '2021-06-24 20:19:00', NULL),
(3259, 'XUTRA BHUM/', NULL, 3255, b'1', 103, '2021-06-25 05:39:00', 103, 2, '2021-06-25 05:39:00', NULL),
(3260, 'MSC SHIRLEY', NULL, 3256, b'1', 103, '2021-06-25 05:55:00', 103, 2, '2021-06-25 05:55:00', NULL),
(3261, 'MSC ANTONELLA', NULL, 3257, b'1', 24, '2021-06-25 15:23:00', 24, 2, '2021-06-25 15:23:00', NULL),
(3262, 'ONE COLUMBA', NULL, 3258, b'1', 103, '2021-07-02 14:07:00', 103, 2, '2021-07-02 14:07:00', NULL),
(3263, 'COSCO FOS', NULL, 3259, b'1', 103, '2021-07-05 18:18:00', 103, 2, '2021-07-05 18:18:00', NULL),
(3264, 'GUOXIANG918', NULL, 3260, b'1', 103, '2021-07-05 18:35:00', 103, 2, '2021-07-05 18:35:00', NULL),
(3265, 'CMA CGM MISSOURI', NULL, 3261, b'1', 103, '2021-07-07 12:53:00', 103, 2, '2021-07-07 12:53:00', NULL),
(3266, 'VEGA VELA', NULL, 3262, b'1', 142, '2021-07-12 17:32:00', 142, 2, '2021-07-12 17:32:00', NULL),
(3267, 'HUI YUE', NULL, 3263, b'1', 103, '2021-07-12 22:45:00', 103, 2, '2021-07-12 22:45:00', NULL),
(3268, 'ONE SWAN', NULL, 3264, b'1', 103, '2021-07-14 21:35:00', 103, 2, '2021-07-14 21:35:00', NULL),
(3269, 'ROBIN 4', NULL, 3265, b'1', 103, '2021-07-16 14:08:00', 142, 2, '2021-07-28 15:56:00', NULL),
(3270, 'MSC JEONGMIN', NULL, 3266, b'1', 103, '2021-07-16 15:30:00', 103, 2, '2021-07-16 15:30:00', NULL),
(3271, 'NAVIGARE COLLECTOR ', NULL, 3267, b'1', 103, '2021-07-16 22:00:00', 103, 2, '2021-07-16 22:00:00', NULL),
(3272, 'YI FENG 777', NULL, 3268, b'1', 103, '2021-07-19 22:11:00', 103, 2, '2021-07-19 22:11:00', NULL),
(3273, 'NEW YORK EXPRESS', NULL, 3269, b'1', 103, '2021-07-21 13:54:00', 103, 2, '2021-07-21 13:54:00', NULL),
(3274, 'KOTA MAKMUR', NULL, 3270, b'1', 103, '2021-07-27 13:20:00', 103, 2, '2021-07-27 13:20:00', NULL),
(3275, 'MSC ROSA', NULL, 3271, b'1', 103, '2021-07-29 23:27:00', 103, 2, '2021-07-29 23:27:00', NULL),
(3276, 'CMA CGM ALASKA', NULL, 3272, b'1', 103, '2021-08-02 14:15:00', 103, 2, '2021-08-02 14:15:00', NULL),
(3277, 'MOL TRUTH', NULL, 3273, b'1', 103, '2021-08-02 15:20:00', 103, 2, '2021-08-02 15:20:00', NULL),
(3278, 'MELBOURNE STRAIT', NULL, 3274, b'1', 155, '2021-08-02 22:15:00', 155, 2, '2021-08-02 22:15:00', NULL),
(3279, 'WAN HAI 722', NULL, 3275, b'1', 155, '2021-08-04 20:29:00', 155, 2, '2021-08-04 20:29:00', NULL),
(3280, 'MSC ROMANE', NULL, 3276, b'1', 103, '2021-08-06 21:28:00', 103, 2, '2021-08-06 21:28:00', NULL),
(3281, 'KOTA DUNIA', NULL, 3277, b'1', 103, '2021-08-06 22:49:00', 103, 2, '2021-08-06 22:49:00', NULL),
(3282, 'CONTSHIP ZOE', NULL, 3278, b'1', 155, '2021-08-09 21:30:00', 155, 2, '2021-08-09 21:30:00', NULL),
(3283, 'HYUNDAI RESPECT', NULL, 3279, b'1', 103, '2021-08-10 12:21:00', 103, 2, '2021-08-10 12:21:00', NULL),
(3284, 'KOTA GAYA', NULL, 3280, b'1', 103, '2021-08-13 16:09:00', 103, 2, '2021-08-13 16:09:00', NULL),
(3285, 'KOTA LAMBANG', NULL, 3281, b'1', 142, '2021-08-13 16:47:00', 142, 2, '2021-08-13 16:47:00', NULL),
(3286, 'LOG-IN DISCOVERY', NULL, 3282, b'1', 103, '2021-08-19 04:23:00', 103, 2, '2021-08-19 04:23:00', NULL),
(3287, 'CMA CGM CHENNAI', NULL, 3283, b'1', 103, '2021-08-20 21:27:00', 103, 2, '2021-08-20 21:27:00', NULL),
(3288, 'MAERSK LEON ', NULL, 3284, b'1', 103, '2021-08-25 15:33:00', 103, 2, '2021-08-25 15:33:00', NULL),
(3289, 'MSC CAPUCINE', NULL, 3285, b'1', 103, '2021-08-25 17:01:00', 103, 2, '2021-08-25 17:01:00', NULL),
(3290, 'RDO ENDEAVOUR ', NULL, 3286, b'1', 103, '2021-08-29 01:18:00', 103, 2, '2021-08-29 01:18:00', NULL),
(3291, 'KOTA MACHAN', NULL, 3287, b'1', 103, '2021-09-01 12:32:00', 103, 2, '2021-09-01 12:32:00', NULL),
(3292, 'MSC ROSA M', NULL, 3288, b'1', 155, '2021-09-01 18:09:00', 155, 2, '2021-09-01 18:09:00', NULL),
(3293, 'HUI XIN HUI ', NULL, 3289, b'1', 24, '2021-09-03 17:23:00', 24, 2, '2021-09-03 17:23:00', NULL),
(3294, 'AS PAMIRA', NULL, 3290, b'1', 103, '2021-09-07 20:12:00', 103, 2, '2021-09-07 20:12:00', NULL),
(3295, 'HE XING', NULL, 3291, b'1', 103, '2021-09-08 15:57:00', 103, 2, '2021-09-08 15:57:00', NULL),
(3296, 'KOTA SAHABAT', NULL, 3292, b'1', 103, '2021-09-16 03:58:00', 103, 2, '2021-09-16 03:58:00', NULL),
(3297, 'LOG IN ENDURANCE', NULL, 3293, b'1', 103, '2021-09-20 01:36:00', 103, 2, '2021-09-20 01:36:00', NULL),
(3298, 'STRIDE ', NULL, 3294, b'1', 14, '2021-09-21 20:56:00', 14, 2, '2021-09-21 20:56:00', NULL),
(3299, 'MSC IRENE', NULL, 3295, b'1', 103, '2021-09-27 14:28:00', 103, 2, '2021-09-27 14:28:00', NULL),
(3300, 'SEASPAN BRILLIANCE', NULL, 3296, b'1', 166, '2021-09-27 21:26:00', 166, 2, '2021-09-27 21:26:00', NULL),
(3301, 'WAN HAI 505', NULL, 3297, b'1', 142, '2021-09-29 14:11:00', 142, 2, '2021-09-29 14:11:00', NULL),
(3302, 'WAN HAI 321', NULL, 3298, b'1', 142, '2021-09-29 14:12:00', 142, 2, '2021-09-29 14:12:00', NULL),
(3303, 'AS FIORELLA', NULL, 3299, b'1', 142, '2021-10-01 19:41:00', 142, 2, '2021-10-01 19:41:00', NULL),
(3304, 'GSL CHATEAU D\'IF', NULL, 3300, b'1', 103, '2021-10-05 13:37:00', 103, 2, '2021-10-05 13:37:00', NULL),
(3305, 'YUGANGJI19', NULL, 3301, b'1', 175, '2021-10-05 21:55:00', 175, 2, '2021-10-05 21:55:00', NULL),
(3306, 'SEASPAN SANTOS', NULL, 3302, b'1', 103, '2021-10-06 00:39:00', 103, 2, '2021-10-06 00:39:00', NULL),
(3307, 'HONG TAI 61', NULL, 3303, b'1', 166, '2021-10-06 17:56:00', 166, 2, '2021-10-06 17:56:00', NULL),
(3308, 'LOG-IN JATOBA', NULL, 3304, b'1', 103, '2021-10-06 22:12:00', 103, 2, '2021-10-06 22:12:00', NULL),
(3309, 'GSL CHATEAU D´IF', NULL, 3305, b'1', 166, '2021-10-07 15:57:00', 166, 2, '2021-10-07 15:57:00', NULL),
(3310, 'WAN HAI 233', NULL, 3306, b'1', 175, '2021-10-12 21:06:00', 175, 2, '2021-10-12 21:06:00', NULL),
(3311, 'MSC GENEVA', NULL, 3307, b'1', 175, '2021-10-13 19:28:00', 175, 2, '2021-10-13 19:28:00', NULL),
(3312, 'SPIL KARTIKA', NULL, 3308, b'1', 103, '2021-10-14 00:27:00', 103, 2, '2021-10-14 00:27:00', NULL),
(3313, 'APL ESPLANADE', NULL, 3309, b'1', 175, '2021-10-14 18:52:00', 175, 2, '2021-10-14 18:52:00', NULL),
(3314, 'MACAO', NULL, 3310, b'1', 175, '2021-10-15 15:22:00', 175, 2, '2021-10-15 15:22:00', NULL),
(3315, 'WAN HAI 622', NULL, 3311, b'1', 155, '2021-10-15 21:01:00', 155, 2, '2021-10-15 21:01:00', NULL),
(3316, 'VELIKA EXPRESS', NULL, 3312, b'1', 174, '2021-10-15 22:50:00', 174, 2, '2021-10-15 22:50:00', NULL),
(3317, 'COLOMBO', NULL, 3313, b'1', 175, '2021-10-19 14:50:00', 175, 2, '2021-10-19 14:50:00', NULL),
(3318, 'CMA CGM MUMBAI', NULL, 3314, b'1', 175, '2021-10-19 17:23:00', 175, 2, '2021-10-19 17:23:00', NULL),
(3319, 'WAN HAI 311', NULL, 3315, b'1', 112, '2021-10-19 22:32:00', 112, 2, '2021-10-19 22:32:00', NULL),
(3320, 'KOTA PUSAKA', NULL, 3316, b'1', 175, '2021-10-21 17:07:00', 175, 2, '2021-10-21 17:07:00', NULL),
(3321, 'MSC ANTONIA', NULL, 3317, b'1', 103, '2021-10-22 19:29:00', 103, 2, '2021-10-22 19:29:00', NULL),
(3322, 'MSC ABIGAIL F', NULL, 3318, b'1', 155, '2021-10-25 15:23:00', 155, 2, '2021-10-25 15:23:00', NULL),
(3323, 'MERCOSUL GUARANI', NULL, 3319, b'1', 175, '2021-10-28 16:38:00', 175, 2, '2021-10-28 16:38:00', NULL),
(3324, 'HYUNDAI AMBITION', NULL, 3320, b'1', 175, '2021-10-28 17:02:00', 175, 2, '2021-10-28 17:02:00', NULL),
(3325, 'CMA CGM PUERTO ANTIOQUIA', NULL, 3321, b'1', 103, '2021-10-29 17:04:00', 103, 2, '2021-10-29 17:04:00', NULL),
(3326, 'GALANE', NULL, 3322, b'1', 103, '2021-10-30 01:03:00', 103, 2, '2021-10-30 01:03:00', NULL),
(3327, 'YUAN HENG', NULL, 3323, b'1', 175, '2021-11-02 19:57:00', 175, 2, '2021-11-02 19:57:00', NULL),
(3328, 'MSC YURIDIA III', NULL, 3324, b'1', 174, '2021-11-03 14:12:00', 174, 2, '2021-11-03 14:12:00', NULL),
(3329, 'GTM', NULL, 3325, b'1', 103, '2021-11-04 18:15:00', 103, 2, '2021-11-04 18:15:00', NULL),
(3330, 'OOCL HO CHI MINH CITY', NULL, 3326, b'1', 103, '2021-11-10 04:17:00', 103, 2, '2021-11-10 04:17:00', NULL),
(3331, 'EVER LADEN', NULL, 3327, b'1', 175, '2021-11-10 21:17:00', 175, 2, '2021-11-10 21:17:00', NULL),
(3332, 'NAVIOS UNITE', NULL, 3328, b'1', 103, '2021-11-12 15:19:00', 103, 2, '2021-11-12 15:19:00', NULL);

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
(10, 58, 81, 4, 5, 'CIUDAD DE COSTARICA', '698574', 49, 39, 0, '2021-08-12', '2021-09-29', '', '', '', '12354.00', '123.00', '1519542.00', '123.00', '1519665.00', '500.00', '26.000', '10.000', '0.00', '5.00', 0, '0.00', '2739.90', '3.75', 1, '64658.00', '8406.00', 0, '73064.00', '0.00', '0.00'),
(11, 58, 81, 4, 5, 'CIUDAD DE COSTARICA', '698574', 1, 0, 10, '2021-08-12', '2021-08-25', '', '', '', '123.00', '123.00', '15129.00', '123.00', '15252.00', '500.00', '26.000', '10.000', '0.00', '5.00', 0, '0.00', '2.00', '3.75', 1, '64916.00', '8440.00', 0, '73098.00', '0.00', '0.00'),
(12, 58, 81, 4, 5, 'CIUDAD DE COSTARICA', '698574', 1, 0, 0, '2021-08-12', '2021-08-25', '', '', '', '123.00', '123.00', '15129.00', '123.00', '15252.00', '500.00', '26.000', '10.000', '0.00', '5.00', 0, '0.00', '2.00', '3.75', 1, '64916.00', '8440.00', 0, '73098.00', '0.00', '0.00');

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
(1, 'Importación'),
(2, 'Exportación'),
(3, 'Mayoreo Local'),
(4, 'Mayoreo Nacional');

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
(1, 52, 5, 'Seguro', 'secure', '', NULL, NULL, NULL, NULL, NULL, '2021-04-16'),
(2, 52, 5, 'Flete Aereo', 'freight Air', '3', NULL, NULL, NULL, NULL, NULL, '2021-04-30'),
(3, 52, 5, 'Almacenaje1', 'gargabe', '3', NULL, NULL, NULL, NULL, NULL, '2021-05-25'),
(4, 52, 3, 'Manejo', '', '001', NULL, NULL, NULL, NULL, NULL, '2021-06-09'),
(5, 52, 3, 'Papeleria', 'paper', '5', NULL, NULL, NULL, NULL, NULL, '2021-08-07'),
(6, 52, 3, 'Descargue', 'download', '', NULL, NULL, NULL, NULL, NULL, '2021-08-07'),
(7, 52, 3, 'Cargue', 'up', '', NULL, NULL, NULL, NULL, NULL, '2021-08-07'),
(8, 58, 4, 'Almacenaje', 'gargabe', '', NULL, NULL, NULL, NULL, NULL, '2021-08-12'),
(9, 58, 4, 'Almacenaje Adicional', '', '', NULL, NULL, NULL, NULL, NULL, '2021-08-12'),
(10, 58, 4, 'Manejo', '', '', NULL, NULL, NULL, NULL, NULL, '2021-08-12'),
(11, 58, 4, 'Seguro', '', '', NULL, NULL, NULL, NULL, NULL, '2021-08-12'),
(12, 58, 4, 'Precintos', '', '', NULL, NULL, NULL, NULL, NULL, '2021-08-12'),
(13, 223, 5, 'Flete Terrestre', '', '5', NULL, NULL, NULL, NULL, NULL, '2022-02-24'),
(14, 223, 5, 'THC', 'THC', '0256', NULL, NULL, NULL, NULL, NULL, '2022-03-02'),
(15, 223, 5, 'prueba', '', '58', NULL, NULL, NULL, NULL, NULL, '2022-03-03'),
(16, 223, 5, 'prueba1', 'prueba1', '25', NULL, NULL, NULL, NULL, NULL, '2022-03-03'),
(17, 223, 5, 'prueba', '', '', NULL, NULL, NULL, NULL, NULL, '2022-03-03'),
(18, 223, 5, 'prueba', '', '', NULL, NULL, NULL, NULL, NULL, '2022-03-03'),
(19, 223, 5, 'prueba5', '', '', NULL, NULL, NULL, NULL, NULL, '2022-03-03'),
(20, 223, 5, 'Flete Adicional', '', '', NULL, NULL, NULL, NULL, NULL, '2022-03-03'),
(21, 223, 5, 'Otros', '', '5898', NULL, NULL, NULL, NULL, NULL, '2022-03-03'),
(22, 223, 5, 'Flete Adicional Maritimo', '', '', NULL, NULL, NULL, NULL, NULL, '2022-03-06'),
(23, 223, 5, 'Gastos', '', '', NULL, NULL, NULL, NULL, NULL, '2022-03-08');

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
(5, 92, 'PETEN'),
(6, 92, 'ESQUIPULAS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunicacionpreferida`
--

CREATE TABLE `comunicacionpreferida` (
  `id_comunicacion` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `comunicacionpreferida`
--

INSERT INTO `comunicacionpreferida` (`id_comunicacion`, `nombre`) VALUES
(1, 'Correo'),
(2, 'Whatsapp'),
(3, 'Llamada');

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
(23, 4, 11, 2021, 1),
(24, 4, 11, 2021, 2),
(25, 4, 11, 2021, 3),
(26, 4, 11, 2021, 4),
(27, 4, 11, 2021, 5),
(28, 4, 11, 2021, 6),
(29, 4, 11, 2021, 7),
(30, 4, 11, 2021, 8),
(31, 4, 11, 2021, 9),
(32, 4, 11, 2021, 10),
(33, 4, 11, 2021, 11),
(34, 4, 11, 2021, 12),
(35, 4, 11, 2021, 13),
(36, 4, 11, 2021, 14),
(37, 4, 11, 2021, 15),
(38, 4, 11, 2021, 16),
(39, 4, 11, 2021, 17),
(40, 4, 11, 2021, 18),
(41, 4, 11, 2021, 19);

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
  `puesto` varchar(50) NOT NULL,
  `celular` varchar(30) DEFAULT NULL,
  `cumpleanios` date DEFAULT NULL,
  `id_comunicacion` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `contactos_e`
--

INSERT INTO `contactos_e` (`id_contacto`, `id_empresa`, `nombre`, `apellido`, `correo`, `telefono`, `puesto`, `celular`, `cumpleanios`, `id_comunicacion`) VALUES
(18, 32, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros', NULL, NULL, NULL),
(19, 33, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros', NULL, NULL, NULL),
(20, 34, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros', NULL, NULL, NULL),
(21, 35, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros', NULL, NULL, NULL),
(22, 36, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros', NULL, NULL, NULL),
(23, 37, 'francisco', 'taquira', 'accguatemala3@sercogua.com', '2303-7000', 'cobros', NULL, NULL, NULL),
(24, 67, 'manuel', 'cruz', 'opguatemala@sercogua.com', '45285945', 'it', NULL, NULL, NULL),
(25, 69, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador', NULL, NULL, NULL),
(26, 70, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador', NULL, NULL, NULL),
(27, 71, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador', NULL, NULL, NULL),
(28, 72, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador', NULL, NULL, NULL),
(29, 73, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador', NULL, NULL, NULL),
(30, 74, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador', NULL, NULL, NULL),
(31, 75, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador', NULL, NULL, NULL),
(32, 90, 'estuardo', 'cruz', 'it@gmail.com', '4528594', 'programador', '458956', '2022-03-09', 1),
(35, 90, 'manuel', 'manuel', 'it@gmail.com', '4528594', '', '', '2022-03-05', 2),
(36, 90, 'estuardo', 'de la cruz', 'it@gmail.com', '4528594', '', '', '2022-03-05', 2),
(37, 90, 'estuardo', 'apel', 'it@gmail.com', '4528594', '', '458956', '2022-03-05', 2),
(38, 90, 'manuel', 'kiolkjh', 'it@gmail.com', '4528594', 'programador', '458956', '2022-03-05', 2),
(39, 88, 'estuardo', 'de la cruz', 'it@gmail.com', '4528594', 'programador', '458956', '2022-03-08', 1),
(40, 92, 'juan', 'perez', 'it@gmail.com', '5896454', 'programador', '5566985', '2022-03-25', 2),
(41, 93, 'juan', 'perez', 'it@gmail.com', '5896454', 'programador', '5566985', '2022-03-25', 2);

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
(25, 4, 83, 12, 2021),
(26, 4, 83, 13, 2021),
(27, 4, 84, 1, 2021),
(28, 4, 83, 14, 2021),
(29, 4, 0, 1, 2021),
(30, 4, 0, 2, 2021),
(31, 4, 0, 3, 2021),
(32, 4, 0, 4, 2021),
(33, 4, 0, 5, 2021),
(34, 4, 0, 6, 2021),
(35, 4, 0, 7, 2021),
(36, 4, 0, 8, 2021),
(37, 4, 0, 9, 2021),
(38, 4, 0, 10, 2021),
(39, 4, 0, 11, 2021),
(40, 4, 0, 12, 2021),
(41, 4, 0, 13, 2021),
(42, 4, 0, 14, 2021),
(43, 4, 0, 15, 2021);

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
-- Estructura de tabla para la tabla `correlativo_proyecto`
--

CREATE TABLE `correlativo_proyecto` (
  `id_correlativo_proyecto` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `correlativo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `correlativo_proyecto`
--

INSERT INTO `correlativo_proyecto` (`id_correlativo_proyecto`, `id_sucursal`, `correlativo`) VALUES
(43, 5, 1),
(44, 5, 2),
(45, 5, 3),
(46, 5, 4),
(47, 5, 5),
(48, 5, 6),
(49, 5, 7),
(50, 5, 8),
(51, 5, 9),
(52, 5, 10),
(53, 5, 11),
(54, 5, 12),
(55, 5, 13),
(56, 5, 14),
(57, 5, 15),
(59, 5, 16),
(60, 5, 17),
(61, 5, 18),
(62, 5, 19),
(65, 5, 20),
(66, 5, 21);

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
(1, 'INFORMATICA         '),
(2, 'GERENCIA            '),
(3, 'ADMINISTRACION      '),
(4, 'CONTABILIDAD        '),
(5, 'CUSTOMER SERVICE    '),
(6, 'OPERACIONES         '),
(7, 'VENTAS              '),
(8, 'RECEPCION           '),
(9, 'ADUANAS             '),
(10, 'IMAGEN CORPORATIVO  '),
(11, 'INTERNACIONAL       '),
(12, 'COMERCIAL           ');

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
(2, 4, '10.00'),
(3, 4, '15.00'),
(4, 4, '20.00'),
(5, 4, '25.00');

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
(30, 10, 15, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(31, 11, 11, '₡.', '20500.00', '0.00', 0, 0, '0.00', '20500.00'),
(32, 11, 12, '₡.', '22658.00', '0.00', 0, 0, '0.00', '22658.00'),
(33, 11, 13, '₡.', '20500.00', '0.00', 0, 0, '0.00', '20500.00'),
(34, 11, 14, '₡.', '1000.00', '0.00', 0, 0, '0.00', '1000.00'),
(35, 11, 15, '₡.', '0.00', '0.00', 0, 0, '0.00', '0.00'),
(36, 12, 11, '₡.', '20500.00', '0.00', 0, 0, '0.00', '2665.00'),
(37, 12, 12, '₡.', '22658.00', '0.00', 0, 0, '0.00', '2946.00'),
(38, 12, 13, '₡.', '20500.00', '1000.00', 0, 1, '0.00', '2665.00'),
(39, 12, 14, '₡.', '1000.00', '0.00', 1, 0, '0.00', '130.00'),
(40, 12, 15, '₡.', '0.00', '0.00', 1, 0, '0.00', '0.00');

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
  `id_aslo` int(11) NOT NULL DEFAULT 0,
  `representante_legal` varchar(100) DEFAULT NULL,
  `dias_credito` tinyint(4) DEFAULT NULL,
  `cuenta_Bancaria` varchar(250) DEFAULT NULL,
  `para_cheque` varchar(250) DEFAULT NULL,
  `id_moneda_pago` int(11) DEFAULT NULL,
  `aniversario` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id_empresa`, `id_sucursal`, `id_usuario`, `id_pais`, `Razons`, `Nombrec`, `identificacion`, `direccion`, `telefono`, `Tipoe`, `codigo`, `estado`, `porcentaje_comision`, `tipo_comision`, `fecha`, `id_giro_negocio`, `id_tamano_empresa`, `id_tipo_carga`, `id_canal_distribucion`, `id_aslo`, `representante_legal`, `dias_credito`, `cuenta_Bancaria`, `para_cheque`, `id_moneda_pago`, `aniversario`) VALUES
(80, 4, 58, 59, 'SERCOGUA CR', 'SERVICIOS COMERCIALES DE GUATEMALA COSTARICA', '56231', 'CIUDAD COSTARICA', '50623037000', 'CO', '1', 1, 0, 'cbm', '2021-08-12 06:00:00', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '0000-00-00'),
(81, 4, 58, 59, 'CLIENTE 1 DE COSTARICA', 'CLIENTE 1 DE COSTARICA', '698574', 'CIUDAD DE COSTARICA', '4569852', 'CL', '1', 1, 0, 'cbm', '2021-08-12 06:00:00', 1, 1, 1, 1, 58, NULL, NULL, NULL, NULL, NULL, NULL),
(82, 4, 58, 59, 'CTM', 'CTM', '59874', 'COSTA RICA', '1236548', 'CO', '2', 1, 0, 'tarifa', '2021-08-24 15:43:58', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(83, 4, 58, 47, 'LEADER GROUP', 'LEADER', '2365458', 'CHINA', '115698854', 'AE', '1', 1, 0, '', '2021-09-02 15:44:15', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(84, 4, 58, 111, 'ONE', 'ONE', '45698', 'JAPON', '458789', 'AE', '2', 1, 0, '', '2021-09-02 16:39:00', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(85, 4, 58, 100, 'LEADER OCEAN', 'LEADER OCEAN', '45896', 'HONG KONG', '5987', 'NA', '1', 1, 0, '', '2021-09-02 16:44:27', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(86, 4, 58, 73, 'EMPRESA DE COLOADER', 'EMPRESA DE COLOADER', '120393918', 'ESPA&Ntilde;A', '101928948', 'AC', '1', 1, 0, '', '2021-09-02 16:59:48', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(87, 4, 58, 92, 'COSCO LINE GUATEMALA', 'COSCO LINE GUATEMALA', '45698', 'GUATEMALA', '45285948', 'NA', '2', 1, 0, '', '2022-01-15 19:46:45', 0, 0, 0, 0, 58, '', 0, '', '', 0, NULL),
(88, 5, 223, 92, 'PRUEBA 1', 'PRUEBA 1', '45898554', 'ZONA 15', '45282700', 'CL', '1', 1, 0, '', '2022-02-04 21:19:56', 1, 3, 2, 1, 223, '', 0, '', '', 0, '0000-00-00'),
(89, 5, 223, 92, 'EMBARCADOR 1', 'EMBARCADOR 1', '12345698', 'GUATEMALA', '2303700', 'EM', '1', 1, 0, '', '2022-03-01 16:55:15', 0, 0, 0, 0, 223, '', 0, '', '', 0, NULL),
(90, 5, 223, 59, 'COSCO LINE GUATEMALA', 'COSCO LINE GUATEMALA', '2315645', 'DIRECCION', '45285948', 'CL', '2', 1, 0, '', '2022-03-04 21:09:07', 0, 0, 0, 0, 223, '', 0, '', '', 0, '2022-03-05'),
(91, 5, 1, 92, 'SERCOGUA', 'SERCOGUA', '230345885', 'GUATEMALA', '5026588966', 'CL', '3', 1, 0, '', '2022-03-05 22:02:51', 0, 0, 0, 0, 1, '', 0, '', '', 0, '2022-03-05'),
(93, 5, 223, 92, 'SERCOGUA CR', 'SERCOGUA CR', '123456', 'COSTA RICA', '22123085', 'CL', '4', 1, 0, '', '2022-03-09 03:33:12', 0, 0, 0, 0, 223, '', 0, '', '', 0, '2022-03-20');

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
-- Estructura de tabla para la tabla `equipo`
--

CREATE TABLE `equipo` (
  `id_tipo_equipo` int(11) NOT NULL,
  `tamano` varchar(20) NOT NULL,
  `tipo` varchar(25) NOT NULL,
  `tara` decimal(10,2) NOT NULL,
  `descripcion` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`id_tipo_equipo`, `tamano`, `tipo`, `tara`, `descripcion`) VALUES
(1, '40', 'DRY', '0.00', 'equipo normal tipo dry'),
(2, '40', 'DRY', '0.00', 'normal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion_proyecto`
--

CREATE TABLE `evaluacion_proyecto` (
  `id_evaluacion_proyecto` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `codigo` varchar(45) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `fechainicio` date DEFAULT NULL,
  `fechafinal` date DEFAULT NULL,
  `id_tipo_carga` int(11) DEFAULT NULL,
  `id_fianza` int(11) DEFAULT NULL,
  `peso` decimal(10,2) DEFAULT NULL,
  `id_unidad_media` int(11) DEFAULT NULL,
  `pies_cubicos` decimal(10,2) DEFAULT NULL,
  `descripcion_mercaderia` varchar(800) DEFAULT NULL,
  `permisos` varchar(800) DEFAULT NULL,
  `entregas` varchar(800) DEFAULT NULL,
  `recorrido` varchar(800) DEFAULT NULL,
  `frecuencua` varchar(800) DEFAULT NULL,
  `id_sercarga` tinyint(4) DEFAULT NULL,
  `id_serdescarga` tinyint(4) DEFAULT NULL,
  `id_efectivo` tinyint(4) DEFAULT NULL,
  `fechagraba` timestamp NOT NULL DEFAULT current_timestamp(),
  `fechamodifica` date NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `descripcionProyecto` varchar(1000) DEFAULT NULL,
  `dias_libres` tinyint(4) DEFAULT NULL,
  `comentario_operacion` varchar(800) DEFAULT NULL,
  `otros` varchar(100) DEFAULT NULL,
  `careta` tinyint(1) DEFAULT NULL,
  `mascarilla` tinyint(1) DEFAULT NULL,
  `guantes` tinyint(1) DEFAULT NULL,
  `lentes` tinyint(1) DEFAULT NULL,
  `chaleco` tinyint(1) DEFAULT NULL,
  `botas` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `evaluacion_proyecto`
--

INSERT INTO `evaluacion_proyecto` (`id_evaluacion_proyecto`, `id_sucursal`, `codigo`, `id_cliente`, `fechainicio`, `fechafinal`, `id_tipo_carga`, `id_fianza`, `peso`, `id_unidad_media`, `pies_cubicos`, `descripcion_mercaderia`, `permisos`, `entregas`, `recorrido`, `frecuencua`, `id_sercarga`, `id_serdescarga`, `id_efectivo`, `fechagraba`, `fechamodifica`, `estado`, `descripcionProyecto`, `dias_libres`, `comentario_operacion`, `otros`, `careta`, `mascarilla`, `guantes`, `lentes`, `chaleco`, `botas`) VALUES
(44, 5, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-02-07 22:18:37', '2022-02-07', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(45, 5, '2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-02-07 22:18:37', '2022-02-07', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(46, 5, '3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-02-07 22:18:37', '2022-02-07', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, 5, 'CT88PCT88P47', 88, '2022-03-06', '2022-03-06', 1, 2, '1.00', 2, '1.00', 'mercaderia', 'permisos', 'ENTREGAS', 'KILOMETROS', 'FRECUENCIA', 2, 2, 2, '2022-02-07 22:18:37', '2022-03-06', 1, 'PRUEBA', 2, 'opeacion fallida', 'OTROS', 0, 1, 0, 1, 0, 1),
(48, 5, '5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-02-07 22:59:42', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 5, '6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-02-07 23:01:56', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 5, '7', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-02-14 16:49:58', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(51, 5, '8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-02-16 14:34:15', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(52, 5, '9', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-03-01 16:22:20', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 5, '10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-03-03 15:06:44', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(54, 5, '11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-03-03 16:04:08', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(55, 5, '12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-03-03 20:16:23', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 5, '13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-03-03 20:33:42', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(57, 5, '14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-03-03 20:33:51', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(58, 5, '15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-03-03 20:42:12', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(60, 5, 'CT0P16', 88, '2022-03-03', '2022-03-03', 2, 0, '0.00', 0, '0.00', '', '', '', '', 'asdf', 2, 2, 2, '2022-03-03 22:15:58', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(61, 5, 'CT0P17', 0, '2022-03-03', '2022-03-03', 2, 0, '0.00', 0, '0.00', '', '', '', '', 'asdf', 2, 2, 2, '2022-03-03 22:20:03', '0000-00-00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(62, 5, 'CT88P18', 88, '2022-03-06', '2022-03-06', 1, 2, '4.00', 1, '4.00', 'ASDF', 'asdf', 'asdf', 'asdf', 'asdf', 2, 2, 2, '2022-03-03 22:28:34', '2022-03-06', 1, 'PRUEBA DE PROYECTO', 0, '', '', 0, 0, 0, 0, 1, 1),
(63, 5, 'CT90P19', 90, '2022-03-07', '2022-03-07', 2, 1, '4.00', 2, '4.00', 'MERCADERIA', 'sin permiso', 'asdf', 'asdf', 'asdf', 1, 2, 2, '2022-03-06 03:15:55', '2022-03-07', 1, 'PROYECTO NUMERO 3', 3, 'no hay nada', '', 0, 0, 0, 0, 0, 0),
(66, 5, 'CT91P20', 91, '2022-03-06', '2022-03-06', 2, 2, '8.00', 1, '3.00', 'MERCA', 'permisos', 'asd', 'asd', 'sdfdfd', 1, 1, 2, '2022-03-06 17:47:12', '0000-00-00', 1, 'DESC', 4, 'xcvdvd', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(67, 5, 'CT90P21', 90, '2022-03-09', '2022-03-09', 2, 2, '1.00', 1, '1.00', 'ADF', 'eed', 'asdf', 'asdf', 's', 2, 2, 2, '2022-03-06 17:59:10', '2022-03-09', 1, 'DESC', 2, 'adf', '', 0, 0, 0, 0, 0, 0);

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
(1, 'Azúcar'),
(2, 'Flores'),
(3, 'Mueble'),
(4, 'Textiles');

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
  `id_sucursal` int(11) NOT NULL DEFAULT 0,
  `id_depto` int(11) NOT NULL,
  `id_puesto` int(11) NOT NULL,
  `acceso` varchar(50) NOT NULL,
  `pass` varchar(150) DEFAULT NULL,
  `avatar` varchar(150) DEFAULT NULL,
  `nombre` varchar(150) NOT NULL,
  `apellido` varchar(150) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `NumDirecta` varchar(120) DEFAULT NULL,
  `Cvndedor` int(11) NOT NULL,
  `rep` int(11) DEFAULT NULL,
  `comision` decimal(5,2) DEFAULT NULL,
  `rep2` int(11) DEFAULT NULL,
  `reppago` int(11) DEFAULT NULL,
  `pass2` varchar(150) DEFAULT NULL,
  `id_usuario2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`id_usuario`, `id_sucursal`, `id_depto`, `id_puesto`, `acceso`, `pass`, `avatar`, `nombre`, `apellido`, `correo`, `estado`, `NumDirecta`, `Cvndedor`, `rep`, `comision`, `rep2`, `reppago`, `pass2`, `id_usuario2`) VALUES
(52, 2, 3, 6, '123456', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1608505306.png', 'Manuel', 'De La Cruz', 'manuelcruz86@gmail.com', 1, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0),
(53, 1, 1, 5, '1234', '1234', '', 'maritza', 'De La Cruz', 'itguatemala@gmail.com', 1, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0),
(58, 4, 1, 6, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1636154948.png', 'Manuel de la cruz', 'lopez', 'itguatemala@gmail.com', 1, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0),
(59, 2, 1, 2, 'manuel', NULL, NULL, 'Manuel', 'De La Cruz', 'itguatemala@sercogua.com', 1, '(502)2388-000', 0, 1, '0.10', 0, 0, 'manuel', 1),
(60, 2, 9, 2, 'fabiola', NULL, NULL, 'Fabiola', 'Sican', 'cbguatemala@sercogua.com', 1, '(502)2388-4180', 8, 1, '0.10', 0, 0, '271428', 2),
(61, 2, 5, 3, 'fmartinez', NULL, NULL, 'Flor', 'Martínez', 'csguatemala@sercogua.com', 1, '(502)23884183', 3, 1, '0.50', 0, 0, 'negrito', 3),
(62, 2, 10, 1, 'andre', NULL, NULL, 'Andrea', 'Luna', 'imagencorporativa@sercogua.com', 0, '2388-4191', 9, 1, '0.10', 0, 0, 'maint14', 4),
(63, 2, 7, 2, 'jgonzalez', NULL, NULL, 'Jose', 'Gonzalez', 'salesguatemala@sercogua.com', 0, NULL, 0, 1, '0.10', 0, 0, 'andre', 5),
(64, 2, 4, 3, 'MiguelJr', NULL, NULL, 'Miguel Jr', 'Junior', '', 1, NULL, 0, 1, '0.10', 0, 0, '654321', 6),
(65, 2, 6, 3, 'igutierrez', NULL, NULL, 'Isabel', 'Gutierrez', 'opguatemala3@sercogua.com', 0, NULL, 0, 1, '0.10', 0, 0, 'charli', 7),
(66, 2, 5, 2, 'lalo', NULL, NULL, 'Julioo', 'Ortiz', 'csguatemala@sercogua.com', 0, '(502)23884183', 0, 1, '0.10', 0, 0, 'eduardo', 8),
(67, 2, 12, 3, 'rcardenas', NULL, NULL, 'Roxana', 'de Cardenas', 'csguatemala2@sercogua.com', 0, '(502)23884191', 13, 1, '0.10', 0, 0, 'rcardenas', 9),
(68, 2, 4, 3, 'any', NULL, NULL, 'Ana Maria', 'Estevez', 'accguatemala4@sercogua.com', 1, NULL, 0, 1, '0.10', 0, 0, 'gusy', 10),
(69, 2, 4, 3, 'hector', NULL, NULL, 'Hector', 'Davila', 'manageracc@sercogua.com', 0, '(502)2388-4179', 0, 1, '0.10', 0, 0, 'hector1', 11),
(70, 2, 3, 3, 'ftaquira', NULL, NULL, 'Francisco', 'Taquira', 'accguatemala3@sercogua.com', 1, 'Pendiente', 11, 1, '0.10', 0, 0, 'ftaquira', 12),
(71, 2, 5, 3, 'carevalo', NULL, NULL, 'Candy', 'Arevalo', 'csguatemala1@sercogua.com', 0, NULL, 0, 1, '0.10', 0, 0, 'preciosa', 13),
(72, 2, 4, 3, 'victor', NULL, NULL, 'Victor', 'Ortiz', 'accguatemala1@sercogua.com', 1, NULL, 0, 1, '0.10', 0, 0, 'beto', 14),
(73, 2, 7, 9, 'ofelia', NULL, NULL, 'Ofelia', 'Gonzalez', 'salesguatemala2@sercogua.com', 1, '(502) 23884188', 6, 1, '0.10', 0, 1, 'ofegon', 15),
(74, 2, 4, 3, 'manuel', NULL, NULL, 'Manu', 'Jimenez', 'accguatemala@sercogua.com', 0, NULL, 0, 1, '0.10', 0, 0, 'memin', 16),
(75, 2, 6, 3, 'ivania', NULL, NULL, 'Ivania', 'Sican', 'opguatemala2@sercogua.com', 1, '2388-4182', 10, 1, '0.10', 0, 0, '140189', 17),
(76, 2, 3, 3, 'jeannete', NULL, NULL, 'Jeannete', 'De Rayo', 'accguatemala2@sercogua.com', 0, 'Pendiente', 16, 1, '0.10', 0, 0, 'rayojea', 18),
(77, 2, 6, 1, 'saira', NULL, NULL, 'Saira', 'Sican', 'cbguatemala@sercogua.com', 0, '(502)23884181', 0, 1, '0.10', 0, 0, 'no', 19),
(78, 2, 3, 3, 'vero', NULL, NULL, 'Veronica', 'Guardado', 'ciguatemala@sercogua.com', 0, 'Pendiente', 15, 1, '0.10', 0, 0, 'guardado', 20),
(79, 2, 7, 3, 'juant', NULL, NULL, 'Juan Jose', 'Taracena', 'salesguatemala2', 0, NULL, 0, 1, '0.10', 0, 0, 'juan', 21),
(80, 2, 9, 3, 'lsanchez', NULL, NULL, 'Luis', 'Sanchez', 'cbguatemala@sercogua.com', 0, NULL, 0, 1, '0.10', 0, 0, 'aduanas3', 22),
(81, 2, 6, 3, 'soraida', NULL, NULL, 'Soraida', 'Soraida', 'assmgrguatemala@sercogua.com', 0, NULL, 0, 1, '0.10', 0, 0, 'asistente', 23),
(82, 2, 2, 1, 'marines', NULL, NULL, 'Marines', 'Guardado', 'managerguatemala@sercogua.com', 1, '(502)23884182', 0, 1, '0.10', 0, 0, 'guardado', 24),
(83, 2, 6, 7, 'anita', NULL, NULL, 'ANITA', 'ANITA', '', 0, NULL, 0, 1, '0.10', 0, 0, 'anita', 25),
(84, 2, 6, 7, 'brenda', NULL, NULL, 'Brenda\r\n', 'López\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'brenda', 26),
(85, 2, 6, 7, 'claudia', NULL, NULL, 'CLAUDIA', 'CLAUDIA', '', 0, NULL, 0, 1, '0.10', 0, 0, 'claudia', 27),
(86, 2, 6, 7, 'diana', NULL, NULL, 'DIANA', 'DIANA', '', 0, NULL, 0, 1, '0.10', 0, 0, 'diana', 28),
(87, 2, 6, 7, 'fransisco', NULL, NULL, 'FRANCISCO\r\n', 'FRANCISCO\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'fransisco', 29),
(88, 2, 6, 7, 'ingrid', NULL, NULL, 'INGRID\r\n', 'INGRID\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'ingrid', 30),
(89, 2, 6, 7, 'korin', NULL, NULL, 'KORIN\r\n', 'KORIN\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'korin', 31),
(90, 2, 6, 7, 'leslie', NULL, NULL, 'Leslie\r\n', 'Catalan\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'leslie', 32),
(91, 2, 6, 7, 'luvia', NULL, NULL, 'Luvia\r\n\r\n', 'Gudiel\r\n\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'luvia', 33),
(92, 2, 6, 7, 'marisol', NULL, NULL, 'Marisol\r\n', 'Gonzalez\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'marisol', 34),
(93, 2, 6, 7, 'marjorie', NULL, NULL, 'MARJORIE\r\n', 'MARJORIE\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'marjorie', 35),
(94, 2, 6, 7, 'mireya', NULL, NULL, 'Mireya\r\n', 'Palacios\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'mireya', 36),
(95, 2, 6, 7, 'monica', NULL, NULL, 'Monica\r\n\r\n', 'Contreras\r\n\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'monica', 37),
(96, 2, 6, 7, 'omar', NULL, NULL, 'OMAR\r\n', 'OMAR\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'omar', 38),
(97, 2, 6, 7, 'onelia', NULL, NULL, 'Onelia\r\n\r\n', 'Pudy\r\n\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'onelia', 39),
(98, 2, 6, 7, 'ricardo', NULL, NULL, 'RICARDO\r\n', 'RICARDO\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'ricardo', 40),
(99, 2, 6, 7, 'vivian', NULL, NULL, 'Vivian\r\n', 'Gutierrez\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'vivian', 41),
(100, 2, 6, 7, 'wendy', NULL, NULL, 'WENDY\r\n', 'WENDY\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'wendy', 42),
(101, 2, 6, 7, 'yadira', NULL, NULL, 'YADIRA\r\n', 'YADIRA\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'yadira', 43),
(102, 2, 6, 7, 'yeimith', NULL, NULL, 'YEIMITH\r\n', 'YEIMITH\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'yeimith', 44),
(103, 2, 6, 7, 'yolanda', NULL, NULL, 'Yolanda\r\n', 'Robles\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'yolanda', 45),
(104, 2, 6, 7, 'oscar', NULL, NULL, 'OSCAR\r\n', 'OSCAR\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'oscar', 46),
(105, 2, 6, 7, 'veronica', NULL, NULL, 'VERONICA\r\n', 'VERONICA\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'veronica', 47),
(106, 2, 5, 7, 'sandra', NULL, NULL, 'Sandra Patricia\r\n\r\n', 'Chile\r\n\r\n', '', 0, NULL, 0, 1, '0.10', 0, 0, 'sandra', 48),
(107, 2, 6, 3, 'sandra', NULL, NULL, 'Sandra', 'Mogollon', 'opguatemala1@sercogua.com', 0, NULL, 0, 1, '0.10', 0, 0, 'smogollon', 49),
(108, 2, 5, 3, 'byron', NULL, NULL, 'Byron', 'Mendizabal', 'csguatemala3@sercogua.com', 0, '(502)23884184', 0, 1, '0.10', 0, 0, 'byronm', 50),
(109, 2, 7, 3, 'hvelasquez', NULL, NULL, 'Hector', 'Velasquez', 'salesguatemala2@sercogua.com', 0, NULL, 0, 1, '0.10', 0, 0, '88121619', 51),
(110, 2, 6, 3, 'rmorales', NULL, NULL, 'Ruth', 'Morales', 'opguatemala3@sercogua.com', 0, NULL, 0, 1, '0.10', 0, 0, 'mishell', 55),
(111, 2, 1, 2, 'Jssue', NULL, NULL, 'Amilcar', 'Gil Gonzalez', '?¿', 0, NULL, 0, 1, '0.10', 0, 0, '003008j', 58),
(112, 2, 6, 3, 'Maira', NULL, NULL, 'Maira', 'Gil', 'dsfg', 0, NULL, 0, 1, '0.10', 0, 0, 'maira', 59),
(113, 2, 5, 9, 'KAREN', NULL, NULL, 'KAREN', 'SANDOVAL', 'csguatemala2@sercogua.com', 0, '23884184', 2, 1, '0.10', 0, 0, 'SANDOVAL', 60),
(114, 2, 7, 5, 'Mayra', NULL, NULL, 'Mayra', 'Gil', 'asd', 0, NULL, 0, 1, '0.10', 0, 0, '3811', 61),
(115, 2, 7, 2, 'sonia', NULL, NULL, 'Sonia', 'De Aldana', '0', 1, NULL, 4, 1, '0.50', 0, 0, 'sonia', 63),
(116, 2, 7, 11, 'Carlos', NULL, NULL, 'Carlos Jose', 'Luna Sagastume', 'salesguatemala@sercogua.com', 0, '23884183', 0, 1, '0.10', 0, 0, 'lunas', 64),
(117, 2, 7, 3, 'URL', NULL, NULL, 'Rafael', 'Landivar', 'asd', 0, NULL, 0, 1, '0.10', 0, 0, 'url', 65),
(118, 2, 6, 3, 'msolares', NULL, NULL, 'Marleny ', 'Solares ', 'opguatemala@sercogua.com', 0, '', 0, 1, '0.10', 0, 0, 'msolares', 66),
(119, 2, 7, 10, 'Llara', NULL, NULL, 'Esmeralda', 'Lara Pelaez', 'tlmkguatemala@sercogua.com', 0, '0', 0, 1, '0.10', 0, 0, 'Llara', 69),
(120, 2, 1, 1, 'tecnico', NULL, NULL, 'Arturo ', 'Escalante', '0', 0, '0', 0, 1, '0.10', 0, 0, 'tecnico', 70),
(121, 2, 7, 9, 'jgonzalez', NULL, NULL, 'Jose Antonio', 'Gonzalez Mendez', 'Pendiente', 0, '0000', 0, 1, '0.10', 0, 0, 'jgonzalez', 71),
(122, 2, 7, 9, 'ggomez', NULL, NULL, 'Gabriela Gomez', 'Cordon', 'Pendiente', 0, '00000', 0, 1, '0.10', 0, 0, 'ggomez', 72),
(123, 2, 2, 1, 'MIGUEL', NULL, NULL, 'MIGUEL', 'GUARDADO G', 'mguardado@sercogua.com', 1, '131', 0, 1, '0.10', 0, 0, 'SERCOGUA', 74),
(124, 2, 7, 2, 'delmi', NULL, NULL, 'Delmi ', 'Alarcon', 'salesguatemala3@sercogua.com', 0, 'ND', 1, 1, '0.10', 0, 0, 'delmi', 75),
(125, 2, 11, 2, 'internacional', NULL, NULL, 'Dpto Internacional', 'Internacional', 'guatemala@sercogua.com', 1, 'ND', 0, 1, '0.10', 0, 0, 'internacional', 77),
(126, 2, 9, 3, 'oclara', NULL, NULL, 'Oscar', 'Clará', 'cbguatemala@sercogua.com', 0, '', 12, 1, '0.10', 0, 0, 'oclara', 78),
(127, 2, 5, 3, 'jeamys', NULL, NULL, 'Jeamy Johana', 'Salazar Vasquez', 'csguatemala2@sercogua.com', 0, '23884183', 7, 1, '0.10', 0, 0, 'JEAN', 79),
(128, 2, 11, 3, 'Lpinelo', NULL, NULL, 'Lourdes', 'Pinelo', 'pricinggt@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'lpinelo', 80),
(129, 2, 3, 3, 'ajin', NULL, NULL, 'Alfredo', 'Lopez Ajin', '0', 0, '0', 0, 1, '0.10', 0, 0, 'ajin', 81),
(130, 2, 3, 3, 'pirir', NULL, NULL, 'Julia', 'Margarita de Pirir', '0', 0, '0', 0, 1, '0.10', 0, 0, 'pirir', 82),
(131, 2, 9, 3, 'jj', NULL, NULL, 'Balbina Ester', 'Jerez Mauricio', '0', 0, '0', 0, 1, '0.10', 0, 0, 'jj', 83),
(132, 2, 9, 3, 'dd', NULL, NULL, 'Eduardo Donado', 'Guerra', '0', 0, '0', 0, 1, '0.10', 0, 0, 'dd', 84),
(133, 2, 12, 12, 'jortiz', NULL, NULL, 'Julio ', 'Ortiz', 'csguatemala@sercogua.com', 1, '23884189', 5, 1, '0.10', 0, 0, '16129876', 85),
(134, 2, 6, 3, 'op01', NULL, NULL, 'Karla', 'Fernandez', 'opguatemala1@sercogua.com', 0, '--', 14, 1, '0.10', 0, 0, 'op01', 86),
(135, 2, 7, 3, 'agil', NULL, NULL, 'Amilcar ', 'Gil Merlos', 'pricinggt@sercogua.com', 0, '00000', 0, 1, '0.10', 0, 0, 'agil', 87),
(136, 2, 6, 3, 'victor', NULL, NULL, 'victor taque', 'Taque', 'opguatemala3@sercogua.com', 0, '2388-4182', 0, 1, '0.10', 0, 0, 'taque', 88),
(137, 2, 6, 3, 'marta', NULL, NULL, 'Marta', 'Sales', 'opguatemala1@sercogua.com', 0, 'ND', 0, 1, '0.10', 0, 0, 'sales', 90),
(138, 2, 12, 3, 'ksandoval', NULL, NULL, 'karen', 'sandoval', 'csguatemala2@sercogua.com', 0, '000', 0, 1, '0.10', 0, 0, 'ksandoval', 91),
(139, 2, 11, 3, 'pmartinez', NULL, NULL, 'Pedro ', 'Martinez', 'guatemala@sercogua.com', 0, '000', 0, 1, '0.10', 0, 0, 'palmieri', 92),
(140, 2, 5, 3, 'sjuarez', NULL, NULL, 'Sara ', 'Juarez', 'opguatemala3@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'saraj', 93),
(141, 2, 5, 3, 'christian', NULL, NULL, 'Christian', 'Aldana', 'csguatemala@sercogua.com', 0, '23884189', 0, 1, '0.10', 0, 0, 'aldana.e', 94),
(142, 2, 6, 2, 'op512', NULL, NULL, 'Monica', 'Castellanos', 'manageropguatemala@sercogua.com', 0, '23884181', 0, 1, '0.10', 0, 0, '183121', 95),
(143, 2, 6, 3, 'vegalvez', NULL, NULL, 'Vivyan', 'Galvez', 'opguatemala1@sercogua.com', 0, '114', 0, 1, '0.10', 0, 0, '12004967', 96),
(144, 2, 1, 2, 'invitado', NULL, NULL, 'invitado', 'invitado', 'asdf', 0, 'asdf', 0, 1, '0.10', 0, 0, 'invitado', 97),
(145, 2, 5, 3, 'ariel', NULL, NULL, 'Ariel', 'vivar', 'csguatemala2@sercogua.com', 0, '121', 0, 1, '0.10', 0, 0, 'Avivar', 98),
(146, 2, 7, 3, 'descobar', NULL, NULL, 'dayane', 'escobar', 'salesguatemala3@sercogua.com', 0, '2388 4100', 0, 1, '0.10', 0, 0, '51051051', 99),
(147, 2, 7, 1, 'asao', NULL, NULL, 'Ana Silvia', 'Arango', 'managersalesguatemala@sercogua.com', 0, '2388-4190', 0, 1, '0.10', 0, 0, 'ximval2509', 100),
(148, 2, 5, 3, 'delia', NULL, NULL, 'Delia', 'Gabriel', 'csguatemala1@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, '41171001', 101),
(149, 2, 5, 3, 'eunice', NULL, NULL, 'Gabriela E.', 'De León', 'csguatemala2@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'nanis', 102),
(150, 2, 3, 3, 'rosario', NULL, NULL, 'Rosario', 'Pirir', 'csguatemala1@sercogua.com', 1, '00', 0, 1, '0.10', 0, 0, 'andaby', 103),
(151, 2, 6, 3, 'joselyn', NULL, NULL, 'Joselyn', 'Morales', 'opguatemala1@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'morales', 104),
(152, 2, 4, 3, 'magdacay', NULL, NULL, 'Magda', 'Cay', 'accguatemala2', 0, '00', 0, 1, '0.10', 0, 0, '55680358', 105),
(153, 2, 3, 3, 'andres', NULL, NULL, 'Andres', 'Melgar', 'guatemala@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, '202619', 106),
(154, 2, 5, 3, 'wendy071', NULL, NULL, 'Wendy', 'Orozco', 'csguatemala2@sercogua.com', 0, '2388-4181', 0, 1, '0.10', 0, 0, '54164678', 107),
(155, 2, 11, 3, 'alejandra', NULL, NULL, 'Alejndra Mendosa', 'Mendoza', 'guatemala@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'a2109', 108),
(156, 2, 5, 3, 'mariac', NULL, NULL, 'Maria C', 'Del Carmen', 'csguatemala2@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'mariac', 109),
(157, 2, 11, 3, 'GabyA.', NULL, NULL, 'Gabriela', 'Aqui no', 'accguatemala2@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'accguate2', 110),
(158, 2, 11, 2, 'mngint', NULL, NULL, 'Plubio', 'Monterroso', 'managerint@sercogua', 0, '00', 0, 1, '0.10', 0, 0, 'sercgt', 111),
(159, 2, 6, 1, 'mpineda', NULL, NULL, 'Miguel P', 'Pineda', 'manageropguatemala@sercogua.com', 1, '00', 0, 1, '0.10', 0, 0, 'jmpc0911', 112),
(160, 2, 7, 9, 'lauro', NULL, NULL, 'Lauro', 'Manzo', 'salesguatemala6@sercogua.com', 0, '23884100', 0, 1, '0.10', 0, 0, 'lauro', 113),
(161, 2, 11, 3, 'eddie', NULL, NULL, 'Eddie', 'Mora', 'pricinggt@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'eddie', 115),
(162, 2, 6, 3, 'hector', NULL, NULL, 'HectorD', 'Davila', 'pendiente', 0, '00', 0, 1, '0.10', 0, 0, 'hector', 116),
(163, 2, 5, 3, 'vivian', NULL, NULL, 'Vivian G', 'Galvez', 'csguatemala1@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'vivian', 117),
(164, 2, 11, 3, 'angulo', NULL, NULL, 'Ana A', 'Angulo', 'accguatemala5@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'angulo', 118),
(165, 2, 5, 3, 'pamela', NULL, NULL, 'Pamela', 'Sican', 'opguatemala1@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'pamela', 119),
(166, 2, 7, 9, 'farid', NULL, NULL, 'Farid', 'acajabon', 'salesguatemala5@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'farid', 120),
(167, 2, 11, 3, 'inter01', NULL, NULL, 'deptointer', 'internacional', '@', 1, '00', 0, 1, '0.10', 0, 0, 'inter01', 121),
(168, 2, 6, 4, 'mare', NULL, NULL, 'marelyn', 'marelyn', '@', 0, '00', 0, 1, '0.10', 0, 0, 'marelyn', 122),
(169, 2, 5, 3, 'ingrid', NULL, NULL, 'Ingrid', 'Mendez', 'csguatemala3@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'ingrid', 123),
(170, 2, 7, 9, 'portillo', NULL, NULL, 'Jenniferp', 'Portillo', 'salesguatemala3', 0, '00', 0, 1, '0.10', 0, 0, 'portillo', 124),
(171, 2, 11, 3, 'lalamejia', NULL, NULL, 'Mejia', 'Mejia', '00', 0, '00', 0, 1, '0.10', 0, 0, '2982014m', 125),
(172, 2, 7, 13, 'jessika', NULL, NULL, 'Jessika', 'Garcia', 'salesguatemala6@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'jessika', 126),
(173, 2, 7, 3, 'lubia', NULL, NULL, 'Lubia', 'Gudiel', 'pricintgt@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'lubia', 127),
(174, 2, 7, 9, 'consuegra', NULL, NULL, 'Gabriela Consuegra', 'Consuegra', 'salesguatemala7@sercogua.com', 1, '00', 0, 1, '0.50', 0, 0, 'consuegra', 128),
(175, 2, 7, 3, 'almadisa', NULL, NULL, 'almadisa', 'almadisa gt', '00', 1, '00', 0, 1, '0.10', 0, 0, 'almadisa', 129),
(176, 2, 7, 9, 'luis', NULL, NULL, 'luis s', 'sanchez', '00', 0, '', 0, 1, '0.10', 0, 0, 'sanchez', 130),
(177, 2, 5, 3, 'evelyn', NULL, NULL, 'evelyn', 'ramirez', 'opguatemala4', 0, '00', 0, 1, '0.10', 0, 0, 'evelyn', 131),
(178, 2, 9, 3, 'carlosc', NULL, NULL, 'carlos castellanos', 'castellanos', '00', 0, '00', 0, 1, '0.10', 0, 0, 'carlosc', 132),
(179, 2, 5, 3, 'gcontreras', NULL, NULL, 'Gabriel Contreras', 'contreras', '00', 0, '00', 0, 1, '0.10', 0, 0, 'gcontreras', 133),
(180, 2, 7, 2, 'cristina', NULL, NULL, 'cristina cardona', 'cardona', '00', 0, '00', 0, 1, '0.10', 0, 0, 'cardona', 134),
(181, 2, 7, 3, 'rosseth', NULL, NULL, 'Rosseth', 'Bautista', '00', 0, '00', 0, 1, '0.10', 0, 0, 'bautista', 135),
(182, 2, 3, 3, 'maria', NULL, NULL, 'Maria jose', 'pineda', '00', 0, '00', 0, 1, '0.10', 0, 0, 'pineda', 136),
(183, 2, 7, 9, 'luisaf', NULL, NULL, 'Luisa F', 'Araujo', '00', 0, '00', 0, 1, '0.10', 0, 0, 'luisaf', 137),
(184, 2, 7, 9, 'priscilaj', NULL, NULL, 'Priscila', 'Jegerlehner', '00', 1, '00', 0, 1, '0.10', 0, 0, 'priscilaj', 138),
(185, 2, 7, 9, 'kevin', NULL, NULL, 'Kevin Alejandro', 'Lopez', '00', 0, '00', 0, 1, '0.10', 0, 0, 'kevin', 139),
(186, 2, 4, 3, 'jose', NULL, NULL, 'Jose', 'Tepet', '00', 1, '00', 0, 1, '0.10', 0, 0, 'tepet', 140),
(187, 2, 7, 9, 'estuardo', NULL, NULL, 'Estuardo', 'Florian', '00', 0, '00', 0, 1, '0.10', 0, 0, 'estuardo', 141),
(188, 2, 5, 3, 'Edin', NULL, NULL, 'Edin', 'Alfaro', '00', 1, '00', 0, 1, '0.10', 0, 0, 'alfaro', 142),
(189, 2, 11, 3, 'carla', NULL, NULL, 'Carla', 'Mejia', '00', 0, '00', 0, 1, '0.10', 0, 0, 'mejia', 143),
(190, 2, 7, 13, 'deborah', NULL, NULL, 'Deborah', 'Martinez', 'pricinggt@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'deborah', 144),
(191, 2, 7, 9, 'karla', NULL, NULL, 'Karla N', 'Noriega', '00', 0, '00', 0, 1, '0.10', 0, 0, 'noriega', 145),
(192, 2, 7, 9, 'eduardom', NULL, NULL, 'Eduardo M', 'Montenegro', '00', 0, '00', 0, 1, '0.10', 0, 0, 'eduardom', 146),
(193, 2, 7, 9, 'mildred', NULL, NULL, 'Mildred', 'Lima', '00', 0, '00', 0, 1, '0.10', 0, 0, 'lima', 147),
(194, 2, 5, 3, 'MENOCAL', NULL, NULL, 'FRANCISCO MENOCAL', 'MENOCAL', '00', 0, '00', 0, 1, '0.10', 0, 0, 'MENOCAL', 148),
(195, 2, 7, 3, 'maribel', NULL, NULL, 'Maribel', 'Garcia', '00', 0, '00', 0, 1, '0.10', 0, 0, 'garcia', 149),
(196, 2, 12, 3, 'axel', NULL, NULL, 'axel', 'rax', '00', 0, '00', 0, 1, '0.10', 0, 0, 'axel', 150),
(197, 2, 5, 3, 'maria', NULL, NULL, 'Maria Josefa', 'pocasangre', '00', 0, '00', 0, 1, '0.10', 0, 0, '10032903', 151),
(198, 2, 5, 3, 'katerin', NULL, NULL, 'Katerin', 'Rodas', '00', 0, '00', 0, 1, '0.10', 0, 0, 'rodas', 152),
(199, 2, 7, 9, 'erick', NULL, NULL, 'Erick', 'Escobar', '00', 1, '00', 0, 1, '0.10', 0, 0, 'erick', 153),
(200, 2, 7, 9, 'lisbeth', NULL, NULL, 'Lisbeth', 'Ramirez', '00', 1, '00', 0, 1, '0.10', 1, 0, 'lisbeth', 154),
(201, 2, 5, 3, 'carmen', NULL, NULL, 'Carmen', 'Martinez', '00', 1, '00', 0, 1, '0.10', 0, 0, 'carmen', 155),
(202, 2, 5, 3, 'amy', NULL, NULL, 'Amy', 'Mendez', '00', 0, '00', 0, 1, '0.10', 0, 0, 'amy', 156),
(203, 2, 3, 3, 'mario', NULL, NULL, 'Mario', 'Salgado', '00', 1, '00', 0, 1, '0.10', 0, 0, 'mario', 157),
(204, 2, 7, 13, 'yaska', NULL, NULL, 'Yaska', 'tol', '00', 0, '00', 0, 1, '0.10', 0, 0, 'tol', 158),
(205, 2, 7, 13, 'liseth', NULL, NULL, 'Liseth', 'Justianiano', '00', 0, '00', 0, 1, '0.10', 0, 0, 'liseth', 159),
(206, 2, 5, 13, 'eber', NULL, NULL, 'Eber', 'Cante', '00', 1, '00', 0, 1, '0.10', 1, 0, 'eber', 160),
(207, 2, 7, 3, 'ronnie', NULL, NULL, 'Ronnie', 'Barrios', '00', 0, '00', 0, 1, '0.10', 0, 0, 'ronnie', 161),
(208, 2, 7, 3, 'gelbert', NULL, NULL, 'Gelbert', 'Gonzales', '00', 1, '00', 0, 1, '0.50', 0, 0, 'gelbert', 162),
(209, 2, 12, 3, 'hugo', NULL, NULL, 'Hugo', 'Vasquez', 'e2eguatemala3@sercogua.com', 0, '00', 0, 1, '0.10', 0, 0, 'hugo', 163),
(210, 2, 12, 9, 'karlam', NULL, NULL, 'Karla Mendoza', 'Mendoza', '00', 1, '00', 0, 1, '0.10', 0, 0, 'karlam', 164),
(211, 2, 5, 3, 'silvia', NULL, NULL, 'silvia', 'hernandez', '00', 1, '00', 0, 1, '0.10', 0, 0, 'silvia', 165),
(212, 2, 12, 3, 'emys', NULL, NULL, 'Emy Subuyuj', 'Subuyuj', '00', 1, '00', 0, 1, '0.10', 0, 0, 'emys', 166),
(213, 2, 11, 13, 'gerardoa', NULL, NULL, 'Gerando A', 'Arreaga', '00', 1, '00', 0, 1, '0.10', 0, 0, 'gerardoa', 167),
(214, 2, 7, 3, 'andreac', NULL, NULL, 'Andrea Carazo', 'Carazo', '00', 1, '00', 0, 1, '0.10', 0, 0, 'andreac', 168),
(215, 2, 5, 5, 'olgac', NULL, NULL, 'Olga Carolina', 'posadas', 'opcs', 1, '00', 0, 1, '0.10', 0, 0, 'olgac', 169),
(216, 2, 7, 9, 'maurel', NULL, NULL, 'Maurel', 'Interiano', '00', 1, '00', 0, 1, '0.10', 0, 0, 'maurel', 170),
(217, 2, 6, 3, 'patricia', NULL, NULL, 'Patricia', 'Leiva', '00', 1, '00', 0, 1, '0.10', 0, 0, 'patricia', 171),
(218, 2, 3, 3, 'marcela', NULL, NULL, 'Marcela', 'Guzman', '00', 1, '00', 0, 1, '0.10', 0, 0, 'marcela', 172),
(219, 2, 5, 3, 'glendi', NULL, NULL, 'Glendi', 'Perez', 'e2eguatemala3@sercogua.com', 1, '00', 0, 1, '0.10', 0, 0, 'glendi', 173),
(220, 2, 5, 3, 'alejandram', NULL, NULL, 'Alejandra', 'Moreno', '00', 1, '00', 0, 1, '0.10', NULL, 0, 'alejandram', 174),
(221, 2, 3, 3, 'alison', NULL, NULL, 'alison', 'vargas', 'accguatemala7@sercogua.com', 1, '00', 0, 1, '0.10', NULL, 0, 'alison', 175),
(222, 2, 5, 3, 'crisly', NULL, NULL, 'Crisly', 'Martinez', '00', 1, '00', 0, 1, '0.10', NULL, 0, 'crisly', 176),
(223, 5, 1, 2, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '', 'Manuel Estuardo', 'de la cruz L&oacute;pez', 'itguatemala@gmail.com', 1, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0);

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
(23, 'Bancos', 0),
(24, 'Comercial', 0),
(25, 'EvaluacionProyecto', 24),
(26, 'Tarifariotru', 24),
(27, 'Ventatru', 24),
(28, 'ServicioCliente', 0),
(29, 'Cuentasporcobrar', 0),
(30, 'Cuentasporpagar', 0),
(31, 'Recepcion', 0),
(32, 'RRHH', 0);

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
-- Estructura de tabla para la tabla `permisos_especiales`
--

CREATE TABLE `permisos_especiales` (
  `id_permiso` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Estructura de tabla para la tabla `productos_venta_truck`
--

CREATE TABLE `productos_venta_truck` (
  `id_producto` int(11) NOT NULL,
  `codigo_producto` varchar(50) NOT NULL,
  `descripcion` varchar(800) NOT NULL,
  `volumen` decimal(10,3) NOT NULL,
  `peso` decimal(10,3) NOT NULL,
  `bultos` smallint(6) NOT NULL,
  `peso_bultos` smallint(6) NOT NULL,
  `id_venta_truck` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos_venta_truck`
--

INSERT INTO `productos_venta_truck` (`id_producto`, `codigo_producto`, `descripcion`, `volumen`, `peso`, `bultos`, `peso_bultos`, `id_venta_truck`) VALUES
(1, '12123', 'pruebasdfdsfades  ', '4.000', '4.000', 4, 4, 10),
(2, '58', 'prueba prudcto', '6.000', '3.000', 4, 85, 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puesto`
--

CREATE TABLE `puesto` (
  `id_puesto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `Tipo` tinyint(4) DEFAULT NULL,
  `NombreT` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `puesto`
--

INSERT INTO `puesto` (`id_puesto`, `nombre`, `Tipo`, `NombreT`) VALUES
(1, 'GERENTE             ', 1, 'AMB                 '),
(2, 'COORDINADOR         ', 1, 'AMB                 '),
(3, 'ASISTENTE           ', 2, 'AM                  '),
(4, 'PRACTICANTE         ', 3, 'A                   '),
(5, 'OPERATIVO-A         ', 3, 'A                   '),
(6, 'OPERATIVO-B         ', 3, 'B                   '),
(7, 'OPERATIVO-C         ', 3, 'C                   '),
(8, 'TECNICO             ', 2, 'AM                  '),
(9, 'ASESOR DE LOGISTICA ', NULL, NULL),
(10, 'EJECUTIVA DE TELEMERCADEO', NULL, NULL),
(11, 'GERENTE DE VENTAS', NULL, NULL),
(12, 'SUPERVISOR', NULL, NULL),
(13, 'Pricing', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio_adicionales_venta_truck`
--

CREATE TABLE `servicio_adicionales_venta_truck` (
  `id_servicio_adicional` int(11) NOT NULL,
  `id_venta_truck` int(11) NOT NULL,
  `id_catalogo` int(11) NOT NULL,
  `tarifa_venta` decimal(10,2) NOT NULL,
  `tarifa_costo` decimal(10,2) NOT NULL,
  `cantidad` smallint(6) NOT NULL,
  `profit` decimal(10,2) NOT NULL,
  `id_moneda` tinyint(4) NOT NULL,
  `origen` varchar(800) NOT NULL,
  `destino` varchar(800) NOT NULL,
  `comision` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `servicio_adicionales_venta_truck`
--

INSERT INTO `servicio_adicionales_venta_truck` (`id_servicio_adicional`, `id_venta_truck`, `id_catalogo`, `tarifa_venta`, `tarifa_costo`, `cantidad`, `profit`, `id_moneda`, `origen`, `destino`, `comision`) VALUES
(1, 10, 2, '500.00', '400.00', 1, '90.00', 3, 'origen', 'destino', '10.00'),
(2, 0, 13, '100.00', '50.00', 1, '51.00', 3, 'guatemala', 'nicaragua', NULL),
(3, 0, 13, '100.00', '50.00', 1, '51.00', 3, 'guatemala', 'nicaragua', NULL),
(5, 0, 2, '88.00', '2.00', 2, '176.00', 3, 'asdf', 'ads', NULL),
(6, 15, 3, '500.00', '400.00', 2, '0.00', 3, 'origen', 'destino', NULL),
(7, 15, 2, '500.00', '400.00', 2, '0.00', 3, 'origen2', 'destino2', NULL),
(8, 16, 3, '500.00', '400.00', 0, '0.00', 3, 'origen', 'destino', NULL),
(9, 17, 3, '500.00', '400.00', 0, '0.00', 3, 'origen', 'destino', NULL),
(10, 18, 3, '500.00', '400.00', 4, '400.00', 3, 'origen', 'destino', NULL),
(11, 18, 14, '500.00', '400.00', 1, '101.00', 3, 'prueba', 'prueba', NULL),
(12, 19, 3, '500.00', '400.00', 3, '992.70', 3, 'origen', 'destino', '110.30'),
(13, 19, 2, '500.00', '400.00', 1, '100.00', 3, 'origen2', 'destino2', NULL),
(19, 21, 2, '500.00', '450.00', 3, '947.70', 3, 'origen2', 'destino2', '105.30'),
(20, 27, 3, '500.00', '400.00', 1, '90.00', 3, 'origen', 'destino', '10.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio_flete_venta_truck`
--

CREATE TABLE `servicio_flete_venta_truck` (
  `id_servicio_flete` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `origen` varchar(800) NOT NULL,
  `destino` varchar(800) NOT NULL,
  `tarifa_venta` decimal(10,2) NOT NULL,
  `tarifa_costo` decimal(10,2) NOT NULL,
  `unidades` tinyint(4) NOT NULL,
  `total_venta` decimal(10,2) NOT NULL,
  `total_costo` decimal(10,2) NOT NULL,
  `profit` decimal(10,2) NOT NULL,
  `hora_posicionamiento` time NOT NULL,
  `id_moneda` tinyint(4) NOT NULL,
  `comision` decimal(10,2) DEFAULT NULL,
  `fecha_posicion` date DEFAULT NULL,
  `dias_libres` tinyint(4) DEFAULT NULL,
  `id_tipo_carga` tinyint(4) NOT NULL,
  `id_tipo_unidad` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `servicio_flete_venta_truck`
--

INSERT INTO `servicio_flete_venta_truck` (`id_servicio_flete`, `id_venta`, `origen`, `destino`, `tarifa_venta`, `tarifa_costo`, `unidades`, `total_venta`, `total_costo`, `profit`, `hora_posicionamiento`, `id_moneda`, `comision`, `fecha_posicion`, `dias_libres`, `id_tipo_carga`, `id_tipo_unidad`) VALUES
(1, 3, 'origen', 'destino', '100.00', '50.00', 0, '0.00', '0.00', '0.00', '00:00:00', 3, NULL, NULL, NULL, 0, NULL),
(2, 4, 'origen', 'destino', '100.00', '50.00', 0, '0.00', '0.00', '0.00', '00:00:00', 3, NULL, NULL, NULL, 0, NULL),
(3, 5, 'origen', 'destino', '100.00', '50.00', 0, '0.00', '0.00', '0.00', '00:00:00', 3, NULL, NULL, NULL, 0, NULL),
(4, 6, 'origen', 'destino', '100.00', '50.00', 0, '0.00', '0.00', '0.00', '00:00:00', 3, NULL, NULL, NULL, 0, NULL),
(5, 7, 'origen', 'destino', '100.00', '50.00', 0, '0.00', '0.00', '0.00', '00:00:00', 3, NULL, NULL, NULL, 0, NULL),
(6, 8, 'origen', 'destino', '100.00', '50.00', 0, '0.00', '0.00', '0.00', '00:00:00', 3, NULL, NULL, NULL, 0, NULL),
(7, 9, 'origen cambio', 'destino ambio', '100.00', '50.00', 2, '200.00', '100.00', '90.00', '14:00:00', 3, '10.00', '2022-03-08', 3, 1, NULL),
(8, 10, 'origen', 'destino', '100.00', '50.00', 1, '100.00', '50.00', '45.00', '15:50:00', 3, '5.00', '2022-03-27', 3, 1, 7),
(9, 15, 'origen', 'destino', '100.00', '50.00', 3, '1.00', '1.00', '2.00', '14:07:00', 3, NULL, NULL, NULL, 0, NULL),
(10, 15, 'origen', 'destino', '100.00', '50.00', 0, '0.00', '0.00', '0.00', '00:00:00', 3, NULL, NULL, NULL, 0, NULL),
(11, 16, 'origen', 'destino', '100.00', '50.00', 0, '0.00', '0.00', '0.00', '00:00:00', 3, NULL, NULL, NULL, 0, NULL),
(12, 17, 'origen', 'destino', '100.00', '50.00', 0, '0.00', '0.00', '0.00', '00:00:00', 3, NULL, NULL, NULL, 0, NULL),
(13, 18, 'origen', 'destino', '100.00', '50.00', 2, '200.00', '100.00', '100.00', '23:31:00', 3, NULL, NULL, NULL, 0, NULL),
(14, 19, 'origen', 'destino', '100.00', '50.00', 1, '100.00', '50.00', '50.00', '23:27:00', 3, NULL, NULL, NULL, 0, NULL),
(15, 19, 'origen', 'destino', '100.00', '50.00', 1, '100.00', '50.00', '50.00', '00:00:00', 3, NULL, NULL, NULL, 0, NULL),
(16, 21, 'origen', 'destino', '200.00', '100.00', 4, '800.00', '400.00', '360.00', '12:01:00', 3, '40.00', '2022-03-10', 2, 1, NULL),
(17, 21, 'origen', 'destino', '100.00', '50.00', 3, '300.00', '150.00', '135.00', '00:00:00', 3, '15.00', '0000-00-00', 0, 1, NULL),
(19, 10, 'guatemala', 'el salvador', '500.00', '400.00', 4, '2000.00', '1600.00', '360.00', '20:00:00', 3, '40.00', '2022-03-13', 3, 2, 8),
(20, 27, 'origen', 'destino', '100.00', '50.00', 1, '100.00', '50.00', '45.00', '00:00:00', 3, '5.00', '0000-00-00', 0, 1, 2),
(21, 27, 'origen', 'destino', '100.00', '50.00', 1, '100.00', '50.00', '45.00', '00:00:00', 3, '5.00', '0000-00-00', 0, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio_target`
--

CREATE TABLE `servicio_target` (
  `id_servicio_target` int(11) NOT NULL,
  `id_servicio` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `lugar_carga` varchar(800) NOT NULL,
  `lugar_descarga` varchar(800) NOT NULL,
  `tarifa_venta` decimal(10,2) DEFAULT NULL,
  `tarifa_costo` decimal(10,2) DEFAULT NULL,
  `id_moneda` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `servicio_target`
--

INSERT INTO `servicio_target` (`id_servicio_target`, `id_servicio`, `id_proyecto`, `lugar_carga`, `lugar_descarga`, `tarifa_venta`, `tarifa_costo`, `id_moneda`) VALUES
(1, 1, 38, 'aca', 'cs', '2.00', '2.00', 3),
(2, 3, 0, '', '', NULL, NULL, NULL),
(3, 3, 0, 'aca', 'cs', '2.00', '2.00', 3),
(4, 2, 0, '', '', NULL, NULL, NULL),
(5, 3, 39, '', '', NULL, NULL, NULL),
(6, 2, 39, '', '', NULL, NULL, NULL),
(7, 2, 39, 'lugar de carga', 'lugar de descarga', NULL, NULL, NULL),
(8, 3, 47, 'lugar de carga', 'lugar de descarga', NULL, NULL, NULL),
(9, 3, 63, 'asdf', 'asdf', '3.00', '3.00', 3),
(10, 21, 63, 'asdf', 'asdf', '4.00', '1.00', 3),
(11, 20, 47, 'asd', 'asdf', '3.00', '2.00', 3),
(12, 20, 47, 'asdf', 'sdaf', '2.00', '1.00', 3),
(13, 13, 47, 'aca', 'cs', '2.00', '2.00', 3),
(14, 0, 66, 'asdf', 'asdf', '6.00', '1.00', 3),
(15, 14, 67, 'puebas', 'descarga', '11.00', '5.00', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sino`
--

CREATE TABLE `sino` (
  `id_sino` int(11) NOT NULL,
  `nombre` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sino`
--

INSERT INTO `sino` (`id_sino`, `nombre`) VALUES
(1, 'SI'),
(2, 'NO');

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
(4, 'ALMADISA CR', 'ALMACENAMIENTO MANEJO Y DISTRIBUCION COSTA RICA', '50623037000', '123456789101112', 'bodega caldera costa rica', '', '2021-08-11', 1, 59, 'ALMCR4', '0.13', '3.75'),
(5, 'TRUCK AND DELIVERY', 'TRUCK AND DELIVERY', '23037000', '2315645', '0 calle b 17-10 colonia el Maestro zona 15', '', '2022-01-29', 1, 92, 'TRUGT5', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal_empresa`
--

CREATE TABLE `sucursal_empresa` (
  `id_sucursal_empresa` int(11) NOT NULL,
  `nombre` varchar(500) NOT NULL,
  `id_empresa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sucursal_empresa`
--

INSERT INTO `sucursal_empresa` (`id_sucursal_empresa`, `nombre`, `id_empresa`) VALUES
(1, 'cambio nuevamante', 93);

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
(1, 'Pequeña 1 a 20 Empleados'),
(2, 'Mediana 21 a 50 Empleados'),
(3, 'Grande mas 51 Empleados'),
(4, 'Multinacional');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifariotruck`
--

CREATE TABLE `tarifariotruck` (
  `id_tarifario_truck` int(11) NOT NULL,
  `origen` varchar(800) NOT NULL,
  `destino` varchar(800) NOT NULL,
  `id_tipo_unidad` int(11) NOT NULL,
  `id_tipo_carga` int(11) NOT NULL,
  `id_piloto` tinyint(4) NOT NULL,
  `ayudantes` smallint(6) NOT NULL,
  `tarifa_venta` decimal(18,2) NOT NULL,
  `tarifa_costo` decimal(18,2) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `id_moneda` tinyint(4) NOT NULL,
  `validez` date NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fechagraba` timestamp NOT NULL DEFAULT current_timestamp(),
  `fechamodifica` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tarifariotruck`
--

INSERT INTO `tarifariotruck` (`id_tarifario_truck`, `origen`, `destino`, `id_tipo_unidad`, `id_tipo_carga`, `id_piloto`, `ayudantes`, `tarifa_venta`, `tarifa_costo`, `id_proyecto`, `id_moneda`, `validez`, `id_sucursal`, `id_usuario`, `fechagraba`, `fechamodifica`) VALUES
(1, 'origen', 'destino', 2, 1, 0, 5, '100.00', '50.00', 47, 3, '2022-02-08', 5, 223, '2022-02-09 02:56:02', '2022-03-08'),
(2, 'origen', 'destino', 1, 1, 0, 5, '100.00', '50.00', 47, 3, '2022-02-08', 5, 223, '2022-02-09 02:56:53', '2022-03-08'),
(3, 'origen', 'destino', 1, 2, 0, 2, '100.00', '50.00', 47, 3, '2022-02-08', 5, 223, '2022-02-09 02:57:53', '2022-03-08'),
(4, 'origen', 'destino', 1, 2, 2, 2, '100.00', '50.00', 47, 3, '2022-02-08', 5, 223, '2022-02-09 02:58:55', '2022-02-09'),
(5, 'origen cambio', 'destino cambio', 3, 3, 0, 2, '5.00', '1.00', 47, 3, '2022-04-01', 5, 223, '2022-02-09 02:59:45', '2022-03-08'),
(6, 'origen', 'destino', 9, 2, 0, 2, '12.00', '3.00', 62, 3, '2022-03-11', 5, 223, '2022-03-12 04:33:16', '2022-03-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifa_servicio`
--

CREATE TABLE `tarifa_servicio` (
  `id_tarifa_servicio` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `id_servicio` int(11) NOT NULL,
  `id_moneda` tinyint(4) NOT NULL,
  `origen` varchar(800) NOT NULL,
  `destino` varchar(800) NOT NULL,
  `tarifa_venta` decimal(18,2) NOT NULL,
  `tarifa_costo` decimal(18,2) NOT NULL,
  `validez` date NOT NULL,
  `fechagraba` timestamp NOT NULL DEFAULT current_timestamp(),
  `fechamodifica` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tarifa_servicio`
--

INSERT INTO `tarifa_servicio` (`id_tarifa_servicio`, `id_sucursal`, `id_usuario`, `id_proyecto`, `id_servicio`, `id_moneda`, `origen`, `destino`, `tarifa_venta`, `tarifa_costo`, `validez`, `fechagraba`, `fechamodifica`) VALUES
(1, 5, 223, 47, 3, 3, 'origen', 'destino', '500.00', '400.00', '0000-00-00', '2022-02-09 18:18:57', '2022-02-09'),
(2, 5, 223, 47, 2, 3, 'origen2', 'destino2', '500.00', '400.00', '2022-03-22', '2022-02-09 18:20:19', '2022-03-08'),
(3, 5, 223, 47, 2, 5, 'er', 'des', '1000.00', '500.00', '2022-03-23', '2022-02-09 18:21:31', '2022-03-08'),
(4, 5, 223, 47, 1, 3, 'adsf', 'dfd', '4.00', '3.00', '0000-00-00', '2022-02-09 18:23:09', '2022-02-09'),
(5, 5, 223, 47, 3, 3, 'asdf', 'asdf', '2.00', '1.00', '0000-00-00', '2022-02-09 18:25:08', '2022-02-09'),
(6, 5, 223, 47, 3, 3, 'asf', 'asdf', '1.00', '1.00', '0000-00-00', '2022-02-09 18:25:49', '2022-02-09'),
(7, 5, 223, 47, 2, 3, 'adfdfeeee', 'ee', '11.00', '2.00', '2022-02-09', '2022-02-09 18:27:27', '2022-02-09'),
(8, 5, 223, 62, 20, 3, 'asdfasdfasdf', 'asdfasdfsd', '4.00', '2.00', '2022-03-11', '2022-03-12 04:33:39', '2022-03-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifa_target_proyecto`
--

CREATE TABLE `tarifa_target_proyecto` (
  `idtarifa_target` int(11) NOT NULL,
  `id_tipo_unidad` smallint(6) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `id_fianza` smallint(6) NOT NULL,
  `lugar_carga` varchar(800) NOT NULL,
  `lugar_descarga` varchar(800) NOT NULL,
  `tarifa_venta` decimal(10,2) DEFAULT NULL,
  `tarifa_costo` decimal(10,2) DEFAULT NULL,
  `id_moneda` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tarifa_target_proyecto`
--

INSERT INTO `tarifa_target_proyecto` (`idtarifa_target`, `id_tipo_unidad`, `id_proyecto`, `id_fianza`, `lugar_carga`, `lugar_descarga`, `tarifa_venta`, `tarifa_costo`, `id_moneda`) VALUES
(1, 1, 29, 2, 'hh', 'hh', NULL, NULL, NULL),
(2, 1, 30, 2, 'asdf', 'asdf', NULL, NULL, NULL),
(3, 1, 30, 2, 'asdf', 'asdf', NULL, NULL, NULL),
(4, 1, 31, 2, 'kjk', 'jk', NULL, NULL, NULL),
(5, 1, 32, 2, 'kj', 'zxcv', NULL, NULL, NULL),
(6, 1, 32, 1, 'adf', 'asdf', NULL, NULL, NULL),
(7, 1, 33, 2, 'asdf', 'adsf', NULL, NULL, NULL),
(8, 1, 35, 2, 'asdf', 'adsf', NULL, NULL, NULL),
(9, 1, 36, 2, 'lugar de carga', 'lugar de descarga', NULL, NULL, NULL),
(10, 3, 36, 1, 'ad', 'asdfadf', NULL, NULL, NULL),
(11, 3, 36, 1, 'ad', 'asdfadf', NULL, NULL, NULL),
(12, 0, 37, 0, '', '', NULL, NULL, NULL),
(13, 0, 37, 0, '', '', NULL, NULL, NULL),
(14, 0, 37, 0, '', '', NULL, NULL, NULL),
(15, 0, 37, 0, '', '', NULL, NULL, NULL),
(16, 0, 37, 0, '', '', NULL, NULL, NULL),
(17, 0, 37, 0, '', '', NULL, NULL, NULL),
(18, 0, 37, 0, '', '', NULL, NULL, NULL),
(19, 1, 47, 2, 'lugar de carga', 'lugar de descarga', NULL, NULL, NULL),
(20, 8, 0, 2, 'asdf', 'asdf', NULL, NULL, NULL),
(21, 7, 0, 1, '', '', NULL, NULL, NULL),
(22, 1, 0, 2, '', '', NULL, NULL, NULL),
(23, 1, 63, 2, 'carga', 'descarga', '100.00', '50.00', 5),
(26, 8, 66, 2, 'vcvd', 'vcvd', '7.00', '7.00', 3),
(27, 10, 67, 2, ' ar', 'cd', '2.00', '1.00', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_carga`
--

CREATE TABLE `tipo_carga` (
  `id_tipo_carga` int(11) NOT NULL,
  `id_tipo_medio` int(11) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `Proveedor` varchar(15) NOT NULL,
  `Cliente` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_carga`
--

INSERT INTO `tipo_carga` (`id_tipo_carga`, `id_tipo_medio`, `nombre`, `Proveedor`, `Cliente`) VALUES
(1, 2, 'FCL / FCL', 'UNO', 'UNO'),
(2, 2, 'FCL / LCL', 'UNO', 'VARIOS'),
(3, 2, 'LCL / LCL', 'VARIOS', 'VARIOS'),
(4, 2, 'LCL / FCL', 'VARIOS', 'UNO'),
(5, 2, 'COLODER', 'VARIOS', 'VARIOS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_carga_empresa`
--

CREATE TABLE `tipo_carga_empresa` (
  `id_tipo_carga_empresa` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `id_sucursal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_carga_empresa`
--

INSERT INTO `tipo_carga_empresa` (`id_tipo_carga_empresa`, `nombre`, `id_sucursal`) VALUES
(1, 'General', 5),
(2, 'Fria o Congelada', 5),
(3, 'Peligrosa', 5);

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
-- Estructura de tabla para la tabla `tipo_equipo_truc`
--

CREATE TABLE `tipo_equipo_truc` (
  `idtipo_equipo_truc` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_equipo_truc`
--

INSERT INTO `tipo_equipo_truc` (`idtipo_equipo_truc`, `nombre`) VALUES
(1, 'Furgón'),
(2, 'Plataforma'),
(3, 'Volteo'),
(4, 'Palangana'),
(5, 'Pipa'),
(6, 'Rastra'),
(7, 'Araña'),
(8, 'Jaula');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_licencia`
--

CREATE TABLE `tipo_licencia` (
  `id_tipo_licencia` int(11) NOT NULL,
  `nombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_licencia`
--

INSERT INTO `tipo_licencia` (`id_tipo_licencia`, `nombre`) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'M'),
(5, 'E');

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
(1, 'IMPORTACION '),
(2, 'EXPORTACION');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_unidades_truc`
--

CREATE TABLE `tipo_unidades_truc` (
  `idtipo_unidades` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_unidades_truc`
--

INSERT INTO `tipo_unidades_truc` (`idtipo_unidades`, `id_sucursal`, `nombre`) VALUES
(1, 5, '1.5TM'),
(2, 5, '2.5TM'),
(3, 5, '3.5TM'),
(4, 5, 'Panel'),
(5, 5, '5TM'),
(6, 5, '8TM'),
(7, 5, '10TM'),
(8, 5, '12TM'),
(9, 5, '48Pies'),
(10, 5, '53Pies'),
(11, 5, 'Contenedor de 20'),
(12, 5, 'Contenedor de 40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_venta_truck`
--

CREATE TABLE `tipo_venta_truck` (
  `id_tipo_venta` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_venta_truck`
--

INSERT INTO `tipo_venta_truck` (`id_tipo_venta`, `nombre`) VALUES
(1, 'Nacional'),
(2, 'Internacional');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_medida`
--

CREATE TABLE `unidad_medida` (
  `id_unidad_medida` int(11) NOT NULL,
  `nombre` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `unidad_medida`
--

INSERT INTO `unidad_medida` (`id_unidad_medida`, `nombre`) VALUES
(1, 'lb'),
(2, 'kg'),
(3, 't');

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_truck`
--

CREATE TABLE `venta_truck` (
  `id_venta_truck` int(11) NOT NULL,
  `id_tipoventa` tinyint(4) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_usuario_modifica` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `fecha_graba` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_modifica` date NOT NULL,
  `botas` tinyint(1) NOT NULL,
  `chaleco` tinyint(1) NOT NULL,
  `lentes` tinyint(1) NOT NULL,
  `guantes` tinyint(1) NOT NULL,
  `mascarilla` tinyint(1) NOT NULL,
  `careta` tinyint(1) NOT NULL,
  `otros` varchar(100) NOT NULL,
  `id_embarcador` int(11) NOT NULL,
  `id_notificar` int(11) NOT NULL,
  `id_agente` int(11) NOT NULL,
  `observaciones` varchar(800) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `venta_truck`
--

INSERT INTO `venta_truck` (`id_venta_truck`, `id_tipoventa`, `id_cliente`, `id_proyecto`, `id_sucursal`, `id_usuario`, `id_usuario_modifica`, `codigo`, `fecha_graba`, `fecha_modifica`, `botas`, `chaleco`, `lentes`, `guantes`, `mascarilla`, `careta`, `otros`, `id_embarcador`, `id_notificar`, `id_agente`, `observaciones`, `estado`) VALUES
(3, 2, 88, 47, 5, 223, 223, '0', '2022-02-23 17:23:58', '2022-02-23', 0, 0, 0, 0, 0, 0, '', 0, 88, 0, '', 0),
(4, 2, 88, 47, 5, 223, 223, '0', '2022-02-23 17:25:11', '2022-02-23', 0, 0, 0, 0, 0, 0, '', 0, 88, 0, '', 0),
(5, 2, 88, 47, 5, 223, 223, '0', '2022-02-23 17:26:20', '2022-02-23', 0, 0, 0, 0, 0, 0, '', 0, 88, 0, '', 0),
(6, 2, 88, 47, 5, 223, 223, '0', '2022-02-23 19:49:19', '2022-02-23', 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0),
(7, 2, 88, 47, 5, 223, 223, '0', '2022-02-23 19:49:22', '2022-02-23', 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0),
(8, 2, 88, 47, 5, 223, 223, '0', '2022-02-23 19:50:18', '2022-02-23', 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0),
(9, 2, 88, 47, 5, 223, 223, '0', '2022-02-23 19:51:00', '2022-02-23', 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0),
(10, 2, 88, 47, 5, 223, 223, '0', '2022-02-23 20:40:56', '2022-02-28', 1, 1, 1, 1, 1, 1, 'OTROS', 0, 0, 0, 'pruebas', 1),
(11, 0, 0, 0, 5, 223, 223, '0', '2022-02-28 20:45:02', '2022-02-28', 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 1),
(12, 0, 0, 0, 5, 223, 223, '0', '2022-02-28 20:50:31', '2022-02-28', 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 1),
(13, 0, 0, 0, 5, 223, 223, '0', '2022-02-28 20:51:22', '2022-02-28', 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 1),
(15, 1, 88, 47, 5, 223, 223, '502', '2022-03-01 17:20:43', '2022-03-01', 0, 0, 0, 0, 1, 1, 'OTROS DOS', 0, 0, 0, 'pruebas', 1),
(16, 1, 88, 47, 5, 223, 223, '502', '2022-03-01 17:21:49', '2022-03-01', 0, 1, 1, 0, 0, 0, '', 0, 0, 0, 'asdf', 0),
(17, 1, 88, 47, 5, 223, 223, '502', '2022-03-01 17:26:20', '2022-03-01', 0, 1, 0, 0, 0, 0, '', 0, 0, 0, 'asdf', 0),
(18, 1, 88, 47, 5, 223, 223, '502.CT88P47.223.2022.NA', '2022-03-01 20:31:06', '2022-03-02', 0, 0, 1, 1, 0, 0, '', 0, 0, 0, '', 1),
(19, 2, 88, 47, 5, 223, 223, '502.CT88P47.223.2022.IN', '2022-03-02 15:28:37', '2022-03-02', 1, 1, 0, 0, 0, 0, 'PRUEBA', 89, 88, 0, '', 1),
(21, 1, 88, 47, 5, 223, 223, '502.CT88PCT88P47.223.2022.NA', '2022-03-09 01:35:18', '2022-03-09', 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 'prueba', 1),
(27, 2, 88, 47, 5, 223, 223, '502.CT88PCT88P47.223.2022.IN', '2022-03-13 21:47:03', '2022-03-13', 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 1);

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
-- Indices de la tabla `archivos_evalua_proyecto`
--
ALTER TABLE `archivos_evalua_proyecto`
  ADD PRIMARY KEY (`id_archivo`);

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
-- Indices de la tabla `asigna_unidad_proyecto`
--
ALTER TABLE `asigna_unidad_proyecto`
  ADD PRIMARY KEY (`id_asigna_unidad`);

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
-- Indices de la tabla `comunicacionpreferida`
--
ALTER TABLE `comunicacionpreferida`
  ADD PRIMARY KEY (`id_comunicacion`);

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
-- Indices de la tabla `correlativo_proyecto`
--
ALTER TABLE `correlativo_proyecto`
  ADD PRIMARY KEY (`id_correlativo_proyecto`);

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
-- Indices de la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`id_tipo_equipo`);

--
-- Indices de la tabla `evaluacion_proyecto`
--
ALTER TABLE `evaluacion_proyecto`
  ADD PRIMARY KEY (`id_evaluacion_proyecto`);

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
-- Indices de la tabla `permisos_especiales`
--
ALTER TABLE `permisos_especiales`
  ADD PRIMARY KEY (`id_permiso`);

--
-- Indices de la tabla `plantilla_calculoa`
--
ALTER TABLE `plantilla_calculoa`
  ADD PRIMARY KEY (`id_plantilla`);

--
-- Indices de la tabla `productos_venta_truck`
--
ALTER TABLE `productos_venta_truck`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `puesto`
--
ALTER TABLE `puesto`
  ADD PRIMARY KEY (`id_puesto`);

--
-- Indices de la tabla `servicio_adicionales_venta_truck`
--
ALTER TABLE `servicio_adicionales_venta_truck`
  ADD PRIMARY KEY (`id_servicio_adicional`);

--
-- Indices de la tabla `servicio_flete_venta_truck`
--
ALTER TABLE `servicio_flete_venta_truck`
  ADD PRIMARY KEY (`id_servicio_flete`);

--
-- Indices de la tabla `servicio_target`
--
ALTER TABLE `servicio_target`
  ADD PRIMARY KEY (`id_servicio_target`);

--
-- Indices de la tabla `sino`
--
ALTER TABLE `sino`
  ADD PRIMARY KEY (`id_sino`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`id_sucursal`);

--
-- Indices de la tabla `sucursal_empresa`
--
ALTER TABLE `sucursal_empresa`
  ADD PRIMARY KEY (`id_sucursal_empresa`);

--
-- Indices de la tabla `tamano_empresa`
--
ALTER TABLE `tamano_empresa`
  ADD PRIMARY KEY (`id_tamano`);

--
-- Indices de la tabla `tarifariotruck`
--
ALTER TABLE `tarifariotruck`
  ADD PRIMARY KEY (`id_tarifario_truck`);

--
-- Indices de la tabla `tarifa_servicio`
--
ALTER TABLE `tarifa_servicio`
  ADD PRIMARY KEY (`id_tarifa_servicio`);

--
-- Indices de la tabla `tarifa_target_proyecto`
--
ALTER TABLE `tarifa_target_proyecto`
  ADD PRIMARY KEY (`idtarifa_target`);

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
-- Indices de la tabla `tipo_equipo_truc`
--
ALTER TABLE `tipo_equipo_truc`
  ADD PRIMARY KEY (`idtipo_equipo_truc`);

--
-- Indices de la tabla `tipo_licencia`
--
ALTER TABLE `tipo_licencia`
  ADD PRIMARY KEY (`id_tipo_licencia`);

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
-- Indices de la tabla `tipo_unidades_truc`
--
ALTER TABLE `tipo_unidades_truc`
  ADD PRIMARY KEY (`idtipo_unidades`);

--
-- Indices de la tabla `tipo_venta_truck`
--
ALTER TABLE `tipo_venta_truck`
  ADD PRIMARY KEY (`id_tipo_venta`);

--
-- Indices de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  ADD PRIMARY KEY (`id_unidad_medida`);

--
-- Indices de la tabla `venta_ro`
--
ALTER TABLE `venta_ro`
  ADD PRIMARY KEY (`id_venta`);

--
-- Indices de la tabla `venta_truck`
--
ALTER TABLE `venta_truck`
  ADD PRIMARY KEY (`id_venta_truck`);

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
-- AUTO_INCREMENT de la tabla `archivos_evalua_proyecto`
--
ALTER TABLE `archivos_evalua_proyecto`
  MODIFY `id_archivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `asigna_menu`
--
ALTER TABLE `asigna_menu`
  MODIFY `idasigna_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=304;

--
-- AUTO_INCREMENT de la tabla `asigna_moneda`
--
ALTER TABLE `asigna_moneda`
  MODIFY `id_asigna_moneda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `asigna_unidad_proyecto`
--
ALTER TABLE `asigna_unidad_proyecto`
  MODIFY `id_asigna_unidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `banco`
--
ALTER TABLE `banco`
  MODIFY `id_banco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `barco`
--
ALTER TABLE `barco`
  MODIFY `id_barco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3333;

--
-- AUTO_INCREMENT de la tabla `calculo_almacen`
--
ALTER TABLE `calculo_almacen`
  MODIFY `id_calculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `canal_distribucion`
--
ALTER TABLE `canal_distribucion`
  MODIFY `id_canal_distribucion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `catalogo`
--
ALTER TABLE `catalogo`
  MODIFY `id_catalogo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `id_ciudad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `comunicacionpreferida`
--
ALTER TABLE `comunicacionpreferida`
  MODIFY `id_comunicacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `consecutivos`
--
ALTER TABLE `consecutivos`
  MODIFY `id_consecutivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `contactos_e`
--
ALTER TABLE `contactos_e`
  MODIFY `id_contacto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `contenedor`
--
ALTER TABLE `contenedor`
  MODIFY `id_contenedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `correlativoagente`
--
ALTER TABLE `correlativoagente`
  MODIFY `id_correlativo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de la tabla `correlativo_almacen`
--
ALTER TABLE `correlativo_almacen`
  MODIFY `idcorrelativo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT de la tabla `correlativo_proyecto`
--
ALTER TABLE `correlativo_proyecto`
  MODIFY `id_correlativo_proyecto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

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
  MODIFY `id_descuento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_almacen`
--
ALTER TABLE `detalle_almacen`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_calculo`
--
ALTER TABLE `detalle_calculo`
  MODIFY `id_detalle_calculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

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
-- AUTO_INCREMENT de la tabla `empaque`
--
ALTER TABLE `empaque`
  MODIFY `id_empaque` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT de la tabla `envio_courier`
--
ALTER TABLE `envio_courier`
  MODIFY `id_envio_courier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `equipo`
--
ALTER TABLE `equipo`
  MODIFY `id_tipo_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `evaluacion_proyecto`
--
ALTER TABLE `evaluacion_proyecto`
  MODIFY `id_evaluacion_proyecto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT de la tabla `giro_negocio`
--
ALTER TABLE `giro_negocio`
  MODIFY `id_giro_negocio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `housebl`
--
ALTER TABLE `housebl`
  MODIFY `id_hbl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=224;

--
-- AUTO_INCREMENT de la tabla `masterbl`
--
ALTER TABLE `masterbl`
  MODIFY `id_mbl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

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
-- AUTO_INCREMENT de la tabla `permisos_especiales`
--
ALTER TABLE `permisos_especiales`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plantilla_calculoa`
--
ALTER TABLE `plantilla_calculoa`
  MODIFY `id_plantilla` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `productos_venta_truck`
--
ALTER TABLE `productos_venta_truck`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `puesto`
--
ALTER TABLE `puesto`
  MODIFY `id_puesto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `servicio_adicionales_venta_truck`
--
ALTER TABLE `servicio_adicionales_venta_truck`
  MODIFY `id_servicio_adicional` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `servicio_flete_venta_truck`
--
ALTER TABLE `servicio_flete_venta_truck`
  MODIFY `id_servicio_flete` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `servicio_target`
--
ALTER TABLE `servicio_target`
  MODIFY `id_servicio_target` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `sino`
--
ALTER TABLE `sino`
  MODIFY `id_sino` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `id_sucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `sucursal_empresa`
--
ALTER TABLE `sucursal_empresa`
  MODIFY `id_sucursal_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tamano_empresa`
--
ALTER TABLE `tamano_empresa`
  MODIFY `id_tamano` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tarifariotruck`
--
ALTER TABLE `tarifariotruck`
  MODIFY `id_tarifario_truck` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tarifa_servicio`
--
ALTER TABLE `tarifa_servicio`
  MODIFY `id_tarifa_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tarifa_target_proyecto`
--
ALTER TABLE `tarifa_target_proyecto`
  MODIFY `idtarifa_target` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `tipo_carga`
--
ALTER TABLE `tipo_carga`
  MODIFY `id_tipo_carga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tipo_carga_empresa`
--
ALTER TABLE `tipo_carga_empresa`
  MODIFY `id_tipo_carga_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `id_tipo_documento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tipo_equipo_truc`
--
ALTER TABLE `tipo_equipo_truc`
  MODIFY `idtipo_equipo_truc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tipo_licencia`
--
ALTER TABLE `tipo_licencia`
  MODIFY `id_tipo_licencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
-- AUTO_INCREMENT de la tabla `tipo_unidades_truc`
--
ALTER TABLE `tipo_unidades_truc`
  MODIFY `idtipo_unidades` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `tipo_venta_truck`
--
ALTER TABLE `tipo_venta_truck`
  MODIFY `id_tipo_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  MODIFY `id_unidad_medida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `venta_ro`
--
ALTER TABLE `venta_ro`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `venta_truck`
--
ALTER TABLE `venta_truck`
  MODIFY `id_venta_truck` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
