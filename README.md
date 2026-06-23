# Introduction
📊Dive into the data job market! Focusing on data analyst roles, this project explores top-paying
jobs, in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/Project_sql/)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from my [SQL Course](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# the Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```SQL
SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name AS company_name
FROM
        job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
        job_title_short = 'Data Analyst' AND
        job_location= 'Anywhere' AND
        salary_year_avg IS NOT NULL
ORDER BY
        salary_year_avg DESC
LIMIT 10
```

Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data
analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
**Diverse Employers:** Companies like
SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity
in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```
WITH top_paying_jobs AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here's the breakdown of the skills required for the top-paying Data Analyst jobs in 2023:

- **SQL and Python Dominate:** These were the most frequently requested skills across high-paying roles, making them essential tools for Data Analysts.
- **Visualization and Reporting Tools:** Tableau, Power BI, Excel, and PowerPoint appeared regularly, highlighting the importance of presenting insights effectively.
- **Cloud and Data Platforms:** Technologies such as AWS, Azure, Snowflake, Databricks, and PySpark were commonly required, showing the growing demand for cloud-based analytics skills.

### 3. In-Demand Skills for Data Analyst
To identify the most in-demand skills for Data Analyst roles, I analyzed all available job postings and joined the job dataset with the skills tables. This allowed me to count how frequently each skill appears across job listings. The goal was to find the top 5 skills that are most commonly required in the job market for Data Analysts.

```
SELECT
      skills,
      COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
      INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
      INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst'
GROUP BY
      skills
ORDER BY
      demand_count DESC
LIMIT 5
```

Here’s the breakdown of the most in-demand skills for Data Analyst roles:

- **SQL Leads the Market:** SQL is the most frequently required skill, making it essential for querying and managing data in almost every data analyst role.
- **Excel is Still Highly Relevant:** Despite modern tools, Excel remains heavily used for quick analysis, reporting, and data handling tasks.
- **Python is a Core Technical Skill:** Python is widely demanded for data analysis, automation, and working with large datasets.
- **Tableau for Visualization:** Tableau is commonly required for building dashboards and visual storytelling in business environments.
- **Power BI is Strong in Business Reporting:** Power BI is frequently used in organizations for interactive reporting and business intelligence solutions.

Table of the demand for the top 5 skills in Data Analyst job postings:

| Skills   | Demand Count |
|----------|-------------:|
| SQL      | 7291 |
| Excel    | 4611 |
| Python   | 4330 |
| Tableau  | 3745 |
| Power BI | 2609 |

### 4. Skills Based on Salary

To identify the highest-paying skills for Data Analysts, I analyzed job postings with specified salary information and calculated the average salary associated with each skill. The analysis focuses on remote Data Analyst roles and highlights the technologies that offer the greatest earning potential.

```SQL
SELECT
      skills,
      ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
      INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
      INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND job_work_from_home = TRUE
GROUP BY
      skills
ORDER BY
      avg_salary DESC
LIMIT 25
```

Table of the top-paying skills for Data Analyst job postings:

| Skills | Average Salary ($) |
|---------|------------------:|
| PySpark | 208,172 |
| Bitbucket | 189,155 |
| Couchbase | 160,515 |
| Watson | 160,515 |
| DataRobot | 155,486 |
| GitLab | 154,500 |
| Swift | 153,750 |
| Jupyter | 152,777 |
| Pandas | 151,821 |
| Elasticsearch | 145,000 |
| Golang | 145,000 |
| NumPy | 143,513 |
| Databricks | 141,907 |
| Linux | 136,508 |
| Kubernetes | 132,500 |
| Atlassian | 131,162 |
| Twilio | 127,000 |
| Airflow | 126,103 |
| Scikit-learn | 125,781 |
| Jenkins | 125,436 |
| Notion | 125,000 |
| Scala | 124,903 |
| PostgreSQL | 123,879 |
| GCP | 122,500 |
| MicroStrategy | 121,619 |

Here's the breakdown of the highest-paying skills for Data Analyst roles:

- **Big Data Skills Lead Salaries:** PySpark and Databricks offer the highest average salaries, showing the value of large-scale data processing skills.

- **Data Science Tools Pay Well:** Pandas, NumPy, Scikit-learn, and Jupyter are strongly associated with higher-paying analytics roles.

- **Cloud and Infrastructure Skills Increase Earnings:** GCP, Kubernetes, Linux, and Elasticsearch demonstrate the growing importance of cloud and platform knowledge.

- **Specialized Technologies Command Premium Salaries:** DataRobot, Couchbase, and Watson appear among the highest-paying skills due to their specialized applications.

- **Development and Automation Skills Add Value:** GitLab, Bitbucket, and Jenkins highlight the benefits of version control and workflow automation expertise.

### 5. Most Optimal Skills to Learn

To identify the most optimal skills for Data Analysts, I combined skill demand and average salary data. First, I calculated how frequently each skill appeared in remote Data Analyst job postings with specified salaries. Then, I calculated the average salary associated with each skill and joined both results together. This analysis highlights skills that offer both strong market demand and high earning potential.

```SQL
WITH skills_demand AS (
SELECT
      skills_dim.skill_id,
      skills_dim.skills,
      COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
      INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
      INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND job_work_from_home = TRUE
GROUP BY
      skills_dim.skill_id
),
average_salary AS (
SELECT
      skills_dim.skill_id,
      skills_dim.skills,
      ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
      INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
      INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND job_work_from_home = TRUE
GROUP BY
      skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

Table of the most optimal skills for Data Analyst job postings:

| Skill | Demand Count | Average Salary ($) |
|---------|------------:|------------------:|
| Go | 27 | 115,320 |
| Confluence | 11 | 114,210 |
| Hadoop | 22 | 113,193 |
| Snowflake | 37 | 112,948 |
| Azure | 34 | 111,225 |
| BigQuery | 13 | 109,654 |
| AWS | 32 | 108,317 |
| Java | 17 | 106,906 |
| SSIS | 12 | 106,683 |
| Jira | 20 | 104,918 |
| Oracle | 37 | 104,534 |
| Looker | 49 | 103,795 |
| NoSQL | 13 | 101,414 |
| Python | 236 | 101,397 |
| R | 148 | 100,499 |
| Redshift | 16 | 99,936 |
| Qlik | 13 | 99,631 |
| Tableau | 230 | 99,288 |
| SSRS | 14 | 99,171 |
| Spark | 13 | 99,077 |
| C++ | 11 | 98,958 |
| SAS | 63 | 98,902 |
| SQL Server | 35 | 97,786 |
| JavaScript | 20 | 97,587 |

Here's the breakdown of the most optimal skills for Data Analyst roles:

- **Python and Tableau Offer the Best Balance:** Both skills have exceptionally high demand while maintaining strong average salaries, making them valuable investments for aspiring Data Analysts.

- **Cloud Technologies Are Highly Rewarded:** Snowflake, Azure, AWS, and BigQuery combine competitive salaries with growing demand, reflecting the industry's shift toward cloud-based analytics.

- **Data Engineering Skills Increase Earning Potential:** Hadoop, Spark, and Redshift command high salaries because organizations increasingly rely on large-scale data processing solutions.

- **Business Intelligence Tools Remain Valuable:** Looker, Tableau, Qlik, and SSRS continue to be sought after for reporting, dashboarding, and decision-making purposes.

- **Specialized Technical Skills Create Opportunities:** Skills such as Go, Java, NoSQL, and SQL Server provide strong salary potential while helping analysts expand into more technical and engineering-focused roles.

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG () into my data-summarizing sidekicks.
- **💡Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# conclusions
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. ***Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics