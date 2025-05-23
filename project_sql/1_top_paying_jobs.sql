/* question 1: what are the top paying jobs for Data Analysts?
*/

select 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
from 
    job_postings_fact
left join
    company_dim on job_postings_fact.company_id = company_dim.company_id
where 
    job_title_short = 'Data Analyst'
    and job_location = 'Anywhere'
    and salary_year_avg is not NULL
order by 
    salary_year_avg DESC
limit 10 