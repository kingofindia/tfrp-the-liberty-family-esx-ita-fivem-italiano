USE `essentialmode`;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('aircraft', 'Aircraft License')
;

CREATE TABLE `aircraft_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `aircraft_categories` (name, label) VALUES
	('plane','Planes'),
	('heli','Helicopters')
;

CREATE TABLE `aircrafts` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,
	PRIMARY KEY (`model`)
);

INSERT INTO `aircrafts` (name, model, price, category) VALUES
	('Alpha Z1', 'alphaz1', 16121000, 'plane'),
	('Besra', 'besra', 15000000, 'plane'),
	('Cuban 800', 'cuban800', 12240000, 'plane'),
	('Dodo', 'dodo', 10500000, 'plane'),
	('Duster', 'duster', 10175000, 'plane'),
	('Howard NX25', 'howard', 12975000, 'plane'),
	('Luxor', 'luxor', 11500000, 'plane'),
	('Luxor Deluxe ', 'luxor2', 14750000, 'plane'),
	('Mallard', 'stunt', 10250000, 'plane'),
	('Mammatus', 'mammatus', 10300000, 'plane'),
	('Nimbus', 'nimbus', 10900000, 'plane'),
	('Rogue', 'rogue', 101000000, 'plane'),
	('Sea Breeze', 'seabreeze', 10850000, 'plane'),
	('Shamal', 'shamal', 10150000, 'plane'),
	('Ultra Light', 'microlight', 8350000, 'plane'),
	('Velum', 'velum2', 9450000, 'plane'),
	('Vestra', 'vestra', 9950000, 'plane'),
	('Buzzard', 'buzzard2', 10500000, 'heli'),
	('Frogger', 'frogger', 12800000, 'heli'),
	('Havok', 'havok', 13250000, 'heli'),
	('Maverick', 'maverick', 12750000, 'heli'),
	('Sea Sparrow', 'seasparrow', 12815000, 'heli'),
	('SuperVolito', 'supervolito', 10000000, 'heli'),
	('SuperVolito Carbon', 'supervolito2', 14250000, 'heli'),
	('Swift', 'swift', 12000000, 'heli'),
	('Swift Deluxe', 'swift2', 13250000, 'heli'),
	('Volatus', 'volatus', 12250000, 'heli')
;
