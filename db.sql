CREATE TABLE "user" (
	"Id" serial NOT NULL,
	"login" VARCHAR(255) NOT NULL,
	"password" VARCHAR(255) NOT NULL,
	"userRoleId" integer NOT NULL,
	CONSTRAINT user_pk PRIMARY KEY ("Id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "userRole" (
	"Id" serial NOT NULL,
	"name" serial(255) NOT NULL,
	CONSTRAINT userRole_pk PRIMARY KEY ("Id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "question" (
	"Id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	"multiAnswer" BOOLEAN NOT NULL DEFAULT 'false',
	"userRoleId" integer NOT NULL DEFAULT 'false',
	CONSTRAINT question_pk PRIMARY KEY ("Id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "answer" (
	"Id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	"questionId" integer NOT NULL,
	"userRoleId" integer NOT NULL,
	CONSTRAINT answer_pk PRIMARY KEY ("Id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "answerUser" (
	"userId" integer NOT NULL,
	"answerId" integer NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "token" (
	"Id" serial NOT NULL,
	"userId" integer NOT NULL,
	"token" VARCHAR(255) NOT NULL,
	CONSTRAINT token_pk PRIMARY KEY ("Id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "user" ADD CONSTRAINT "user_fk0" FOREIGN KEY ("userRoleId") REFERENCES "userRole"("Id");


ALTER TABLE "question" ADD CONSTRAINT "question_fk0" FOREIGN KEY ("userRoleId") REFERENCES "userRole"("Id");

ALTER TABLE "answer" ADD CONSTRAINT "answer_fk0" FOREIGN KEY ("questionId") REFERENCES "question"("Id");
ALTER TABLE "answer" ADD CONSTRAINT "answer_fk1" FOREIGN KEY ("userRoleId") REFERENCES "userRole"("Id");

ALTER TABLE "answerUser" ADD CONSTRAINT "answerUser_fk0" FOREIGN KEY ("userId") REFERENCES "user"("Id");
ALTER TABLE "answerUser" ADD CONSTRAINT "answerUser_fk1" FOREIGN KEY ("answerId") REFERENCES "answer"("Id");

ALTER TABLE "token" ADD CONSTRAINT "token_fk0" FOREIGN KEY ("userId") REFERENCES "user"("Id");

ALTER TABLE "user" ADD UNIQUE (login);
