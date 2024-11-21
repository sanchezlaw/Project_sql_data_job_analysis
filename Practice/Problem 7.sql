with remote_job as (
SELECT
    skill_id,
    count(skill_id) as skill_count
FROM
    skills_job_dim 
INNER JOIN job_postings_fact on job_postings_fact.job_id = skills_job_dim.job_id
WHERE 
    job_postings_fact.job_work_from_home = True and 
    job_title_short = 'Data Analyst'
GROUP BY
    skills_job_dim.skill_id
)

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    remote_job.skill_count
FROM
    remote_job
INNER JOIN skills_dim on remote_job.skill_id = skills_dim.skill_id
ORDER BY remote_job.skill_count DESC
LIMIT 5
