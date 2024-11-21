SELECT
    count(job_id) as Jobs,
    CASE
        WHEN salary_year_avg < 50000 then 'low'
        WHEN salary_year_avg BETWEEN 50001 and 80000 then 'median'
        ELSE 'high'
    END as condition
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    condition 
ORDER BY
    Jobs DESC
