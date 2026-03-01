-- EXISTS Clause : The SQL EXISTS clause is primarily used to filter rows based on the existence of related records in another table or to enforce conditional logic in subqueries
CREATE DATABASE IF NOT EXISTS db; -- Exists is a clause used with only databases and tables to check whether they exists or not
USE db;

SELECT order_id 
FROM zomato.orders AS T1
WHERE EXISTS (
  SELECT 1 FROM zomatoorder_details AS T2 -- Return all the columns
  WHERE T1.order_id = T2.order_id
); -- For each order_id if subquery returns anything then only that order_id will be printed

-- -------------------------------------------------------------------------------------------------------------------------- --

-- DDL (Data Definition Language) commands are used to define, modify, or remove database objects such as tables, indexes, views, schemas, and more. `They are autocommit in most databases, meaning changes are saved permanently once executed`.

-- 1. CREATE – Creates new database objects (tables, views, indexes, etc.)
CREATE DATABASE practice;
CREATE TABLE tb (
	col INT
);

INSERT INTO tb VALUES (1), (2), (3), (4), (5);
SELECT * FROM  practice.tb
WHERE EXISTS (
	SELECT * FROM practice.tb
    WHERE col = col
); -- If subquerry return data then the main querry will return as well

-- NOTE: If you are using just one table and apply a where clause then is will check the condition for each row, however if you are using two tables and comparing between them then its like applying a join wrt a perticular condition.

SELECT * FROM  practice.tb
WHERE NOT EXISTS (
	SELECT * FROM practice.tb
    WHERE col = col
); -- In this case, subquerry returns rows but since we are using NOT EXISTS this will change TRUE -> FALSE thats why main querry remains empty 


-- 2. ALTER – Modifies an existing database object (e.g., add/drop columns, modify data types)
ALTER TABLE zomato.order_details
ADD COLUMN new_column_1 INT NOT NULL DEFAULT 0; -- Initially all values in the columns are initialized to 0.

ALTER TABLE zomato.order_details
MODIFY COLUMN new_column_1 VARCHAR(255); -- You cannot change the datatype from `string to decimal` unless all the values are in integer just like python, but you can change from int to string, infact you can change anything to string

ALTER TABLE zomato.order_details
DROP COLUMN new_column_1;

-- NOTE: `COLUMN` keyword is optional


-- 3. DROP – Permanently removes an entire database object
DROP TABLE IF EXISTS tb;
DROP DATABASE IF EXISTS db;


-- 4. TRUNCATE – Removes all rows from a table, but keeps the table structure intact
TRUNCATE TABLE new_datatypes;
SELECT * FROM new_datatypes;

-- Difference between trucate and drop and delete from table_name (without where statment) -> drop will removes the entire data with table but truncate will only deletes the data


-- 5. RENAME – Changes the name of a database object
RENAME TABLE datatypes TO new_datatypes;

-- -------------------------------------------------------------------------------------------------------------------------- --

-- To see all tables in a selected databases [Not a DDL command]
SHOW TABLES; 
SHOW DATABASES;

-- Another way "DESC TABLE datatypes" - Return the type of columns, null values and type of key [Not a DDL command]
DESCRIBE zomato.orders;