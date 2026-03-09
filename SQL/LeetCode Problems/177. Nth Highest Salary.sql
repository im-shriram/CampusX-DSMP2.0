-- 177. Nth Highest Salary - https://leetcode.com/problems/nth-highest-salary/description/

-- Wrong Solution: Since I've used COUNT() which is an aggregate function, it implicitely aggregated considering entire table into one row that means you cannot access all the salaries that also means your order by is worthless.
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N = N - 1;
    RETURN (
        # Write your MySQL query statement below.
        SELECT 
            CASE
                WHEN COUNT(DISTINCT(salary)) > N THEN salary 
                ELSE NULL
            END
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET N
    );
    END

-- Solution 1: Simple Query
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N = N - 1;
    RETURN (
        # Write your MySQL query statement below.
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET N
    );
    END

-- Solution 2: Using dense_rank window function
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Use a Common Table Expression (CTE) to rank salaries
      WITH T AS (
          SELECT
              salary, 
              DENSE_RANK() OVER(ORDER BY salary DESC) AS salary_rank
          FROM Employee
      )
      
      SELECT DISTINCT salary
      FROM T
      WHERE salary_rank = N  -- In SQL, use '=' for comparison, not '=='
  );
END