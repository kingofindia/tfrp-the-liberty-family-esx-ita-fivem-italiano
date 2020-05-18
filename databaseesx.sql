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


-- Dump della struttura del database essentialmode3
DROP DATABASE IF EXISTS `essentialmode3`;
CREATE DATABASE IF NOT EXISTS `essentialmode3` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `essentialmode3`;

-- Dump della struttura di tabella essentialmode3.addon_account
DROP TABLE IF EXISTS `addon_account`;
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(255) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.addon_account: ~43 rows (circa)
/*!40000 ALTER TABLE `addon_account` DISABLE KEYS */;
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('bank_savings', 'Livret Bleu', 0),
	('caution', 'Caution', 0),
	('property_black_money', 'Argent Sale Propriété', 0),
	('root_property_bed_black_money', 'root_property Black Money Bed', 0),
	('root_property_black_money', 'root_property Black Money ', 0),
	('society_ambulance', 'Ambulance', 1),
	('society_armeria', 'Armeria', 1),
	('society_bahama_mamas', 'Bahama Mamas', 1),
	('society_banker', 'Banque', 1),
	('society_bratva', 'bratva', 1),
	('society_cardealer', 'Concessionnaire', 1),
	('society_casino', 'Kasyno', 1),
	('society_coffee', 'coffee', 1),
	('society_death', 'death', 1),
	('society_deathrowrecords', 'Death Row Record', 1),
	('society_fbi', 'fbi', 1),
	('society_fueler', 'Petrolieri', 1),
	('society_giustizia', 'Giustizia', 1),
	('society_grigi', 'grigi', 1),
	('society_journaliste', 'Giornalista', 1),
	('society_lavanderia', 'lavanderia', 1),
	('society_loggia', 'loggia', 1),
	('society_mafia', 'mafia', 1),
	('society_magazzino', 'Magazzino', 1),
	('society_magazzino2', 'Magazzino2', 1),
	('society_magazzino3', 'Magazzino3', 1),
	('society_magazzino4', 'Magazzino4', 1),
	('society_magazzino5', 'Magazzino5', 1),
	('society_maluma', 'Sony', 1),
	('society_mecano', 'Mécano', 1),
	('society_mercato', 'mercato', 1),
	('society_mercenari', 'mercenari', 1),
	('society_narcos', 'narcos', 1),
	('society_nibba', 'nibba', 1),
	('society_nightclub', 'Nightclub', 1),
	('society_police', 'Police', 1),
	('society_realestateagent', 'Agent immobilier', 1),
	('society_state', 'Stato', 1),
	('society_tailor', 'Sartoria', 1),
	('society_taxi', 'Taxi', 1),
	('society_tequila', 'Tequila', 1),
	('society_vanilla', 'Vanilla', 1),
	('society_vigne', 'Winegrower', 1);
/*!40000 ALTER TABLE `addon_account` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.addon_account_data
DROP TABLE IF EXISTS `addon_account_data`;
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) DEFAULT NULL,
  `money` double NOT NULL,
  `owner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.addon_account_data: ~38 rows (circa)
/*!40000 ALTER TABLE `addon_account_data` DISABLE KEYS */;
INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
	(99, 'society_ambulance', 0, NULL),
	(100, 'society_armeria', 0, NULL),
	(101, 'society_bahama_mamas', 0, NULL),
	(102, 'society_banker', 0, NULL),
	(103, 'society_bratva', 0, NULL),
	(104, 'society_cardealer', 0, NULL),
	(105, 'society_casino', 0, NULL),
	(106, 'society_coffee', 0, NULL),
	(107, 'society_death', 0, NULL),
	(108, 'society_deathrowrecords', 0, NULL),
	(109, 'society_fbi', 0, NULL),
	(110, 'society_fueler', 0, NULL),
	(111, 'society_giustizia', 0, NULL),
	(112, 'society_grigi', 0, NULL),
	(113, 'society_journaliste', 0, NULL),
	(114, 'society_lavanderia', 0, NULL),
	(115, 'society_loggia', 0, NULL),
	(116, 'society_mafia', 0, NULL),
	(117, 'society_magazzino', 0, NULL),
	(118, 'society_magazzino2', 0, NULL),
	(119, 'society_magazzino3', 0, NULL),
	(120, 'society_magazzino4', 0, NULL),
	(121, 'society_magazzino5', 0, NULL),
	(122, 'society_maluma', 0, NULL),
	(123, 'society_mecano', 0, NULL),
	(124, 'society_mercato', 0, NULL),
	(125, 'society_mercenari', 0, NULL),
	(126, 'society_narcos', 0, NULL),
	(127, 'society_nibba', 0, NULL),
	(128, 'society_nightclub', 0, NULL),
	(129, 'society_police', 0, NULL),
	(130, 'society_realestateagent', 0, NULL),
	(131, 'society_state', 0, NULL),
	(132, 'society_tailor', 0, NULL),
	(133, 'society_taxi', 0, NULL),
	(134, 'society_tequila', 0, NULL),
	(135, 'society_vanilla', 0, NULL),
	(136, 'society_vigne', 0, NULL);
/*!40000 ALTER TABLE `addon_account_data` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.addon_inventory
DROP TABLE IF EXISTS `addon_inventory`;
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(255) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.addon_inventory: ~51 rows (circa)
/*!40000 ALTER TABLE `addon_inventory` DISABLE KEYS */;
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('property', 'Propriété', 0),
	('root_property', 'root_property Inventory', 0),
	('root_property_bed', 'root_property Bed Inventory', 0),
	('society_airlines', 'D.C.S.A', 1),
	('society_ambulance', 'Ambulance', 1),
	('society_armeria', 'Armeria', 1),
	('society_bahama_mamas', 'Bahama Mamas', 1),
	('society_bahama_mamas_fridge', 'Bahama Mamas (frigo)', 1),
	('society_banker', 'Banca', 1),
	('society_bratva', 'Yakuza', 1),
	('society_cardealer', 'Concesionnaire', 1),
	('society_casino', 'Kasyno', 1),
	('society_casino_fridge', 'Casino (lodowka)', 1),
	('society_coffee', 'Sons of Anarchy', 1),
	('society_death', 'Il Cartello', 1),
	('society_deathrowrecords', 'Death Row Record', 1),
	('society_fbi', 'FBI', 1),
	('society_fueler', 'Petrolieri', 1),
	('society_giustizia', 'Giustizia', 1),
	('society_grigi', 'I Grigi', 1),
	('society_hitman', 'hitman', 1),
	('society_journaliste', 'Giornalista', 1),
	('society_lavanderia', 'Lavanderia', 1),
	('society_loggia', 'L.B.H Inc.', 1),
	('society_lostriade', 'Los Triade', 1),
	('society_mafia', 'Cosa Nostra', 1),
	('society_magazzino', 'Magazzino', 1),
	('society_magazzino2', 'Magazzino2', 1),
	('society_magazzino3', 'Magazzino3', 1),
	('society_magazzino4', 'Magazzino4', 1),
	('society_magazzino5', 'Magazzino5', 1),
	('society_maluma', 'Sony', 1),
	('society_marasalvatrucha', 'marasalvatrucha', 1),
	('society_mecano', 'Mécano', 1),
	('society_mercato', 'Mercato Nero', 1),
	('society_mercenari', 'I Mercenari', 1),
	('society_messican', 'messican', 1),
	('society_narcos', 'La Fratellanza', 1),
	('society_nibba', 'Luxor Resort', 1),
	('society_nightclub', 'Nightclub', 1),
	('society_nightclub_fridge', 'Nightclub (fridge)', 1),
	('society_police', 'Police', 1),
	('society_state', 'Stato', 1),
	('society_tailor', 'Sartoria', 1),
	('society_taxi', 'Taxi', 1),
	('society_tequila', 'Tequila', 1),
	('society_tequila_fridge', 'Tequila (frigo)', 1),
	('society_thegoodfellas', 'Los Pollos Hermanos', 1),
	('society_vanilla', 'Vanilla', 1),
	('society_vanilla_fridge', 'Vanilla (frigo)', 1),
	('society_vigne', 'Winegrower', 1);
/*!40000 ALTER TABLE `addon_inventory` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.addon_inventory_items
DROP TABLE IF EXISTS `addon_inventory_items`;
CREATE TABLE IF NOT EXISTS `addon_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.addon_inventory_items: ~0 rows (circa)
/*!40000 ALTER TABLE `addon_inventory_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `addon_inventory_items` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.aircrafts
DROP TABLE IF EXISTS `aircrafts`;
CREATE TABLE IF NOT EXISTS `aircrafts` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.aircrafts: ~24 rows (circa)
/*!40000 ALTER TABLE `aircrafts` DISABLE KEYS */;
INSERT INTO `aircrafts` (`name`, `model`, `price`, `category`) VALUES
	('Alpha Z1', 'alphaz1', 16121000, 'plane'),
	('Besra', 'besra', 15000000, 'plane'),
	('Cuban 800', 'cuban800', 12240000, 'plane'),
	('Dodo', 'dodo', 10500000, 'plane'),
	('Duster', 'duster', 10175000, 'plane'),
	('Frogger', 'frogger', 12800000, 'heli'),
	('Havok', 'havok', 13250000, 'heli'),
	('Howard NX25', 'howard', 12975000, 'plane'),
	('Luxor Deluxe ', 'luxor2', 14750000, 'plane'),
	('Mammatus', 'mammatus', 10300000, 'plane'),
	('Maverick', 'maverick', 12750000, 'heli'),
	('Ultra Light', 'microlight', 8350000, 'plane'),
	('Nimbus', 'nimbus', 10900000, 'plane'),
	('Rogue', 'rogue', 101000000, 'plane'),
	('Sea Breeze', 'seabreeze', 10850000, 'plane'),
	('Sea Sparrow', 'seasparrow', 12815000, 'heli'),
	('Shamal', 'shamal', 10150000, 'plane'),
	('Mallard', 'stunt', 10250000, 'plane'),
	('SuperVolito', 'supervolito', 10000000, 'heli'),
	('SuperVolito Carbon', 'supervolito2', 14250000, 'heli'),
	('Swift', 'swift', 12000000, 'heli'),
	('Swift Deluxe', 'swift2', 13250000, 'heli'),
	('Velum', 'velum2', 9450000, 'plane'),
	('Vestra', 'vestra', 9950000, 'plane');
