USE codingon_store_db;

-- View
CREATE VIEW v_customers_2 AS
SELECT customer_id, name FROM customers; -- view에 담아줄, 추상화할 SELECT문

SELECT * FROM v_customers_2; -- 이렇게 사용가능

-- 테이블 생성 혹은 덮어씌우기/대체
CREATE OR REPLACE VIEW v_customer_orders AS
SELECT c.name 이름, o.order_id 주문아이디, o.order_date 주문일
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

SELECT * FROM v_customer_orders;

-- view를 수정
ALTER VIEW v_customer_orders AS 
SELECT c.name 이름, o.order_id "주문 아이디", o.order_date "주문 일"
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- SELECT시 유의 사항 
SELECT `주문 아이디` FROM v_customer_orders; -- 띄어쓰기 쓰려면 백틱으로 감싸주세요

-- view로 데이터 입력
CREATE OR REPLACE VIEW v_customers AS
SELECT customer_id, name FROM customers;
WHERE customer_id < 20
WITH CHECK OPTION;

-- v_customers로 데이터 업데이트 시도
UPDATE v_customers
SET NAME = "홍길남"
WHERE customer_id = 1;

SELECT * FROM v_customers;

-- view를 통하여 데이터 입력
INSERT INTO v_customers (customer_id, name, city) -- city를 추가해보니 v_customers에는 없어서 추가 안됨
VALUES (19, "테스트", "대전");

SELECT * FROM v_customers; -- 추상화, 전체 테이블의 데이터는 숨기기
SELECT * FROM customers; 

INSERT INTO v_customers
VALUES (11, "테스트", "abc@abc.com", "대전", "010-1234-1234", "1972-11-21", "Iron"); -- 이것도 일단 안됨

-- WITH CHECK OPTION 추가 된 사항
CREATE OR REPLACE VIEW v_customers AS
SELECT customer_id, name FROM customers
WHERE customer_id < 20 
WITH CHECK OPTION; -- WHERE를 기준으로 이걸 벗어난 값을 넣지 못하게 함

INSERT INTO v_customers (customer_id, name) -- view가 보여줄 수 있는 범위 안으로만 데이터 입력 허용
VALUES(30, "테스트3"); -- WITH CHECK OPTION에 의해 20을 넘은 데이터는 추가되지 못함

-- VIEW 삭제
DROP VIEW v_customers;