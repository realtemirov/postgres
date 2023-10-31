-- SELECT
--     pka,
--     c1,
--     pkb,
--     c2
-- FROM
--     A
-- INNER JOIN B
--     ON pka=pkb;

SELECT
    customer.customer_id,
    first_name,
    last_name,
    amount,
    payment_date
FROM
    customer
INNER JOIN payment
    ON payment.customer_id = customer.customer_id
ORDER BY payment_date;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    p.amount,
    p.payment_date
FROM customer c
INNER JOIN payment p
    ON p.customer_id = c.customer_id
WHERE c.customer_id = 2;

SELECT
    customer_id,
    first_name,
    last_name,
    amount,
    payment_date
FROM
    customer
INNER JOIN payment USING(customer_id)
ORDER BY payment_date;


SELECT
    c.customer_id,
    c.first_name customer_first_name,
    c.last_name customer_last_name,
    s.first_name staff_first_name,
    s.last_name staff_last_name,
    amount,
    payment_date
FROM
    customer c
INNER JOIN payment p
    ON p.customer_id = c.customer_id
INNER JOIN staff s
    ON p.staff_id = s.staff_id
ORDER BY payment_date;