/*!40000 ALTER TABLE `aircrafts` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.aircraft_categories
DROP TABLE IF EXISTS `aircraft_categories`;
CREATE TABLE IF NOT EXISTS `aircraft_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.aircraft_categories: ~2 rows (circa)
/*!40000 ALTER TABLE `aircraft_categories` DISABLE KEYS */;
INSERT INTO `aircraft_categories` (`name`, `label`) VALUES
	('heli', 'Helicopters'),
	('plane', 'Planes');
/*!40000 ALTER TABLE `aircraft_categories` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.baninfo
DROP TABLE IF EXISTS `baninfo`;
CREATE TABLE IF NOT EXISTS `baninfo` (
  `identifier` varchar(25) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `playername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dump dei dati della tabella essentialmode3.baninfo: ~0 rows (circa)
/*!40000 ALTER TABLE `baninfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `baninfo` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.banlist
DROP TABLE IF EXISTS `banlist`;
CREATE TABLE IF NOT EXISTS `banlist` (
  `identifier` varchar(25) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `expiration` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dump dei dati della tabella essentialmode3.banlist: ~0 rows (circa)
/*!40000 ALTER TABLE `banlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `banlist` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.banlisthistory
DROP TABLE IF EXISTS `banlisthistory`;
CREATE TABLE IF NOT EXISTS `banlisthistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(25) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` int(11) NOT NULL,
  `added` varchar(40) COLLATE utf8mb4_bin NOT NULL,
  `expiration` int(11) NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dump dei dati della tabella essentialmode3.banlisthistory: ~0 rows (circa)
/*!40000 ALTER TABLE `banlisthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `banlisthistory` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.billing
DROP TABLE IF EXISTS `billing`;
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.billing: ~0 rows (circa)
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.businesses
DROP TABLE IF EXISTS `businesses`;
CREATE TABLE IF NOT EXISTS `businesses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `description` varchar(75) NOT NULL,
  `blipname` varchar(75) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `earnings` int(11) NOT NULL,
  `position` text NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `stock_price` int(11) NOT NULL DEFAULT 100,
  `employees` text NOT NULL,
  `taxrate` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella essentialmode3.businesses: ~0 rows (circa)
/*!40000 ALTER TABLE `businesses` DISABLE KEYS */;
/*!40000 ALTER TABLE `businesses` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.cardealer_vehicles
DROP TABLE IF EXISTS `cardealer_vehicles`;
CREATE TABLE IF NOT EXISTS `cardealer_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2968 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.cardealer_vehicles: ~0 rows (circa)
/*!40000 ALTER TABLE `cardealer_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `cardealer_vehicles` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.characters
DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dateofbirth` varchar(255) NOT NULL,
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `height` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.characters: ~0 rows (circa)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.datastore
DROP TABLE IF EXISTS `datastore`;
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(255) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.datastore: ~41 rows (circa)
/*!40000 ALTER TABLE `datastore` DISABLE KEYS */;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('property', 'Propriété', 0),
	('root_property', 'root_property Datastore', 0),
	('root_property_bed', 'root_property Bed Datastore', 0),
	('society_ambulance', 'Ambulance', 1),
	('society_armeria', 'Armeria', 1),
	('society_bahama_mamas', 'Bahama Mamas', 1),
	('society_banker', 'Banca', 1),
	('society_bratva', 'Yakuza', 1),
	('society_casino', 'Kasyno', 1),
	('society_coffee', 'Sons of Anarchy', 1),
	('society_death', 'Il Cartello', 1),
	('society_fbi', 'FBI', 1),
	('society_fueler', 'Petrolieri', 1),
	('society_giustizia', 'Giustizia', 1),
	('society_grigi', 'I Grigi', 1),
	('society_journaliste', 'Giornalista', 1),
	('society_lavanderia', 'Lavanderia', 1),
	('society_loggia', 'L.B.H Inc.', 1),
	('society_mafia', 'Cosa Nostra', 1),
	('society_magazzino', 'Magazzino', 1),
	('society_magazzino2', 'Magazzino2', 1),
	('society_magazzino3', 'Magazzino3', 1),
	('society_magazzino4', 'Magazzino4', 1),
	('society_magazzino5', 'Magazzino5', 1),
	('society_maluma', 'Sony', 1),
	('society_mercato', 'Mercato Nero', 1),
	('society_mercenari', 'I Mercenari', 1),
	('society_narcos', 'La Fratellanza', 1),
	('society_nibba', 'Luxor Resort', 1),
	('society_nightclub', 'Nightclub', 1),
	('society_police', 'Police', 1),
	('society_state', 'Stato', 1),
	('society_tailor', 'Sartoria', 1),
	('society_taxi', 'Taxi', 1),
	('society_tequila', 'Tequila', 1),
	('society_vanilla', 'Vanilla', 1),
	('society_vigne', 'Winegrower', 1),
	('user_ears', 'Ears', 0),
	('user_glasses', 'Glasses', 0),
	('user_helmet', 'Helmet', 0),
	('user_mask', 'Mask', 0);
/*!40000 ALTER TABLE `datastore` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.datastore_data
DROP TABLE IF EXISTS `datastore_data`;
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_datastore_owner_name` (`owner`,`name`),
  KEY `index_datastore_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.datastore_data: ~34 rows (circa)
/*!40000 ALTER TABLE `datastore_data` DISABLE KEYS */;
INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
	(119, 'society_ambulance', NULL, '{}'),
	(120, 'society_armeria', NULL, '{}'),
	(121, 'society_bahama_mamas', NULL, '{}'),
	(122, 'society_banker', NULL, '{}'),
	(123, 'society_bratva', NULL, '{}'),
	(124, 'society_casino', NULL, '{}'),
	(125, 'society_coffee', NULL, '{}'),
	(126, 'society_death', NULL, '{}'),
	(127, 'society_fbi', NULL, '{}'),
	(128, 'society_fueler', NULL, '{}'),
	(129, 'society_giustizia', NULL, '{}'),
	(130, 'society_grigi', NULL, '{}'),
	(131, 'society_journaliste', NULL, '{}'),
	(132, 'society_lavanderia', NULL, '{}'),
	(133, 'society_loggia', NULL, '{}'),
	(134, 'society_mafia', NULL, '{}'),
	(135, 'society_magazzino', NULL, '{}'),
	(136, 'society_magazzino2', NULL, '{}'),
	(137, 'society_magazzino3', NULL, '{}'),
	(138, 'society_magazzino4', NULL, '{}'),
	(139, 'society_magazzino5', NULL, '{}'),
	(140, 'society_maluma', NULL, '{}'),
	(141, 'society_mercato', NULL, '{}'),
	(142, 'society_mercenari', NULL, '{}'),
	(143, 'society_narcos', NULL, '{}'),
	(144, 'society_nibba', NULL, '{}'),
	(145, 'society_nightclub', NULL, '{}'),
	(146, 'society_police', NULL, '{}'),
	(147, 'society_state', NULL, '{}'),
	(148, 'society_tailor', NULL, '{}'),
	(149, 'society_taxi', NULL, '{}'),
	(150, 'society_tequila', NULL, '{}'),
	(151, 'society_vanilla', NULL, '{}'),
	(152, 'society_vigne', NULL, '{}');
/*!40000 ALTER TABLE `datastore_data` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.distributor
DROP TABLE IF EXISTS `distributor`;
CREATE TABLE IF NOT EXISTS `distributor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.distributor: ~8 rows (circa)
/*!40000 ALTER TABLE `distributor` DISABLE KEYS */;
INSERT INTO `distributor` (`id`, `name`, `item`, `price`) VALUES
	(1, 'Distributor', 'jus_raisin', 620),
	(2, 'Distributor', 'icetea', 50),
	(3, 'Distributor', 'hotdog', 100),
	(4, 'Distributor', 'jusfruit', 60),
	(5, 'Distributor', 'limonade', 67),
	(6, 'Distributor', 'nugets', 78),
	(7, 'Distributor', 'soda', 53),
	(8, 'Distributor', 'water', 40);
