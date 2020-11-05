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

