-- 혹시라도 이전에 존재하는 DB 날림
DROP DATABASE IF EXISTS my_shop;

CREATE DATABASE my_shop DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE my_shop;

-- customer 테이블 생성
CREATE TABLE customer(
	cust_id CHAR(10) NOT NULL PRIMARY KEY,
    cust_name VARCHAR(10) NOT NULL,
    address CHAR(10) NOT NULL,
    phone CHAR(11),
    birth DATE
);

-- orders 테이블 생성
CREATE TABLE orders(
	order_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cust_id CHAR(10) NOT NULL,
    prod_name CHAR(6) NOT NULL,
    price INT NOT NULL,
    amount SMALLINT NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

SHOW TABLES;
DESC customer;
DESC orders;

ALTER TABLE orders ADD CONSTRAINT fk_customer
FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE oders DROP FOREIGN KEY fk_customer;

DESC orders;

ALTER TABLE orders
DROP INDEX cust_id;

