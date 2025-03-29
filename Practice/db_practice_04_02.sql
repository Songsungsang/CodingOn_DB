create database university_db character set utf8mb4 COLLATE utf8mb4_unicode_ci;
USE university_db;

drop table students;
drop table professors;

create table students(
	student_id int primary key auto_increment,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    major VARCHAR(30),
    advisor_id int,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- foreign key 설정
alter table students
add constraint professor_fk
foreign key (advisor_id) references professors(professor_id)
ON delete set NULL;

describe students;

create table professors(
	professor_id int primary key auto_increment,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department VARCHAR(30),
    mentee_id int,
    joined_at DATE
);

alter table professors
add constraint student_fk
foreign key (mentee_id) references students(student_id)
ON delete set NULL;

describe professors;

use my_shop;
alter table professors drop foreign key student_fk;
alter table students drop foreign key professor_fk;
drop table professors;
drop table students;