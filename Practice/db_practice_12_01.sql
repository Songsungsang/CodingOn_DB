-- book_management_db DB 만들기
CREATE DATABASE book_management_db;
USE book_management_db;

CREATE TABLE books( -- 도서
	book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    author VARCHAR(100),
    published_at DATE,
    price INT,
    status ENUM('Rentable', 'Renting') DEFAULT 'Rentable'
);
SELECT * FROM books;
ALTER TABLE books MODIFY COLUMN status ENUM('Rentable', 'Renting') DEFAULT 'Rentable';

CREATE TABLE members( -- 회원
	member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(20),
    registered_at DATETIME
);
SELECT * FROM members;

CREATE TABLE rentals( -- 대여
	rental_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    rented_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    returned_at DATETIME NULL,
    
    CONSTRAINT book_fk
    FOREIGN KEY (book_id)
    REFERENCES books(book_id)
    ON DELETE SET NULL, -- 삭제했을때 반응

    CONSTRAINT member_fk
    FOREIGN KEY (member_id)
    REFERENCES members(member_id)
    ON DELETE SET NULL -- 삭제했을때 반응
);
SELECT * FROM rentals;

INSERT INTO books (title, author, published_at, price, status)
VALUES ('test', 'author', '2024-01-01', 10000, '대여가능');