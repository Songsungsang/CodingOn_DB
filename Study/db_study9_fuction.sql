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

-- 날짜 포멧
SELECT DATE_FORMAT(now(), "%Y년-%m월-%d일");

-- IF
USE codingon_db;

SELECT name, gender,
	IF(gender = "남", "Male", "Female") gender_eng
FROM student;

USE codingon_store_db;
	
SELECT name, price,
	IF(price >= 10000, "비쌈", "저렴") price_level
FROM products;

-- IFNULL
SELECT name, IFNULL(phone, "전화번호 없음")
FROM customers;

SELECT name, IFNULL(membership_level, "IRON")
FROM customers;

-- NULLIF
SELECT order_id, order_status,
	 NULLIF(order_status, "처리중") order_status_edit
FROM orders;

-- CASE
SELECT
	order_id, order_status,
    CASE order_status
		WHEN "결제완료" THEN "준비 중"
        WHEN "배송중" THEN "이동 중"
        WHEN "완료" THEN "도착"
        WHEN "주문취소" THEN "취소됨"
        ELSE "알 수 없음"
	END AS status_label
FROM orders;

USE function_db;
SELECT order_id, created_at,
	datediff(now(), created_at) days_ago,
    CASE
		WHEN DATEDIFF(now(), created_at) <= 3 THEN "최근 주문"
        WHEN DATEDIFF(now(), created_at) <= 7 THEN "지난주 주문"
        ELSE "오래된 주문"
	END order_age
FROM orders;

-- 암시적 형변환
SELECT '100' + '200'; -- 300
SELECT 100 + 200; -- 이거도 300
-- 문자열 결합 CONCAT
SELECT CONCAT("100", "200");
SELECT CONCAT(100, "200"); -- CONCAT은 전부 문자열로 바꿈

-- 명시적 형변환 : CAST, CONVERT
SELECT CAST('123' AS SIGNED); -- SIGNED = INT. 즉, '123'을 SIGNEDINT 123으로 변환중
SELECT CAST(3.14 AS CHAR);
SELECT CAST("2025&4&3" AS DATE); -- 날짜 변환
-- CONVERT - 문자 셋을 지정할때 필요