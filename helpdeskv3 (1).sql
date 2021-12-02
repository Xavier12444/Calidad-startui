-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-10-2021 a las 19:03:01
-- Versión del servidor: 5.6.16
-- Versión de PHP: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `helpdeskv3`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE definer='id18048758_root'@'localhost'  PROCEDURE `Del_usuario`(IN `pId` INT(11))
BEGIN

	DELETE FROM tm_usuario
    WHERE usu_id = pId;

END$$

CREATE  PROCEDURE `llamado_borrados`()
BEGIN
SELECT * FROM del_usuarios;
END$$

CREATE  PROCEDURE `new_procedure`(IN `xusu_id` INT)
BEGIN
	UPDATE tm_usuario SET est='0', fech_elim = now() where usu_id = xusu_id;
END$$

CREATE PROCEDURE `sp_d_usuario`(IN `xusu_id` INT)
BEGIN
	UPDATE tm_usuario SET est='0', fech_elim = now() where usu_id = xusu_id;
END$$

CREATE  PROCEDURE `sp_graficoxusuario`(IN `xusu_id` INT)
BEGIN
	SELECT tm_categoria.cat_nom as nom,COUNT(*) AS total
                    FROM tm_ticket JOIN 
                    tm_categoria ON tm_ticket.cat_id = tm_categoria.cat_id
                    WHERE
                    tm_ticket.est = 1
                    AND tm_ticket.usu_id = xusu_id
                    GROUP BY
                    tm_categoria.cat_nom
                    ORDER BY total DESC;
END$$

CREATE  PROCEDURE `sp_i_ticket`(IN `xusu_id` INT, IN `xcat_id` INT, IN `xtick_titulo` VARCHAR(100), IN `xtick_descrip` VARCHAR(9000))
BEGIN
	INSERT INTO tm_ticket (tick_id,usu_id,cat_id,tick_titulo,tick_descrip,tick_estado,fech_crea,est) 
    VALUES (NULL,xusu_id,xcat_id,xtick_titulo,xtick_descrip,'Abierto',now(),'1');
END$$

CREATE  PROCEDURE `sp_i_ticketdetalle_01`(IN `xtick_id` INT, IN `xusu_id` INT)
BEGIN
	INSERT INTO td_ticketdetalle (tickd_id,tick_id,usu_id,tickd_descrip,fech_crea,est) 
    VALUES (NULL,xtick_id,xusu_id,'Ticket Cerrado...',now(),'1');
END$$

CREATE  PROCEDURE `sp_i_ticket_d`(IN `xtick_id` INT, IN `xusu_id` INT, IN `xtickd_descrip` VARCHAR(9000))
BEGIN
	INSERT INTO td_ticketdetalle (tickd_id,tick_id,usu_id,tickd_descrip,fech_crea,est) VALUES (NULL,xtick_id,xusu_id,xtickd_descrip,now(),'1');
END$$

CREATE  PROCEDURE `sp_i_usuario`(IN `xusu_nom` VARCHAR(150), IN `xsu_ape` VARCHAR(150), IN `xusu_correo` VARCHAR(150), IN `xusu_pass` VARCHAR(150), IN `xrol_id` INT)
BEGIN
	INSERT INTO tm_usuario (usu_id, usu_nom, usu_ape, usu_correo, usu_pass, rol_id, fech_crea, fech_modi, fech_elim, est) 
    VALUES (NULL,xusu_nom,xsu_ape,xusu_correo,xusu_pass,xrol_id,now(), NULL, NULL, '1');
END$$

CREATE  PROCEDURE `sp_listar_tick_x_usu`(IN `xusu_id` INT)
BEGIN
	SELECT tm_ticket.tick_id, tm_ticket.usu_id, tm_ticket.cat_id, tm_ticket.tick_titulo, tm_ticket.tick_descrip,
		   tm_ticket.tick_estado, tm_ticket.fech_crea, tm_usuario.usu_nom, tm_usuario.usu_ape, tm_categoria.cat_nom
    FROM tm_ticket
	INNER JOIN tm_categoria on tm_ticket.cat_id = tm_categoria.cat_id
    INNER JOIN tm_usuario on tm_ticket.usu_id = tm_usuario.usu_id
    WHERE tm_ticket.est = 1
    AND tm_usuario.usu_id = xusu_id;
END$$

