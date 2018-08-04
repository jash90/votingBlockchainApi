CREATE USER admin WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'admin';

CREATE DATABASE "votingOnlineDb"
    WITH 
    OWNER = admin
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;
		
CREATE TABLE "answer" (
	"Id" serial NOT NULL,
	"name" VARCHAR(50) NOT NULL,
	"questionId" integer NOT NULL,
	"userRole" integer NOT NULL DEFAULT '0',
	CONSTRAINT answer_pk PRIMARY KEY ("Id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "user" (
	"Id" serial NOT NULL,
	"login" VARCHAR(50) NOT NULL UNIQUE,
	"password" VARCHAR(64) NOT NULL,
	"userRoleId" integer NOT NULL DEFAULT '3',
	CONSTRAINT user_pk PRIMARY KEY ("Id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "userRole" (
	"Id" serial NOT NULL,
	"name" VARCHAR(50) NOT NULL,
	"login" BOOLEAN NOT NULL DEFAULT 'true',
	"register" BOOLEAN NOT NULL DEFAULT 'true',
	CONSTRAINT userRole_pk PRIMARY KEY ("Id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "question" (
	"Id" serial NOT NULL,
	"name" VARCHAR(100) NOT NULL,
	"multiAnswer" BOOLEAN NOT NULL DEFAULT 'false',
	"userRoleId" integer NOT NULL DEFAULT '0',
	"publicated" BOOLEAN NOT NULL DEFAULT 'false',
	CONSTRAINT question_pk PRIMARY KEY ("Id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "answerUser" (
	"answerId" integer NOT NULL,
	"userId" integer NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "token" (
	"Id" serial NOT NULL,
	"userId" integer NOT NULL UNIQUE,
	"token" VARCHAR(64) NOT NULL UNIQUE,
	CONSTRAINT token_pk PRIMARY KEY ("Id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "answer" ADD CONSTRAINT "answer_fk0" FOREIGN KEY ("questionId") REFERENCES "answer"("Id");
ALTER TABLE "answer" ADD CONSTRAINT "answer_fk1" FOREIGN KEY ("userRole") REFERENCES "userRole"("Id");

ALTER TABLE "user" ADD CONSTRAINT "user_fk0" FOREIGN KEY ("userRoleId") REFERENCES "userRole"("Id");


ALTER TABLE "question" ADD CONSTRAINT "question_fk0" FOREIGN KEY ("userRoleId") REFERENCES "userRole"("Id");

ALTER TABLE "answerUser" ADD CONSTRAINT "answerUser_fk0" FOREIGN KEY ("answerId") REFERENCES "answer"("Id");
ALTER TABLE "answerUser" ADD CONSTRAINT "answerUser_fk1" FOREIGN KEY ("userId") REFERENCES "user"("Id");

ALTER TABLE "token" ADD CONSTRAINT "token_fk0" FOREIGN KEY ("userId") REFERENCES "user"("Id");


-- Create userRole

INSERT INTO public."userRole"(name)
	VALUES ('admin');

INSERT INTO public."userRole"(name)
	VALUES ('teacher');

INSERT INTO public."userRole"(name)
	VALUES ('student');

-- Insert admin

INSERT INTO public."user"("Id", login, password, "userRoleId")
	VALUES (1,"admin","e6e8601e3d2c975cb9347de7ad12da9af3a645570d398057a1d01999d29b1a35",3);
