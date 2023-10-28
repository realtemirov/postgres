-- SELECT select_list
-- FROM A
-- EXCEPT 
-- SELECT select_list
-- FROM B;

SELECT * FROM top_rated_films
EXCEPT 
SELECT * FROM most_popular_films;