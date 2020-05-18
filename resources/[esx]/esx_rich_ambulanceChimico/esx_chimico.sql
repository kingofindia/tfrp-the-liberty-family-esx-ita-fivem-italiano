CREATE TABLE `ambulancechimico` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  
  PRIMARY KEY (`id`)
);

INSERT INTO `ambulancechimico` (name, item, price) VALUES
	('chimico','pomata',80),
	('chimico','antibiotico',50),
	('chimico','sciroppo',50),
;
