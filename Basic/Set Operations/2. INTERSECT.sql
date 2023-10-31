-- SELECT select_list
-- FROM A
-- INTERSECT
-- SELECT select_list
-- FROM B;

-- SELECT select_list
-- FROM A
-- INTERSECT
-- SELECT select_list
-- FROM B
-- ORDER BY sort_expression;


SELECT *
FROM most_popular_films 
INTERSECT
SELECT *
FROM top_rated_films;