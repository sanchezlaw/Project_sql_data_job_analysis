with skill_count as (
    SELECT skill_id, count(skill_id) as total_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY total_count DESC
)

SELECT 
    skills,
    skill_count.total_count
FROM skills_dim
LEFT JOIN skill_count on skills_dim.skill_id =  skill_count.skill_id
ORDER BY
    skill_count.total_count DESC

