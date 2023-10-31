-- SELECT * FROM A
-- FULL [OUTER] JOIN B
--     ON A.id=B.id;


DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employee;

CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(255),
    department_id INTEGER
);

INSERT INTO 
    departments(department_name)
VALUES 
    ('Sales'),
    ('Marketing'),
    ('HR'),
    ('IT'),
    ('Production');

INSERT INTO 
    employees (
        employee_name,
        department_id
    )
VALUES
    ('Bette Nicholson', 1),
	('Christian Gable', 1),
	('Joe Swank', 2),
	('Fred Costner', 3),
	('Sandra Kilmer', 4),
	('Julia Mcqueen', NULL);

SELECT
    employee_name,
    department_name
FROM
    employees e
FULL OUTER JOIN departments d
    ON d.department_id=e.department_id;


SELECT
	employee_name,
	department_name
FROM
	employees e
FULL OUTER JOIN departments d ON d.department_id = e.department_id
WHERE
	department_name IS NULL;