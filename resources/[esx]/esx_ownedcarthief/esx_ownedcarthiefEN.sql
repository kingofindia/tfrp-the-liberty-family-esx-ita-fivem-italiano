USE `essentialmode`;

ALTER TABLE `owned_vehicles` ADD `security` int(1) NOT NULL DEFAULT '0' COMMENT 'Alarm system state' AFTER `owner`;

CREATE TABLE `pawnshop_vehicles` (
	`owner` varchar(30) DEFAULT NULL,
	`security` int(1) NOT NULL DEFAULT '0' COMMENT 'Alarm system state',
	`plate` varchar(12) NOT NULL,
	`vehicle` longtext,
	`price` int(15) NOT NULL,
	`expiration` int(15) NOT NULL,

	PRIMARY KEY (`plate`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `items` (name, label, `limit`) VALUES
	('hammerwirecutter', 'Martello e tronchese', 1),
	('unlockingtool', 'Strumenti di furto con scasso', 1),
	('jammer', 'Jammer di segnale', 1),
	('alarminterface', "Interfaccia del sistema di allarme", 1),
	('alarm1', 'Sistema di allarme di base', 1),
	('alarm2', 'Sistema di allarme per connettersi alla centrale', 1),
	('alarm3', 'Sistema di allarme ad alta tecnologia con GPS', 1)
;
