-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/fCyp5F
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
--DROP TABLE "dept_emp"
--DROP TABLE "Employees"
--DROP TABLE "Salaries"
--DROP TABLE "titles"
--DROP TABLE "departments"
--DROP TABLE "dept_manager"

CREATE TABLE "employees" (
    "emp_no" Int NOT NULL,
    "emp_title_id" varchar(10) NOT NULL,
    "birth_date" date NOT NULL,
    "first_name" varchar(40) NOT NULL,
    "last_name" varchar(40) NOT NULL,
    "sex" varchar(5) NOT NULL,
    "hire_date" date NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" Int NOT NULL,
    "salary" Int NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" varchar(10) NOT NULL,
    "title" varchar(40) NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "departments" (
    "dept_no" varchar(10) NOT NULL,
    "dept_name" varchar(40) NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" Int NOT NULL,
    "dept_no" varchar(10) NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no", "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(10) NOT NULL,
    "emp_no" Int NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no", "emp_no"
     )
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Salaries" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

--Select * FROM titles
--Select * From dept_emp
--Select * FROM dept_manager
--Select * FROM departments
--Select * FROM Employees
--SELECT * FROM Salaries

-- Count to verify same ratio
--SELECT COUNT(emp_no) FROM employees;
--SELECT COUNT(emp_no) FROM salaries;

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

-- Bonus 1. # Create a histogram to visualize the most common salary ranges for employees
SELECT salary
FROM salaries
ORDER BY salary DESC;
--plot the salaries in histogram with 5 bins

-- Bonus 2.  # Create a bar chart of average salary by title.  -- this gives salary by title ordered by title, but not the avg salary
SELECT s.salary, t.title
FROM salaries AS s
	INNER JOIN employees AS e
	ON e.emp_no = s.emp_no
	INNER JOIN titles AS t
	ON t.title_id = e.emp_title_id
	ORDER BY t.title;


--need to groupby to get average
SELECT s.salary, t.title,
	AVG(s.salary) AS "AvgSalary"
FROM salaries AS s
INNER JOIN employees AS e
ON e.emp_no = s.emp_no
INNER JOIN titles AS t
	ON t.title_id = e.emp_title_id
GROUP BY t.title
ORDER BY t.title;

-- https://stackoverflow.com/questions/38229899/sql-join-two-tables-with-avg