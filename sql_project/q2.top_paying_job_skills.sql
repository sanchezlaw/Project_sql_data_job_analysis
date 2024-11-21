/*
I want to know why such jobs have top-paying job
steps
1. using the data from q1
2. find the specific skills required for these job
3. find the most required skills in these job
*/

With top_paying_jobs as (
    SELECT
        job_id,
        job_title,
        job_location,
        company_dim.name as company_name,
        job_schedule_type,
        salary_year_avg as salary,
        job_posted_date
    FROM
        job_postings_fact
    LEFT JOIN 
        company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' and 
        salary_year_avg is not NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
    10
),
temp as(
    SELECT
        top_paying_jobs.*,
        skills_dim.skill_id,
        skills_dim.skills
    FROM
        top_paying_jobs
    INNER JOIN 
        skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    ORDER BY
        salary DESC
)

SELECT
    skills,
    count(skill_id) as skill_count
From 
    temp
group by 
    skills
ORDER BY
    skill_count DESC

/*
Most Common Skills:
Python: 4 occurrences
SQL: 3 occurrences
Excel: 3 occurrences
Tableau: 3 occurrences
R: 3 occurrences
*/
