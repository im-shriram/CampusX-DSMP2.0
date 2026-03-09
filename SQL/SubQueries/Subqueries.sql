-- SCALER SUBQUERRIES -- 
SELECT * 
FROM joins.movies
WHERE (gross - budget) = (SELECT MAX(gross - budget) FROM joins.movies); # The subquerry returns only one value

SELECT *
FROM joins.movies
WHERE score > (SELECT AVG(score) FROM joins.movies);

-- Find the highest rated movie in 2000 year
SELECT *
FROM joins.movies
WHERE score = (SELECT MAX(score) as s FROM joins.movies WHERE year = 2000) AND year = 2000;

-- Find the movie with highest profit
-- Using subquerry
SELECT * FROM joins.movies
WHERE (gross - budget) = (SELECT MAX(gross - budget) FROM joins.movies);

-- Without using Subquerry
SELECT * FROM joins.movies
ORDER BY (gross - budget) DESC
LIMIT 0, 1;
-- Because of indexing -> The ORDER BY approach is more faster than the subquerry (IMP 💕)

-- Find how many movies have a rating > the average of all the movie rating(Find the count of above movies)
SELECT COUNT(*) FROM joins.movies
WHERE score > (SELECT AVG(score) FROM joins.movies);

SELECT COUNT(*) FROM joins.movies
WHERE score > AVG(score); -- Why this is not working
--  there is an issue with the use of the AVG(score) function directly in the WHERE clause. SQL doesn't allow aggregate functions like AVG to be used in the WHERE clause because WHERE is evaluated before the aggregation.

-- Find the highest rated movie in 2000 year
SELECT * FROM joins.movies
WHERE score = (SELECT MAX(score) FROM joins.movies WHERE year = 2000) AND year = 2000;

-- Find the highest rated movie among all the movies whose number of votes are > than dataset avg votes
SELECT * FROM joins.movies
WHERE score = (SELECT MAX(score)
				FROM joins.movies
				WHERE votes > (SELECT AVG(votes) FROM joins.movies)); -- Nested Subquerries
 

-- ROW SUBQUERRIES --
-- user dataset

-- Find the users who never ordered
CREATE DATABASE zomato;

SELECT * FROM zomato.user
WHERE user_id NOT IN (SELECT DISTINCT user_id 
						FROM zomato.orders);
-- When subquerry returns more than one row, you have to use IN or NOT IN operator and not = and != These only works for comparing with single values

-- Find all the movies made by top 3 directors(in terms of total gross income)
SELECT * FROM joins.movies
WHERE director IN (SELECT director 
					FROM joins.movies 
                    GROUP BY director
					ORDER BY SUM(gross) DESC
                    LIMIT 3); -- This will work in other DB languages
-- Solved using Common Table Expressions                    
WITH top_directors AS (SELECT director 
						FROM joins.movies 
						GROUP BY director
						ORDER BY SUM(gross) DESC -- We can aggrigate function with order by clause as they execute after aggrigation (group by)
						LIMIT 3)
SELECT * FROM joins.movies
WHERE director in (SELECT * FROM top_directors);

-- Find all movies of all those actors whose filmgraphy's avg rating > 8.5 (Take 25000 votes as cutoff)
SELECT * FROM joins.movies
WHERE star IN (SELECT star
				FROM joins.movies
                WHERE votes > 25000
				GROUP BY star
				HAVING AVG(score) > 8.5);
                
-- Table Subquerries

-- Find the most profitable movie of each year
-- Approach 1 - Row subquerry
SELECT name, (gross - budget) AS Profit
FROM joins.movies
WHERE (gross - budget) IN (SELECT MAX(gross - budget) AS profit
							FROM joins.movies
							GROUP BY year
							ORDER BY year ASC);
-- 2nd approach - Table Subquerry
SELECT name, (gross - budget) AS Profit
FROM joins.movies
WHERE (year, gross - budget) IN (SELECT year, MAX(gross - budget) AS profit
							FROM joins.movies
							GROUP BY year
							ORDER BY year ASC);

