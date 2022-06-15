-- №1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине
-- создадим и заполним таблицу заказов (orders)


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

INSERT INTO orders VALUES
  (DEFAULT, 1, DEFAULT, DEFAULT),
  (DEFAULT, 1, DEFAULT, DEFAULT),
  (DEFAULT, 2, DEFAULT, DEFAULT);
  
  -- список покупателей
  
  SELECT u.name
FROM users AS u
INNER JOIN orders AS o ON (o.user_id = u.id)
GROUP BY u.name
HAVING COUNT(o.id) > 0;

-- №2 Выведите список товаров products и разделов catalogs, который соответствует товару

SELECT p.name, c.name 
    FROM products 
    AS p JOIN catalogs 
    AS c ON (p.catalog_id = c.id) 
GROUP BY p.id;

-- №3  Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов

-- создадим и заполним таблицы полетов (flights) и городов(cities)

DROP TABLE IF EXISTS flights;
CREATE TABLE IF NOT EXISTS flights(
 	id SERIAL PRIMARY KEY,
 	`from` VARCHAR(50) NOT NULL COMMENT 'en', 
 	`to` VARCHAR(50) NOT NULL COMMENT 'en'
 );

DROP TABLE IF EXISTS cities;
CREATE TABLE  IF NOT EXISTS cities(
 	label VARCHAR(50) PRIMARY KEY COMMENT 'en', 
 	name VARCHAR(50) COMMENT 'ru'
 );
 
 INSERT INTO flights VALUES
 	(DEFAULT, 'Moscow', 'Saint Petersburg'),
    (DEFAULT, 'Saint Petersburg', 'Minsk'),
 	(DEFAULT, 'Minsk', 'Tomsk'),
 	(DEFAULT, 'Tomsk', 'Novosibirsk'),
 	(DEFAULT, 'Novosibirsk', 'Moscow');
    
 INSERT INTO cities VALUES
 	('Moscow', 'Москва'),
 	('Saint Petersburg', 'Санкт-Петербург'),
 	('Minsk', 'Минск'),
 	('Tomsk', 'Томск'),
 	('Novosibirsk', 'Новосибирск');

 
SELECT
	id AS flight_id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM flights
ORDER BY flight_id;
    


