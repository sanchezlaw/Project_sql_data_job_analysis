CREATE TABLE job_applied(
    job_id INT,
    application_sent_date date,
    ciustom_resume boolean,
    resume_file_name varchar(225),
    cover_letter_sent boolean,
    cover_letter_file_name varchar(225),
    status varchar(50)
);
INSERT into job_applied(
    job_id,
    application_sent_date,
    ciustom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
)
values (1, '2024-02-01', true, 'resume_01.pdf', true, 'cover_letter_01.pdf', 'submitted'),
    (2, '2024-02-02', False, 'resume_02.pdf', False, 'cover_letter_02.pdf', null),
    (3, '2024-02-03', true, 'resume_03.pdf', False, 'cover_letter_03.pdf', 'submitted'),
    (4, '2024-02-04', False, 'resume_04.pdf', true, 'cover_letter_04.pdf', 'submitted'),
    (5, '2024-02-05', true, 'resume_05.pdf', true, 'cover_letter_05.pdf', null);

ALTER TABLE job_applied
add contact varchar(50);

UPDATE job_applied
set contact = 'Samson'
WHERE job_id = 1;

UPDATE job_applied
set contact = 'Kelly'
WHERE job_id = 2;

UPDATE job_applied
set contact = 'Jason'
WHERE job_id = 3;

UPDATE job_applied
set contact = 'May'
WHERE job_id = 4;

UPDATE job_applied
set contact = 'Dennis'
WHERE job_id = 5;

ALTER TABLE job_applied
rename column contact to contact_name;

ALTER TABLE job_applied
ALTER column contact_name type text;

ALTER TABLE job_applied
drop column contact_name;

drop TABLE job_applied;


