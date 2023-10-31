-- SELECT select_list
-- FROM table_name
-- WHERE condition
-- ORDER BY sort_expression

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    first_name='Jamie';

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    first_name='Jamie' AND
    last_name='Rice';

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    last_name='Rodriguez' OR
    first_name='Adam';

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    first_name IN ('Ann','Anne','Annie');

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    first_name LIKE 'Ann%';

SELECT
    first_name,
    LENGTH(first_name) name_length
FROM
    customer
WHERE
    first_name LIKE 'A%' AND
    LENGTH(first_name) BETWEEN 3 AND 5
ORDER BY
    first_name;

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    first_name LIKE 'Bra%' AND
    last_name <> 'Motley';