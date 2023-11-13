USE project3;

select * from job_data;

#Jobs Reviewed Over Time:
/*Objective: Calculate the number of jobs reviewed per hour for each day in November 2020.
Your Task: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.*/
SELECT 
    COUNT(DISTINCT job_id) / 24 * 30 AS jobs_per_hour_per_day
FROM
    job_data
WHERE
    ds BETWEEN '2020-11-01' AND '2020-11-30';

#Throughput Analysis
/*Objective: Calculate the 7-day rolling average of throughput (number of events per second).
Your Task: Write an SQL query to calculate the 7-day rolling average of throughput. 
Additionally, explain whether you prefer using the daily metric or the 7-day rolling average for throughput, and why.*/

SELECT ds, 
       jobs_count,
       AVG(jobs_count) OVER(ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as rolling_avg_throughput
FROM
(
SELECT 
    ds, COUNT(DISTINCT job_id) AS jobs_count
FROM
    job_data
WHERE
    ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY ds
) temp;

#Language Share Analysis
/*Objective: Calculate the percentage share of each language in the last 30 days.
Your Task: Write an SQL query to calculate the percentage share of each language over the last 30 days.*/

SELECT 
    language,
    ROUND((COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    job_data)) * 100,
            1) AS percentage_share
FROM
    job_data
WHERE
    ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY language;

#Duplicate Rows Detection
/*Objective: Identify duplicate rows in the data.
Your Task: Write an SQL query to display duplicate rows from the job_data table.*/

SELECT * 
FROM
(
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY job_id, actor_id, event, language, time_spent, org, ds) AS row_num
FROM job_data
) temp
WHERE row_num > 1;




