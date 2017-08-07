-- DROP TABLE groups CASCADE ;
-- DROP TABLE contacts CASCADE ;
-- DROP TABLE users CASCADE ;
-- DROP TABLE contact_group CASCADE;

CREATE TABLE IF NOT EXISTS public.groups
(
  id SERIAL PRIMARY KEY NOT NULL,
  title CHAR(100) NOT NULL
);
CREATE UNIQUE INDEX groups_title_uindex ON public.groups (title);
CREATE UNIQUE INDEX groups_id_uindex ON public.groups (id);
COMMENT ON TABLE public.groups IS 'таблица групп';

INSERT  INTO groups (title) VALUES
  ('a'),
  ('b'),
  ('c');

CREATE TABLE IF NOT EXISTS public.users
(
  id SERIAL PRIMARY KEY NOT NULL,
  login CHAR(100) NOT NULL,
  password CHAR(100) NOT NULL
);
CREATE UNIQUE INDEX users_login_uindex ON public.users (login);
COMMENT ON TABLE public.users IS 'таблица пользователей';

INSERT  INTO users (login, password) VALUES
  ('Филип','root'),
  ('Николай','root'),
  ('Жанна','root');

CREATE TABLE IF NOT EXISTS public.contacts(
  id SERIAL  NOT NULL CONSTRAINT pk_contacts PRIMARY KEY,
  fio CHAR(255) NOT NULL ,
  phone CHAR(100),
  email CHAR(100),
  user_id INTEGER NOT NULL ,
  CONSTRAINT fk_contact FOREIGN KEY (user_id)
  REFERENCES public.users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

COPY public.contacts(id,fio,phone,email,user_id)
FROM 'D:\sql\contacts.csv' WITH DELIMITER ',' CSV;

CREATE TABLE IF NOT EXISTS public.contact_group
(
  contact_id INT NOT NULL,
  group_id INT NOT NULL,
  CONSTRAINT contact_group_contact_id_fk FOREIGN KEY (contact_id) REFERENCES contacts (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT contact_group_group_id_fk FOREIGN KEY (group_id) REFERENCES groups (id) ON DELETE CASCADE ON UPDATE CASCADE
);

COPY public.contact_group(contact_id, group_id)
FROM 'D:\sql\contacts_groups.csv' WITH DELIMITER ',' CSV;