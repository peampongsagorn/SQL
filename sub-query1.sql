#Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');

#Select the entire information for all employees whose job title is “Assistant Engineer”. 
SELECT 
    first_name, last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no and title = 'Assistant Engineer')
ORDER BY first_name ASC;

#assign employee number 110022 as a manager to all employees from 10001 to 10020 and employee number 110039 as a manager to all employees from 10021 to 10040
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS departments_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS managerID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS departments_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS managerID
    FROM
        employees e
    JOIN dept_emp de ON de.emp_no = e.emp_no
    WHERE
        e.emp_no > 110020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;