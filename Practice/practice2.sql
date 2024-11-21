SELECT
    job_schedule_type,
    avg(salary_year_avg) as year_avg,
    avg(salary_hour_avg) as hour_avg
FROM
    job_postings_fact
where 
    job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type;

SELECT
    count(job_id) as job_count,
    EXTRACT(month from job_posted_date at time zone 'UTC' at time zone 'America/New_York') as month
FROM
    job_postings_fact
GROUP BY
    month;

SELECT
    EXTRACT(quarter from job_posted_date) as quarter,
    dim.name
from
    job_postings_fact as fact
left join company_dim as dim on dim.company_id = fact.company_id
WHERE
    EXTRACT(quarter from job_posted_date) = 2 and fact.job_health_insurance = true;




    
