-- SELECT
--     DISTINCT column1
-- FROM
--     table_name;

SELECT
    DISTINCT column1, column2
FROM
    table_name;

SELECT
    DISTINCT ON(column1) column_alias,
    column2
FROM
    table_name
ORDER BY
    column1,
    column2;

CREATE TABLE distinct_demo(
    ID SERIAL NOT NULL PRIMARY KEY,
    bcolor VARCHAR,
    fcolor VARCHAR
);


INSERT INTO distinct_demo( bcolor, fcolor)
VALUES
    ('red', 'red'),
	('red', 'red'),
	('red', NULL),
	(NULL, 'red'),
	('red', 'green'),
	('red', 'blue'),
	('green', 'red'),
	('green', 'blue'),
	('green', 'green'),
	('blue', 'red'),
	('blue', 'green'),
	('blue', 'blue'); 


SELECT
    id,
    bcolor,
    fcolor
FROM
    distinct_demo;

SELECT
    DISTINCT bcolor
FROM
    distinct_demo
ORDER BY
    bcolor;

SELECT
    DISTINCT bcolor,
    fcolor
FROM
    distinct_demo
ORDER BY
    bcolor,
    fcolor;

SELECT
    DISTINCT ON(bcolor) bcolor,
    fcolor
FROM
    distinct_demo
ORDER BY
    bcolor,
    fcolor;