CREATE  PROCEDURE `sp_l_ticket`()
BEGIN
	SELECT
                tm_ticket.tick_id,
                tm_ticket.usu_id,
                tm_ticket.cat_id,
                tm_ticket.tick_titulo,
                tm_ticket.tick_descrip,
                tm_ticket.tick_estado,
                tm_ticket.fech_crea,
                tm_usuario.usu_nom,
                tm_usuario.usu_ape,
                tm_categoria.cat_nom
                FROM
                tm_ticket
                INNER JOIN tm_categoria on tm_ticket.cat_id = tm_categoria.cat_id
                INNER JOIN tm_usuario on tm_ticket.usu_id = tm_usuario.usu_id
                WHERE tm_ticket.est = 1;
END$$

CREATE  PROCEDURE `sp_l_ticketdetalle_xticket`(IN `xtick_id` INT)
BEGIN
	SELECT
            td_ticketdetalle.tickd_id,
            td_ticketdetalle.tickd_descrip,
            td_ticketdetalle.fech_crea,
            tm_usuario.usu_nom,
            tm_usuario.usu_ape,
            tm_usuario.rol_id
            FROM
            td_ticketdetalle
            INNER JOIN tm_usuario on td_ticketdetalle.usu_id = tm_usuario.usu_id
            WHERE
            tick_id = xtick_id;
END$$

CREATE  PROCEDURE `sp_l_ticket_x_id`(IN `xtick_id` INT)
BEGIN
	SELECT 
                tm_ticket.tick_id,
                tm_ticket.usu_id,
                tm_ticket.cat_id,
                tm_ticket.tick_titulo,
                tm_ticket.tick_descrip,
                tm_ticket.tick_estado,
                tm_ticket.fech_crea,
                tm_usuario.usu_nom,
                tm_usuario.usu_ape,
                tm_categoria.cat_nom
                FROM 
                tm_ticket
                INNER join tm_categoria on tm_ticket.cat_id = tm_categoria.cat_id
                INNER join tm_usuario on tm_ticket.usu_id = tm_usuario.usu_id
                WHERE
                tm_ticket.est = 1
                AND tm_ticket.tick_id = xtick_id;
END$$

CREATE  PROCEDURE `sp_l_usuario02`(IN `xusu_id` INT)
BEGIN
	SELECT * FROM tm_usuario where usu_id = xusu_id;
END$$

CREATE  PROCEDURE `sp_l_usuario_01`()
BEGIN
	SELECT * FROM tm_usuario where est='1';
END$$

CREATE  PROCEDURE `sp_totalticketabiertosxusuario`(IN `xusu_id` INT)
BEGIN
	SELECT COUNT(*) TOTAL FROM tm_ticket WHERE usu_id = xusu_id AND tick_estado = 'Abierto';
END$$

CREATE  PROCEDURE `sp_totalticketcerradosxusuario`(IN `xusu_id` INT)
BEGIN
	SELECT COUNT(*) TOTAL FROM tm_ticket WHERE usu_id = xusu_id AND tick_estado = 'Cerrado';
END$$

CREATE  PROCEDURE `sp_totalticketxusuario`(IN `xusu_id` INT)
BEGIN
	SELECT COUNT(*) TOTAL FROM tm_ticket WHERE usu_id = xusu_id;
END$$

CREATE  PROCEDURE `sp_t_ticket`()
BEGIN
	SELECT COUNT(*) TOTAL FROM tm_ticket;
END$$

CREATE  PROCEDURE `sp_t_ticketgrafico`()
BEGIN
	SELECT tm_categoria.cat_nom as nom,COUNT(*) AS total
                    FROM tm_ticket JOIN 
                    tm_categoria ON tm_ticket.cat_id = tm_categoria.cat_id
                    WHERE
                    tm_ticket.est = 1
                    GROUP BY
                    tm_categoria.cat_nom
                    ORDER BY total DESC;
END$$

CREATE  PROCEDURE `sp_t_ticket_abierto`()
BEGIN
	SELECT COUNT(*) TOTAL FROM tm_ticket WHERE tick_estado = 'Abierto';
END$$

CREATE  PROCEDURE `sp_t_ticket_cerrado`()
BEGIN
	SELECT COUNT(*) TOTAL FROM tm_ticket WHERE  tick_estado = 'Cerrado';
END$$

