-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-01-2024 a las 05:28:20
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `apps`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actext`
--

CREATE TABLE `actext` (
  `id_act` int(3) NOT NULL,
  `nombre_act` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrera`
--

CREATE TABLE `carrera` (
  `id_carrera` int(3) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrera`
--

INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES
(1, 'Sistemas Computacionales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallehorario`
--

CREATE TABLE `detallehorario` (
  `ID_DetalleHorario` int(11) NOT NULL,
  `ID_Horario` int(11) DEFAULT NULL,
  `Dia` varchar(10) DEFAULT NULL,
  `HoraInicio` time DEFAULT NULL,
  `HoraFin` time DEFAULT NULL,
  `ID_MaestroMateria` int(11) DEFAULT NULL,
  `HoraImpartida` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detallehorario`
--

INSERT INTO `detallehorario` (`ID_DetalleHorario`, `ID_Horario`, `Dia`, `HoraInicio`, `HoraFin`, `ID_MaestroMateria`, `HoraImpartida`) VALUES
(173, 36, '1', '05:00:00', '06:00:00', 3, 1),
(174, 36, '1', '06:00:00', '07:00:00', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `generacion`
--

CREATE TABLE `generacion` (
  `ID_Generacion` int(3) NOT NULL,
  `Nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `generacion`
--

INSERT INTO `generacion` (`ID_Generacion`, `Nombre`) VALUES
(1, '2019-2023');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupopedagogico`
--

CREATE TABLE `grupopedagogico` (
  `ID_Grupopedagogico` int(3) NOT NULL,
  `Nombre` varchar(30) DEFAULT NULL,
  `Semestre` int(3) DEFAULT NULL,
  `ID_Generacion` int(3) DEFAULT NULL,
  `id_carrera` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `grupopedagogico`
--

INSERT INTO `grupopedagogico` (`ID_Grupopedagogico`, `Nombre`, `Semestre`, `ID_Generacion`, `id_carrera`) VALUES
(1, 'A', 3, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

CREATE TABLE `horario` (
  `ID_Horario` int(11) NOT NULL,
  `NombreHorario` varchar(255) DEFAULT NULL,
  `ID_Grupopedagogico` int(3) DEFAULT NULL,
  `Semana` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`ID_Horario`, `NombreHorario`, `ID_Grupopedagogico`, `Semana`) VALUES
(36, 'Test2', 1, '2024-W06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incidencias`
--

CREATE TABLE `incidencias` (
  `ID_Incidencias` int(3) NOT NULL,
  `Motivo` varchar(50) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `ID_Grupopedagogico` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestromateria`
--

CREATE TABLE `maestromateria` (
  `id_maestro_materia` int(3) NOT NULL,
  `ID_Maestro` int(11) DEFAULT NULL,
  `ID_Materia` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `maestromateria`
--

INSERT INTO `maestromateria` (`id_maestro_materia`, `ID_Maestro`, `ID_Materia`) VALUES
(3, 1, 5),
(4, 2, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestros`
--

CREATE TABLE `maestros` (
  `ID_Maestro` int(3) NOT NULL,
  `Nombre_maestro` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `maestros`
--

INSERT INTO `maestros` (`ID_Maestro`, `Nombre_maestro`) VALUES
(1, 'Alejandro Aguilar'),
(2, 'Octavio Corral Tovar'),
(3, 'Alejandro Panduro López');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `ID_Materia` int(3) NOT NULL,
  `Nombre_materia` varchar(20) NOT NULL,
  `Horas_totales` int(20) DEFAULT NULL,
  `Horas_impartidas` int(20) DEFAULT NULL,
  `ID_Grupopedagogico` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`ID_Materia`, `Nombre_materia`, `Horas_totales`, `Horas_impartidas`, `ID_Grupopedagogico`) VALUES
(4, 'Matematicas', 50, 1, 1),
(5, 'POO', 55, 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actext`
--
ALTER TABLE `actext`
  ADD PRIMARY KEY (`id_act`);

--
-- Indices de la tabla `carrera`
--
ALTER TABLE `carrera`
  ADD PRIMARY KEY (`id_carrera`);

--
-- Indices de la tabla `detallehorario`
--
ALTER TABLE `detallehorario`
  ADD PRIMARY KEY (`ID_DetalleHorario`),
  ADD KEY `ID_Horario` (`ID_Horario`),
  ADD KEY `ID_MaestroMateria` (`ID_MaestroMateria`);

--
-- Indices de la tabla `generacion`
--
ALTER TABLE `generacion`
  ADD PRIMARY KEY (`ID_Generacion`);

--
-- Indices de la tabla `grupopedagogico`
--
ALTER TABLE `grupopedagogico`
  ADD PRIMARY KEY (`ID_Grupopedagogico`),
  ADD KEY `ID_Generacion` (`ID_Generacion`),
  ADD KEY `id_carrera` (`id_carrera`);

--
-- Indices de la tabla `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`ID_Horario`),
  ADD KEY `ID_Grupopedagogico` (`ID_Grupopedagogico`);

--
-- Indices de la tabla `incidencias`
--
ALTER TABLE `incidencias`
  ADD PRIMARY KEY (`ID_Incidencias`),
  ADD KEY `ID_Grupopedagogico` (`ID_Grupopedagogico`);

--
-- Indices de la tabla `maestromateria`
--
ALTER TABLE `maestromateria`
  ADD PRIMARY KEY (`id_maestro_materia`),
  ADD KEY `ID_Maestro` (`ID_Maestro`),
  ADD KEY `ID_Materia` (`ID_Materia`);

--
-- Indices de la tabla `maestros`
--
ALTER TABLE `maestros`
  ADD PRIMARY KEY (`ID_Maestro`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`ID_Materia`),
  ADD KEY `ID_Grupopedagogico` (`ID_Grupopedagogico`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actext`
--
ALTER TABLE `actext`
  MODIFY `id_act` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `carrera`
--
ALTER TABLE `carrera`
  MODIFY `id_carrera` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detallehorario`
--
ALTER TABLE `detallehorario`
  MODIFY `ID_DetalleHorario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=175;

--
-- AUTO_INCREMENT de la tabla `generacion`
--
ALTER TABLE `generacion`
  MODIFY `ID_Generacion` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `grupopedagogico`
--
ALTER TABLE `grupopedagogico`
  MODIFY `ID_Grupopedagogico` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `horario`
--
ALTER TABLE `horario`
  MODIFY `ID_Horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `incidencias`
--
ALTER TABLE `incidencias`
  MODIFY `ID_Incidencias` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `maestromateria`
--
ALTER TABLE `maestromateria`
  MODIFY `id_maestro_materia` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `maestros`
--
ALTER TABLE `maestros`
  MODIFY `ID_Maestro` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `materia`
--
ALTER TABLE `materia`
  MODIFY `ID_Materia` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detallehorario`
--
ALTER TABLE `detallehorario`
  ADD CONSTRAINT `detallehorario_ibfk_1` FOREIGN KEY (`ID_Horario`) REFERENCES `horario` (`ID_Horario`),
  ADD CONSTRAINT `detallehorario_ibfk_2` FOREIGN KEY (`ID_MaestroMateria`) REFERENCES `maestromateria` (`id_maestro_materia`);

--
-- Filtros para la tabla `grupopedagogico`
--
ALTER TABLE `grupopedagogico`
  ADD CONSTRAINT `grupopedagogico_ibfk_1` FOREIGN KEY (`ID_Generacion`) REFERENCES `generacion` (`ID_Generacion`),
  ADD CONSTRAINT `grupopedagogico_ibfk_2` FOREIGN KEY (`id_carrera`) REFERENCES `carrera` (`id_carrera`);

--
-- Filtros para la tabla `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `horario_ibfk_1` FOREIGN KEY (`ID_Grupopedagogico`) REFERENCES `grupopedagogico` (`ID_Grupopedagogico`);

--
-- Filtros para la tabla `incidencias`
--
ALTER TABLE `incidencias`
  ADD CONSTRAINT `incidencias_ibfk_1` FOREIGN KEY (`ID_Grupopedagogico`) REFERENCES `grupopedagogico` (`ID_Grupopedagogico`);

--
-- Filtros para la tabla `maestromateria`
--
ALTER TABLE `maestromateria`
  ADD CONSTRAINT `maestromateria_ibfk_1` FOREIGN KEY (`ID_Maestro`) REFERENCES `maestros` (`ID_Maestro`),
  ADD CONSTRAINT `maestromateria_ibfk_2` FOREIGN KEY (`ID_Materia`) REFERENCES `materia` (`ID_Materia`);

--
-- Filtros para la tabla `materia`
--
ALTER TABLE `materia`
  ADD CONSTRAINT `materia_ibfk_1` FOREIGN KEY (`ID_Grupopedagogico`) REFERENCES `grupopedagogico` (`ID_Grupopedagogico`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
