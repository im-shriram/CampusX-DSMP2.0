CREATE DATABASE joins;

-- 1. Find out top 10 countries' which have maximum A and D values each and join them in one table.
SELECT A.Country, A, D FROM (SELECT * FROM joins.country_ab -- Make sure to print a column of left table on top of which you joining the table.
ORDER BY A DESC
LIMIT 10) AS A
LEFT JOIN -- After join this is subquery
(SELECT * FROM joins.country_cd
ORDER BY D DESC
LIMIT 10) AS B
ON A.Country = B.Country
UNION
SELECT B.Country, A, D FROM (SELECT * FROM joins.country_ab -- Same for right join as well.
ORDER BY A DESC
LIMIT 10) AS A
RIGHT JOIN -- After join this is subquery
(SELECT * FROM joins.country_cd
ORDER BY D DESC
LIMIT 10) AS B
ON A.Country = B.Country;

-- 2. Find out highest CL value for 2020 for every region. Also sort the result in descending order. Also display the CL values in descending order.
SELECT T1.Region, MAX(CL) FROM joins.country_ab AS T1
INNER JOIN joins.country_cl AS T2
ON T1.Country = T2.Country
WHERE T1.Edition = 2020
GROUP BY T1.Region
ORDER BY MAX(CL) DESC;

-- 3. Find top-5 most sold products.
SELECT T2.Name, SUM(T1.Quantity) AS total_sale FROM joins.sales1 AS T1
INNER JOIN joins.products AS T2
ON T1.ProductID = T2.ProductID
GROUP BY T2.Name
ORDER BY total_sale DESC
LIMIT 5;

-- 4. Find sales man who sold most no of products.
SELECT CONCAT(T2.FirstName, ' ', T2.MiddleInitial, ' ', T2.LastName), SUM(T1.Quantity) as counter FROM joins.sales1 AS T1
INNER JOIN joins.employees AS T2
ON T1.SalesPersonID = T2.EmployeeID
GROUP BY T2.FirstName, T2.MiddleInitial, T2.LastName
ORDER BY counter DESC
LIMIT 0, 1;

-- 5. Sales man name who has most no of unique customer.
SELECT CONCAT(T3.FirstName, ' ', T3.MiddleInitial, ' ', T3.LastName) AS Name, COUNT(*) AS counter FROM joins.sales1 AS T1
INNER JOIN joins.customers AS T2
ON T1.CustomerID = T2.CustomerID
INNER JOIN
(SELECT * FROM joins.employees) AS T3
ON T1.SalesPersonID = T3.EmployeeID
GROUP BY T3.FirstName, T3.MiddleInitial, T3.LastName, T2.FirstName, T2.LastName
ORDER BY counter DESC
LIMIT 0, 1;

-- 6. Sales man who has generated most revenue. Show top 5.
SELECT CONCAT(T3.FirstName, ' ', T3.MiddleInitial, ' ', T3.LastName) AS Name, SUM(T2.Price) AS Total_revenue FROM joins.sales1 AS T1
INNER JOIN joins.products AS T2
ON T1.ProductID = T2.ProductID
INNER JOIN
(SELECT * FROM joins.employees) AS T3
ON T1.SalesPersonID = T3.EmployeeID
GROUP BY T3.FirstName, T3.MiddleInitial, T3.LastName
ORDER BY Total_revenue DESC
LIMIT 5;

-- 7. List all customers who have made more than 10 purchases.
SELECT T2.FirstName, T2.LastName, COUNT(*) AS total FROM joins.sales1 AS T1
INNER JOIN joins.customers AS T2
ON T1.CustomerID = T2.CustomerID
GROUP BY T2.FirstName, T2.LastName
HAVING total > 10;

-- 8. List all salespeople who have made sales to more than 5 customers.
SELECT * FROM joins.employees
WHERE EmployeeID IN (SELECT SalesPersonID FROM joins.sales1
GROUP BY SalesPersonID, CustomerID
HAVING COUNT(DISTINCT CustomerID) > 5);

-- 9. List all pairs of customers who have made purchases with the same salesperson.
SELECT DISTINCT T1.SalesPersonID, T1.CustomerID, T2.CustomerID FROM joins.sales1 AS T1
INNER JOIN joins.sales1 AS T2
ON T1.SalesPersonID = T2.SalesPersonID
AND T1.CustomerID != T2.CustomerID