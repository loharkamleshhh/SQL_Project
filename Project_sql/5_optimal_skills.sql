"""
    Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
    - Identify skills in high demand and associated with high average salaries for Data Analyst roles
    - Focus on remote positions with specified salaries
    Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis
"""
with skills_demand As(
SELECT
      skills_dim.SKILL_ID,
      skills_dim.skills,
      COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
      INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
      INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      ANd job_work_from_home = True
GROUP BY
      skills_dim.SKILL_ID
),  AVERAGE_SALARY AS (
SELECT
      skills_dim.SKILL_ID,
      skills_dim.skills,
      round(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
      INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
      INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND job_work_from_home = True
GROUP BY
      skills_dim.SKILL_ID
      )

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
where demand_count > 10
order by avg_salary DESC,
         demand_count DESC
         
limit 25