-- You cannot compaire between a subquerry which returns more than one column and a criteria on less number of columns eg.. `WHERE year IN (SELECT year, name, ...)`					
SELECT *
FROM joins.movies
WHERE name IN (SELECT name, gross from joins.movies);

-- NOTE: The columns and its sequence in where clause and subquerry must be same.


-- Find the highest rated movie of each genre votes cutoff of 25000
SELECT name, genre, score
FROM joins.movies
WHERE (genre, score) IN (SELECT genre, MAX(score) AS score FROM joins.movies WHERE votes > 25000 GROUP BY genre);


-- Find the highest grocessing movie of top 5 actor/director combo in terms of total gross income
SELECT name, star, director, gross FROM joins.movies
WHERE (star, director, gross) IN (SELECT star, director, MAX(gross) AS max_gross
									FROM joins.movies
									GROUP BY star, director)
ORDER BY gross DESC;                                 


-- CORRELATED QUERIES

-- Print those movies which have higher rating than the average rating of the gonera of which the movie belongs
SELECT * FROM joins.movies AS m1
WHERE score > (SELECT AVG(score) FROM joins.movies AS m2 WHERE m2.genre = m1.genre);
-- Think about you are running the outer querry for 1st movie then try to find the ans of inner querry for that perticular row no.


-- Find the most favourit food of each customer (criteria - most ordered)
WITH fav_food AS (
	SELECT name, f_name, COUNT(*) as frequency FROM zomato.user AS t1
    JOIN zomato.orders AS t2 ON t1.user_id = t2.user_id
    JOIN zomato.order_details AS t3 ON t2.order_id = t3.order_id
    JOIN zomato.food AS t4 ON t3.f_id = t4.f_id
    GROUP BY t2.user_id, t3.f_id
)

SELECT * FROM fav_food AS f1
WHERE frequency = (SELECT MAX(frequency) FROM fav_food AS f2 WHERE f2.user_id = f1.user_id); 


-- Subquerry with SELECT - you need to be super carefull when using subquerries with select  because for each row you are traversing over entire dataset, its like O(n^2) TC
-- calculate the precent vote of each movie
SELECT name, (votes / (SELECT SUM(votes) FROM joins.movies)) * 100 AS precent_votes
FROM joins.movies;

-- Display all movie names, genre, score and avg(score)
SELECT name, genre, score, (score / (SELECT COUNT(*) FROM joins.movies AS t2 WHERE t2.genre = t1.genre)),
(SELECT AVG(score) FROM joins.movies AS t2 WHERE t2.genre = t1.genre)
 AS avg_score FROM joins.movies AS t1;
 

-- Subquerries with Having
-- Find genres having avg(genre) > avg(all)
SELECT genre, AVG(score)
FROM joins.movies
GROUP BY genre
HAVING AVG(score) > (SELECT AVG(score) FROM joins.movies);
 

-- Subquerries with INSERT
CREATE TABLE IF NOT EXISTS loyal_customers(
	name VARCHAR(255),
    money INT
);
INSERT INTO loyal_customers(name) -- Dont write "VALUES" here if you are inserting values from another table
SELECT t1.name
FROM zomato.user AS t1
JOIN zomato.orders AS t2 ON t1.user_id = t2.user_id
GROUP BY t1.name
HAVING COUNT(*) > 3;

UPDATE loyal_customers
SET money = (SELECT SUM(amount)
				FROM zomato.orders
                WHERE orders.user_id = loyal_customers.user_id); # Adhi user id add kr loyal madhe nanter he querry run kr

SELECT t1.name, t2.discount
FROM zomato.user AS t1
INNER JOIN (SELECT user_id, SUM(amount) * 0.1 AS "discount"
FROM zomato.orders
GROUP BY user_id) AS t2 
ON t1.user_id = t2.user_id;


-- Subquerries with DELETE
DELETE FROM zomato.user
WHERE user_id IN (SELECT *
					FROM user AS t1
					WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM zomato.orders));

SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.employee_id = e.id);
-- Time Complexity: O(n × log m) to O(n × m)
	-- With proper indexing: O(n × log m)
	-- Without indexes: O(n × m)
	-- Often more efficient than IN because it stops at first match