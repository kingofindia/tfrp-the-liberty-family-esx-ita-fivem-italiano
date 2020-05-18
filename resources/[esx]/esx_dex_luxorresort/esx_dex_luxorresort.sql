USE `essentialmode` ;

INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_nibba','nibba',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_nibba','Luxor Resort',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_nibba', 'Luxor Resort', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('nibba', 'Luxor Resort', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('nibba', 0, 'soldato', 'BarMan', 0, '{}', '{}'),
	('nibba', 1, 'killer', 'Security', 0, '{}', '{}'),
	('nibba', 2, 'lamadredelkiller', 'Lady', 0, '{}', '{}'),
	('nibba', 3, 'ilpadredelkiller', 'Braccio Destro', 0, '{}', '{}'),
	('nibba', 4, 'boss', 'Boss ', 0, '{}', '{}')
;
