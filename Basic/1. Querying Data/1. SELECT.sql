-- SELECT
--     select_list
-- FROM
--     table_name;

SELECT first_name FROM customer;

SELECT
    first_name,
    last_name,
    email
FROM
    customer;

SELECT * FROM customer;

SELECT 
    first_name || ' ' || last_name,
    email
FROM 
    customer;

SELECT 5 * 3;

SELECT 1;

SELECT 'Hello, World!';