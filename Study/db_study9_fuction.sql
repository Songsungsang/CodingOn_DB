USE function_db;

-- 문자합수
-- CONCAT 문자열 결함
SELECT name, birth_date, CONCAT(name, " (",birth_date, ")") name_with_birth
FROM users;

-- LEFT, 앞쪽 일부 문자열 추출
SELECT product_name, LEFT(product_name, 2) -- 2글자 추출
FROM products;

-- SUBSTRING 지정한 위치에서 문자열 추출
SELECT name, SUBSTRING(name, 2, 2)
FROM users;

-- 특정 문자나 인덱스를 기준으로 뒤의 문자열 추출
SELECT email, SUBSTRING_INDEX(email, "@", -1) AS email_domain
FROM users;

-- UPPER 대문자 변환
SELECT name, UPPER(email) upper_email
FROM users;

-- 수학함수
-- ROUND : 반올림, CEIL : 올림, FLOOR : 내림
SELECT ROUND(3.14);
SELECT ROUND(1234.5678, 2); -- 소수점 둘째자리까지 반올림
SELECT ROUND(1234.5678, -2); -- 둘째자리에서 반올림
SELECT CEIL(3.44);
SELECT FLOOR(3.64);

-- MOD : 나머지 구하기
SELECT MOD(10, 3);

-- ABS : 절대값
SELECT ABS(-100);

-- RAND : 0~1 난수 생성
SELECT RAND();
SELECT ROUND(RAND() * 100);

SELECT user_id, ROUND(RAND() * 10000) recommended_code
FROM users;

-- 날짜 함수
SELECT NOW(); -- 현재 날짜와 시간
SELECT CURDATE(); -- 현재 날짜
SELECT CURTIME(); -- 현재 시간

-- 날짜의 차이 계산
SELECT DATEDIFF(CURDATE(), "2025-03-14");

SELECT created_at, DATEDIFF(NOW(), created_at) -- 주문일로부터 경과일 확인
FROM orders;

-- 날짜에 더하기
SELECT DATE_ADD("2025-03-14", INTERVAL 3 DAY); -- 날짜에 	Interval 3일 더하기

-- Year, Month, Day : 년도 월 날 추출
SELECT YEAR("2025-04-01") year, MONTH("2025-04-01"), DAY("2025-04-01");