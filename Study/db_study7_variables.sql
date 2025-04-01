USE my_shop;

-- 변수 지정
SET @price = 1000;
SELECT @price;

SET @quantity = 3;
SET @total = @price * @quantity;
SELECT @total;