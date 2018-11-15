CREATE USER admin WITH LOGIN SUPERUSER CREATEDB CREATEROLE INHERIT NOREPLICATION CONNECTION
LIMIT - 1 PASSWORD 'psB2r#e4';

CREATE DATABASE "votingOnlineDb" WITH OWNER = admin ENCODING = 'UTF8' CONNECTION
LIMIT = - 1;

CREATE TABLE "answer" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "date" TIMESTAMP NOT NULL DEFAULT NOW(),
    "questionId" INTEGER NOT NULL,
    "userRoleId" INTEGER NOT NULL DEFAULT 3,
    CONSTRAINT answer_pk PRIMARY KEY ("id"))
WITH (OIDS = FALSE);

CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "login" VARCHAR(50) NOT NULL UNIQUE,
    "password" VARCHAR(64) NOT NULL,
    "email" VARCHAR(100) UNIQUE NOT NULL,
    "firstname" VARCHAR(100) NOT NULL,
    "lastname" VARCHAR(100) NOT NULL,
    "userRoleId" INTEGER NOT NULL DEFAULT 3,
    "requestId" INTEGER NULL DEFAULT NULL,
    CONSTRAINT user_pk PRIMARY KEY ("id"))
WITH (OIDS = FALSE);

CREATE TABLE "userRole" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "login" BOOLEAN NOT NULL DEFAULT TRUE,
    "register" BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT userRole_pk PRIMARY KEY ("id"))
WITH (OIDS = FALSE);

CREATE TABLE "question" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "multiAnswer" BOOLEAN NOT NULL DEFAULT FALSE,
    "userRoleId" INTEGER NOT NULL DEFAULT 3,
    "createdById" INTEGER NOT NULL DEFAULT 2,
    "publicated" BOOLEAN NOT NULL DEFAULT FALSE,
    "publicatedDate" TIMESTAMP NULL DEFAULT NOW(),
    "publicatedDateEnd" TIMESTAMP NULL,
    CONSTRAINT question_pk PRIMARY KEY ("id"))
WITH (OIDS = FALSE);

CREATE TABLE "answerUser" (
    "answerId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "date" TIMESTAMP NOT NULL DEFAULT NOW())
WITH (OIDS = FALSE);

CREATE TABLE "token" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL UNIQUE,
    "token" VARCHAR(64) NOT NULL UNIQUE,
    CONSTRAINT token_pk PRIMARY KEY ("id"))
WITH (OIDS = FALSE);

ALTER TABLE "answer"
    ADD CONSTRAINT "answer_fk0" FOREIGN KEY ("questionId") REFERENCES "answer" ("id");

ALTER TABLE "answer"
    ADD CONSTRAINT "answer_fk1" FOREIGN KEY ("userRoleId") REFERENCES "userRole" ("id");

ALTER TABLE "user"
    ADD CONSTRAINT "user_fk0" FOREIGN KEY ("userRoleId") REFERENCES "userRole" ("id");

ALTER TABLE "question"
    ADD CONSTRAINT "question_fk0" FOREIGN KEY ("userRoleId") REFERENCES "userRole" ("id");

ALTER TABLE "question"
    ADD CONSTRAINT "question_fk1" FOREIGN KEY ("createdById") REFERENCES "user" ("id");

ALTER TABLE "answerUser"
    ADD CONSTRAINT "answerUser_fk0" FOREIGN KEY ("answerId") REFERENCES "answer" ("id");

ALTER TABLE "answerUser"
    ADD CONSTRAINT "answerUser_fk1" FOREIGN KEY ("userId") REFERENCES "user" ("id");

ALTER TABLE "token"
    ADD CONSTRAINT "token_fk0" FOREIGN KEY ("userId") REFERENCES "user" ("id");

-- Insert userRole
INSERT INTO public. "userRole" ("name")
    VALUES ('admin');

INSERT INTO public. "userRole" ("name")
    VALUES ('teacher');

INSERT INTO public. "userRole" ("name")
    VALUES ('student');

INSERT INTO public. "userRole" ("id", "name", "login", "register")
    VALUES (4, 'request', FALSE, TRUE);

-- Insert users
INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (1, 'admin', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 1, 'bartekziimny90@gmail.com', 'Bartłomiej', 'Zimny');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (2, 'mod', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 2, 'mod@gmail.com', '', '');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (3, 'user', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'user@gmail.com', '', '');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (4, 'user1', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'user1@gmail.com', '', '');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (5, 'user2', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'user2@gmail.com', '', '');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (6, 'user3', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'user3@gmail.com', '', '');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (7, 'user4', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'user4@gmail.com', '', '');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (8, 'user5', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'user5@gmail.com', '', '');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (9, 'user6', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'user6@gmail.com', '', '');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (10, 'user7', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'user7@gmail.com', '', '');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (11, 'user8', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'user8@gmail.com', '', '');

INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (12, 'user9', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'user9@gmail.com', '', '');

-- Insert question
INSERT INTO public.question ("id", "name", "createdById", "publicated", "publicatedDateEnd")
    VALUES (1, 'Czy lubisz koty ?', 2, TRUE, CURRENT_TIMESTAMP + interval '76 hours');

INSERT INTO public.question ("id", "name", "createdById")
    VALUES (2, 'Czy lubisz psy ?', 2);

INSERT INTO public.question ("id", "name", "createdById")
    VALUES (3, 'Czy lubisz słodycze ?', 2);

-- Insert answer
INSERT INTO public.answer (id, name, "questionId")
    VALUES (1, 'Tak', 1);

INSERT INTO public.answer (id, name, "questionId")
    VALUES (2, 'Nie', 1);

INSERT INTO public.answer (id, name, "questionId")
    VALUES (3, 'Nie wiem', 1);

INSERT INTO public.answer (id, name, "questionId")
    VALUES (4, 'Tak', 2);

INSERT INTO public.answer (id, name, "questionId")
    VALUES (5, 'Nie', 2);

INSERT INTO public.answer (id, name, "questionId")
    VALUES (6, 'Nie wiem', 2);

INSERT INTO public.answer (id, name, "questionId")
    VALUES (7, 'Tak', 3);

INSERT INTO public.answer (id, name, "questionId")
    VALUES (8, 'Nie', 3);

INSERT INTO public.answer (id, name, "questionId")
    VALUES (9, 'Nie wiem', 3);

-- Insert answerUser
INSERT INTO public. "answerUser" ("answerId", "userId")
    VALUES (1, 3);

INSERT INTO public. "answerUser" ("answerId", "userId")
    VALUES (2, 4);

INSERT INTO public. "answerUser" ("answerId", "userId")
    VALUES (1, 5);

INSERT INTO public. "answerUser" ("answerId", "userId")
    VALUES (3, 6);

INSERT INTO public. "answerUser" ("answerId", "userId")
    VALUES (2, 7);

INSERT INTO public. "answerUser" ("answerId", "userId")
    VALUES (2, 8);

INSERT INTO public. "answerUser" ("answerId", "userId")
    VALUES (1, 9);

INSERT INTO public. "answerUser" ("answerId", "userId")
    VALUES (1, 10);

INSERT INTO public. "answerUser" ("answerId", "userId")
    VALUES (3, 11);

INSERT INTO public. "answerUser" ("answerId", "userId")
    VALUES (1, 12);