CREATE  PROCEDURE `sp_u_ticket`(IN `xtick_id` INT)
BEGIN
	update tm_ticket 
                  set	
                  tick_estado = 'Cerrado'
                  where
                  tick_id = xtick_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_u_usuario`(IN `xusu_id` INT, IN `xusu_nom` VARCHAR(150), IN `xusu_ape` VARCHAR(150), IN `xusu_correo` VARCHAR(150), IN `xusu_pass` VARCHAR(150), IN `xrol_id` INT)
BEGIN
	UPDATE tm_usuario 
    SET usu_nom = xusu_nom, usu_ape = xusu_ape, usu_correo = xusu_correo, usu_pass = xusu_pass, rol_id = xrol_id
	WHERE usu_id = xusu_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_u_usuario01`(IN `xusu_nom` VARCHAR(150), IN `xusu_ape` VARCHAR(150), IN `xusu_correo` VARCHAR(150), IN `xusu_pass` VARCHAR(150), IN `xrol_id` INT, IN `xusu_id` INT)
BEGIN
	UPDATE tm_usuario 
    SET usu_nom = xusu_nom, usu_ape = xusu_ape, usu_correo = xusu_correo, usu_pass = xusu_pass, rol_id = xrol_id
    WHERE usu_id = xusu_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `del_usuarios`
--

