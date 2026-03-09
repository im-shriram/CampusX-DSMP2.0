-- Randomly select 5 rows from users table - df.sample(5) from pandas
SELECT * FROM zomato.users
ORDER BY rand()
LIMIT 5; 

-- Finding the rows which include atleast 1 null value
SELECT * FROM zomato.orders
WHERE restaurant_rating = ""; -- for null values command `restaurant_rating IS NULL`

-- Replacing null values with empty string
UPDATE zomato.orders
SET restaurant_rating = NULL WHERE (restaurant_rating = "" OR restaurant_rating IS NULL);
SELECT * FROM zomato.orders;

-- Find number of orders placed by each customer
SELECT T1.user_id, T1.name, COUNT(*) FROM zomato.users AS T1
INNER JOIN zomato.orders AS T2 
WHERE T1.user_id = T2.user_id -- If you not mention the `where` clause the join becomes cross join
GROUP BY T1.user_id, T1.name;

-- Find the restaurant with most number of menu items
SELECT T2.r_id, T1.r_name, COUNT(*) AS freq FROM zomato.restaurants AS T1
INNER JOIN zomato.menu AS T2
ON T1.r_id = T2.r_id
GROUP BY T2.r_id, T1.r_name -- HAVING accessing the columns name mentioned in the select statment even though the QEO of having is before select?
ORDER BY freq DESC
LIMIT 1;

-- Find the number of votes and average rating for all the restaurants
SELECT T1.r_id, T2.r_name, COUNT(*) AS 'Votes', AVG(T1.restaurant_rating) AS 'avg_rating' 
FROM zomato.orders AS T1
INNER JOIN zomato.restaurants AS T2
ON T1.r_id = T2.r_id
WHERE T1.restaurant_rating <> "" -- IS NOT NULL
GROUP BY T1.r_id, T2.r_name;

-- Find the food that is being ordered by most number of customers
SELECT T3.f_id, T3.f_name, COUNT(*) AS freq
FROM zomato.orders AS T1
INNER JOIN zomato.menu AS T2
ON T1.r_id = T2.r_id
INNER JOIN zomato.food AS T3
ON T2.f_id = T3.f_id
GROUP BY T3.f_id, T3.f_name
ORDER BY freq DESC
LIMIT 1;

-- Find reataurant with max_revenue in a given month
WITH T AS (
	SELECT T1.r_id, T2.r_name, MONTH(T1.date) AS month, SUM(amount) AS total_amount
	FROM zomato.orders AS T1
	INNER JOIN zomato.restaurants AS T2
	ON T1.r_id = T2.r_id
	GROUP BY T1.r_id, T2.r_name, MONTH(T1.date)
)
SELECT *
FROM T
WHERE (month, total_amount) IN (
	SELECT month, MAX(total_amount)
	FROM T
	GROUP BY month
);

-- Find restaurants with total sales > avg(sales of all the restaurants)
SELECT T1.r_id, T2.r_name, SUM(T1.amount) AS total_revenue
FROM zomato.orders AS T1
INNER JOIN zomato.restaurants AS T2
ON T1.r_id = T2.r_id
GROUP BY T1.r_id, T2.r_name
HAVING SUM(T1.amount) > (SELECT AVG(amount) FROM zomato.orders);

-- Month wise revenue for a perticular restaurant
SELECT MONTH(T2.date) AS "Month", SUM(T2.amount) AS "Total Amount" FROM zomato.restaurants AS T1
INNER JOIN zomato.orders AS T2
ON T1.r_id = T2.r_id
WHERE T1.r_name = "kfc" -- You can choose any restaurant from dataset
GROUP BY MONTH(T2.date)
ORDER BY SUM(amount) ASC;

-- Find the customers who never ordered
SELECT * FROM zomato.users
WHERE user_id NOT IN (SELECT user_id FROM zomato.orders);

-- Show order details of a perticular customer in a given range
USE zomato;
SELECT orders.order_id, orders.date, food.f_name, orders.amount
FROM users
INNER JOIN orders
ON users.user_id = orders.user_id
INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN food
on food.f_id = order_details.f_id
WHERE users.name = "Nitish" AND orders.date BETWEEN DATE("2022-05-01") AND DATE("2022-06-30")
ORDER BY orders.date;

-- Customer's favourite food - based on how frequently he/she ordered that food
WITH T AS (
SELECT orders.user_id AS "user_id", order_details.f_id AS "food_id", COUNT(*) AS "freq"
FROM orders
INNER JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY order_details.f_id, orders.user_id
)
SELECT users.name, food.f_name, T.freq FROM T
INNER JOIN food
ON T.food_id = food.f_id
INNER JOIN users
ON T.user_id = users.user_id
WHERE (T.user_id, T.freq) IN (
	SELECT T.user_id, MAX(T.freq)
    FROM T
    GROUP BY T.user_id
); -- We got 2 favourite foods of "User - Ankit" which is of same frequency