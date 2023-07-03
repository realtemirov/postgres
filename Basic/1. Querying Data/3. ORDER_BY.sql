-- SELECT
--     select_list
-- FROM
--     table_name
-- ORDER BY
--     sort_expression1 [ASC | DESC],
--     ...
--     sort_expression2 [ASC | DESC];

SELECT
    first_name,
    last_name
FROM
    customer
ORDER BY
    first_name ASC;

SELECT
    first_name,
    last_name
FROM
    customer
ORDER BY
    first_name ASC,
    last_name DESC;

-- clause and NULL

CREATE TABLE sort_demo(
    num INT
);

INSERT INTO sort_demo(num)
VALUES (1), (2), (3), (null);

SELECT num
FROM sort_demo
ORDER BY num;

SELECT num
FROM sort_demo
ORDER BY num NULLS LAST;

SELECT num
FROM sort_demo
ORDER BY num NULLS FIRST;