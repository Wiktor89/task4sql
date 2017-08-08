--  Хранимые процедуры  --

--  Функция вычисляет количество пользователей***
CREATE FUNCTION number_users () RETURNS integer AS '
DECLARE
i INTEGER;
BEGIN
SELECT count(*) FROM users into i;
RETURN i;
END;
' LANGUAGE plpgsql;
--  Функция вычисляет количество пользователей

--  Функция вычисляет количество контактов каждого пользователя
CREATE FUNCTION number_contacts (name_user CHAR (100)) RETURNS integer AS '
DECLARE
i INTEGER;
BEGIN
SELECT COUNT(contacts.user_id) FROM contacts JOIN users ON contacts.user_id = users.id GROUP BY contacts.user_id, users.login HAVING users.login=name_user INTO i;
RETURN i;
END;
' LANGUAGE plpgsql;
--  Функция вычисляет количество контактов каждого пользователя

--  Функция вычисляет количество групп каждого пользователя
CREATE FUNCTION quantity_groups_user (name_user CHAR (100)) RETURNS integer AS '
DECLARE
i INTEGER;
BEGIN
SELECT COUNT(DISTINCT groups.title),users.login
  FROM users JOIN contacts ON users.id = contacts.user_id
  JOIN contact_group ON contacts.id = contact_group.contact_id
  JOIN groups ON contact_group.group_id = groups.id
  GROUP BY users.login HAVING users.login = name_user INTO i;
RETURN i;
END;
' LANGUAGE plpgsql;
--  Функция вычисляет количество групп каждого пользователя

--  Функция вычисляет среднее количество контактов в группах***
CREATE FUNCTION average_number_contacts_groups () RETURNS integer AS '
DECLARE
i INTEGER;
contactC INTEGER;
groupC INTEGER;
BEGIN
SELECT COUNT(contact_group.contact_id) FROM contact_group INTO contactC;
SELECT COUNT(groups.id) FROM groups INTO groupC;
i := contactC / groupC;
RETURN i;
END;
' LANGUAGE plpgsql;
--  Функция вычисляет среднее количество контактов в группах

--  Функция вычисляет среднее количество контактов у пользователя***
CREATE FUNCTION average_number_contacts_user () RETURNS integer AS '
DECLARE
contact INTEGER;
  usersC INTEGER;
i INTEGER;
BEGIN
SELECT COUNT(contacts.id) FROM contacts INTO contact;
SELECT COUNT(users.id) FROM users INTO usersC;
i := contact / usersC;
RETURN i;
END;
' LANGUAGE plpgsql;
--  Функция вычисляет среднее количество контактов у пользователя

--  Функция вычисляет пользователя с количеством контактов < 10***
CREATE FUNCTION user_with_contacts_min_10 ()
RETURNS TABLE(user_name CHAR(100)) AS '
BEGIN
RETURN QUERY SELECT users.login FROM contacts JOIN users ON contacts.user_id = users.id
GROUP BY contacts.user_id,users.login HAVING COUNT(contacts.user_id) < 10;
END;
' LANGUAGE plpgsql;
--  Функция вычисляет пользователя с количеством контактов < 10






