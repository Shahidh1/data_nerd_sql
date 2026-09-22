/*
Find the count  of the number of remote job posting per skills
    -Display top 5 skills by thier demand in remote jobs
    -Include skill ID, name and count of posting requiring skills
*\
WITH remote_job_skills AS   (
    SELECT 
        skills_to_job.skill_id,
        count(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN
        job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = True AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skills_to_job.skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM
    remote_job_skills
INNER JOIN
    skills_dim AS skills ON remote_job_skills.skill_id = skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;



SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date :: DATE,
    salary_year_avg
FROM (

SELECT *
FROM january_job
UNION ALL
SELECT *
FROM february_job
UNION ALL
SELECT *
FROM march_job
) AS quater1_job_postings
WHERE
    quater1_job_postings.salary_year_avg > 70000 AND
    quater1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quater1_job_postings.salary_year_avg DESC