USE function_db;

-- 1. 상품 가격의 평균을 계산하고, 소수 첫째 자리까지 반올림하여 출력하시오.
SELECT ROUND(AVG(price), 1) AS avg_price_rounded
FROM products;

-- 2. 최근 7일 이내에 주문된 주문건을 조회하고, 경과일을 출력하시오.
SELECT order_id, created_at, DATEDIFF(NOW(), created_at) AS days_ago
FROM orders
WHERE DATEDIFF(NOW(), created_at) <= 7;

-- 3. 사용자 ID가 홀수이면서, 이름에 '김' 또는 '이'가 포함된 사용자만 조회하시오.
SELECT user_id, name, email
FROM users
WHERE MOD(user_id, 2) = 1 AND (name LIKE "%김%" OR name LIKE "%이%");

-- 4. 배송완료된 주문 중, 주문일로부터 7일 이상 경과한 주문을 조회하시오.
SELECT order_id, order_status, created_at, DATEDIFF(NOW(), created_at) AS days_ago
FROM orders
WHERE order_status = "배송완료" AND DATEDIFF(NOW(), created_at) >= 7;