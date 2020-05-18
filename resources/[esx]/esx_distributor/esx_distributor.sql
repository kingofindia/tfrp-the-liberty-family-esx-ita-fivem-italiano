CREATE TABLE `distributor` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  
  PRIMARY KEY (`id`)
);

INSERT INTO `distributor` (name, item, price) VALUES
	('Distributor','pepsi',3),
	('Distributor','icetea',3),
	('Distributor','hotdog',3),
	('Distributor','jusfruit',3),
	('Distributor','limonade',4),
	('Distributor','nugets',3),
	('Distributor','soda',2),
	('Distributor','water',4) -- A vous de mettre d'autres items (le name !!!!!!)
;
