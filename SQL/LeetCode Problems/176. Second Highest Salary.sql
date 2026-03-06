-- 176. Second Highest Salary - https://leetcode.com/problems/second-highest-salary/description/

-- Note: LIMIT is applied after SELECT (Query execution order). As well as LIMIT does not return `NULL` if there isnt any rows
SELECT 
    CASE
        WHEN COUNT(salary) = 0 THEN NULL 
        ELSE salary 
    END AS SecondHighestSalary
FROM Employee
ORDER BY salary
LIMIT 1, 3;

-- Solution 1: With LIMIT
WITH SecondHighestSalary AS (
    SELECT DISTINCT(salary)
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1, 1
)
SELECT IF(COUNT(salary)=1, salary, NULL) AS SecondHighestSalary FROM SecondHighestSalary

-- Solution 2: Without LIMIT and ORDER BY
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);