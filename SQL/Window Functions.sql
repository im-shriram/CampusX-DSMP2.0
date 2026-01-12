CREATE DATABASE db;
USE db;

CREATE TABLE marks(
	name VARCHAR(255),
    branch VARCHAR(255),
    marks INT
);

INSERT INTO marks (name,branch,marks) VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);

SELECT * FROM marks;
-- ----------------------------------------------------------------------------------------------------------------

-- OVER Clause
-- Find the avg marks of all the student for their respective branch
SELECT name, branch,
AVG(marks) OVER(PARTITION BY branch) AS "avg_marks" -- we cannot do something like - ROUND(AVG(marks), 5)
FROM marks;

-- Find the minimum and max marks corrosopnding to all the student as per there specific branch
SELECT name, branch, marks,
MIN(marks) OVER(PARTITION BY branch) AS "Lowest Marks",
MAX(marks) OVER(PARTITION BY branch) AS "Highest Marks"
FROM marks;

-- Find all the students who have marks higher then the avg of there respective branch
-- Using Correlated Subquery
SELECT name, marks
FROM marks AS T1
WHERE marks > (SELECT AVG(marks) FROM marks AS T2 WHERE T1.branch = T2.branch);

-- Using CTE
WITH T AS (
	SELECT name, branch, marks,
	AVG(marks) OVER(PARTITION BY branch) AS "avg_marks"
	FROM marks
)
SELECT * FROM T
WHERE T.marks > T.avg_marks;

-- Using Subquery
SELECT * FROM (SELECT name, branch, marks, AVG(marks) OVER(PARTITION BY branch) AS "avg_marks" FROM marks) AS T
WHERE T.marks > T.avg_marks;
-- ----------------------------------------------------------------------------------------------------------------

-- ROW_NUMBER(): Unique sequential integer (1, 2, 3...) per partition.
-- RANK(): Ranks with gaps for ties (e.g., 1, 1, 3).
-- DENSE_RANK(): Ranks without gaps for ties (e.g., 1, 1, 2).
-- NTILE(n): Splits rows into n groups (e.g., quartiles).

-- Why every record appearing 2 times --
SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks) AS "rank", -- RANK() works over ORDER BY clause, if you cannot provide it then all the rows will be assigned to rank = 1
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks) AS "dense rank", -- DENSE_RANK() works over ORDER BY clause, if you cannot provide it then all the rows will be assigned to rank = 1
ROW_NUMBER() OVER(PARTITION BY branch) AS "row num", -- default ascending order (check)
NTILE(3) OVER(PARTITION BY branch) AS "tile"
FROM marks;
-- If you provide ORDER BY clause in atleast any of the OVER clause then all the window functions work accordingly. Just like in the case of ROW_NUMBER

-- You have to find top 2 users from each month who have the total max bill in that month
WITH ref AS (
	SELECT user_id, MONTHNAME(date) AS 'month_name', SUM(amount) AS total_amount,
	RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY SUM(amount) DESC) AS ranked_user -- SUM(amount) is tricker
	FROM zomato.orders
	GROUP BY month_name, user_id
)
SELECT * FROM ref
WHERE ranked_user < 3;
-- ----------------------------------------------------------------------------------------------------------------

-- FIRST_VALUE(column): First row in the partition.
-- LAST_VALUE(column): Last row in the partition.
-- NTH_VALUE(column): Nth row in the partition.

-- Find the student who got highest marks in there respective branch
SELECT *,
FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS "Topper",
LAST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Back Bencher", -- Frames
NTH_VALUE(name, 2) OVER(PARTITION BY branch ORDER BY marks ASC) AS "Avg"
FROM marks;
-- ----------------------------------------------------------------------------------------------------------------

-- LEAD(column, offset): Access a subsequent row.
-- LAG(column, offset): Access a preceding row

SELECT *,
LEAD(name, 2) OVER(PARTITION BY branch),
LAG(name, 2) OVER(PARTITION BY branch)
FROM marks;
-- ----------------------------------------------------------------------------------------------------------------

