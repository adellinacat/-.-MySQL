-- № 1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем


UPDATE users
    SET created_at = NOW();
    
UPDATE users
	SET updated_at = NOW();

-- № 2 Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

-- сначала приводим тип столбцов в соотвествии с требованием задачи.

ALTER TABLE users 
    CHANGE COLUMN `created_at` `created_at` VARCHAR(256) NULL,
    CHANGE COLUMN `updated_at` `updated_at` VARCHAR(256) NULL;
    
DESCRIBE users;

-- преобразуем поля к типу DATETIME

ALTER TABLE users 
	CHANGE COLUMN `created_at` `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHANGE COLUMN `updated_at` `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
    
DESCRIBE users;    

-- №3 В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и ---- выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения --- значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

-- сначала наполнение таблицы

INSERT INTO storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 100),
    (1, 2, 0),
    (1, 3, 200),
    (1, 5, 56),
    (1, 4, 115),
    (1, 6, 0);
    
SELECT value FROM storehouses_products ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;

-- № 4 (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT name, birthday_at, 
    CASE 
        WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'may'
        WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'august'
    END AS mounth
FROM
    users WHERE DATE_FORMAT(birthday_at, '%m') = 05 OR DATE_FORMAT(birthday_at, '%m') = 08;

SELECT
    name, birthday_at, DATE_FORMAT(birthday_at, '%m') as mounth_of_birth
FROM
    users;
    
    
-- Практическое задание теме “Агрегация данных”
    
-- № 1 Подсчитайте средний возраст пользователей в таблице users
    
        
SELECT AVG(
    (YEAR(CURRENT_DATE) - YEAR(birthday_at)) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday_at, '%m%d')) 
          )
 FROM users;
 
 -- № 2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения
 
SELECT weekday(DATE_FORMAT(birthday_at, '2022-%m-%d')) AS 'day_number',
    COUNT(*) AS 'birthdays_amount'
FROM users
    GROUP BY weekday(DATE_FORMAT(birthday_at, '2022-%m-%d'))
    ORDER BY day_number;
    
-- № 3 (по желанию) Подсчитайте произведение чисел в столбце таблицы

SELECT exp(SUM(log(value))) products 
FROM (
    VALUES(2),(3),(4),(5)
    ) X(value);
