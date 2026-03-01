-- UNRESOLVED QUESTION --

-- 1. Which aggregate function are only used with GROUP BY statments and which functions are used with and without GROUP BY?
-- >  All standard aggregate functions in SQL – such as SUM, AVG, COUNT, MIN, MAX, and others like STRING_AGG, ARRAY_AGG, GROUP_CONCAT – can be used both with and without a GROUP BY clause.

SELECT SUM(id) AS total_sum,
       AVG(id) AS average,
       MIN(id) AS minimum,
       MAX(id) AS maximum,
       COUNT(id) AS total_count
FROM zomato.order_details; 

-- You cannot do like this
SELECT *, SUM(id) FROM zomato.order_details; -- * expands to all columns from the table (including id, which is already referenced separately). The aggregate functions (SUM, AVG, etc.) are computed over the entire table as a single group. The nonaggregated columns (like all columns from the table) are not part of the GROUP BY clause, and there is no GROUP BY at all.
-- Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'zomato.order_details.id'; this is incompatible with sql_mode=only_full_group_by

-- ------------------------------------------------------------------------------------------------------------------------ --

-- The LIMIT clause is used to restrict the number of rows returned by a query. Instead of getting all rows from a table, you can ask for only the first few.
	SELECT column1, column2
	FROM table_name
	LIMIT number;
-- number is the maximum rows to return from beggining.

-- Using LIMIT with OFFSET – Pagination
-- OFFSET allows you to skip a certain number of rows before starting to return rows.
	SELECT *
	FROM table_name
	LIMIT number OFFSET skip_rows;
-- skip_rows is how many rows to skip from the beginning.

SELECT * FROM zomato.order_details
LIMIT 2 OFFSET 3;
-- another way to get the same result using limit
SELECT * FROM zomato.order_details
LIMIT 3, 2; -- skip 3 rows from biggining and return the next 2 rows.

-- Top 5 highest screen size smasung phones
SELECT brand_name, screen_size
FROM dml.smartphones
WHERE brand_name = 'samsung'
ORDER BY screen_size DESC
LIMIT 5;

-- Sort the dataset on the bases of ppi
SELECT brand_name, 
ROUND(SQRT((resolution_height * resolution_height) + (resolution_width * resolution_width)) / screen_size) AS 'ppi'
FROM dml.smartphones
ORDER BY ppi DESC
LIMIT 5;

-- Find the phone who have 2nd largest battery - (IMP)
SELECT brand_name, model, battery_capacity FROM dml.smartphones
ORDER BY battery_capacity DESC
LIMIT 1, 1; -- skip 1 row from the biggining and return the next 1 row

-- Find the name and rating of worst rated apple phone
SELECT model, rating
FROM dml.smartphones
WHERE brand_name = 'apple'
ORDER BY rating ASC
LIMIT 0, 1;

-- Sort the phones alphabetically and then on the bases of rating in descending order
SELECT *
FROM dml.smartphones
ORDER BY brand_name ASC, rating DESC;

-- Group smartphones by brand and get the count, avg price, max rating, avg screen size and avg battery capacity
SELECT COUNT(*), AVG(price), MAX(rating), AVG(screen_size), AVG(battery_capacity)
FROM dml.smartphones
GROUP BY brand_name;
-- NOTE: If you are performing a `GROUP BY` operation over a column which contains `NULL` values then `NULL` is considered as a seperate, stand-alone group.

-- groupby using has_nfc and find avg_rating
SELECT has_nfc, AVG(price), AVG(rating)
FROM dml.smartphones
GROUP BY has_nfc;

-- Group smartphones by the brand_name and processor_brand and get the count of models and the avg primary_camera_front_resolution
SELECT brand_name, processor_brand, COUNT(*), AVG(primary_camera_front)
FROM dml.smartphones
GROUP BY brand_name, processor_brand; -- groupby on 2 columns

-- Find top 5 most costly phone brands
SELECT brand_name, MAX(price) AS 'max_price'
FROM dml.smartphones
GROUP BY brand_name
ORDER BY max_price
LIMIT 5;

-- avg price of 5G phones vs avg_price of non-5G phones
SELECT has_5g, AVG(price)
FROM dml.smartphones
GROUP BY has_5g;

-- Find all samsung 5G enabled phones and find out the avg price of those have NFC and those have dont.
SELECT has_nfc, AVG(price)
FROM dml.smartphones
WHERE has_5g = 'True' AND brand_name = 'samsung'
GROUP BY has_nfc;

-- Find the avg price of smartphones which have more than 20 phones
SELECT brand_name, AVG(price) AS avg_price
FROM dml.smartphones
GROUP BY brand_name
HAVING COUNT(*) > 20;

-- Find the top 3 brands with the highest avg refresh rate of atleast 90HZ and fast charging is available and dont consider brands which have less than 10 phones
SELECT brand_name, AVG(refresh_rate) AS avg_refresh_rate 
FROM dml.smartphones
WHERE fast_charging IS NOT NULL -- WHERE fast_charging != NULL (is wrong querry) 
GROUP BY (brand_name)
HAVING avg_refresh_rate >= 90 AND COUNT(*) > 10
ORDER BY avg_refresh_rate
LIMIT 3;