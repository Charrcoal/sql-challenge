-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

DROP TABLE departments;

CREATE TABLE departments(
    dept_no VARCHAR(10) NOT NULL,
    dept_name VARCHAR(30) NOT NULL,
	CONSTRAINT pk_departments PRIMARY KEY(dept_no)
);

SELECT * 
FROM departments;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees(
    emp_no INTEGER NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    gender VARCHAR(5) NOT NULL,
    hire_date DATE NOT NULL,
	CONSTRAINT pk_employees PRIMARY KEY(emp_no)
);

SELECT *
FROM employees;



DROP TABLE IF EXISTS dept_emp;

CREATE TABLE dept_emp(
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR(10) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	CONSTRAINT fk_emp_no FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	CONSTRAINT fk_dept_no FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY(emp_no, dept_no)
);
 
SELECT *
FROM dept_emp;



DROP TABLE IF EXISTS dept_manager;

CREATE TABLE dept_manager(
    dept_no VARCHAR(10) NOT NULL,
    emp_no INTEGER NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	CONSTRAINT fk_dept_no FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	CONSTRAINT fk_emp_no FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY(dept_no, emp_no)
);

SELECT *
FROM dept_manager;


DROP TABLE IF EXISTS salaries;

CREATE TABLE salaries(
    emp_no INTEGER NOT NULL,
    salary INTEGER NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	CONSTRAINT fk_emp_no FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY(emp_no)
);

SELECT *
FROM salaries;

DROP TABLE IF EXISTS titles;

CREATE TABLE titles(
    emp_no INTEGER(10) NOT NULL,
    title VARCHAR(30) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	CONSTRAINT fk_emp_no FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM titles;

-- Question 1
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s 
ON e.emp_no = s.emp_no;


-- Question 2
SELECT emp_no, last_name, first_name, hire_date
FROM employees 
WHERE DATE_PART('year', hire_date) = 1986;
-- WHERE TO_CHAR(hire_date, 'yyyy') = 1986;


-- Question 3
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager AS dm
INNER JOIN departments AS d
ON d.dept_no = dm.dept_no
INNER JOIN employees AS e
ON dm.emp_no = e.emp_no;

-- Question 4
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no 
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
ORDER BY e.emp_no ;


-- Question 5
SELECT last_name, first_name
FROM employees  
WHERE last_name LIKE 'B%' and first_name LIKE 'Hercules';


-- Question 6
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no 
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE de.dept_no IN
(
	SELECT d.dept_no
	FROM departments AS d
	WHERE d.dept_name = 'Sales'	
);



-- Question 7
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS de
ON e.emp_no = de.emp_no 
LEFT JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE de.dept_no IN
(
	SELECT d.dept_no
	FROM departments AS d
	WHERE d.dept_name IN ('Sales', 'Development')
	--OR d.dept_name = 'Development'
);

-- Question 8
SELECT last_name, COUNT(last_name) AS "last_name_count"
FROM employees
GROUP BY last_name
ORDER BY "last_name_count" DESC;



