/*!40000 ALTER TABLE `distributor` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.fine_types
DROP TABLE IF EXISTS `fine_types`;
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.fine_types: ~53 rows (circa)
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(1, 'Abuso di clacson', 1000, 0),
	(2, 'Sorpasso linea continua', 1400, 0),
	(3, 'Guida contromano', 1100, 0),
	(4, 'Inversione a U vietata', 1200, 0),
	(5, 'Guida fuoristrada con mezzo non adatto', 1400, 0),
	(6, 'Mancato rispetto distanza sicurezza', 2000, 0),
	(7, 'Divieto di sosta', 900, 0),
	(8, 'Parcheggio errato', 1200, 0),
	(9, 'Mancato rispetto precedenza a destra', 500, 0),
	(10, 'Mancato rispetto precedenza veicolo', 500, 0),
	(11, 'Mancato rispetto stop', 600, 0),
	(12, 'Passaggio semaforo rosso', 500, 0),
	(13, 'Sorpasso pericoloso', 420, 0),
	(14, 'Veicolo danneggiato', 480, 0),
	(15, 'Guida senza patente', 3000, 0),
	(16, 'Omissione di soccorso', 1800, 0),
	(17, 'Eccesso di velocità < 5 kmh', 200, 0),
	(18, 'Eccesso di velocità 5-15 kmh', 400, 0),
	(19, 'Eccesso di velocità 15-30 kmh', 600, 0),
	(20, 'Eccesso di velocità > 30 kmh', 800, 0),
	(21, 'Intralcio al traffico', 1000, 1),
	(22, 'Danneggiamento beni pubblici', 1400, 1),
	(23, 'Disturbo alla quiete pubblica', 2000, 1),
	(24, 'Intralcio operazione polizia', 10000, 1),
	(25, 'Ingiuria verbale', 5000, 1),
	(26, 'Oltraggio a pubblico ufficiale', 10000, 1),
	(27, 'Minaccia', 5000, 1),
	(28, 'Minaccia a pubblico ufficiale', 10000, 1),
	(29, 'Manifestazione illegale', 20000, 1),
	(30, 'Tentata corruzione', 30000, 1),
	(31, 'Arma bianca in città', 5000, 2),
	(32, 'Arma letale in città', 20000, 2),
	(33, 'Porto d\'armi non autorizzato', 10000, 2),
	(34, 'Porto d\'armi illegale', 8000, 2),
	(35, 'Furto', 4000, 2),
	(36, 'Furto d\'auto', 8000, 2),
	(37, 'Spaccio', 55000, 2),
	(38, 'Processo droga', 70000, 2),
	(39, 'Possesso di droga', 70000, 2),
	(40, 'Ostaggio civile', 50000, 2),
	(41, 'Ostaggio pubblico ufficiale', 80000, 2),
	(42, 'Rapina gioielleria', 125000, 2),
	(43, 'Rapina negozio', 200000, 2),
	(44, 'Rapina in banca', 350000, 2),
	(45, 'Sparatoria contro civile', 60000, 3),
	(46, 'Sparatoria contro pubblico ufficiale', 90000, 3),
	(47, 'Tentato omicidio', 75000, 3),
	(48, 'Tentato omicidio pubblico ufficiale', 115000, 3),
	(49, 'Omicidio', 120000, 3),
	(50, 'Omicidio pubblico ufficiale', 145000, 3),
	(51, 'Omicidio colposo', 150000, 3),
	(52, 'Truffa', 30000, 2),
	(53, 'Multa per mancata assicurazione al veicolo', 10000, 1);
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.gruppo_sanguigno
DROP TABLE IF EXISTS `gruppo_sanguigno`;
CREATE TABLE IF NOT EXISTS `gruppo_sanguigno` (
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella essentialmode3.gruppo_sanguigno: ~0 rows (circa)
/*!40000 ALTER TABLE `gruppo_sanguigno` DISABLE KEYS */;
/*!40000 ALTER TABLE `gruppo_sanguigno` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.informatica
DROP TABLE IF EXISTS `informatica`;
CREATE TABLE IF NOT EXISTS `informatica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store` varchar(100) NOT NULL,
  `item` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.informatica: ~3 rows (circa)
/*!40000 ALTER TABLE `informatica` DISABLE KEYS */;
INSERT INTO `informatica` (`id`, `store`, `item`, `price`) VALUES
	(1, 'TwentyFourSeven', 'phone', 800),
	(2, 'TwentyFourSeven', 'tablet', 1200),
	(3, 'TwentyFourSeven', 'macchinetta', 2000);
