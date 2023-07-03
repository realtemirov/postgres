-- table_name AS alias_name;
-- table_name alias_name;

SELECT
    c.customer_id,
    first_name,
    amount,
    payment_date
FROM
    customer c
INNER JOIN payment p
    ON p.customer_id = c.customer_id
ORDER BY
    payment_date DESC;

SELECT
    e.first_name employee,
    m.first_name manager
FROM
    customer e
INNER JOIN employee m
    ON m.employee_id = e.manager_id
ORDER BY manager;