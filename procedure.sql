delimiter $$
	create procedure v_avg_salary_emp()
begin 
	select ROUND(AVG(salary), 2) from salaries s
	join 
    employees e on e.emp_no = s.emp_no;
end$$
delimiter ;

call v_avg_salary_emp();

delimiter $$ 
create procedure emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
begin
	select emp_no
    into p_emp_no
    from employees e
    where p_first_name = first_name and p_last_name = last_name;
end$$
delimiter ;
    
#variable
SET @v_emp_no = 0;
CALL emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;