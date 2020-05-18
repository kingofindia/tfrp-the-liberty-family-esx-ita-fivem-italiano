-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              10.4.8-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win64
-- HeidiSQL Versione:            10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dump della struttura del database essentialmode
DROP DATABASE IF EXISTS `essentialmode`;
CREATE DATABASE IF NOT EXISTS `essentialmode` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `essentialmode3`;

-- Dump della struttura di tabella essentialmode.vehicle_categories
DROP TABLE IF EXISTS `vehicle_categories`;
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode.vehicle_categories: ~56 rows (circa)
/*!40000 ALTER TABLE `vehicle_categories` DISABLE KEYS */;
INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
	('abarth', 'Abarth'),
	('alfaromeo', 'Alfa Romeo'),
	('audi', 'Audi'),
	('bmw', 'BMW'),
	('citroen', 'Citroen'),
	('dacia', 'Dacia'),
	('dodge', 'Dodge'),
	('ferrari', 'Ferrari'),
	('fiat', 'Fiat'),
	('ford', 'Ford'),
	('honda', 'Honda'),
	('hyundai', 'Hunday'),
	('jaguar', 'Jaguar'),
	('jeep', 'Jeep'),
	('kia', 'Kia'),
	('lamborghini', 'Lamborghini'),
	('lancia', 'Lancia'),
	('rover', 'Rover'),
	('nissan', 'Nissan'),
	('astonmartin', 'Aston Martin'),
	('rollsroyce', 'Rolls Royce'),
	('renault', 'Renault'),
	('pagani', 'Pagani'),
	('volvo', 'Volvo'),
	('lotus', 'Lotus'),
	('mini', 'Mini'),
	('moto', 'Moto'),
	('vans', 'Camion'),
	('abarth', 'Abarth'),
	('alfaromeo', 'Alfa Romeo'),
	('audi', 'Audi'),
	('bmw', 'BMW'),
	('citroen', 'Citroen'),
	('dacia', 'Dacia'),
	('dodge', 'Dodge'),
	('ferrari', 'Ferrari'),
	('fiat', 'Fiat'),
	('ford', 'Ford'),
	('honda', 'Honda'),
	('hyundai', 'Hunday'),
	('jaguar', 'Jaguar'),
	('jeep', 'Jeep'),
	('kia', 'Kia'),
	('lamborghini', 'Lamborghini'),
	('lancia', 'Lancia'),
	('rover', 'Rover'),
	('nissan', 'Nissan'),
	('astonmartin', 'Aston Martin'),
	('rollsroyce', 'Rolls Royce'),
	('renault', 'Renault'),
	('pagani', 'Pagani'),
	('volvo', 'Volvo'),
	('lotus', 'Lotus'),
	('mini', 'Mini'),
	('moto', 'Moto'),
	('vans', 'Camion');
/*!40000 ALTER TABLE `vehicle_categories` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
