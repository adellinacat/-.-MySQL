№ 1 Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
  append_dt DATETIME DEFAULT CURRENT_TIMESTAMP,
  append_tn VARCHAR (255),
  pk_id INT UNSIGNED NOT NULL,
  append_name VARCHAR (255)
  ) ENGINE ARCHIVE;

DROP PROCEDURE IF EXISTS append_logs;

delimiter //

CREATE PROCEDURE append_logs (
  tn VARCHAR (255),
  id INT,
  an VARCHAR (255)
)
BEGIN
	INSERT INTO `logs` (append_tn, pk_id, append_name) VALUES (tn, id, an);
END //

delimiter ;

DROP TRIGGER IF EXISTS log_appending_from_catalogs;

delimiter //

CREATE TRIGGER log_appending_from_catalogs
AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	CALL append_logs('catalogs', NEW.id, NEW.name);
END //

delimiter ;

DROP TRIGGER IF EXISTS log_appending_from_users;

#SELECT * FROM products\G;

#*************************** 1. row ***************************
#         id: 1
#       name: Intel Core i3-8100
#description: Процессор для настольных персональных компьютеров, основанных на платформе Intel.
#      price: 7890.00
# catalog_id: 1
# created_at: 2022-05-18 14:44:41
# updated_at: 2022-05-18 14:44:41
#*************************** 2. row ***************************
#         id: 2
#       name: Intel Core i5-7400
#description: Процессор для настольных персональных компьютеров, основанных на платформе Intel.
#      price: 12700.00
# catalog_id: 1
# created_at: 2022-05-18 14:44:41
# updated_at: 2022-05-18 14:44:41
#*************************** 3. row ***************************
#         id: 3
#       name: AMD FX-8320E
#description: Процессор для настольных персональных компьютеров, основанных на платформе AMD.
#      price: 4780.00
# catalog_id: 1
# created_at: 2022-05-18 14:44:41
# updated_at: 2022-05-18 14:44:41
#********
#ERROR:
#No query specified


INSERT INTO products (name, description, price, catalog_id) VALUES ('Intel Core i5 10400',
  'Процессор Intel Core i5-10400 OEM LGA 1200, 6 x 2.9 ГГц', 13999, 1);
 
 
DESC products;

#+-------------+-----------------+------+-----+-------------------+-----------------------------------------------+
#| Field       | Type            | Null | Key | Default           | Extra                                         |
#+-------------+-----------------+------+-----+-------------------+-----------------------------------------------+
#| id          | bigint unsigned | NO   | PRI | NULL              | auto_increment                                |
#| name        | varchar(255)    | YES  |     | NULL              |                                               |
#| description | text            | YES  |     | NULL              |                                               |
#| price       | decimal(11,2)   | YES  |     | NULL              |                                               |
#| catalog_id  | bigint unsigned | YES  | MUL | NULL              |                                               |
#| created_at  | datetime        | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED                             |
#| updated_at  | datetime        | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |
#+-------------+-----------------+------+-----+-------------------+-----------------------------------------------+
#7 rows in set (0.01 sec)

delimiter //

CREATE TRIGGER log_appending_from_users
AFTER INSERT ON users
FOR EACH ROW
BEGIN
	CALL append_logs('users', NEW.id, NEW.name);
END //

delimiter ;

DROP TRIGGER IF EXISTS log_appending_from_products;

delimiter //

CREATE TRIGGER log_appending_from_products
AFTER INSERT ON products
FOR EACH ROW
BEGIN
	CALL append_logs('products', NEW.id, NEW.name);
END //

delimiter ;




