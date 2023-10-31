-- OFFSET start { ROW | ROWS }
-- FETCH { FIRST | NEXT } [ row_count ] { ROW | ROWS } ONLY

SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
FETCH FIRST ROW ONLY;

SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
FETCH FIRST 1 ROW ONLY;

SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
FETCH FIRST 5 ROW ONLY;

SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
OFFSET 5 ROWS
FETCH FIRST 5 ROW ONLY;