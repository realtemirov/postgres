DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS film_reviews;

CREATE TABLE films(
    film_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

INSERT INTO films(title)
VALUES ('Joker'),
    ('Avangers: Endgame'),
    ('Parasite');

CREATE TABLE film_reviews(
    review_id SERIAL PRIMARY KEY,
    film_id INT,
    review VARCHAR(255) NOT NULL
);

INSERT INTO film_reviews(film_id, review)
VALUES (1, 'Excellent'),
       (1, 'Awesome'),
       (2, 'Cool'),
       (NULL, 'Beautiful');


SELECT
    review,
    title
FROM 
    films
RIGHT JOIN film_reviews
    ON film_reviews.film_id = films.film_id;


SELECT
    review,
    title
FROM
    films
RIGHT JOIN film_reviews
    USING(film_id);

SELECT
    review,
    title
FROM
    films
RIGHT JOIN film_reviews
    USING(film_id)
WHERE title IS NULL;