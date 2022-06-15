-- № 1 Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным ------пользователем (написал ему сообщений)

USE vk;
 
SELECT *
FROM messages
    WHERE to_user_id = 1
    GROUP BY from_user_id
    ORDER BY from_user_id DESC 
LIMIT 1;

-- № 2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет

SELECT COUNT(*) as 'Likes' 
FROM `profiles` WHERE (YEAR(NOW())-YEAR(birthday)) < 10;

-- № 3 Определить кто больше поставил лайков (всего): мужчины или женщины

-- вариант простой сортировки по полу

SELECT gender, 
    COUNT(*) as 'Likes' FROM profiles GROUP BY gender;
 
-- вариант сортировки с переименованием значаний в колонке 
 
SELECT 
    CASE(gender)
        WHEN 'm' THEN 'Мужчины'
        WHEN 'f' THEN 'Женщины'
        ELSE 'нет'
    END as gender,
    COUNT(*) as 'Likes:' FROM profiles GROUP BY gender;