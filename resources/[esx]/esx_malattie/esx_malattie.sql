INSERT INTO `items` (name, label) VALUES
  ('sciroppo','Sciroppo per la tosse'),
  ('antibiotico','Antibiotico'),
;

ALTER TABLE `users` ADD `malato` varchar(255) COLLATE utf8mb4_bin DEFAULT 'no';
ALTER TABLE `users` ADD `malatostomaco` varchar(255) COLLATE utf8mb4_bin DEFAULT 'no';
