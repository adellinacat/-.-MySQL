/*
№ 1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
*/

[mysql]
user=inna
password=*********


/*
№ 2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
*/
CREATE DATABASE example;
USE example;
CREATE TABLE users (id INT, name TEXT);
DESCRIBE users;
/*
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| id    | int  | YES  |     | NULL    |       |
| name  | text | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
2 rows in set (0.00 sec)
*/

/*
№ 3 Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
*/

CREATE DATABASE sample;
\q;

/* на Windows "дампить" нужно в консоли под администратором  */
C:\Windows\system32>C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe -u root -p example > example.sql
Enter password: *********

/* Снова из Windows разворачиваем содержимое дампа в базу sample  */
C:\Windows\system32>cd C:\Program Files\MySQL\MySQL Server 8.0\bin\
C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql -u root -p sample < example.sql
Enter password: *********

mysql> USE sample;

mysql> SHOW tables;
/*
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+
1 row in set (0.00 sec)
*/
DESCRIBE users;
/*
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| id    | int  | YES  |     | NULL    |       |
| name  | text | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
2 rows in set (0.00 sec)
*/

/* № 4 (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
*/
C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u root -p --opt --where="1 limit 100" mysql help_keyword > first_100_rows_help_keyword.sql
Enter password: *********


