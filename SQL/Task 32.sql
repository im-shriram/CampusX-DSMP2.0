-- Show records of 'male' patient from 'southwest' region.
SELECT *
FROM Patients
WHERE gender = 'male' AND region = 'southwest';

-- Show all records having bmi in range 30 to 45 both inclusive.
SELECT *
FROM Patients
WHERE bmi BETWEEN 30 AND 45;

-- Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.
SELECT MIN(bloodpressure) AS MinBP, MAX(bloodpressure) AS MaxBP
FROM Patients
WHERE diabetic = TRUE AND smoker = TRUE;

-- Find no of unique patients who are not from southwest region.
SELECT COUNT(DISTINCT PatientID)
FROM Patients
WHERE region != 'southwest';

-- Total claim amount from male smoker.
SELECT SUM(claim)
FROM Patients
WHERE gender = 'male' AND smoker = TRUE;

-- Select all records of south region.
SELECT *
FROM Patients
WHERE region = 'south';

-- No of patient having normal blood pressure. Normal range[90-120]
SELECT COUNT(PatientID)
FROM Patients
WHERE bloodpressure BETWEEN 90 AND 120;

-- No of patient below 17 years of age having normal blood pressure as per below formula -
-- BP normal range = 80+(age in years × 2) to 100 + (age in years × 2)
-- Note: Formula taken just for practice, don't take in real sense.
SELECT COUNT(PatientID)
FROM Patients
WHERE age < 17
AND bloodpressure BETWEEN (80 + (age * 2)) AND (100 + (age * 2));

-- What is the average claim amount for non-smoking female patients who are diabetic?
SELECT AVG(claim)
FROM Patients
WHERE gender = 'female' AND diabetic = TRUE AND smoker = FALSE;

-- Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
UPDATE Patients
SET claim = 5000
WHERE PatientID = 1234;

-- Write a SQL query to delete all records for patients who are smokers and have no children.
DELETE FROM Patients
WHERE smoker = TRUE AND children = 0;