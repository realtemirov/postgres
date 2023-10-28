-- SELECT
--     column1,
--     aggregate_function(column2)
-- FROM
--     table_name
-- GROUP BY
--     column1
-- HAVING
--     condition;

SELECT 
    customer_id,
    SUM(amount)
FROM
    payment
GROUP BY
    customer_id;

SELECT 
    customer_id,
    SUM(amount)
FROM
    payment
GROUP BY
    customer_id
HAVING
    SUM(amount) > 200;

SELECT
    store_id,
    COUNT(customer_id)
FROM
    customer
GROUP BY
    store_id;

SELECT
    store_id,
    COUNT(customer_id)
FROM
    customer
GROUP BY
    store_id
HAVING
    COUNT(customer_id) > 300;