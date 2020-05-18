SET @job_name = 'vanilla';
SET @society_name = 'society_vanilla';
SET @job_Name_Caps = 'Vanilla';

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'barman', 'Barista', 300, '{}', '{}'),
  (@job_name, 1, 'stripper', 'Stripper', 300, '{}', '{}'),
  (@job_name, 2, 'dancer', 'Sicurezza', 300, '{}', '{}'),
  (@job_name, 3, 'viceboss', 'Capo Sicurezza', 500, '{}', '{}'),
  (@job_name, 4, 'boss', 'Direttore', 600, '{}', '{}')
;
