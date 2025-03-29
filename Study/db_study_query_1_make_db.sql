-- 주석작성
-- 1. CREATE
CREATE DATABASE test_db;
DROP DATABASE test_db;

-- 인코딩 지정, 정렬 규칙 지정
CREATE DATABASE test_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
SHOW DATABASES;

-- DB, 스키마 지정
use test_db;

-- 테이블 생성
CREATE TABLE user(
	user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(10) NOT NULL,
    adress VARCHAR(45),
    join_date DATE
);

SHOW TABLES;
-- 테이블 구조 설명
DESCRIBE user;