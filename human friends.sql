CREATE DATABASE Human_Friends; 

USE mans_friends;

CREATE TABLE animals
(
	Id INT AUTO_INCREMENT PRIMARY KEY,  
	Animal_class VARCHAR(50)
);

INSERT INTO animals (Animal_class)
VALUES ('pets'),
('pack animals');  

CREATE TABLE pets
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Pet_class VARCHAR (50),
    Animal_id INT,
    FOREIGN KEY (Animal_id) REFERENCES animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pets (Pet_class, Animal_id)
VALUES ('Dog', 1),
('Cat', 1),  
('Hamster', 1); 

CREATE TABLE pack_animals
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Pack_animal_class VARCHAR (50),
    Animal_id INT,
    FOREIGN KEY (Animal_id) REFERENCES animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pack_animals (Pack_animal_class, Animal_id)
VALUES ('Horse', 2),
('Camel', 2),  
('Donkey', 2); 
    

CREATE TABLE dogs
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pet_id int,
    Foreign KEY (Pet_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cats
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pet_id int,
    Foreign KEY (Pet_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE hamsters
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pet_id int,
    Foreign KEY (Pet_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE horses
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pack_animal_id int,
    Foreign KEY (Pack_animal_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE camels
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pack_animal_id int,
    Foreign KEY (Pack_animal_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE donkeys
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(50), 
    Birthday DATE,
    Commands VARCHAR(50),
    Pack_animal_id int,
    Foreign KEY (Pack_animal_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO dogs (Name, Birthday, Commands, Pet_id)
VALUES ('Бобик', '2022-10-14', 'Апорт, Лежать, Дай лапу, голос', 1),
('Шарик', '2018-04-11', 'Ко мне, Прыгать', 1),  
('Рекс', '2019-05-15', 'Искать, Голос, Апорт, Нельзя', 1);

INSERT INTO cats (Name, Birthday, Commands, Pet_id)
VALUES ('Мурка', '2016-10-05', 'Мурка', 2),
('Степа', '2021-9-05', "Фу, Степа", 2),  
('Борис', '2019-04-15', NULL, 2); 

INSERT INTO hamsters (Name, Birthday, Commands, Pet_id)
VALUES ('Дин', '2019-02-01', NULL, 3),
('Арчибальдо', '2020-05-03', "Арчибальдо", 3),  
('Херши', '2022-11-01', NULL, 3);

INSERT INTO horses (Name, Birthday, Commands, Pack_animal_id)
VALUES ('Пуля', '2018-11-01', 'Рысь, Хооп, Шагом, Бегом', 1),
('Дуги', '2018-05-19', 'Хоп, Быстрее', 1),  
('Хомчик', '2019-05-12', 'Голоп, Спокойнее', 1); 

INSERT INTO camels (Name, Birthday, Commands, Pack_animal_id)
VALUES ('Шахрай', '2020-02-01', NULL, 2),
('Атейней', '2016-05-02', 'Рокки', 2),  
('Нану', '2014-05-22', 'Нану ко мне', 2);

INSERT INTO donkeys (Name, Birthday, Commands, Pack_animal_id)
VALUES ('Тема', '2017-04-30', NULL, 3),
('Пушок', '2021-05-22', 'Пушок ко мне', 3),  
('Цаца', '2020-01-14', 'шагом, Цаца', 3);

SET SQL_SAFE_UPDATES = 0;
DELETE FROM camels;

SELECT Name, Birthday, Commands FROM horses
UNION ALL SELECT  Name, Birthday, Commands FROM donkeys;

CREATE TEMPORARY TABLE all_animals AS
    SELECT *, 'Собаки' as class FROM dogs
    UNION SELECT *, 'Кошки' AS class FROM cats
    UNION SELECT *, 'Хомяки' AS class FROM hamsters
    UNION SELECT *, 'Лошади' AS class FROM horses
    UNION SELECT *, 'Ослы' AS class FROM donkeys;
    
CREATE TABLE young_animals AS
SELECT Name, Birthday, Commands, class, TIMESTAMPDIFF(MONTH, Birthday, CURDATE()) AS Age_in_month
FROM all_animals WHERE Birthday BETWEEN ADDDATE(curdate(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);


SELECT h.Name, h.Birthday, h.Commands, pa.Pack_animal_class, ya.Age_in_month 
FROM horses h
LEFT JOIN young_animals ya ON ya.Name = h.Name
LEFT JOIN pack_animals pa ON pa.Id = h.Pack_animal_id
UNION 
SELECT d.Name, d.Birthday, d.Commands, pa.Pack_animal_class, ya.Age_in_month 
FROM donkeys d 
LEFT JOIN young_animals ya ON ya.Name = d.Name
LEFT JOIN pack_animals pa ON pa.Id = d.Pack_animal_id
UNION
SELECT c.Name, c.Birthday, c.Commands, p.Pet_class, ya.Age_in_month 
FROM cats c
LEFT JOIN young_animals ya ON ya.Name = c.Name
LEFT JOIN pets p ON p.Id = c.Pet_id
UNION
SELECT d.Name, d.Birthday, d.Commands, p.Pet_class, ya.Age_in_month 
FROM dogs d
LEFT JOIN young_animals ya ON ya.Name = d.Name
LEFT JOIN pets p ON p.Id = d.Pet_id
UNION
SELECT hm.Name, hm.Birthday, hm.Commands, p.Pet_class, ya.Age_in_month 
FROM hamsters hm
LEFT JOIN young_animals ya ON ya.Name = hm.Name
LEFT JOIN pets p ON p.Id = hm.Pet_id;
