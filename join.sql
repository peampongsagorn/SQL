#leftjoin 'emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’
SELECT 
    em.emp_no,
    em.first_name,
    em.last_name,
    d.dept_no,
    d.from_date
FROM
    employees em
        LEFT JOIN
    dept_manager d ON em.emp_no = d.emp_no
WHERE
    em.last_name = 'Markovitch'
ORDER BY dept_no DESC , emp_no;

#innerjoin
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;

#Old Syntax
SELECT 
    e.emp_no, m.dept_no, e.first_name, e.last_name, e.hire_date
FROM
    employees e,
    dept_manager m
WHERE
    e.emp_no = m.emp_no;

SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch'
ORDER BY e.emp_no;   

#Cross join
SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;

#Select all managers’ first and last name, hire date, job title, start date, and department name.
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;

SELECT 
    e.gender, COUNT(dm.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;

SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
		e.first_name,
		e.last_name,
		NULL AS dept_no,
		NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
		NULL AS first_name,
		NULL AS last_name,
		dm.dept_no,
		dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;