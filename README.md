# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [sql_project folder](/sql_project)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

### The questions I want to know from the data:

1. What are the top-paying data analyst jobs?
2. Why such jobs have top-paying?
3. What are the most in-demand skills for data anaylst?
4. Which skills with higer salary?
5. What are the optimal skills to learn for data analyst?

# Tool I Used
- SQL
- PostgreSQL
- Visual Studio Code
- Git & GitHub

# The Analysis
Each query for this project is to look for different aspect of data analyst

### Here are the question:
### 1. What are the top-paying data analyst jobs?
Steps:
1. Find the job are 'Data Analyst' 
2. Remove null value in salary column
3. Sort the data by salary to get top 10 salary

```sql
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
LEFT JOIN 
    company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' and 
    salary_year_avg is not NULL
ORDER BY
    salary_year_avg DESC
LIMIT
10;
```

### 2. Why such jobs have top-paying
Steps
1. Using the data from q1
2. Find the specific skills required for these job
3. Find the most required skills in these job
```sql
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
    skill_count DESC;
```
### Most Common Skills:
1. Python: 4 occurrences
2. SQL: 3 occurrences
3. Excel: 3 occurrences
4. Tableau: 3 occurrences
5. R: 3 occurrences


### 3. What are the most in-demand skills for data anaylst?
Steps:
1. Joining all table
2. Indentify the top 10 skills for data analyst
3. See the different of skills required between work from home and work in office

```sql
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
    10;
```
### These are most in-damand skills for data analyst
#### Top 7 skills in both work from home and remote job are
1. sql
2. excel
3. python
4. tableau
5. power bi
6. r
7. sas

#### Different skills for work from home are
8. looker
9. azure
10. powerpoint

#### Different skills for remote job are
8. powerpoint
9. word
10. sep

### 4. Which skills with higer salary?
Steps:
1.  Find the avarage salary for data analyst
2.  Sort the skills by salary

```sql
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
```
### Top skills for data analyst:
svn, solidity, couchbase, datarobot, etc
- Most of these skills are for big data and machine learning skills,
- Some of them are related to software development
- These are the skills that make you more comptetive

### 5. What are the optimal skills to learn for data analyst?
Step:
1. Combine the query in q1 and q2
2. Focus on all data analyst job 

```sql
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
    average_salary DESC;  
```

# Conclusion
### Insights
From the analysis, several general insights emerged:

1. Top-Paying Data Analyst Jobs: The highest-paying jobs for data analysts offer a wide range of salaries, the highest at $650,000!
2. Skills for Top-Paying Jobs: High-paying data analyst jobs require advanced proficiency in SQL, Python, excel and tableau. It’s a required skill for earning a top salary.
3. Most In-Demand Skills: SQL is also the most demanded skill in the both remote and office data analyst job as well as the other top 6 skills, thus making it essential for job seekers. 
4. Skills with Higher Salaries: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. Optimal Skills for Data Analyst: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.