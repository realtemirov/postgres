-- value LIKE pattern % _ 
-- value LIKE pattern

-- ~~ LIKE
-- ~~* ILIKE
-- !~~ NOT LIKE
-- !~~* NOT ILIKE

SELECT
    first_name,
    last_name
FROM
    customer
WHERE first_name LIKE 'Jen%';

SELECT
	'foo' LIKE 'foo', -- true
	'foo' LIKE 'f%', -- true
	'foo' LIKE '_o_', -- true
	'bar' LIKE 'b_'; -- false

SELECT
    first_name,
    last_name
FROM
    customer
WHERE first_name LIKE '%er%'
ORDER BY
    first_name;

SELECT
    first_name,
    last_name
FROM
    customer
WHERE first_name LIKE '_her%'
ORDER BY
    first_name;

SELECT
    first_name,
    last_name
FROM
    customer
WHERE first_name NOT LIKE 'Jer%'
ORDER BY
    first_name;

SELECT
    first_name,
    last_name
FROM
    customer
WHERE first_name ILIKE 'BAR%';