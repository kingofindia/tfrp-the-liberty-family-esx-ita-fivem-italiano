CREATE TABLE `gruppo_sanguigno` (
  `identifier` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `account` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL
);

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('sangueab+', 'Sangue AB+', 20, 0, 1),
  ('sangueab-', 'Sangue AB-', 20, 0, 1),
  ('sanguea+', 'Sangue A+', 20, 0, 1),
  ('sanguea-', 'Sangue A-', 20, 0, 1),
  ('sangueb+', 'Sangue B+', 20, 0, 1),
  ('sangueb-', 'Sangue B-', 20, 0, 1),
  ('sangue0+', 'Sangue 0+', 20, 0, 1),
  ('sangue0-', 'Sangue 0-', 20, 0, 1)
;