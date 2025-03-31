USE codingon_db;

SELECT name, gender
FROM student
WHERE age >= 25;

SELECT DISTINCT class_id
FROM student;

SELECT name, age
FROM student
WHERE gender = "남"
ORDER BY age;

SELECT *
FROM student
WHERE join_date BETWEEN "2024-03-01" AND "2024-04-30";

SELECT * 
FROM class
ORDER BY start_date DESC
LIMIT 3;

SELECT name
FROM student
WHERE (class_id IN ("CLS01", "CLS02", "CLS03"))
	AND (name LIKE "%정%" OR name LIKE "%영%");