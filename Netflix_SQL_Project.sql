CREATE DATABASE Netflix;
use Netflix;

-- Retrive Data

SELECT * FROM netflix_data;
SELECT count(*) FROM netflix_data;
SELECT * FROM netflix_data limit 10;

desc netflix_data;
# We chane the datatype and formate of date_added

UPDATE netflix_data
SET date_added = STR_TO_DATE(date_added, '%m/%d/%Y')
WHERE date_added LIKE '%/%/%';

# and then we change the datatype
alter table netflix_data
modify date_added date;

SELECT * FROM netflix_data;

-- 1 What is the Total number of 'Movies'  and 'TV Shows' on Netflix ?

SELECT type,
COUNT(*) AS Total_Counts
FROM netflix_data
GROUP BY type;

-- 2- Which Country has produced the most content (Movie and TV Show) on Netflix? List the top -5 countries?

SELECT country Type, 
COUNT(*) AS Total_Content
FROM netflix_data
GROUP BY country
ORDER BY Total_Content DESC LIMIT 5;

-- 3- Retrieve a list of all movies and TV Show released in the year 2020?
SELECT
 count(*) as Total_content
FROM netflix_data

WHERE release_year = '2020' LIMIT 10;

-- 4. What are the titles of all movies directed by 'Kirsten Johnson'?
SELECT  title FROM netflix_data
WHERE type= 'Movie' and  director= 'Kirsten Johnson';

-- 5. Which content rating is the most common on Netflix? (Count of titles by rating).
SELECT 
rating,
COUNT(*) AS Total_Titles
FROM netflix_data
GROUP BY rating
ORDER BY Total_Titles DESC;

-- 6. Find the list of all 'TV Shows' that have 5 or more seasons.
SELECT title, type, duration
FROM netflix_data
WHERE type = 'TV Show' AND duration> 5;

-- 7. List all the movies produced in 'India' that belong to the 'Comedies' category.
SELECT title, listed_in
FROM netflix_data
WHERE type = 'Movie' AND
	country = 'India' AND 
	listed_in LIKE '%Comedies%';

-- 8. How many new shows/movies were released each year? Sort the results in descending order of the release year.
SELECT release_year,
COUNT(*) AS Total_Release
FROM netflix_data
GROUP BY release_year
ORDER BY release_year DESC LIMIT 10;

-- 9 Who are the top 5 directors with the highest number of directed movies (excluding 'Not Given')?
SELECT director , COUNT(*) AS Total_Movies FROM netflix_data
WHERE type = 'Movie' AND director != ''
GROUP BY director
ORDER BY Total_Movies DESC LIMIT 5;

-- 10. In which year did Netflix add the highest amount of content to its platform?
SELECT DATE_FORMAT(date_added, '%Y') AS Year, 
COUNT(*) AS Total_Content
FROM netflix_data
GROUP BY Year
ORDER BY total_content DESC LIMIT 1;

-- 11. Which are the 5 oldest movies released in India on Netflix?
SELECT title,release_year
FROM netflix_data
WHERE country = 'India' AND type= 'Movie' 
ORDER BY release_year ASC LIMIT 5;
-- 12 Find the titles of all movies listed as 'Documentaries' that were released after the year 2015.
SELECT title, release_year, listed_in
FROM netflix_data
WHERE type = 'Movie' AND
	  release_year =2015 AND 
      listed_in LIKE '%Documentaries%';

-- 13 Which movie has the longest duration in minutes on Netflix?
SELECT title,  
CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS Duration_Minutes
FROM netflix_data
WHERE type = 'Movie'
ORDER BY Duration_Minutes DESC LIMIT 1;

-- 14. What is the most recently released movie for each country?

WITH Rnks AS (
SELECT country, title, release_year,
ROW_NUMBER() OVER(PARTITION BY country ORDER BY release_year desc) AS rnk
FROM netflix_data
WHERE type = 'Movie' and country != ''
)
SELECT country, title as Latest_Movie, release_year from Rnks
where rnk = 1;

-- 15. Identify the release years in which more than 50 movies from India were released.
SELECT release_year AS Release_Year, COUNT(*) AS Total_Movies
FROM netflix_data
WHERE country = 'India' AND type = 'Movie'
GROUP BY release_year
HAVING COUNT(*)>=50
ORDER BY release_year DESC;


        

        


SELECT * FROM netflix_data;



