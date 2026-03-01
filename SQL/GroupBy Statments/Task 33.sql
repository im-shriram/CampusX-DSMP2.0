USE db;
SELECT * FROM db.sleep_efficiency;

-- 1. Find out the average sleep duration of top 15 male candidates who's sleep duration are equal to 7.5 or greater than 7.5.
SELECT *
FROM db.sleep_efficiency
WHERE sleep_efficiency.Gender = 'Male' AND sleep_efficiency.`Sleep duration` >= 7.5
ORDER BY sleep_efficiency.`Sleep duration` DESC
LIMIT 15;

-- 2. Show avg deep sleep time for both gender. Round result at 2 decimal places.
SELECT gender, ROUND(AVG(sleep_efficiency.`Deep sleep percentage`), 2)
FROM sleep_efficiency
GROUP BY Gender;

-- 3. Find out the lowest 10th to 30th light sleep percentage records where deep sleep percentage values are between 25 to 45. Display age, light sleep percentage and deep sleep percentage columns only.
SELECT age, sleep_efficiency.`light sleep percentage`, sleep_efficiency.`deep sleep percentage`
FROM sleep_efficiency
WHERE sleep_efficiency.`deep sleep percentage` BETWEEN 25 AND 45
ORDER BY sleep_efficiency.`light sleep percentage` ASC
LIMIT 10;

-- 4. Group by on exercise frequency and smoking status and show average deep sleep time, average light sleep time and avg rem sleep time.
-- Note the differences in deep sleep time for smoking and non smoking status
SELECT AVG(sleep_efficiency.`light sleep percentage`), AVG(sleep_efficiency.`deep sleep percentage`), AVG(sleep_efficiency.`REM sleep percentage`)
FROM sleep_efficiency
GROUP BY sleep_efficiency.`Exercise frequency`, sleep_efficiency.`Smoking status`;

-- 5. Group By on Awekning and show AVG Caffeine consumption, AVG Deep sleep time and AVG Alcohol consumption only for people who do exercise atleast 3 days a week. Show result in descending order awekenings
SELECT AVG(sleep_efficiency.`Caffeine consumption`), AVG(sleep_efficiency.`deep sleep percentage`), AVG(sleep_efficiency.`Alcohol consumption`)
FROM sleep_efficiency
GROUP BY sleep_efficiency.`Awakenings`;

-- 6. Display those power stations which have average 'Monitored Cap.(MW)' (display the values) between 1000 and 2000 and the number of occurance of the power stations (also display these values) are greater than 200. Also sort the result in ascending order.
SELECT PowerStations.`Power Station`, VG(PowertStations.`Monitored Cap.(MW)`), COUNT(*) AS station_count
FROM PowerStations
GROUP BY PowerStations.`Power Station`
HAVING AVG(PowertStations.`Monitored Cap.(MW)`) BETWEEN 1000 AND 2000
ORDER BY station_count ASC;

-- 7. Display top 10 lowest "value" State names of which the Year either belong to 2013 or 2017 or 2021 and type is 'Public In-State'. Also the number of occurance should be between 6 to 10. Display the average value upto 2 decimal places, state names and the occurance of the states.
SELECT State, COUNT(*), ROUND(AVG(Value), 2) FROM mydatabase.college_expenses
WHERE Year IN (2013, 2017, 2021) AND Type = 'Public In-State'
GROUP BY State
HAVING COUNT(*) BETWEEN 6 AND 10
ORDER BY AVG(Value) ASC
LIMIT 10;

-- 8. Best state in terms of low education cost (Tution Fees) in 'Public' type university.
SELECT State, ROUND(AVG(Value), 2) FROM mydatabase.college_expenses
WHERE Type IN ('Public In-State', 'Public Out-of-State')
GROUP BY State
ORDER BY AVG(Value) ASC
LIMIT 1;

-- 9. 2nd Costliest state for Private education in year 2021. Consider.
SELECT State, ROUND(AVG(Value), 2) FROM mydatabase.college_expenses
WHERE Type LIKE '%Private%' AND Year = 2021
GROUP BY State
ORDER BY AVG(Value) DESC
LIMIT 1, 1;