/*!40000 ALTER TABLE `informatica` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.items
DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(255) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT -1,
  `rare` int(11) NOT NULL DEFAULT 0,
  `can_remove` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.items: ~190 rows (circa)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('acidob', 'Acido', 40, 0, 1),
	('acqua', 'Acqua Per Piante', 10, 0, 1),
	('airbag', 'Airbag', 7, 0, 1),
	('ak', 'AK', 2, 0, 1),
	('alive_chicken', 'Pollo vivo', 500, 0, 1),
	('antibiotico', 'Antibiotico', 50, 0, 1),
	('bait', 'Esca', 200, 0, 1),
	('bandage', 'Benda', 50, 0, 1),
	('battery', 'Batteria auto', 2, 0, 1),
	('beer', 'Birra', 20, 0, 1),
	('blowpipe', 'Cerbottana', 20, 0, 1),
	('bolcacahuetes', 'Ciotola di noccioline', 20, 0, 1),
	('bolchips', 'Ciotola di patatine', 20, 0, 1),
	('bolnoixcajou', 'Ciotola di anacardi', 20, 0, 1),
	('bolpistache', 'Ciotola di pistacchi', 20, 0, 1),
	('bossolo', 'Bossolo', 200, 0, 1),
	('bottiglia', 'Bottiglia Vuota', 200, 0, 1),
	('bottigliasp', 'Bottiglia di spumante', 200, 0, 1),
	('bracciale', 'Braccialetto Prevendita', 1000, 0, 1),
	('bread', 'Pane', 20, 0, 1),
	('bromobiatomico', 'Bromo biatomico', 25, 0, 1),
	('candy', 'Pacchetto di caramelle', 20, 0, 1),
	('cannabis', 'Semi di marijuana', 200, 0, 1),
	('carabina', 'Carabina', 2, 0, 1),
	('carokit', 'Kit carozzeria', 20, 0, 1),
	('carotool', 'strumenti carrozzeria', 20, 0, 1),
	('cecchino', 'Cecchino', 1, 0, 1),
	('champagne', 'Champagne', 200, 0, 1),
	('ciambella', 'Ciambella', 10, 0, 1),
	('cigarett', 'Sigarette', 100, 0, 1),
	('clothe', 'vestiti', 1000, 0, 1),
	('cocaina', 'Foglie di Cocaina', 200, 0, 1),
	('cocainag', 'g di cocaina', 80, 0, 1),
	('collanadtwe', 'Venom Light', 10, 0, 1),
	('coltello', 'Coltello', 5, 0, 1),
	('combattimento', 'Pistola da combattimento', 3, 0, 1),
	('copper', 'rame', 1000, 0, 1),
	('crack', 'Foglie di crack', 200, 0, 1),
	('crack_pooch', 'g di crack', 80, 0, 1),
	('croquettes', 'Crocchette', 20, 0, 1),
	('cutted_wood', 'legna tagliata', 1000, 0, 1),
	('diamond', 'Diamanti', 140, 0, 1),
	('disco', 'Disco', 200, 0, 1),
	('drill', 'Borrmaskin', 1, 0, 1),
	('drpepper', 'Dr. Pepper', 20, 0, 1),
	('energy', 'Bevanda energetica', 20, 0, 1),
	('eroina', 'Foglie di eroina', 200, 0, 1),
	('eroina_pooch', 'g di eroina', 80, 0, 1),
	('essence', 'benzina', 1000, 0, 1),
	('fabric', 'panno', 1000, 0, 1),
	('fertilizzante', 'Fertilizzante', 1, 0, 1),
	('fioridiverbena', 'Fiori di Verbena', 15, 0, 1),
	('firework', 'Fuochi D\'Artificio', -1, 0, 1),
	('fish', 'pesce', 1000, 0, 1),
	('fiskespo', 'Canna da pesca', 1, 0, 1),
	('fixkit', 'Kit riparazione', 20, 0, 1),
	('fixtool', 'strumenti riparazione', 20, 0, 1),
	('flashlight', 'Torcia per armi', 5, 0, 1),
	('fogliecentella', 'Foglie di Centella', 15, 0, 1),
	('gas', 'Granate a gas', 25, 0, 1),
	('gasdue', 'Granata a gas', 25, 0, 1),
	('gazbottle', 'gas', 20, 0, 1),
	('giub', 'Giubbotto antiproiettile', 10, 0, 1),
	('gloves', 'Guantoni', -1, 0, 1),
	('glucomannano', 'Glucomannano', 15, 0, 1),
	('gold', 'Oro', 400, 0, 1),
	('golem', 'Golem', 20, 0, 1),
	('grand_cru', 'Vino drogato', -1, 0, 1),
	('grapperaisin', 'Grappolo uva', 5, 0, 1),
	('grip', 'Impugnatura', 1, 0, 1),
	('gym_membership', 'Abbonamento Palestra', -1, 0, 1),
	('headbag', 'Sacchetto', 5, 0, 1),
	('highradio', 'Radio 2', 5, 0, 1),
	('highrim', 'Rim 2', 4, 0, 1),
	('hotdog', 'Hotdog', 20, 0, 1),
	('ice', 'Ghiaccio', 20, 0, 1),
	('icetea', 'Ice Tea', 20, 0, 1),
	('iron', 'Ferro', 1000, 0, 1),
	('jager', 'Jägermeister', 20, 0, 1),
	('jagerbomb', 'Jägerbomb', 20, 0, 1),
	('jagercerbere', 'Jäger Cerberus', 3, 0, 1),
	('jewels', 'Gioielli', 300, 0, 1),
	('jumelles', 'Binocolo', 5, 0, 1),
	('jusfruit', 'Succo di frutta', 20, 0, 1),
	('jus_raisin', 'Succo d\'uva', -1, 0, 1),
	('krokodil', 'Krokodil', 14, 0, 1),
	('lighter', 'Fiammiferi', 100, 0, 1),
	('limonade', 'Limonata', 20, 0, 1),
	('lowradio', 'Radio', 5, 0, 1),
	('lsd', 'LSD', 200, 0, 1),
	('lsdprocessato', 'LSD Processato', 80, 0, 1),
	('macchinetta', 'Macchinetta Telecomandata', 1, 0, 1),
	('mak', 'Munizioni AK', 180, 0, 1),
	('manette', 'Manette', 1, 0, 1),
	('manganello', 'manganello', 1, 0, 1),
	('marijuana', 'Marijuana', 120, 0, 1),
	('martini', 'Martini Bianco', 10, 0, 1),
	('masch', 'Maschera subacquea', 10, 0, 1),
	('mazza', 'Mazza ba baseball', 1, 0, 1),
	('mcarabinaspeciale', 'Munizioni Carabina Speciale', -1, 0, 1),
	('mcecchino', 'Munizioni Cecchino', 150, 0, 1),
	('mcom', 'Munizioni Pistola da combattimento', 1000, 0, 1),
	('medikit', 'Medikit', 50, 0, 1),
	('menthe', 'Foglia di menta', 10, 0, 1),
	('metallo', 'Metallo', 150, 0, 1),
	('metallo_pooch', 'Metallo lavorato', 200, 0, 1),
	('metanfetamina', 'Metanfetamina', 120, 0, 1),
	('meth', 'Metanfetamina', 50, 0, 1),
	('meth_pooch', 'Grammo di meth', 80, 0, 1),
	('metreshooter', 'Misuratore sparatutto', 3, 0, 1),
	('milk', 'Latte', 20, 0, 1),
	('mixapero', 'Mix di aperitivi', 3, 0, 1),
	('mojito', 'Mojito', 20, 0, 1),
	('moonshine', 'Whisky', 20, 0, 1),
	('mpistola', 'Munizioni Pistola', 1000, 0, 1),
	('mpompa', 'Munizioni Fucile a pompa', 400, 0, 1),
	('msmg', 'Munizioni SMG', 500, 0, 1),
	('multi_key', 'Cle course de rue', 10, 0, 1),
	('nugets', 'Nugets', 500, 0, 1),
	('opium', 'Oppio', 200, 0, 1),
	('opium_pooch', 'Grammo di oppio', 80, 0, 1),
	('oppio', 'Oppio', 80, 0, 1),
	('packaged_chicken', ' sul vassoio', 1000, 0, 1),
	('packaged_plank', 'Insieme di tavole', 1000, 0, 1),
	('papavero', 'Papavero', 200, 0, 1),
	('pastocompleto', 'Pasto completo', 1000, 0, 1),
	('pefedrina', 'Pillole Di Efedrina', 200, 0, 1),
	('petrol', 'Olio', 500, 0, 1),
	('petrol_raffin', 'Olio raffinato', 500, 0, 1),
	('phone', 'Telefono', 3, 0, 1),
	('pistola', 'Pistola', 5, 0, 1),
	('policarbonato', 'Policarbonato', 100, 0, 1),
	('pomata', 'Pomata per la rosacea', 20, 0, 1),
	('pompa', 'Fucile a pompa', 2, 0, 1),
	('poolreceipt', 'Ricevuta', 15, 0, 1),
	('powerade', 'Powerade', -1, 0, 1),
	('proiettile', 'Proiettile', 200, 0, 1),
	('protein_shake', 'Frullato proteico', -1, 0, 1),
	('purpledrunk', 'Purple Drunk', 5, 0, 1),
	('radicedimungere', 'Radice di Mungere', 15, 0, 1),
	('radio', 'Radio Polizia', 5, 0, 1),
	('raisin', 'Uva', -1, 0, 1),
	('redpurpledrunk', 'Red Purple Drunk', 3, 0, 1),
	('rhum', 'Rhum', 20, 0, 1),
	('rhumcoca', 'Rhum-coke', 20, 0, 1),
	('rhumfruit', 'Rhum-alla frutta', 20, 0, 1),
	('saldatore', 'Saldatore', 25, 0, 1),
	('sangue0+', 'Sangue 0+', 20, 0, 1),
	('sangue0-', 'Sangue 0-', 20, 0, 1),
	('sanguea+', 'Sangue A+', 20, 0, 1),
	('sanguea-', 'Sangue A-', 20, 0, 1),
	('sangueab+', 'Sangue AB+', 20, 0, 1),
	('sangueab-', 'Sangue AB-', 20, 0, 1),
	('sangueb+', 'Sangue B+', 20, 0, 1),
	('sangueb-', 'Sangue B-', 20, 0, 1),
	('saucisson', 'Salsiccia', 5, 0, 1),
	('sciroppo', 'Sciroppo per la tosse', 20, 0, 1),
	('silencieux', 'Silenziatore', 1, 0, 1),
	('slaughtered_chicken', ' macellato', 1000, 0, 1),
	('smg', 'SMG', 2, 0, 1),
	('soda', 'Lemon soda', 20, 0, 1),
	('solo_key', 'Cle conte la montre', 10, 0, 1),
	('sportlunch', 'Pranzo da allenamento', -1, 0, 1),
	('sprite', 'Sprite', 50, 0, 1),
	('squalo', 'Carne di squalo', 10, 0, 1),
	('stockrim', 'Rim', 4, 0, 1),
	('stone', 'pietra', 1000, 0, 1),
	('storditore', 'Storditore', 1, 0, 1),
	('tablet', 'Tablet', 1, 0, 1),
	('tanica', 'Tanica di benzina', 5, 0, 1),
	('teqpaf', 'Teq\'paf', 20, 0, 1),
	('tequila', 'Tequila', 20, 0, 1),
	('tiroxina', 'L-tiroxina', 30, 0, 1),
	('torcia', 'Torcia', 5, 0, 1),
	('uzi', 'Micro SMG', 2, 0, 1),
	('valigetta', 'Valigetta', 1, 0, 1),
	('viande', 'Carne', 20, 0, 1),
	('vine', 'Vino', -1, 0, 1),
	('vodka', 'Vodka', 20, 0, 1),
	('vodkaenergy', 'Vodka-energetica', 20, 0, 1),
	('vodkafruit', 'Vodka-alla frutta', 20, 0, 1),
	('vodkag', 'Bottiglia di Vodka', 200, 0, 1),
	('washed_stone', 'Pietra lavorata', 400, 0, 1),
	('water', 'Acqua', 20, 0, 1),
	('weld', 'Svets', 1, 0, 1),
	('whisky', 'Whisky', 20, 0, 1),
	('whiskycoca', 'Whisky-coke', 20, 0, 1),
	('wood', 'legno', 500, 0, 1),
	('wool', 'lana', 500, 0, 1),
	('yusuf', 'Skin', 1, 0, 1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.jobs
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.jobs: ~20 rows (circa)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('ambulance', 'EMS', 1),
	('armeria', 'Armeria', 1),
	('bahama_mamas', 'Bahama Mamas', 1),
	('cardealer', 'Rivenditore auto', 1),
	('fueler', 'Petroliere', 0),
	('lumberjack', 'Taglialegna', 0),
	('mecano', 'West Coast Custom', 1),
	('miner', 'Minatore', 0),
	('nibba', 'Luxor Resort', 1),
	('nightclub', 'Nightclub', 1),
	('police', 'LSPD', 1),
	('poolcleaner', 'Pulitore della piscina', 0),
	('slaughterer', 'Macellaio', 0),
	('state', 'Stato', 1),
	('tailor', 'Sarto', 0),
	('taxi', 'Taxi', 1),
	('tequila', 'Tequila', 1),
	('trucker', 'Camionista', 0),
	('unemployed', 'Disoccupato', 0),
	('vanilla', 'Vanilla', 1);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.job_grades
DROP TABLE IF EXISTS `job_grades`;
CREATE TABLE IF NOT EXISTS `job_grades` (
  `job_name` varchar(255) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.job_grades: ~82 rows (circa)
/*!40000 ALTER TABLE `job_grades` DISABLE KEYS */;
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('unemployed', 0, 'unemployed', 'Trovati un lavoro', 50, '{}', '{}'),
	('cardealer', 0, 'recruit', 'Recluta', 2500, '{}', '{}'),
	('cardealer', 1, 'novice', 'Apprendista', 2000, '{}', '{}'),
	('cardealer', 2, 'experienced', 'Vice Direttore', 2000, '{}', '{}'),
	('cardealer', 3, 'boss', 'Direttore', 2000, '{}', '{}'),
	('police', 0, 'recruit', 'Cadetto', 1350, '{}', '{}'),
	('police', 1, 'officer', 'Agente I', 1700, '{}', '{}'),
	('police', 2, 'sergeant', 'Agente II', 1800, '{}', '{}'),
	('police', 5, 'lieutenant', 'Sergente II', 2100, '{}', '{}'),
	('police', 11, 'boss', 'Comandante', 3500, '{}', '{}'),
	('taxi', 0, 'recrue', 'Recluta', 300, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	('taxi', 1, 'novice', 'Apprendista', 1, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	('taxi', 2, 'experimente', 'Dirigente', 1, '{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	('taxi', 3, 'uber', 'Uber', 1, '{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	('taxi', 4, 'boss', 'Direttore', 1, '{"hair_2":0,"hair_color_2":0,"torso_1":29,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":1,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":4,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	('lumberjack', 0, 'employee', 'Dipendente', 100, '{"tshirt_2":0,"torso_2":0,"shoes_2":0,"pants_1":47,"shoes_1":54,"pants_2":1,"torso_1":41,"tshirt_1":15,"arms":1}\', \'{}\'),', '{}'),
	('fueler', 0, 'employee', 'Dipendente', 40, '{"tshirt_2":0,"torso_2":0,"shoes_2":0,"pants_1":47,"shoes_1":14,"pants_2":1,"torso_1":230,"tshirt_1":9,"arms":0}\', \'{}\'),', '{}'),
	('miner', 0, 'employee', 'Dipendente', 100, '{"tshirt_2":1,"ears_1":8,"glasses_1":15,"torso_2":0,"ears_2":2,"glasses_2":3,"shoes_2":1,"pants_1":75,"shoes_1":51,"bags_1":0,"helmet_2":0,"pants_2":7,"torso_1":71,"tshirt_1":59,"arms":2,"bags_2":0,"helmet_1":0}', '{}'),
	('tailor', 0, 'employee', 'Dipendente', 100, '{"mask_1":0,"arms":1,"glasses_1":0,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":29,"helmet_2":0,"lipstick_4":0,"sex":0,"torso_1":24,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":0,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":36,"tshirt_2":0,"beard_3":0,"hair_1":2,"hair_color_1":0,"pants_1":48,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}', '{"mask_1":0,"arms":5,"glasses_1":5,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":29,"helmet_2":0,"lipstick_4":0,"sex":1,"torso_1":52,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":1,"lipstick_2":0,"chain_1":0,"tshirt_1":23,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":42,"tshirt_2":4,"beard_3":0,"hair_1":2,"hair_color_1":0,"pants_1":36,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}'),
	('slaughterer', 0, 'employee', 'Dipendente', 100, '{"age_1":0,"glasses_2":0,"beard_1":5,"decals_2":0,"beard_4":0,"shoes_2":0,"tshirt_2":0,"lipstick_2":0,"hair_2":0,"arms":67,"pants_1":36,"skin":29,"eyebrows_2":0,"shoes":10,"helmet_1":-1,"lipstick_1":0,"helmet_2":0,"hair_color_1":0,"glasses":0,"makeup_4":0,"makeup_1":0,"hair_1":2,"bproof_1":0,"bags_1":0,"mask_1":0,"lipstick_3":0,"chain_1":0,"eyebrows_4":0,"sex":0,"torso_1":56,"beard_2":6,"shoes_1":12,"decals_1":0,"face":19,"lipstick_4":0,"tshirt_1":15,"mask_2":0,"age_2":0,"eyebrows_3":0,"chain_2":0,"glasses_1":0,"ears_1":-1,"bags_2":0,"ears_2":0,"torso_2":0,"bproof_2":0,"makeup_2":0,"eyebrows_1":0,"makeup_3":0,"pants_2":0,"beard_3":0,"hair_color_2":4}', '{"age_1":0,"glasses_2":0,"beard_1":5,"decals_2":0,"beard_4":0,"shoes_2":0,"tshirt_2":0,"lipstick_2":0,"hair_2":0,"arms":72,"pants_1":45,"skin":29,"eyebrows_2":0,"shoes":10,"helmet_1":-1,"lipstick_1":0,"helmet_2":0,"hair_color_1":0,"glasses":0,"makeup_4":0,"makeup_1":0,"hair_1":2,"bproof_1":0,"bags_1":0,"mask_1":0,"lipstick_3":0,"chain_1":0,"eyebrows_4":0,"sex":1,"torso_1":49,"beard_2":6,"shoes_1":24,"decals_1":0,"face":19,"lipstick_4":0,"tshirt_1":9,"mask_2":0,"age_2":0,"eyebrows_3":0,"chain_2":0,"glasses_1":5,"ears_1":-1,"bags_2":0,"ears_2":0,"torso_2":0,"bproof_2":0,"makeup_2":0,"eyebrows_1":0,"makeup_3":0,"pants_2":0,"beard_3":0,"hair_color_2":4}'),
	('mecano', 0, 'recrue', 'Meccanico', 1700, '{"tshirt_2":0,"torso_2":12,"shoes_2":23,"pants_1":97,"shoes_1":70,"pants_2":23,"torso_1":244,"tshirt_1":129,"arms":22,"chain_1":112,"chain_2":2,"decals_1":13,"decals_2":0}\', \'{}\'),', '{}'),
	('mecano', 1, 'novice', 'Vice Tuner', 2, '{"tshirt_2":0,"torso_2":25,"shoes_2":24,"pants_1":97,"shoes_1":70,"pants_2":24,"torso_1":244,"tshirt_1":129,"arms":22,"chain_1":112,"chain_2":2,"decals_1":13,"decals_2":0}\', \'{}\'),', '{}'),
	('mecano', 2, 'experimente', 'Tuner', 1200, '{"tshirt_2":0,"torso_2":7,"shoes_2":2,"pants_1":97,"shoes_1":70,"pants_2":22,"torso_1":244,"tshirt_1":129,"arms":21,"chain_1":112,"chain_2":2,"decals_1":13,"decals_2":0}\', \'{}\'),', '{}'),
	('mecano', 3, 'chief', 'Vice direttore', 1, '{"tshirt_2":0,"torso_2":14,"shoes_2":16,"pants_1":97,"shoes_1":70,"pants_2":16,"torso_1":248,"tshirt_1":129,"arms":22,"chain_1":112,"chain_2":0,"decals_1":13,"decals_2":0}\', \'{}\'),', '{}'),
	('mecano', 4, 'boss', 'Direttore', 1, '{"tshirt_2":0,"torso_2":15,"shoes_2":16,"pants_1":97,"shoes_1":70,"pants_2":16,"torso_1":247,"tshirt_1":129,"arms":21,"chain_1":112,"chain_2":0,"decals_1":13,"decals_2":0}\', \'{}\'),', '{}'),
	('trucker', 0, 'employee', 'Dipendente', 100, '{"tshirt_1":59,"torso_1":89,"arms":31,"pants_1":36,"glasses_1":19,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":2,"glasses_2":0,"torso_2":1,"shoes":35,"hair_1":0,"skin":0,"sex":0,"glasses_1":19,"pants_2":0,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":5}', '{"tshirt_1":36,"torso_1":0,"arms":68,"pants_1":30,"glasses_1":15,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":27,"glasses_2":0,"torso_2":11,"shoes":26,"hair_1":5,"skin":0,"sex":1,"glasses_1":15,"pants_2":2,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":19}'),
	('armeria', 0, 'dipendente', 'Dipendente', 700, '{}', '{}'),
	('armeria', 1, 'soldato', 'Matricola', 1, '{}', '{}'),
	('armeria', 2, 'caporale', 'Mercenario', 1, '{}', '{}'),
	('armeria', 3, 'sergente', 'Capo Brigata', 1, '{}', '{}'),
	('armeria', 4, 'tenente', 'Colonnello', 1, '{}', '{}'),
	('armeria', 5, 'boss', 'Generale', 1, '{}', '{}'),
	('police', 3, 'ufficiale', 'Detective', 1800, '{}', '{}'),
	('police', 9, 'comandante', 'Vice Capitano', 2600, '{}', '{}'),
	('police', 12, 'vicecapitano', 'Capitano', 2850, '{}', '{}'),
	('police', 10, 'vicecapitano', 'Vice Com.', 3000, '{}', '{}'),
	('fueler', 1, 'boss', 'Direttore', 60, '{"tshirt_2":0,"torso_2":0,"shoes_2":0,"pants_1":47,"shoes_1":14,"pants_2":1,"torso_1":230,"tshirt_1":9,"arms":0}\', \'{}\'),', '{}'),
	('ambulance', 0, 'ambulance', 'Tirocinante', 1000, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":20,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":85,"face":19,"decals_1":58,"torso_1":250,"hair_2":0,"skin":34,"pants_2":0}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	('ambulance', 1, 'doctor', 'Specializzando', 1500, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":20,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":85,"face":19,"decals_1":58,"torso_1":250,"hair_2":0,"skin":34,"pants_2":0}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	('ambulance', 2, 'chief_doctor', 'Medico', 2200, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":20,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":85,"face":19,"decals_1":58,"torso_1":250,"hair_2":0,"skin":34,"pants_2":0}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	('ambulance', 3, 'chirurgo', 'Chirurgo', 2600, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":20,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":85,"face":19,"decals_1":58,"torso_1":250,"hair_2":0,"skin":34,"pants_2":0}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	('ambulance', 4, 'primario', 'Primario di medicina', 2900, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":20,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":85,"face":19,"decals_1":58,"torso_1":250,"hair_2":0,"skin":34,"pants_2":0}', '{"tshirt_2":0,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":258,"shoes":10,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":1,"tshirt_1":3,"pants_1":23,"helmet_1":57,"torso_2":0,"arms":98,"sex":1,"glasses_2":0,"decals_1":66,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	('ambulance', 5, 'boss', 'Direttore Sanitario', 3500, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":20,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":85,"face":19,"decals_1":58,"torso_1":250,"hair_2":0,"skin":34,"pants_2":0}', '{"tshirt_2":0,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":258,"shoes":10,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":1,"tshirt_1":3,"pants_1":23,"helmet_1":57,"torso_2":0,"arms":98,"sex":1,"glasses_2":0,"decals_1":66,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	('tailor', 1, 'boss', 'Direttore', 1200, '{}', '{}'),
	('nightclub', 0, 'barman', 'Affiliado', 1000, '{}', '{}'),
	('nightclub', 1, 'dancer', 'Miembro', 1000, '{}', '{}'),
	('nightclub', 2, 'viceboss', 'El Primero', 1000, '{}', '{}'),
	('nightclub', 3, 'boss', 'El Chapo', 1000, '{}', '{}'),
	('state', 0, 'stato', 'Guardia Del Corpo', 5000, '{}', '{}'),
	('state', 10, 'boss', 'Presidente', 2500, '{}', '{}'),
	('state', 1, 'gouvernment', 'Avvocato', 1, '{}', '{}'),
	('state', 4, 'vicepresidente', 'NSA - Caporale', 1, '{}', '{}'),
	('poolcleaner', 0, 'interim', 'Pulitore', 400, '{}', '{}'),
	('state', 9, 'vicepresidente', 'Vicepresidente', 1, '{}', '{}'),
	('bahama_mamas', 0, 'barman', 'Barman', 700, '{}', '{}'),
	('bahama_mamas', 1, 'dancer', 'Ballerina', 1, '{}', '{}'),
	('bahama_mamas', 2, 'viceboss', 'Vice Boss', 2200, '{}', '{}'),
	('bahama_mamas', 3, 'boss', 'Boss', 1, '{}', '{}'),
	('vanilla', 0, 'barman', 'Barista', 500, '{}', '{}'),
	('vanilla', 1, 'stripper', 'Stripper', 500, '{}', '{}'),
	('vanilla', 2, 'dancer', 'Sicurezza', 500, '{}', '{}'),
	('vanilla', 3, 'viceboss', 'Capo Sicurezza', 800, '{}', '{}'),
	('vanilla', 4, 'boss', 'Direttore', 300, '{}', '{}'),
	('state', 3, 'vicepresidente', 'NSA - Soldato', 1, '{}', '{}'),
	('state', 2, 'vicepresidente', 'Segretaria', 5000, '{}', '{}'),
	('police', 4, 'ufficiale', 'Sergente I', 2000, '{}', '{}'),
	('police', 6, 'lieutenant', 'Tenente I', 2200, '{}', '{}'),
	('state', 5, 'vicepresidente', 'NSA - Maggiore', 1, '{}', '{}'),
	('police', 7, 'lieutenant', 'Procuratore', 2400, '{}', '{}'),
	('tequila', 0, 'barman', 'Barista', 300, '{}', '{}'),
	('tequila', 1, 'dancer', 'Sicurezza', 300, '{}', '{}'),
	('tequila', 2, 'viceboss', 'Capo Sicurezza', 300, '{}', '{}'),
	('tequila', 3, 'boss', 'Direttore', 1, '{}', '{}'),
	('nibba', 0, 'soldato', 'BarMan', 1500, '{}', '{}'),
	('nibba', 1, 'killer', 'Security', 1800, '{}', '{}'),
	('nibba', 2, 'lamadredelkiller', 'Lady', 0, '{}', '{}'),
	('nibba', 3, 'ilpadredelkiller', 'Braccio Destro', 1500, '{}', '{}'),
	('nibba', 4, 'boss', 'Boss ', 800, '{}', '{}'),
	('state', 8, 'vicepresidente', 'Ministro ', 1, '{}', '{}'),
	('state', 7, 'vicepresidente', 'NSA - Generale', 1, '{}', '{}'),
	('police', 8, 'lieutenant', 'Tenente II', 2500, '{}', '{}'),
	('state', 6, 'vicepresidente', 'NSA - Colonnello', 1, '{}', '{}');
/*!40000 ALTER TABLE `job_grades` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.jsfour_atm
DROP TABLE IF EXISTS `jsfour_atm`;
CREATE TABLE IF NOT EXISTS `jsfour_atm` (
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.jsfour_atm: ~0 rows (circa)
/*!40000 ALTER TABLE `jsfour_atm` DISABLE KEYS */;
/*!40000 ALTER TABLE `jsfour_atm` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.licenses
DROP TABLE IF EXISTS `licenses`;
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.licenses: ~17 rows (circa)
/*!40000 ALTER TABLE `licenses` DISABLE KEYS */;
INSERT INTO `licenses` (`type`, `label`) VALUES
	('aircraft', 'Aircraft License'),
	('assicurazione', 'Assicurazione Veicolo'),
	('assicurazionemedica', 'Assicurazione Medica'),
	('avvocato', 'Permesso Avvocato'),
	('boat', 'Licenza Nautica'),
	('caccia', 'Licenza da caccia'),
	('certificatom', 'Certificato per l\'utilizzo di Marijuana'),
	('certificatopda', 'Certificato per il rilascio del porto d\'armi'),
	('dmv', 'Test teorico patente'),
	('drive', 'Patente B'),
	('drive_bike', 'Patente A'),
	('drive_truck', 'Patente C'),
	('testarmi', 'Test armeria superato'),
	('venditacannabis', 'Licenza vendita erba'),
	('volo', 'Licenza di volo'),
	('weapon', 'Porto d\'armi'),
	('weed_processing', 'Certificato per raccolta di Marijuana');
/*!40000 ALTER TABLE `licenses` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.multi_race
DROP TABLE IF EXISTS `multi_race`;
CREATE TABLE IF NOT EXISTS `multi_race` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) NOT NULL,
  `race` int(11) NOT NULL,
  `nb_laps` int(11) NOT NULL,
  `nb_pers` int(11) NOT NULL,
  `ended` tinyint(1) NOT NULL,
  `created_date` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella essentialmode3.multi_race: ~0 rows (circa)
/*!40000 ALTER TABLE `multi_race` DISABLE KEYS */;
/*!40000 ALTER TABLE `multi_race` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.owned_aircrafts
DROP TABLE IF EXISTS `owned_aircrafts`;
CREATE TABLE IF NOT EXISTS `owned_aircrafts` (
  `owner` varchar(22) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'State of the aircraft',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`plate`),
  KEY `state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.owned_aircrafts: ~0 rows (circa)
/*!40000 ALTER TABLE `owned_aircrafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_aircrafts` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.owned_boats
DROP TABLE IF EXISTS `owned_boats`;
CREATE TABLE IF NOT EXISTS `owned_boats` (
  `owner` varchar(22) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'State of the boat',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `vehicleType` varchar(20) DEFAULT 'car',
  PRIMARY KEY (`plate`),
  KEY `stored_vehicleType` (`stored`,`vehicleType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.owned_boats: ~0 rows (circa)
/*!40000 ALTER TABLE `owned_boats` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_boats` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.owned_keys
DROP TABLE IF EXISTS `owned_keys`;
CREATE TABLE IF NOT EXISTS `owned_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dump dei dati della tabella essentialmode3.owned_keys: ~0 rows (circa)
/*!40000 ALTER TABLE `owned_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_keys` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.owned_properties
DROP TABLE IF EXISTS `owned_properties`;
CREATE TABLE IF NOT EXISTS `owned_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL,
  `shared` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella essentialmode3.owned_properties: ~0 rows (circa)
/*!40000 ALTER TABLE `owned_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_properties` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.owned_shops
DROP TABLE IF EXISTS `owned_shops`;
CREATE TABLE IF NOT EXISTS `owned_shops` (
  `identifier` varchar(250) DEFAULT NULL,
  `ShopNumber` int(11) DEFAULT NULL,
  `money` int(11) DEFAULT 0,
  `ShopValue` int(11) DEFAULT NULL,
  `LastRobbery` int(11) DEFAULT 0,
  `ShopName` varchar(30) DEFAULT NULL,
  UNIQUE KEY `ShopNumber` (`ShopNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.owned_shops: ~19 rows (circa)
/*!40000 ALTER TABLE `owned_shops` DISABLE KEYS */;
INSERT INTO `owned_shops` (`identifier`, `ShopNumber`, `money`, `ShopValue`, `LastRobbery`, `ShopName`) VALUES
	('0', 1, 0, 470000, 0, '0'),
	('0', 2, 0, 930000, 0, '0'),
	('0', 3, 0, 380000, 0, '0'),
	('0', 4, 0, 920000, 0, '0'),
	('0', 5, 0, 700000, 0, '0'),
	('0', 6, 0, 490000, 0, '0'),
	('0', 7, 0, 450000, 0, '0'),
	('0', 8, 0, 800000, 0, '0'),
	('0', 9, 0, 620000, 0, '0'),
	('0', 10, 0, 680000, 0, '0'),
	('0', 12, 0, 650000, 0, '0'),
	('0', 13, 0, 950000, 0, '0'),
	('0', 14, 0, 730000, 0, '0'),
	('0', 15, 0, 340000, 0, '0'),
	('0', 16, 0, 720000, 0, '0'),
	('0', 18, 0, 590000, 0, '0'),
	('0', 11, 0, 390000, 0, '0'),
	('0', 19, 0, 540000, 0, '0'),
	('0', 20, 0, 780000, 0, '0'),
	('0', 17, 0, 970000, 0, '0');
/*!40000 ALTER TABLE `owned_shops` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.owned_vehicles
DROP TABLE IF EXISTS `owned_vehicles`;
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(22) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'State of the car',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `vehicleType` varchar(20) DEFAULT 'car',
  PRIMARY KEY (`plate`),
  KEY `state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.owned_vehicles: ~0 rows (circa)
/*!40000 ALTER TABLE `owned_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_vehicles` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.phone_app_chat
DROP TABLE IF EXISTS `phone_app_chat`;
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella essentialmode3.phone_app_chat: ~0 rows (circa)
/*!40000 ALTER TABLE `phone_app_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_app_chat` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.phone_calls
DROP TABLE IF EXISTS `phone_calls`;
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella essentialmode3.phone_calls: ~0 rows (circa)
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.phone_messages
DROP TABLE IF EXISTS `phone_messages`;
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `time` (`time`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella essentialmode3.phone_messages: 0 rows
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.phone_users_contacts
DROP TABLE IF EXISTS `phone_users_contacts`;
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella essentialmode3.phone_users_contacts: 0 rows
/*!40000 ALTER TABLE `phone_users_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_users_contacts` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.properties
DROP TABLE IF EXISTS `properties`;
CREATE TABLE IF NOT EXISTS `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `outside` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT '[]',
  `gateway` varchar(255) DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.properties: ~42 rows (circa)
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(1, 'WhispymoundDrive', '2677 Whispymound Drive', '{"y":564.89,"z":182.959,"x":119.384}', '{"x":117.347,"y":559.506,"z":183.304}', '{"y":557.032,"z":183.301,"x":118.037}', '{"y":567.798,"z":182.131,"x":119.249}', '[]', NULL, 1, 1, 0, '{"x":118.748,"y":566.573,"z":175.697}', 1500000),
	(2, 'NorthConkerAvenue2045', '2045 North Conker Avenue', '{"x":372.796,"y":428.327,"z":144.685}', '{"x":373.548,"y":422.982,"z":144.907},', '{"y":420.075,"z":145.904,"x":372.161}', '{"x":372.454,"y":432.886,"z":143.443}', '[]', NULL, 1, 1, 0, '{"x":377.349,"y":429.422,"z":137.3}', 1500000),
	(3, 'RichardMajesticApt2', 'Richard Majestic, Apt 2', '{"y":-379.165,"z":37.961,"x":-936.363}', '{"y":-365.476,"z":113.274,"x":-913.097}', '{"y":-367.637,"z":113.274,"x":-918.022}', '{"y":-382.023,"z":37.961,"x":-943.626}', '[]', NULL, 1, 1, 0, '{"x":-927.554,"y":-377.744,"z":112.674}', 1700000),
	(4, 'NorthConkerAvenue2044', '2044 North Conker Avenue', '{"y":440.8,"z":146.702,"x":346.964}', '{"y":437.456,"z":148.394,"x":341.683}', '{"y":435.626,"z":148.394,"x":339.595}', '{"x":350.535,"y":443.329,"z":145.764}', '[]', NULL, 1, 1, 0, '{"x":337.726,"y":436.985,"z":140.77}', 1500000),
	(5, 'WildOatsDrive', '3655 Wild Oats Drive', '{"y":502.696,"z":136.421,"x":-176.003}', '{"y":497.817,"z":136.653,"x":-174.349}', '{"y":495.069,"z":136.666,"x":-173.331}', '{"y":506.412,"z":135.0664,"x":-177.927}', '[]', NULL, 1, 1, 0, '{"x":-174.725,"y":493.095,"z":129.043}', 1500000),
	(6, 'HillcrestAvenue2862', '2862 Hillcrest Avenue', '{"y":596.58,"z":142.641,"x":-686.554}', '{"y":591.988,"z":144.392,"x":-681.728}', '{"y":590.608,"z":144.392,"x":-680.124}', '{"y":599.019,"z":142.059,"x":-689.492}', '[]', NULL, 1, 1, 0, '{"x":-680.46,"y":588.6,"z":136.769}', 1500000),
	(7, 'LowEndApartment', 'Appartement de base', '{"y":-1078.735,"z":28.4031,"x":292.528}', '{"y":-1007.152,"z":-102.002,"x":265.845}', '{"y":-1002.802,"z":-100.008,"x":265.307}', '{"y":-1078.669,"z":28.401,"x":296.738}', '[]', NULL, 1, 1, 0, '{"x":265.916,"y":-999.38,"z":-100.008}', 562500),
	(8, 'MadWayneThunder', '2113 Mad Wayne Thunder', '{"y":454.955,"z":96.462,"x":-1294.433}', '{"x":-1289.917,"y":449.541,"z":96.902}', '{"y":446.322,"z":96.899,"x":-1289.642}', '{"y":455.453,"z":96.517,"x":-1298.851}', '[]', NULL, 1, 1, 0, '{"x":-1287.306,"y":455.901,"z":89.294}', 1500000),
	(9, 'HillcrestAvenue2874', '2874 Hillcrest Avenue', '{"x":-853.346,"y":696.678,"z":147.782}', '{"y":690.875,"z":151.86,"x":-859.961}', '{"y":688.361,"z":151.857,"x":-859.395}', '{"y":701.628,"z":147.773,"x":-855.007}', '[]', NULL, 1, 1, 0, '{"x":-858.543,"y":697.514,"z":144.253}', 1500000),
	(10, 'HillcrestAvenue2868', '2868 Hillcrest Avenue', '{"y":620.494,"z":141.588,"x":-752.82}', '{"y":618.62,"z":143.153,"x":-759.317}', '{"y":617.629,"z":143.153,"x":-760.789}', '{"y":621.281,"z":141.254,"x":-750.919}', '[]', NULL, 1, 1, 0, '{"x":-762.504,"y":618.992,"z":135.53}', 1500000),
	(11, 'TinselTowersApt12', 'Tinsel Towers, Apt 42', '{"y":37.025,"z":42.58,"x":-618.299}', '{"y":58.898,"z":97.2,"x":-603.301}', '{"y":58.941,"z":97.2,"x":-608.741}', '{"y":30.603,"z":42.524,"x":-620.017}', '[]', NULL, 1, 1, 0, '{"x":-622.173,"y":54.585,"z":96.599}', 1700000),
	(12, 'MiltonDrive', 'Milton Drive', '{"x":-775.17,"y":312.01,"z":84.658}', NULL, NULL, '{"x":-775.346,"y":306.776,"z":84.7}', '[]', NULL, 0, 0, 1, NULL, 0),
	(13, 'Modern1Apartment', 'Appartement Moderne 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_01_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.661,"y":327.672,"z":210.396}', 1300000),
	(14, 'Modern2Apartment', 'Appartement Moderne 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_01_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.735,"y":326.757,"z":186.313}', 1300000),
	(15, 'Modern3Apartment', 'Appartement Moderne 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_01_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.386,"y":330.782,"z":195.08}', 1300000),
	(16, 'Mody1Apartment', 'Appartement Mode 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_02_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.615,"y":327.878,"z":210.396}', 1300000),
	(17, 'Mody2Apartment', 'Appartement Mode 2', '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_02_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.297,"y":327.092,"z":186.313}', 1300000),
	(18, 'Mody3Apartment', 'Appartement Mode 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_02_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.303,"y":330.932,"z":195.085}', 1300000),
	(19, 'Vibrant1Apartment', 'Appartement Vibrant 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_03_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.885,"y":327.641,"z":210.396}', 1300000),
	(20, 'Vibrant2Apartment', 'Appartement Vibrant 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_03_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.607,"y":327.344,"z":186.313}', 1300000),
	(21, 'Vibrant3Apartment', 'Appartement Vibrant 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_03_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.525,"y":330.851,"z":195.085}', 1300000),
	(22, 'Sharp1Apartment', 'Appartement Persan 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_04_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.527,"y":327.89,"z":210.396}', 1300000),
	(23, 'Sharp2Apartment', 'Appartement Persan 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_04_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.642,"y":326.497,"z":186.313}', 1300000),
	(24, 'Sharp3Apartment', 'Appartement Persan 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_04_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.503,"y":331.318,"z":195.085}', 1300000),
	(25, 'Monochrome1Apartment', 'Appartement Monochrome 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_05_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.289,"y":328.086,"z":210.396}', 1300000),
	(26, 'Monochrome2Apartment', 'Appartement Monochrome 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_05_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.692,"y":326.762,"z":186.313}', 1300000),
	(27, 'Monochrome3Apartment', 'Appartement Monochrome 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_05_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.094,"y":330.976,"z":195.085}', 1300000),
	(28, 'Seductive1Apartment', 'Appartement Séduisant 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_06_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.263,"y":328.104,"z":210.396}', 1300000),
	(29, 'Seductive2Apartment', 'Appartement Séduisant 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_06_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.655,"y":326.611,"z":186.313}', 1300000),
	(30, 'Seductive3Apartment', 'Appartement Séduisant 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_06_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.3,"y":331.414,"z":195.085}', 1300000),
	(31, 'Regal1Apartment', 'Appartement Régal 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_07_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.956,"y":328.257,"z":210.396}', 1300000),
	(32, 'Regal2Apartment', 'Appartement Régal 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_07_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.545,"y":326.659,"z":186.313}', 1300000),
	(33, 'Regal3Apartment', 'Appartement Régal 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_07_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.087,"y":331.429,"z":195.123}', 1300000),
	(34, 'Aqua1Apartment', 'Appartement Aqua 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_08_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.187,"y":328.47,"z":210.396}', 1300000),
	(35, 'Aqua2Apartment', 'Appartement Aqua 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_08_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.658,"y":326.563,"z":186.313}', 1300000),
	(36, 'Aqua3Apartment', 'Appartement Aqua 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_08_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.287,"y":331.084,"z":195.086}', 1300000),
	(37, 'IntegrityWay', '4 Integrity Way', '{"x":-47.804,"y":-585.867,"z":36.956}', NULL, NULL, '{"x":-54.178,"y":-583.762,"z":35.798}', '[]', NULL, 0, 0, 1, NULL, 0),
	(38, 'IntegrityWay28', '4 Integrity Way - Apt 28', NULL, '{"x":-31.409,"y":-594.927,"z":79.03}', '{"x":-26.098,"y":-596.909,"z":79.03}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{"x":-11.923,"y":-597.083,"z":78.43}', 1700000),
	(39, 'IntegrityWay30', '4 Integrity Way - Apt 30', NULL, '{"x":-17.702,"y":-588.524,"z":89.114}', '{"x":-16.21,"y":-582.569,"z":89.114}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{"x":-26.327,"y":-588.384,"z":89.123}', 1700000),
	(40, 'DellPerroHeights', 'Dell Perro Heights', '{"x":-1447.06,"y":-538.28,"z":33.74}', NULL, NULL, '{"x":-1440.022,"y":-548.696,"z":33.74}', '[]', NULL, 0, 0, 1, NULL, 0),
	(41, 'DellPerroHeightst4', 'Dell Perro Heights - Apt 28', NULL, '{"x":-1452.125,"y":-540.591,"z":73.044}', '{"x":-1455.435,"y":-535.79,"z":73.044}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{"x":-1467.058,"y":-527.571,"z":72.443}', 1700000),
	(42, 'DellPerroHeightst7', 'Dell Perro Heights - Apt 30', NULL, '{"x":-1451.562,"y":-523.535,"z":55.928}', '{"x":-1456.02,"y":-519.209,"z":55.929}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{"x":-1457.026,"y":-530.219,"z":55.937}', 1700000);
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.record_multi
DROP TABLE IF EXISTS `record_multi`;
CREATE TABLE IF NOT EXISTS `record_multi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `race` int(11) NOT NULL,
  `record` int(11) NOT NULL,
  `vehicle` int(11) NOT NULL,
  `nb_laps` int(11) NOT NULL,
  `multi_race_id` int(11) NOT NULL,
  `ended` tinyint(1) NOT NULL,
  `record_date` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella essentialmode3.record_multi: ~0 rows (circa)
/*!40000 ALTER TABLE `record_multi` DISABLE KEYS */;
/*!40000 ALTER TABLE `record_multi` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.rented_vehicles
DROP TABLE IF EXISTS `rented_vehicles`;
CREATE TABLE IF NOT EXISTS `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(22) NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.rented_vehicles: ~0 rows (circa)
/*!40000 ALTER TABLE `rented_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `rented_vehicles` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.shipments
DROP TABLE IF EXISTS `shipments`;
CREATE TABLE IF NOT EXISTS `shipments` (
  `id` int(11) DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `count` varchar(50) DEFAULT NULL,
  `time` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.shipments: ~0 rows (circa)
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.shops
DROP TABLE IF EXISTS `shops`;
CREATE TABLE IF NOT EXISTS `shops` (
  `ShopNumber` int(11) NOT NULL DEFAULT 0,
  `src` varchar(50) NOT NULL,
  `count` int(11) NOT NULL,
  `item` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella essentialmode3.shops: ~0 rows (circa)
/*!40000 ALTER TABLE `shops` DISABLE KEYS */;
/*!40000 ALTER TABLE `shops` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.solo_race
DROP TABLE IF EXISTS `solo_race`;
CREATE TABLE IF NOT EXISTS `solo_race` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(255) NOT NULL,
  `record` int(11) NOT NULL,
  `race` int(11) NOT NULL,
  `vehicle` int(11) NOT NULL,
  `record_date` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella essentialmode3.solo_race: ~0 rows (circa)
/*!40000 ALTER TABLE `solo_race` DISABLE KEYS */;
/*!40000 ALTER TABLE `solo_race` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.transefrimenti
DROP TABLE IF EXISTS `transefrimenti`;
CREATE TABLE IF NOT EXISTS `transefrimenti` (
  `Inviatore` varchar(50) DEFAULT NULL,
  `Tipo` varchar(50) DEFAULT NULL,
  `Importo` int(11) DEFAULT NULL,
  `Beneficiario` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Transferimenti soldi giocatori';

-- Dump dei dati della tabella essentialmode3.transefrimenti: ~0 rows (circa)
/*!40000 ALTER TABLE `transefrimenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `transefrimenti` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.trunk_inventory
DROP TABLE IF EXISTS `trunk_inventory`;
CREATE TABLE IF NOT EXISTS `trunk_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`),
  KEY `owned` (`owned`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.trunk_inventory: ~0 rows (circa)
/*!40000 ALTER TABLE `trunk_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunk_inventory` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.twitter_accounts
DROP TABLE IF EXISTS `twitter_accounts`;
CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dump dei dati della tabella essentialmode3.twitter_accounts: ~0 rows (circa)
/*!40000 ALTER TABLE `twitter_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_accounts` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.twitter_likes
DROP TABLE IF EXISTS `twitter_likes`;
CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dump dei dati della tabella essentialmode3.twitter_likes: ~0 rows (circa)
/*!40000 ALTER TABLE `twitter_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_likes` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.twitter_tweets
DROP TABLE IF EXISTS `twitter_tweets`;
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella essentialmode3.twitter_tweets: ~0 rows (circa)
/*!40000 ALTER TABLE `twitter_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_tweets` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT '',
  `skin` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `job` varchar(255) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `status` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `dateofbirth` varchar(25) COLLATE utf8mb4_bin DEFAULT '',
  `sex` varchar(10) COLLATE utf8mb4_bin DEFAULT '',
  `height` varchar(5) COLLATE utf8mb4_bin DEFAULT '',
  `jail` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `last_property` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `tattoos` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL,
  `pet` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `phone_number` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `malato` varchar(255) COLLATE utf8mb4_bin DEFAULT 'no',
  `malatostomaco` varchar(255) COLLATE utf8mb4_bin DEFAULT 'no',
  `malatopelle` varchar(255) COLLATE utf8mb4_bin DEFAULT 'no',
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dump dei dati della tabella essentialmode3.users: ~0 rows (circa)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.user_accounts
DROP TABLE IF EXISTS `user_accounts`;
CREATE TABLE IF NOT EXISTS `user_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.user_accounts: ~0 rows (circa)
/*!40000 ALTER TABLE `user_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_accounts` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.user_contacts
DROP TABLE IF EXISTS `user_contacts`;
CREATE TABLE IF NOT EXISTS `user_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.user_contacts: ~0 rows (circa)
/*!40000 ALTER TABLE `user_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_contacts` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.user_inventory
DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier_item` (`identifier`,`item`)
) ENGINE=InnoDB AUTO_INCREMENT=2265 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.user_inventory: ~0 rows (circa)
/*!40000 ALTER TABLE `user_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_inventory` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.user_licenses
DROP TABLE IF EXISTS `user_licenses`;
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.user_licenses: ~0 rows (circa)
/*!40000 ALTER TABLE `user_licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_licenses` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.user_parkings
DROP TABLE IF EXISTS `user_parkings`;
CREATE TABLE IF NOT EXISTS `user_parkings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) DEFAULT NULL,
  `garage` varchar(60) DEFAULT NULL,
  `zone` int(11) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.user_parkings: ~0 rows (circa)
/*!40000 ALTER TABLE `user_parkings` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_parkings` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.vehicles
DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.vehicles: ~70 rows (circa)
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` (`name`, `model`, `price`, `category`) VALUES
	('Chevrolet Camaro ZL1 2017', 'zl2017', 350000, 'sport'),
	('BMW Z4', 'z419', 600000, 'sport'),
	('Jaguar XE S', 'xes2015', 200000, 'berline'),
	('Rolls Royce Wraith', 'wraith', 1500000, 'super'),
	('Mercedes-Benz w140s600', 'w140s600', 70000, 'berline'),
	('Dodge Viper', 'viper', 1750000, 'super'),
	('Aston Martin V8 Vantage', 'vantage', 1850000, 'super'),
	('Renault Twingo 1998', 'twingo', 10000, 'compatte'),
	('Nissan Patrol', 'tulenis', 650000, 'super'),
	('Jeep Trailcat', 'trailcat', 400000, 'outroad'),
	('Subaru WRX STI', 'sti', 200000, 'sport'),
	('Jeep Gran Cherokee SRT8', 'srt8', 450000, 'outroad'),
	('Audi SQ7 2016', 'sq72016', 600000, 'suv'),
	('McLaren Senna', 'senna', 7000000, 'super'),
	('Audi RS3', 'rs318', 600000, 'sport'),
	('Nissan Qashqai 16 dCi', 'qashqai16', 200000, 'suv'),
	('Peugeot 108', 'peug108', 40000, 'compatte'),
	('Porsche 911r', 'p911r', 3200000, 'super'),
	('Lincoln Navigator', 'navigator', 80000, 'compatte'),
	('Ford Mustang GT', 'mgt', 400000, 'sport'),
	('Mercedes-Benz AMG CLA45', 'macla', 350000, 'sport'),
	('Lamborghini Huracán LP 610-4', 'lp610', 5000000, 'super'),
	('KIA Stinger GT', 'kiagt', 150000, 'berline'),
	('Renault Kangoo', 'kangoo', 25000, 'compatte'),
	('Hummer H6', 'h6', 1300000, 'outroad'),
	('Nissan GT-R', 'gtr', 2100000, 'super'),
	('GMC Sierra Denali 3500D', 'gmcs', 150000, 'outroad'),
	('Mercedes-Benz GL63 AMG', 'gl63', 350000, 'suv'),
	('Ferrari California T', 'fct', 5000000, 'super'),
	('Ferrari 812 Superfast', 'f812', 1700000, 'super'),
	('BMW M4 F82', 'f82', 650000, 'sport'),
	('Mitsubishi Lancer Evo 9 MR', 'evo9mr', 250000, 'sport'),
	('Renault Espace 3', 'espace3', 10000, 'suv'),
	('Mercedes-Benz E 63 AMG', 'e63amg', 800000, 'super'),
	('Ford Everest', 'everest', 220000, 'suv'),
	('BMW Serie5  E34', 'e34', 150000, 'berline'),
	('Cadillac CTS-V 2016', 'ctsv16', 450000, 'berline'),
	('Opel Corsa', 'corsae', 25000, 'compatte'),
	('Mini Cooper S', 'cooper15 ', 65000, 'compatte'),
	('Mercedes-Benz AMG CLA 45 SB ', 'cla45sb', 500000, 'sport'),
	('Citroën C4', 'citroc4', 20000, 'compatte'),
	('Dodge Grand Caravan', 'caravan', 18000, 'berline'),
	('Audi RS6 2003', 'c5rs6', 100000, 'sport'),
	('Bugatti Veyron', 'bugatti', 10000000, 'super'),
	('BMW 750i (e38)', 'bmwe38', 30000, 'berline'),
	('Audi R8', 'arv10', 1900000, 'super'),
	('Audi A8', 'a8audi', 280000, 'Berline'),
	('Porsche 911 TBS', '911tbs', 2800000, 'super'),
	('Porsche 911 RWB', '911rwb', 2400000, 'super'),
	(' Lamborghini Huracán Performante', '18performante', 7000000, 'super'),
	('Ferrari 488 GTB', '488', 6000000, 'super'),
	('McLaren 675 LT', '675lt', 5500000, 'super'),
	('Dodge Charger R/T 1969', '69 charger', 200000, 'sport'),
	('Citroën C3 Pluriel', 'c3plur   ', 30000, 'compatte'),
	('Honda Civic', 'civic', 50000, 'berline'),
	('Dacia  Logan', 'logan', 25000, 'compatte'),
	('Renault Megane 4', 'megane4', 35000, 'berline'),
	('McLaren P1', 'p1 ', 12000000, 'super'),
	('Mercedes-Benz v250', 'v250 ', 300000, 'furgoni'),
	('Seat Leon', 'seatleon', 60000, 'berline'),
	('BMW S 1000 RR HP4', 'bmws', 200000, 'moto'),
	('HONDA CRF 450 RX Supermoto', 'crfsm', 70000, 'moto'),
	('Ducati Panigale S', 'd99', 120000, 'moto'),
	('KTM  EXC 530 ', 'exc530', 70000, 'moto'),
	('HONDA CBR1000RR', 'hcbr17', 140000, 'moto'),
	('KTM 690 SM', 'ktmsm', 50000, 'moto'),
	('Yamaha  R6', 'r6', 125000, 'moto'),
	('Yamaha DT125', 'yzfsm2', 90000, 'moto'),
	('Kawasaki Ninja ZX-10R', 'zx10', 170000, 'moto'),
	('Kawasaki Ninja H2', 'nh2r', 120000, 'moto');
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.vehicle_categories
DROP TABLE IF EXISTS `vehicle_categories`;
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.vehicle_categories: ~8 rows (circa)
/*!40000 ALTER TABLE `vehicle_categories` DISABLE KEYS */;
INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
	('sport', 'Sportive'),
	('berline', 'Berline'),
	('super', 'Super'),
	('compatte', 'Compatte'),
	('outroad', 'Fuoristrada'),
	('suv', 'SUV'),
	('furgoni', 'Furgoni'),
	('moto', 'Moto');
/*!40000 ALTER TABLE `vehicle_categories` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.vehicle_sold
DROP TABLE IF EXISTS `vehicle_sold`;
CREATE TABLE IF NOT EXISTS `vehicle_sold` (
  `client` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `soldby` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.vehicle_sold: ~0 rows (circa)
/*!40000 ALTER TABLE `vehicle_sold` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_sold` ENABLE KEYS */;

-- Dump della struttura di tabella essentialmode3.weashops
DROP TABLE IF EXISTS `weashops`;
CREATE TABLE IF NOT EXISTS `weashops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella essentialmode3.weashops: ~5 rows (circa)
/*!40000 ALTER TABLE `weashops` DISABLE KEYS */;
INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
	(3, 'GunShop', 'WEAPON_FLASHLIGHT', 300),
	(9, 'GunShop', 'WEAPON_BAT', 350),
	(31, 'GunShop', 'WEAPON_KNIFE', 500),
	(32, 'BlackWeashop', 'WEAPON_KNIFE', 1000),
	(33, 'GunShop', 'WEAPON_PETROLCAN', 100);
/*!40000 ALTER TABLE `weashops` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
