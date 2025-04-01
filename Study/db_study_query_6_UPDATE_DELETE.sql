USE codingon_db;

-- Update
UPDATE student
SET name = "로제", age = 20
WHERE name = "박채영";

UPDATE student
SET name = "박채영", age = NULL
WHERE name = "로제";