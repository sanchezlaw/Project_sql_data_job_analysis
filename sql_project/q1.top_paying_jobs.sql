/*
I want to know what are the top-paying data analyst jobs
steps:
1. find the job are 'Data Analyst' 
2. remove null value in salary column
3. sort the data by salary to get top 10 salary
*/

SELECT
    job_postings_fact.job_id,
    job_title,
    job_location,
    company_dim.name as company_name,
    job_schedule_type,
    salary_year_avg as salary,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' and 
    salary_year_avg is not NULL
ORDER BY
    salary_year_avg DESC
LIMIT
10





