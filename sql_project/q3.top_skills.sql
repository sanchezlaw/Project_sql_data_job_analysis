/*
I want to know the most in-demand skills for data anaylst
steps:
1. joining all table
2. indentify the top 10 skills for data analyst
3. see the different of skills required between work from home and work in office
*/

SELECT
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' and job_work_from_home = 'True'
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT
    10;

SELECT
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' and job_work_from_home = 'False'
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT
    10

/*
Top 7 skills in both work from home and remote job are
1.sql
2.excel
3.python
4.tableau
5.power bi
6.r
7.sas

Different skills for work from home are
8.looker
9.azure
10.powerpoint

Different skills for remote job are
8.powerpoint
9.word
10.sep

There are most in-damand skills for data analyst
*/
