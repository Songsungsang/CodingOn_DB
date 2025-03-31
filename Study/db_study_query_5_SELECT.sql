-- 1. SELECT 기본 문법
USE codingon_db;

SELECT * FROM class;
SELECT * FROM codingon_db.class;
SELECT * FROM student;

-- 일부 컬럼만 선택
SELECT class_name, category FROM class;
SELECT name, age, gender FROM student;

-- alias(별칭)
SELECT name, age, gender AS 성별 FROM student;
SELECT class_name 반이름, category 분류 FROM class;

-- 2. WHERE 조건을 지정해서 조회
SELECT * 
FROM student 
WHERE name = "이지은";
SELECT * 
FROM student 
WHERE student_id = 10;
SELECT name, age 
FROM student 
WHERE age >= 25;

-- 여러 조건 넣어서 조회
SELECT name, age
FROM student
WHERE age >= 25 AND age <= 27;
SELECT name, age
FROM student
WHERE class_id IN("CLS01", "CLS02", "CLS03");

-- 문자열 조건으로 조회. 이% -> 이로 시작하는. %이 -> 이로 끝나는. %이% -> 이가 포함된
SELECT *
FROM student
WHERE name LIKE "이%";

SELECT *
FROM student
WHERE join_date LIKE "%04%";

-- 정렬 order by
SELECT name, age
FROM student
ORDER BY age;

SELECT class_id, class_name, start_date
FROM class
ORDER BY class_name DESC;

SELECT *
FROM student
WHERE join_date LIKE "%04%"
ORDER BY join_date;

-- 여러기준 정렬
SELECT name, gender
FROM student
ORDER BY gender, name DESC; -- 성별 기준으로 먼저, 그다음에 이름순

-- LIMIT
SELECT * 
FROM student
LIMIT 3; -- 3개만 나오도록

SELECT class_id, class_name, start_date
FROM class
ORDER BY start_date DESC
LIMIT 1, 2; -- 0번 시작 기준 1번부터 2개를 조회

-- null 값 조회
SELECT name, age
FROM student
WHERE age IS NULL; -- 반대는 IS NOT NULL

-- distinct -> 중복 요소를 제거
SELECT DISTINCT gender
FROM student;

-- group by, having
USE my_shop;

SELECT cust_id, sum(amount) -- group by 할때 숫자에 대한 처리
FROM orders
GROUP BY cust_id;

SELECT CUST_ID "고객 아이디", SUM(amount) "총 구매 개수" 
FROM orders 
GROUP BY cust_id;

SELECT CUST_ID "고객 아이디", SUM(amount * price) "총 구매 금액" 
FROM orders 
GROUP BY cust_id
ORDER BY SUM(amount * price) DESC; -- 별칭인 총 구매 금액으로는 검색이 안됐음

SELECT CUST_ID "고객 아이디", SUM(amount * price) "총 구매 금액" 
FROM orders 
GROUP BY cust_id
HAVING SUM(price * amount) > 400000
ORDER BY SUM(amount * price) DESC; -- 별칭인 총 구매 금액으로는 검색이 안됐음
