/*
Top skills base on salary
steps:
1.find the avarage salary for data analyst
2.sort the skills by salary
*/

SELECT
    skills_dim.skills,
    round(avg(salary_year_avg), 0) as average_salary
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg is not NULL
GROUP BY
    skills_dim.skills
ORDER BY
    average_salary DESC;

/*
svn, solidity, couchbase, datarobot, etc are the top skills for data analyst
most of these skills are for big data and machine learning skills,
some of them are related to software development
These are the skills that make you more comptetive
*/
