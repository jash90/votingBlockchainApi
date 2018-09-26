CREATE USER admin WITH LOGIN SUPERUSER CREATEDB CREATEROLE INHERIT NOREPLICATION CONNECTION
LIMIT - 1 PASSWORD 'admin';

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

-- Create userRole
INSERT INTO public. "userRole" ("name")
    VALUES ('admin');

INSERT INTO public. "userRole" ("name")
    VALUES ('teacher');

INSERT INTO public. "userRole" ("name")
    VALUES ('student');

INSERT INTO public. "userRole" ("id", "name", "login", "register")
    VALUES (4, 'request', FALSE, TRUE);

-- Insert admin
INSERT INTO public. "user" ("id", "login", "password", "userRoleId", email, firstname, lastname)
    VALUES (1, 'admin', 'e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35', 3, 'bartekziimny90@gmail.com', 'Bartłomiej', 'Zimny');

