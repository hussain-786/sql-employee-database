create database employees_db;
use employees_db;

CREATE TABLE titles (
    title_id VARCHAR(10) NOT NULL,
    title VARCHAR(100) NOT NULL,
    PRIMARY KEY (title_id)
);

INSERT INTO titles (title_id, title) VALUES
('T1', 'Manager'),
('T2', 'Senior Engineer'),
('T3', 'Software Engineer'),
('T4', 'Accountant'),
('T5', 'HR Specialist');


CREATE TABLE departments (
    dept_no VARCHAR(10) NOT NULL,
    dept_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (dept_no)
);

INSERT INTO departments (dept_no, dept_name) VALUES
('D1', 'Engineering'),
('D2', 'Human Resources'),
('D3', 'Finance'),
('D4', 'Sales'),
('D5', 'IT Support');


CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

INSERT INTO employees (emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date) VALUES
(1001, 'T1', '1980-03-15', 'John', 'Smith', 'M', '2010-06-01'),
(1002, 'T2', '1985-07-24', 'Emily', 'Johnson', 'F', '2012-03-18'),
(1003, 'T3', '1990-01-11', 'Michael', 'Brown', 'M', '2015-09-23'),
(1004, 'T4', '1988-10-05', 'Sarah', 'Davis', 'F', '2013-11-30'),
(1005, 'T5', '1992-04-20', 'David', 'Wilson', 'M', '2018-02-14');


CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(10) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

INSERT INTO dept_emp (emp_no, dept_no) VALUES
(1001, 'D1'),
(1002, 'D1'),
(1003, 'D5'),
(1004, 'D3'),
(1005, 'D2');


CREATE TABLE dept_manager (
    dept_no VARCHAR(10) NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

INSERT INTO dept_manager (dept_no, emp_no) VALUES
('D1', 1001),
('D2', 1005),
('D3', 1004),
('D4', 1002),
('D5', 1003);


CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

INSERT INTO salaries (emp_no, salary) VALUES
(1001, 95000),
(1002, 85000),
(1003, 70000),
(1004, 60000),
(1005, 55000);

select*from employees;



SELECT emp.emp_no as employee_number, emp.last_name, emp.first_name, emp.sex, sal.salary
FROM employees as emp
LEFT JOIN salaries as sal
ON emp.emp_no = sal.emp_no
ORDER BY emp.emp_no;


SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2010-01-01' AND '2018-12-31';


SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments d 
JOIN dept_manager dm ON (d.dept_no = dm.dept_no)
JOIN employees e ON (dm.emp_no = e.emp_no);


SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON (e.emp_no = de.emp_no)
JOIN departments d ON (de.dept_no = d.dept_no);


SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'John'
AND last_name LIKE 'S%';


SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e 
JOIN dept_emp de ON (e.emp_no = de.emp_no)
JOIN departments d ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Finance';


SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e 
JOIN dept_emp de ON (e.emp_no = de.emp_no)
JOIN departments d ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Finance' 
OR d.dept_name = 'Engineering';


SELECT count(last_name) as frequency, last_name
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;