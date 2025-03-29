USE my_shop;

DESC customer;

-- INSERT
INSERT INTO customer (cust_id, cust_name, address, phone, birth)
VALUES ("C001", "김민수", "서울시", "01012345678", "2000-01-01");

-- 값을 처음부터 넣음 = column 명시 안해도 됨
INSERT INTO customer
VALUES ("C002", "이영희", "부산시", "01012341234", "2001-01-01");

-- INSERT 구문하나 쓰고 값들 쭉쭉
INSERT INTO customer VALUES
("C003", "박철수", "대전시", "01012345678", "1999-01-01"),
("C004", "정유진", "광주시", "01012341234", "2002-01-01");

SELECT * FROM customer;

DESC orders;
INSERT INTO orders VALUES
(NULL, "C003", "김치찌개", 10000, 15), -- C003의 이 부분은 foreign key를 받아와야 하므로 있어야 하는 값이다
(NULL, "C004", "마라탕", 30000, 15);

SELECT * FROM orders;