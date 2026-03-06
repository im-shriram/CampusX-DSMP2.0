-- 178. Rank Scores - https://leetcode.com/problems/rank-scores/description/

-- Solution 1: With Window Function
SELECT score,
DENSE_RANK() OVER(ORDER BY score DESC) AS "rank"
FROM Scores;

--Soution 2 [Brute Force]: Using Joins
SELECT 
   s1.score,   
   COUNT(DISTINCT s2.score) AS "rank" -- COUNT(DISTINCT s2.score) + 1
FROM Scores s1 
LEFT JOIN Scores s2 
ON s1.score <= s2.score -- s1.score < s2.score
GROUP BY s1.id, s1.score  
ORDER BY s1.score DESC;