/*
Optimal skills to learn for data analyst
step:
1.combine the query in q1 and q2
2. focus on all data analyst job 
*/

with skill_demand as(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as demand_count
    FROM
        job_postings_fact
    INNER JOIN 
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        salary_year_avg is not NULL 
    GROUP BY
        skills_dim.skill_id
),
average_salary_table as(
    SELECT
        skills_dim.skill_id,
        round(avg(salary_year_avg), 0) as average_salary
    FROM
        job_postings_fact
    INNER JOIN 
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg is not NULL
    GROUP BY
        skills_dim.skill_id
)

SELECT
    skill_demand.skill_id,
    skill_demand.skills,
    demand_count,
    average_salary
FROM
    skill_demand 
INNER JOIN 
    average_salary_table on skill_demand.skill_id = average_salary_table.skill_id
WHERE
    demand_count >100
ORDER BY
    average_salary DESC   
