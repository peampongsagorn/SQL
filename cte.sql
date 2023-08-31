#1
WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg,
COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;

#2
WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;

#3
SELECT
    SUM(CASE
        WHEN s.salary < a.avg_salary THEN 1
        ELSE 0
    END) AS no_salaries_below_avg,
    COUNT(s.salary) AS no_of_salary_contracts
FROM
    (SELECT
        AVG(salary) AS avg_salary
    FROM
        salaries s) a
        JOIN
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'M';

#4
WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg_w_sum,
# COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' CROSS JOIN cte c;