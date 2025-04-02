-- ✅ 데이터베이스 생성 및 사용
DROP DATABASE IF EXISTS fuction_db;
CREATE DATABASE function_db;
USE function_db;

-- ✅ 기존 테이블이 있다면 삭제
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

-- ✅ 사용자 테이블 생성
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    birth_date DATE
);

-- ✅ 상품 테이블 생성 (카테고리 추출이 가능하도록 상품명 구성)
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

-- ✅ 주문 테이블 생성
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    order_status VARCHAR(20),
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ✅ 사용자 데이터 삽입
INSERT INTO users (name, email, birth_date) VALUES
('홍길동', 'hong@example.com', '1990-05-10'),
('김영희', 'kim@example.com', '1985-11-20'),
('이철수', 'lee@example.com', '2000-03-15'),
('박민수', 'park@example.com', '1995-07-30'),
('정은지', 'jeong@example.com', '1993-01-01'),
('한지민', 'han@example.com', '1988-09-14'),
('장동건', 'jang@example.com', '1978-06-25'),
('신세경', 'shin@example.com', '1999-12-05'),
('유재석', 'yoo@example.com', '1972-08-14'),
('강호동', 'kang@example.com', '1970-06-11');

-- ✅ 상품 데이터 삽입 (카테고리 포함된 상품명)
INSERT INTO products (product_name, price) VALUES
('갤럭시북 노트북', 1299000),
('맥북 에어 노트북', 1890000),
('로지텍 무선 마우스', 29900),
('앱코 유선 마우스', 19900),
('한성 기계식 키보드', 89000),
('로지텍 블루투스 키보드', 99000),
('삼성 27인치 모니터', 279000),
('LG 게이밍 모니터', 259000),
('삼성 외장 SSD', 139000),
('샌디스크 휴대용 SSD', 119000);

-- ✅ 주문 데이터 삽입
INSERT INTO orders (user_id, product_id, order_status, created_at) VALUES
(1, 1, '배송완료', '2025-03-24 10:00:00'),
(2, 2, '주문취소', '2025-03-25 15:30:00'),
(3, 3, '배송중', '2025-03-27 09:00:00'),
(4, 4, '배송완료', '2025-03-29 14:20:00'),
(5, 5, '결제완료', '2025-03-28 11:45:00'),
(6, 6, '배송완료', '2025-03-27 08:15:00'),
(7, 7, '결제완료', '2025-03-23 13:00:00'),
(8, 8, '배송중', '2025-03-27 10:30:00'),
(9, 9, '배송완료', '2025-03-24 17:45:00'),
(10, 10, '주문취소', '2025-03-23 19:25:00');