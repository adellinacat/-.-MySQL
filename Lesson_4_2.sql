--  Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

SELECT DISTINCT firstname
FROM users
;

-- Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)

ALTER TABLE profiles ADD is_active BIT DEFAULT false NULL;

UPDATE `profiles`
SET is_active = 1
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 3) < RIGHT(birthday, 3)) < 18
;

-- Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
-- Если нет сообщений с датой из будущего, можно поменять дату в сообщении с id 10 более позднюю дату, например на год позже сегодняшней

UPDATE messages
	SET created_at='2023-05-15 17:06:29'
	WHERE id = 10;

-- Удалим сообщение из будущего

DELETE FROM messages
WHERE created_at > now()
;