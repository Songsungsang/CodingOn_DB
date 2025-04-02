USE function_db;

-- 1. 사용자 이름과 이메일을 결합하여 "홍길동(hong@example.com)" 형식으로 출력하시오.
SELECT name, email, CONCAT(name, " (",email, ")") formatted_contact
FROM users;

-- 2. 이메일 주소에서 도메인(@ 뒤 문자열)만 추출하여 email_domain컬럼으로 출력하시오.
SELECT email, SUBSTRING(email, LOCATE("@", email)+1) AS email_domain
FROM users;

-- 3. 상품명에서 마지막 단어(공백 기준)를 추출하여 category_keyword컬럼으로 출력하시오.
SELECT product_name, SUBSTRING_INDEX(product_name, " ", -1) AS category_keyword
FROM products;