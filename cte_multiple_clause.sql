#1
WITH cte1 AS (
SELECT AVG(salary) AS avg_salary FROM salaries
),
cte2 AS (
SELECT s.emp_no, MAX(s.salary) AS max_salary
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
GROUP BY s.emp_no
)
SELECT
SUM(CASE WHEN c2.max_salary < c1.avg_salary THEN 1 ELSE 0 END) AS highest_salaries_below_avg
FROM employees e
JOIN cte2 c2 ON c2.emp_no = e.emp_no
JOIN cte1 c1;

#2
WITH cte_avg_salary AS (
SELECT AVG(salary) AS avg_salary FROM salaries
),
cte_m_highest_salary AS (
SELECT s.emp_no, MAX(s.salary) AS max_salary
FROM salaries s JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
GROUP BY s.emp_no
)
SELECT
COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS max_salary
FROM employees e
JOIN cte_m_highest_salary c2 ON c2.emp_no = e.emp_no
JOIN cte_avg_salary c1;

#3
WITH cte_avg_salary AS (
SELECT AVG(salary) AS avg_salary FROM salaries
),
cte_m_highest_salary AS (
SELECT s.emp_no, MAX(s.salary) AS max_salary
FROM salaries s JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
GROUP BY s.emp_no
)
SELECT
COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS max_salary
FROM cte_m_highest_salary c2
JOIN cte_avg_salary c1;