-- Concept of Frames
SELECT *,
AVG(marks) OVER(PARTITION BY branch ORDER BY marks ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "avg_marks"
FROM marks;
-- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW - default behavior - From start to current row

SELECT *,
AVG(marks) OVER(PARTITION BY branch ORDER BY marks ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "avg_marks"
FROM marks;
-- `rows between unbounded preceding and unbounded following` - Complete Frame

SELECT *,
AVG(marks) OVER(PARTITION BY branch ORDER BY marks ROWS BETWEEN 3 PRECEDING AND 0 FOLLOWING) AS "avg_marks"
FROM marks;
-- `rows between unbounded preceding and unbounded following` - 3 row above and 3 row below
-- ----------------------------------------------------------------------------------------------------------------

-- Calculating Cumulative Marks
SELECT *,
SUM(marks) OVER(PARTITION BY branch ORDER BY marks ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "cumulative_marks"
FROM marks;

-- Calculating Cumulative Average
SELECT *,
AVG(marks) OVER(PARTITION BY branch ORDER BY marks ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "average_marks"
FROM marks;

-- Calculating the running average
SELECT *,
AVG(marks) OVER(PARTITION BY branch ORDER BY marks ROWS BETWEEN 5 PRECEDING AND 0 FOLLOWING)
FROM db.marks;
-- A proper example would be - The average marks of a student in his recent 5 exams 

-- Calculating a pie chart
-- Using CLT
WITH T AS (
	SELECT branch, COUNT(branch) as "branch_count"
	FROM marks
    GROUP BY branch
)
SELECT branch, branch_count * 100 / SUM(branch_count) OVER() AS "percantage" FROM T;

-- Simple Subquery
SELECT branch, SUM(marks) * 100 / (SELECT SUM(marks) FROM marks) AS "percentage_marks"
FROM marks
GROUP BY branch;

-- Another Subquery
SELECT T.branch, MAX(T.percentage_marks)
FROM (SELECT *, SUM(marks) OVER (PARTITION BY branch) * 100 / SUM(marks) OVER() AS 'percentage_marks'
FROM db.marks) AS T
GROUP BY T.branch;

-- Calculating The Change in Views on Quarterly bases
SELECT YEAR(Date), QUARTER(Date), SUM(views) AS 'views',
((SUM(views) - LAG(SUM(views)) OVER(ORDER BY YEAR(Date), QUARTER(Date))) / LAG(SUM(views)) OVER(ORDER BY YEAR(Date), QUARTER(Date))) * 100 AS 'Percent_change'
FROM youtube_views
GROUP BY YEAR(Date), QUARTER(Date)
ORDER BY YEAR(Date), QUARTER(Date);

-- Calculating a weekly percentage change
SELECT *,
((Views - LAG(Views, 7) OVER(ORDER BY Date))/LAG(Views,7) OVER(ORDER BY Date))*100 AS 'weekly_percent_change' -- 7th lag value
FROM youtube_views;

-- Percentiles and Quantiles
SELECT *,
((COUNT(name) OVER(ORDER BY marks ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) - 1) / COUNT(*) OVER()) * 100 AS 'percentile' -- Just replace 100 with 4 to calclulate Quartiles and simillarly for other varients
FROM db.marks;

-- Using Inbuilt Function - Getting an Error
SELECT 
    branch,
    marks,
    PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY marks) OVER (PARTITION BY branch) AS 'median_marks',
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY marks) OVER (PARTITION BY branch) AS 'median_marks_cont'
FROM db.marks;
-- Find and remove the outliers from the dataset using IQR formula and above function and methds

-- SEGMENTATION - Buckting the dataset
SELECT *,
NTILE(3) OVER(ORDER BY marks DESC) AS 'buckets' -- Return the bucket number
FROM marks;

SELECT brand_name,model,price, 
CASE 
	WHEN bucket = 1 THEN 'budget'
    WHEN bucket = 2 THEN 'mid-range'
    WHEN bucket = 3 THEN 'premium'
END AS 'phone_type' -- Using case statement you are creating new column
FROM (SELECT brand_name,model,price,
NTILE(3) OVER(PARTITION BY brand_name ORDER BY price) AS 'bucket' 
FROM smartphones) t;

-- Cumulative Distribution
SELECT * FROM (SELECT *,
CUME_DIST() OVER(ORDER BY marks) AS 'Percentile_Score' -- 0 to 1
FROM marks) t;

SELECT * FROM (SELECT source,destination,airline,AVG(price) AS 'avg_fare',
DENSE_RANK() OVER(PARTITION BY source,destination ORDER BY AVG(price)) AS 'rank'
FROM flights
GROUP BY source,destination,airline) t
WHERE t.rank < 2