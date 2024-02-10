SELECT *
FROM data_analyst_jobs;

--1. How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
FROM data_analyst_jobs;
--answer: 1793

--2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;
--answer: "ExxonMobil"

--3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location ='TN';

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location IN ('TN', 'KY');

--answer: 21 in TN, 27 in TN/KY

--4. How many postings in Tennessee have a star rating above 4?

SELECT star_rating, location
FROM data_analyst_jobs
WHERE star_rating >4
AND location = 'TN';
--answer: 3 postings

--5. How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(review_count)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
--answer: 151

--6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY state
ORDER BY avg_rating DESC;
--answer: NE has highest avg rating

--7. Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs;
--answer: 881

--8. How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT(title)) AS unique_job_titles, location 
FROM data_analyst_jobs
WHERE location IN ('CA')
GROUP BY location;
--answer: 230

--9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT DISTINCT(company), AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY DISTINCT(company), review_count
HAVING review_count > 5000
AND company IS NOT NULL
ORDER BY avg_rating;
--answer: 40 companies 

--10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT DISTINCT(company), AVG(star_rating) 
FROM data_analyst_jobs
GROUP BY DISTINCT(company), review_count
HAVING review_count > 5000
ORDER BY AVG(star_rating) DESC;
--answer: "American Express", "General Motors", "Kaiser Permanente", "Microsoft", "Nike", "Unilever", 4.1999998090000000

--11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE title iLIKE '%Analyst%';

SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE title iLIKE '%Analyst%';
--answer: 774

--12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
--hard way:
SELECT title
FROM data_analyst_jobs
WHERE (title NOT LIKE '%Analyst%') AND (title NOT LIKE '%Analytics%') AND (title NOT LIKE '%ANALYST%') AND (title NOT LIKE '%analyst%') AND (title NOT LIKE '%ANALYTICS%') AND (title NOT LIKE '%analytics%');

--easy way:
SELECT title
FROM data_analyst_jobs
WHERE (title NOT ILIKE '%Analyst%') AND (title NOT ILIKE '%Analytics%');
-- answer: 4, Tableau

--BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
--Disregard any postings where the domain is NULL.
--Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
--Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT domain, COUNT(title)
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
AND days_since_posting > 21
AND domain IS NOT NULL
GROUP BY domain
ORDER BY COUNT(title) DESC;

--answer: 
--"Internet and Software" 62
--Banks & Financial Services - 61 jobs
--Consulting and Business Services - 57 jobs
