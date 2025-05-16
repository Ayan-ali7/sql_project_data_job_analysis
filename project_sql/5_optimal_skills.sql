/* Question 5: what are the most optimal skills to learn? */

with skills_demand AS (
select
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
from 
    job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short='Data Analyst'
    and salary_year_avg is not null
    and job_work_from_home = True
group by 
    skills_dim.skill_id
), 
average_salary AS (
select 
    skills_dim.skill_id,
    skills_dim.skills,
    round(avg(salary_year_avg),0) as average_salary
from 
    job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short='Data Analyst'
    and salary_year_avg is not null
    and job_work_from_home = True
group by 
    skills_dim.skill_id
)

select
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
from
    skills_demand 
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
where 
    demand_count > 10
order by 
    average_salary desc,
    demand_count desc
limit 25

-- rewriting query more concisely

select 
    skills_dim.skill_id,       skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count,
    round(avg(salary_year_avg),0) as average_salary
from
    job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id   
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id  
where 
    job_title_short='Data Analyst'
    and salary_year_avg is not null
    and job_work_from_home = True
group by 
    skills_dim.skill_id
having count(skills_job_dim.job_id) > 10
order by 
    average_salary desc,
    demand_count desc
limit 25;

