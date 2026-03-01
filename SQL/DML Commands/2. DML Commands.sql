CREATE TABLE IF NOT EXISTS dml_commands(
	id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    branch VARCHAR(255) NOT NULL
);

-- DML Commands (Data Manipulation Language): DML commands are used to query (print), insert, modify, and delete data within database objects (like tables). Unlike DDL, DML operations are typically transactional – they can be rolled back if not committed.

-- 1. INSERT – Adds new rows to a table
INSERT INTO dml_commands() -- There is no need to mention the () if you are inserting in all the columns 
VALUES (1, 'jonny', 'IT'), (2, 'DEX', 'CS'), (3, 'SAM', 'MECH');

-- Different Ways of Insertion
-- a. Inserting into All Columns
CREATE TABLE users (id INT, name VARCHAR(50), age INT);
INSERT INTO users
VALUE (1, 'John Doe', 30); -- If you are inserting just one record use `VALUE` otherwise use `VALUES`

-- b. Inserting into Specific Columns
CREATE TABLE users (id INT AUTO_INCREMENT, name VARCHAR(50), age INT);
INSERT INTO users (name, age)
VALUES ('Jane Doe', 28);

-- NOTE: If you want to add values only in a specific set of columns then, you need to explicitely pass `NULL` as a value for other column.

-- c. Inserting Multiple Rows at Once
CREATE TABLE customers (name VARCHAR(50), age INT, country VARCHAR(50));
INSERT INTO customers (name, age, country)
VALUES
    ('Mike', 35, 'USA'),
    ('Emma', 22, 'UK'),
    ('Tom', 40, 'Canada');

-- d. Inserting from Another Table - (IMP)
CREATE TABLE new_customers (name VARCHAR(50), age INT);
CREATE TABLE old_customers (name VARCHAR(50), age INT);

INSERT INTO new_customers (name, age) -- Dont need to write `VALUES` here
SELECT name, age
FROM old_customers;

-- e. Inserting with Default Values
CREATE TABLE users (id INT AUTO_INCREMENT, name VARCHAR(50), age INT DEFAULT 18);
INSERT INTO users (name)
VALUES ('Alex');


-- 2. UPDATE – Modifies existing data in one or more rows
UPDATE dml_commands
SET name = 'new_name', branch = 'ABC' -- Multiple Updations
WHERE id = 1;

-- NOTE: If the WHERE clause is omitted, all rows would be updated – so use it carefully!


-- 3. DELETE – Removes rows from a table
SET SQL_SAFE_UPDATES = 0;
DELETE FROM dml_commands
WHERE name = 'DEX';

-- NOTE: Without a WHERE clause, all rows in the table would be deleted.
-- DELETE and UPDATE are perminant Querries


-- 4. SELECT – Retrieves data from one or more tables
SELECT * FROM dml_commands; -- SELECT is a DQL/DML command

-- -------------------------------------------------------------------------------------------------------------------------- --

-- Creating new column with default values
SELECT
brand_name, 'smartphone' AS 'phone' -- `phone` is col name and `smartphone` is default value
from dml.smartphones;