-- №1 В базе данных shop и sample присутвуют одни и те же таблицы учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
USE sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	birthday_at DATE DEFAULT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



-- SELECT * FROM users;

START TRANSACTION;

INSERT INTO sample.users 
SELECT * 
FROM shop.users
    WHERE id = 1;
    
COMMIT;

-- SELECT * FROM users;


-- №2 Создайте представление, которое выводит название (name) товарной позиции из
-- таблицы products и соответствующее название (name) каталога из таблицы catalogs

USE shop;

CREATE OR REPLACE VIEW prods_desc(prod_id, prod_name, cat_name) AS
SELECT p.id AS prod_id, p.name, cat.name
FROM products AS p
LEFT JOIN catalogs AS cat ON p.catalog_id = cat.id;

SELECT * FROM prods_desc;

-- № 3 (по желанию) Пусть имеется таблица с календарным полем created_at.
-- В ней размещены разряженые календарные записи за август 2018 года:
-- '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17
-- Составьте запрос, который выводит полный список дат за август,
-- выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0,
-- если она отсутствует


USE shop;

DROP TABLE IF EXISTS `datetable`;
CREATE TABLE `datetable` (
	created_at DATE
);

INSERT INTO `datetable` VALUES
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-08-17');

SELECT * 
FROM `datetable` 
ORDER BY created_at;

SELECT 
	time_period.selected_date AS day,
	(SELECT EXISTS(SELECT * FROM `datetable`
                   WHERE created_at = day)) 
                   AS has_already
FROM
	(SELECT v.* FROM 
		(SELECT ADDDATE('1970-01-01', t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) selected_date FROM
			(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
		    (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
		    (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
		    (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
		    (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v
	WHERE selected_date BETWEEN '2018-08-01' AND '2018-08-31') 
    AS time_period
    ORDER BY day;

-- № 4 (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей


DROP TABLE IF EXIST `datetable`;
CREATE TABLE `datetable` (
     created_at DATE);
     
INSERT INTO `datetable` VALUES
     ('2022-01-01'),
     ('2022-01-10'),
     ('2022-01-31'),
     ('2022-02-01'),
     ('2022-02-02'),
     ('2022-02-03'),
     ('2022-03-08'),
     ('2022-03-09');  
     
SELECT * 
FROM `datetable` 
ORDER BY created_at DESC;

DELETE FROM `datetable`
WHERE created_at NOT IN (
	SELECT *
	FROM (
		SELECT *
		FROM `datetable`
		ORDER BY created_at DESC
		LIMIT 5
	) AS foo
) ORDER BY created_at DESC;

SELECT * 
FROM `datetable` 
ORDER BY created_at DESC;

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- № 1 Создайте хранимую функцию hello(), которая будет возвращать приветствие,
-- в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи"

DROP PROCEDURE IF EXISTS hello;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	IF(CURTIME() BETWEEN '06:00:00' AND '12:00:00') THEN
		SELECT 'Доброе утро';
	ELSEIF(CURTIME() BETWEEN '12:00:00' AND '18:00:00') THEN
		SELECT 'Добрый день';
	ELSEIF(CURTIME() BETWEEN '18:00:00' AND '00:00:00') THEN
		SELECT 'Добрый вечер';
	ELSE
		SELECT 'Доброй ночи';
	END IF;
END //
delimiter ;

CALL hello();


     
     
     
     
     
     
     