CREATE TABLE IF NOT EXISTS `del_usuarios` (
  `usu_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_nom` varchar(150) NOT NULL,
  `usu_ape` varchar(150) NOT NULL,
  `usu_correo` varchar(150) NOT NULL,
  `usu_pass` varchar(20) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `fech_crea` datetime NOT NULL,
  `fech_modi` datetime NOT NULL,
  `fech_elim` datetime NOT NULL,
  `est` int(11) NOT NULL,
  PRIMARY KEY (`usu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `del_usuarios`
--

INSERT INTO `del_usuarios` (`usu_id`, `usu_nom`, `usu_ape`, `usu_correo`, `usu_pass`, `rol_id`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(9, 'dsd', 'sds', 'sdsd', 'sdsd', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_ticketdetalle`
--

CREATE TABLE IF NOT EXISTS `td_ticketdetalle` (
  `tickd_id` int(11) NOT NULL AUTO_INCREMENT,
  `tick_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `tickd_descrip` mediumtext COLLATE utf8_spanish_ci NOT NULL,
  `fech_crea` datetime NOT NULL,
  `est` int(11) NOT NULL,
  PRIMARY KEY (`tickd_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=27 ;

--
-- Volcado de datos para la tabla `td_ticketdetalle`
--

INSERT INTO `td_ticketdetalle` (`tickd_id`, `tick_id`, `usu_id`, `tickd_descrip`, `fech_crea`, `est`) VALUES
(1, 1, 2, 'Te respondo', '2021-07-23 00:00:00', 1),
(2, 1, 1, 'Soy el usuario respondiendo', '2021-07-23 00:00:00', 1),
(3, 1, 2, 'Para resolver el problema, reinicia tu equipo', '2021-07-23 00:00:00', 1),
(4, 1, 1, 'Si, con eso se resolvió el problema, gracias.', '2021-07-23 00:00:00', 1),
(5, 1, 2, 'Muchas gracias por confirmar, por favor cierre el tiquete', '2021-07-23 00:00:00', 1),
(7, 1, 1, '<p>test222<br></p>', '2021-07-24 18:19:26', 1),
(8, 1, 1, '<p>El problema persiste, me ayudas? <br></p>', '2021-07-24 18:23:26', 1),
(9, 1, 1, '<p>Ya pude, gracias<br></p>', '2021-07-24 18:26:59', 1),
(10, 1, 1, '<p>Ok<br></p>', '2021-07-24 18:27:39', 1),
(11, 1, 2, '<p>Perfecto<br></p>', '2021-07-24 18:28:34', 1),
(13, 6, 1, '<p>Espero respuestas lo más pronto posible, gracias!<br></p>', '2021-07-24 18:57:38', 1),
(14, 3, 1, '<p>asd<br></p>', '2021-07-24 21:02:29', 1),
(15, 3, 1, '<p>asd<br></p>', '2021-07-24 21:02:32', 1),
(16, 4, 1, '<p>TSM?</p><p><br></p>', '2021-07-24 21:09:08', 1),
(17, 4, 1, '<p>ASD<br></p>', '2021-07-24 21:18:06', 1),
(18, 4, 1, 'Ticket Cerrado...', '2021-07-24 21:18:08', 1),
(19, 1, 1, 'Ticket Cerrado...', '2021-07-25 16:20:50', 1),
(20, 7, 2, 'Ticket Cerrado...', '2021-07-25 16:38:45', 1),
(21, 5, 2, '<p>Ok<br></p>', '2021-07-25 17:18:52', 1),
(22, 6, 2, 'Ticket Cerrado...', '2021-07-25 17:20:01', 1),
(23, 8, 1, '<p>Vale xd<br></p>', '2021-07-25 17:27:29', 1),
(24, 10, 2, '<p>Sea necio mae</p>', '2021-10-08 22:55:08', 1),
(25, 10, 3, '<p>Muchas gracias, muy amable</p>', '2021-10-08 22:55:36', 1),
(26, 10, 3, 'Ticket Cerrado...', '2021-10-08 22:55:39', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_categoria`
--

CREATE TABLE IF NOT EXISTS `tm_categoria` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_nom` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `est` int(11) NOT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `tm_categoria`
--

INSERT INTO `tm_categoria` (`cat_id`, `cat_nom`, `est`) VALUES
(1, 'Hardware', 1),
(2, 'Software', 1),
(3, 'Insidencia', 1),
(4, 'Petición de Servicio', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_ticket`
--

CREATE TABLE IF NOT EXISTS `tm_ticket` (
  `tick_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `tick_titulo` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `tick_descrip` varchar(9000) COLLATE utf8_spanish_ci NOT NULL,
  `tick_estado` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fech_crea` datetime DEFAULT NULL,
  `est` int(11) NOT NULL,
  PRIMARY KEY (`tick_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `tm_ticket`
--

INSERT INTO `tm_ticket` (`tick_id`, `usu_id`, `cat_id`, `tick_titulo`, `tick_descrip`, `tick_estado`, `fech_crea`, `est`) VALUES
(1, 1, 1, 'test', 'test', 'Abierto', '2021-07-21 00:00:00', 1),
(2, 1, 1, 'test', '<p>test<br></p>', 'Abierto', '2021-07-21 00:00:00', 1),
(3, 1, 3, 'Mami', '<p>Mami<br></p>', 'Abierto', '2021-07-21 00:00:00', 1),
(4, 1, 4, 'Hola', '<p><b>TSM</b><br></p>', 'Cerrado', '2021-07-21 11:35:14', 1),
(5, 1, 1, 'Prueba', '<p>Error<br></p>', 'Abierto', '2021-07-24 18:33:18', 1),
(6, 1, 2, 'Window', '<p>No por qjurqnwebqehjqwed<br></p>', 'Cerrado', '2021-07-24 18:56:59', 1),
(7, 3, 1, 'Test', '<p>test<br></p>', 'Cerrado', '2021-07-25 15:35:26', 1),
(8, 1, 1, 'Prueba', '<p>Prueba<br></p>', 'Abierto', '2021-07-25 17:27:17', 1),
(9, 3, 1, 'Bienvenidos', '<p>Es solo una prueba</p><p><br></p>', 'Abierto', '2021-10-08 22:53:37', 1),
(10, 3, 1, 'Bryan', '<p>Bryan</p><p><br></p>', 'Cerrado', '2021-10-08 22:54:48', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_usuario`
--

CREATE TABLE IF NOT EXISTS `tm_usuario` (
  `usu_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_nom` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usu_ape` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usu_correo` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `usu_pass` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `fech_crea` datetime DEFAULT NULL,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(11) NOT NULL,
  PRIMARY KEY (`usu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla Mantenedor de Usuarios' AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `tm_usuario`
--

INSERT INTO `tm_usuario` (`usu_id`, `usu_nom`, `usu_ape`, `usu_correo`, `usu_pass`, `rol_id`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(1, 'Tony', 'Jimenez', 'jimenezcorderoanthony@gmail.com', '123456', 1, '2021-07-18 00:00:00', NULL, NULL, 1),
(2, 'Soporte', 'Soporte', 'soporte@gmail.com', 'soporte', 2, NULL, NULL, NULL, 1),
(3, 'Test', 'Test', 'test@gmail.com', 'test', 1, NULL, NULL, '2021-07-24 23:44:46', 1),
(4, 'Usuario1', 'Usuario1', 'usuario1@gmail.com', '123456', 1, '2021-07-25 14:38:25', NULL, '2021-07-25 14:48:11', 1);

--
-- Disparadores `tm_usuario`
--
DROP TRIGGER IF EXISTS `TRG1`;
DELIMITER //
CREATE TRIGGER `TRG1` AFTER DELETE ON `tm_usuario`
 FOR EACH ROW INSERT INTO  del_usuarios
VALUES(OLD.usu_id, OLD.usu_nom, OLD.usu_ape, OLD.usu_correo, OLD.usu_pass, OLD.rol_id, OLD.fech_crea, OLD.fech_modi, OLD.fech_elim, OLD.est )
//
DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
