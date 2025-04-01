-- db, 스키마 만들기
DROP DATABASE IF EXISTS test_db;
CREATE DATABASE test_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 이 db 사용한다고 특정해야 함
USE test_db;

-- 테이블 생성
CREATE TABLE users (
	user_id CHAR(10) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    age INT,
    join_date DATE
);

CREATE TABLE orders (
	order_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id CHAR(10),
    prod_name VARCHAR(20),
    price INT NOT NULL,
    amount SMALLINT NOT NULL,
    CONSTRAINT user_fk -- 제약명
    FOREIGN KEY (user_id) -- 외래키를 지정할 칼럼명
	REFERENCES users(user_id) -- users 테이블의 user_id 참조
    ON DELETE CASCADE -- 삭제할때 같이 삭제됨
    ON UPDATE CASCADE 
);


-- 테이블 수정 ALTER
ALTER TABLE users ADD nickname VARCHAR(45);
ALTER TABLE users MODIFY nickname CHAR(45);
ALTER TABLE users RENAME COLUMN nickname TO nickname2;
ALTER TABLE users CHANGE nickname2 nickname CHAR(45);
ALTER TABLE users DROP nickname;

DESC users;

-- 지우기 DROP
ALTER TABLE orders DROP CONSTRAINT user_fk; -- 외부키 제약 지우기
DROP TABLE orders;
DROP TABLE users;
DROP DATABASE test_db;