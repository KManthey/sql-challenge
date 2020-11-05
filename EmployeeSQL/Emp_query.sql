-- 1. List employee details (item 1) --- need to save as view
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM salaries AS s
INNER JOIN employees AS e
ON e.emp_no = s.emp_no
ORDER BY emp_no;

-- 2. List first, last, hire date for employees hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date DESC;

-- 3. List manager for each dept with deptnum, deptname, mgr emp#, last, first
-- This gives me all but dept name
SELECT e.emp_no, e.first_name, e.last_name, mgr.dept_no
FROM dept_manager AS mgr
INNER JOIN employees AS e
ON e.emp_no = mgr.emp_no
ORDER BY emp_no;

-- Add department name by joining with departments - result provides the same # of results
SELECT e.emp_no, e.last_name, e.first_name, mgr.dept_no, d.dept_name
FROM dept_manager AS mgr
	INNER JOIN departments AS d
	ON mgr.dept_no = d.dept_no
	INNER JOIN employees AS e
	ON e.emp_no = mgr.emp_no
	ORDER BY emp_no;

-- 4. List dept for each employee with emp#, last, first, dept name -- results approx 33k rows
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
	INNER JOIN departments AS d
	ON de.dept_no = d.dept_no
	INNER JOIN employees AS e
	ON e.emp_no = de.emp_no
	ORDER BY emp_no;

-- 5. List first, last, sex, for emp with first 'Hercules' last begin wth B
SELECT first_name, last_name, sex
FROM employees AS e
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B_%';

-- 6. List employees with sales dept, including their emp#, last, first, dept name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
	INNER JOIN departments AS d
	ON de.dept_no = d.dept_no
	INNER JOIN employees AS e
	ON e.emp_no = de.emp_no
	WHERE d.dept_name = 'Sales'
	ORDER BY emp_no;

-- 7. List all employees in the Sales and Development depts with emp#, last, first, dept name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
	INNER JOIN departments AS d
	ON de.dept_no = d.dept_no
	INNER JOIN employees AS e
	ON e.emp_no = de.emp_no
	WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- 8. Desc order list frequency count of employee last name, -how many employees share each last name
-- Group By last name then count the number of occurances in DESC order
SELECT last_name,
	COUNT (*) occurances
FROM employees
GROUP BY last_name
HAVING
	COUNT(*)>=1
ORDER BY
	last_name DESC;

