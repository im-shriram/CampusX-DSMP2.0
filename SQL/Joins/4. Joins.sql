-- UNRESOLVED QUESTION --

-- 1. `JOIN` without JOIN statment - In below SQL query each id from T1 will be compared with each id in T2 and for each `true` result it will return the id in the table. Am I right?
	SELECT T1.id
	FROM T1, T2
	WHERE T1.id = T2.id;
-- It takes every row from T1 and every row from T2, forming a Cartesian product (all possible combinations). Then it keeps only the combinations where T1.id = T2.id. For each such matching pair, it returns the id from T1.
-- Note 1: Duplicates: If T2 has multiple rows with the same id that matches a single T1 row, that T1 id will appear multiple times in the output (once per matching T2 row).
-- Note 2: Similarly, if T1 has duplicate ids, each will be paired with matching T2 rows, producing even more duplicates.

-- -------------------------------------------------------------------------------------------------------------------------- --

USE db;
CREATE TABLE customers (
    id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Doe', 'jane@example.com'),
('Emily Smith', 'emily.smith@example.com'),
('Michael Brown', 'michael.brown@example.com'),
('Sarah Taylor', 'sarah.taylor@example.com');

INSERT INTO orders (customer_id, order_date, total) VALUES
(1, '2023-01-01', 100.00),
(1, '2023-01-15', 50.00),
(2, '2023-02-01', 200.00),
(3, '2023-03-01', 75.00),
(4, '2023-04-01', 150.00);


-- Cross Join: It returns all possible combinations of rows from the two tables. 
SELECT count(*) FROM customers
CROSS JOIN orders;
-- NOTE: This join is basically used when there is no column having same name in the joining tables otherwise it becomes inner join.


-- Inner Join
SELECT * FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id; 
-- NOTE: You cannot just write the name of the column even though the name is same in both the tables. -> Error Code: 1052. Column 'id' in on clause is ambiguous


-- Right Join
SELECT * FROM customers
RIGHT JOIN orders
ON customers.id = orders.customer_id; 
-- NOTE: The values corrosponding to the records from right table which is not involved in the group by there values for the features of the left table considered as NULL.


-- Left Join
SELECT * FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id;


-- Full Outer Join
SELECT * FROM customers
RIGHT JOIN orders
ON customers.id = orders.customer_id
UNION
SELECT * FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id;


-- SELF Join
SELECT * FROM customers AS t1
INNER JOIN customers AS t2
ON t1.id; -- This is like full self join
-- NOTE: Since you are using same table to joing you can mention just the column name instead of `ON col_1 = col_2`

SELECT * FROM customers AS t1
INNER JOIN customers AS t2
ON t1.id = t2.id;

-- -------------------------------------------------------------------------------------------------------------------------- --

-- Practice Questions
-- Query 1: Join multiple tables
SELECT * 
FROM FLIPCART.USERS AS USERS
INNER JOIN FLIPCART.ORDERS AS ORDERS
ON USERS.USER_ID = ORDERS.USER_ID
INNER JOIN FLIPCART.ORDER_DETAILS AS ORDER_DETAILS
ON ORDER_DETAILS.ORDER_ID = ORDERS.ORDER_ID
INNER JOIN FLIPCART.CATEGORY AS CATEGORY
ON CATEGORY.CATEGORY_ID = ORDER_DETAILS.CATEGORY_ID;

-- Query 2: Find all orders placed in Pune
SELECT * FROM FLIPCART.USERS AS USERS
INNER JOIN FLIPCART.ORDERS AS ORDERS
ON USERS.USER_ID = ORDERS.USER_ID
WHERE USERS.CITY = 'PUNE';

-- Query 3: Find all profitable orders
SELECT ORDERS.ORDER_ID, SUM(OD.AMOUNT) AS PROFIT FROM FLIPCART.USERS AS USERS
INNER JOIN FLIPCART.ORDERS AS ORDERS
ON USERS.USER_ID = ORDERS.USER_ID
INNER JOIN FLIPCART.ORDER_DETAILS AS OD
ON OD.ORDER_ID = ORDERS.ORDER_ID
GROUP BY ORDERS.ORDER_ID
HAVING SUM(OD.AMOUNT) > 0;

-- Query 4: Find the name of the customer who has placed the maximum number of orders
SELECT USERS.NAME, COUNT(USERS.CITY) AS CT FROM FLIPCART.USERS AS USERS
INNER JOIN FLIPCART.ORDERS AS ORDERS
ON USERS.USER_ID = ORDERS.USER_ID
GROUP BY USERS.USER_ID, USERS.NAME
ORDER BY CT DESC
LIMIT 1;

-- -------------------------------------------------------------------------------------------------------------------------- --

-- SET Operations
-- 1. UNION
SELECT * FROM customers
RIGHT JOIN orders
ON customers.id = orders.customer_id
UNION
SELECT * FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id;

-- 2. UNION ALL
SELECT * FROM customers
RIGHT JOIN orders
ON customers.id = orders.customer_id
UNION ALL
SELECT * FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id;

-- 3. INTERSECTION 
SELECT * FROM customers
RIGHT JOIN orders
ON customers.id = orders.customer_id
INTERSECT
SELECT * FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id;

-- 4. EXCEPT
SELECT * FROM customers
RIGHT JOIN orders
ON customers.id = orders.customer_id
EXCEPT
SELECT * FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id;