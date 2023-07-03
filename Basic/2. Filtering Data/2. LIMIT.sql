-- SELECT select_list
-- FROM table_name
-- ORDER BY sort_expression
-- LIMIT row_count;

-- SELECT select_list
-- FROM table_name
-- ORDER BY sort_expression
-- LIMIT row_count OFFSET row_to_skip;

SELECT
    film_id,
    title,
    release_year
FROM
    film
ORDER BY
    film_id
LIMIT 5;

SELECT
    film_id,
    title,
    release_year
FROM
    film
ORDER BY
    film_id
LIMIT 5 OFFSET 3;

SELECT
    film_id,
    title,
    rental_rate
FROM
    film
ORDER BY
    rental_rate DESC
LIMIT 10;