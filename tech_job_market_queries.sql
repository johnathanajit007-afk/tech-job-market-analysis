-- ============================================================
-- TECH JOB MARKET SKILL DEMAND & SALARY BENCHMARK ANALYSIS
-- SQL File: tech_job_market_queries.sql
-- ============================================================

-- 1. Create and select the database dynamically
CREATE DATABASE IF NOT EXISTS tech_job_market_db;
USE tech_job_market_db;

-- 2. Clean up existing table if it exists and create the schema
DROP TABLE IF EXISTS tech_job_postings;

CREATE TABLE tech_job_postings (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(100),
    experience_level VARCHAR(50),
    work_mode VARCHAR(50),
    primary_skill VARCHAR(50),
    salary_usd INT
);

-- Note: Once your CSV data is imported into this table, the queries below will execute successfully.


-- ============================================================
-- ANALYTICAL QUERIES
-- ============================================================

-- 1. Top 10 Most In-Demand Technical Skills & Average Pay
SELECT 
    primary_skill,
    COUNT(job_id) AS total_job_postings,
    ROUND(AVG(salary_usd), 2) AS avg_salary_usd
FROM tech_job_postings
GROUP BY primary_skill
ORDER BY total_job_postings DESC
LIMIT 10;


-- 2. Salary Benchmarks across Roles and Experience Levels
SELECT 
    job_title,
    experience_level,
    COUNT(job_id) AS total_jobs,
    ROUND(AVG(salary_usd), 2) AS avg_salary_usd,
    MIN(salary_usd) AS min_salary_usd,
    MAX(salary_usd) AS max_salary_usd
FROM tech_job_postings
GROUP BY job_title, experience_level
ORDER BY job_title, experience_level;


-- 3. Highest Paying Primary Skills (Filter: Min 10 Postings)
SELECT 
    primary_skill,
    COUNT(job_id) AS demand_count,
    ROUND(AVG(salary_usd), 2) AS avg_compensation_usd
FROM tech_job_postings
GROUP BY primary_skill
HAVING COUNT(job_id) >= 10
ORDER BY avg_compensation_usd DESC;


-- 4. Remote vs. Hybrid vs. On-Site Work Mode Analysis
SELECT 
    work_mode,
    COUNT(job_id) AS total_postings,
    ROUND(AVG(salary_usd), 2) AS avg_salary_usd
FROM tech_job_postings
GROUP BY work_mode
ORDER BY avg_salary_usd DESC;