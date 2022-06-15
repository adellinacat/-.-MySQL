-- С помощью JOIN запросов


-- № 1 Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным ------пользователем (написал ему сообщений)

USE vk;
 
SELECT firstname, lastname, from_user_id, to_user_id, body
FROM users AS u
JOIN messages AS m ON u.id = m.from_user_id
    WHERE m.to_user_id = 1\G
    GROUP BY m.from_user_id
    ORDER BY from_user_id DESC
LIMIT 1;

-- № 2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет

SELECT firstname, firstname, COUNT(*) AS 'Likes' 
FROM users AS u
JOIN `profiles` AS l ON u.id = l.user_id 
    WHERE (YEAR(NOW())-YEAR(birthday)) < 10
    GROUP BY l.user_id;



-- № 3 Определить кто больше поставил лайков (всего): мужчины или женщины

    
SELECT gender, 
    COUNT(*) AS 'Likes' FROM `profiles` 
JOIN users AS u ON u.id = user_id
GROUP BY gender;    