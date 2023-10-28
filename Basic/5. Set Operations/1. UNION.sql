-- SELECT select_list1
-- FROM table_expression1
-- UNION
-- SELECT select_list2
-- FROM table_expression2

DROP TABLE IF EXISTS top_rated_films;
CREATE TABLE top_rated_films(
    title VARCHAR NOT NULL,
    release_year SMALLINT
);

DROP TABLE IF EXISTS most_popular_films;
CREATE TABLE most_popular_films(
    title VARCHAR NOT NULL,
    release_year SMALLINT
);

INSERT INTO
    top_rated_films(title,release_year)
VALUES
    ('The Shawshank Redemption',1994),
    ('The Godfather',1972),
    ('12 Angry Man',1957);

INSERT INTO
    most_popular_films(title,release_year)
VALUES
    ('An American Pickle',2020),
    ('The Godfather',1972),
    ('Greyhound',2020);

SELECT * FROM top_rated_films;
SELECT * FROM most_popular_films;

SELECT * FROM top_rated_films
UNION
SELECT * FROm most_popular_films;

SELECT * FROM top_rated_films
UNION ALL
SELECT * FROm most_popular_films;