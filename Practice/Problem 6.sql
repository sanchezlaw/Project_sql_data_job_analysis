CREATE table january_jobs as(
    SELECT*
    FROM job_postings_fact
    WHERE 
        EXTRACT(month from job_posted_date) = 1
    );

CREATE table February_jobs as(
    SELECT*
    FROM job_postings_fact
    WHERE 
        EXTRACT(month from job_posted_date) = 2
    );

CREATE table March_jobs as(
    SELECT*
    FROM job_postings_fact
    WHERE 
        EXTRACT(month from job_posted_date) = 3
    );
