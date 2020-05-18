CREATE TABLE `chimico` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  
  PRIMARY KEY (`id`)
);

INSERT INTO `chimico` (name, item, price) VALUES
	('chimico','water',20),
	('chimico','fertilizzante',30),
	('chimico','cannabis',60),
	('chimico','radicedimungere',10),
	('chimico','fogliecentella',10),
	('chimico','glucomannano',15),
	('chimico','tiroxina',25),
	('chimico','fioridiverbena',20),
	('chimico','bromobiatomico',20)
;
