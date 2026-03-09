-- 1. Display the names of athletes who won a gold medal in the 2008 Olympics and whose height is greater than the average height of all athletes in the 2008 Olympics.
SELECT * FROM olympics.athletes AS T
WHERE T.medal = 'Gold' AND T.year = 2008 AND T.height > (SELECT AVG(height) FROM olympics.athletes);

-- 2. Display the names of athletes who won a medal in the sport of basketball in the 2016 Olympics and whose weight is less than the average weight of all athletes who won a medal in the 2016 Olympics.
SELECT * FROM olympics.athletes AS T
WHERE T.medal IS NOT NULL AND T.sport = 'Basketball' AND T.year = 2016 AND T.weight < (SELECT AVG(weight) FROM olympics.athletes WHERE year = 2016 AND medal IS NOT NULL);

-- 3. Display the names of all athletes who have won a medal in the sport of swimming in both the 2008 and 2016 Olympics.
SELECT * FROM olympics.athletes
WHERE sport = 'Swimming' AND year IN (SELECT year FROM olympics.athletes WHERE year IN (2008, 2016));

-- 4. Display the names of all countries that have won more than 50 medals in a single year.
SELECT team, year FROM olympics.athletes
WHERE (team, year) IN (
	SELECT team, year AS counter FROM olympics.athletes
	WHERE medal IS NOT NULL
	GROUP BY team, year
	HAVING COUNT(*) > 50
);

-- 5. Display the names of all athletes who have won medals in more than one sport in the same year.
SELECT name, year FROM olympics.athletes
WHERE (name, year) IN (
	SELECT name, year AS counter FROM olympics.athletes
	WHERE medal IS NOT NULL
	GROUP BY name, year
	HAVING COUNT(*) > 1
);

-- 6. What is the average weight difference between male and female athletes in the Olympics who have won a medal in the same event?
WITH T1 AS (
	SELECT event, AVG(weight) AS weight FROM olympics.athletes
	WHERE medal IS NOT NULL AND sex = 'M'
	GROUP BY event
),
T2 AS(
	SELECT event, AVG(weight) AS weight FROM olympics.athletes
	WHERE medal IS NOT NULL AND sex = 'F'
	GROUP BY event
)
SELECT T1.event, T1.weight - T2.weight AS 'weight_difference' FROM T1, T2
WHERE T1.event = T2.event;

-- 7. How many patients have claimed more than the average claim amount for patients who are smokers and have at least one child, and belong to the southeast region?
SELECT * FROM mydatabase.insurance_data
WHERE smoker = 'Yes' AND children > 0 AND region = 'southeast' AND claim > (SELECT AVG(claim) FROM mydatabase.insurance_data);

-- 8. How many patients have claimed more than the average claim amount for patients who are not smokers and have a BMI greater than the average BMI for patients who have at least one child?

-- 9. How many patients have claimed more than the average claim amount for patients who have a BMI greater than the average BMI for patients who are diabetic, have at least one child, and are from the southwest region?


-- 10. What is the difference in the average claim amount between patients who are smokers and patients who are non-smokers, and have the same BMI and number of children?
WITH T1 AS(
	SELECT bmi, children, AVG(claim) AS Claim FROM mydatabase.insurance_data
    WHERE smoker = 'Yes'
    GROUP BY bmi, children
),
T2 AS(
	SELECT bmi, children, AVG(claim) AS Claim FROM mydatabase.insurance_data
    WHERE smoker = 'No'
    GROUP BY bmi, children
)
SELECT T1.bmi, T1.children, T1.Claim - T2.Claim FROM T1, T2
WHERE T1.bmi = T2.bmi AND T1.children = T2.children;