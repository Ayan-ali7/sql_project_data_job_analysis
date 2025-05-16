/* Question 4: what are the top skills based on salary?
*/

select 
    skills,
    round(avg(salary_year_avg),0) as average_salary
from 
    job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short='Data Analyst'
    and salary_year_avg is not null
group by 
    skills
order by 
    average_salary desc
limit 25
