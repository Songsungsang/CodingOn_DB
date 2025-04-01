CREATE DATABASE codingon_store_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE codingon_store_db;

CREATE TABLE customers(
	customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    city VARCHAR(50),
    phone VARCHAR(20),
    birth_date DATE,
    membership_level VARCHAR(20)
);

CREATE TABLE orders(
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
	order_date DATE,
    order_status VARCHAR(20),
    payment_method VARCHAR(30),
    delivery_fee INT DEFAULT 0,
    CONSTRAINT customer_fk
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
	ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE products(
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price INT,
    stock_quantity INT,
    category VARCHAR(50),
    manufacturer VARCHAR(50)
);

CREATE TABLE order_items(
	order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price INT,
    discount_rate DECIMAL(5,2),
    CONSTRAINT order_fk
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT product_fk
	FOREIGN KEY (product_id) REFERENCES products(product_id)
	ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE employees(
	employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
	manager_id INT,
    hire_date DATE,
    department VARCHAR(50),
    position VARCHAR(50),
    
    FOREIGN KEY(manager_id) REFERENCES employees(employee_id) -- 자기 자신의 테이블로부터 상사의 id를 가져옴
);