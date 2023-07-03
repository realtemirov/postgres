# Joins
## Inner Join
```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
INNER JOIN basket_b
    ON fruit_a = fruit_b;
```
![Inner Join](inner_join.png "Inner Join")

<br>

## Left Outer Join
```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
LEFT JOIN basket_b
    ON fruit_a=fruit_b;
```
![Left Join](left_outer_join.png "Left Join")

<br>

## Left Outer Join Only
```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
LEFT JOIN basket_b
    ON fruit_a=fruit_b
WHERE b IS NULL;
```

![Left Outer Join](left_outer_join_only.png "Left Outer Join")

<br>

## Right Outer Join
```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
RIGHT JOIN basket_b
    ON fruit_a=fruit_b;
```

![Right Outer Join](right_outer_join.png "Right Outer Join")

<br>

## Right Outer Join Only
```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
RIGHT JOIN basket_b
    ON fruit_a=fruit_b
WHERE a IS NULL;
```

![Right Outer Join Only ](right_outer_join_only.png "Right Outer Join Only")


<br>

## Full Outer Join

```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
FULL OUTER JOIN basket_b
    ON fruit_a=fruit_b;
```
![Full Outer Join](full_outer_join.png "Full Outer Join")

<br>

## Full Outer Join Only

```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
FULL OUTER JOIN basket_b
    ON fruit_a=fruit_b
WHERE a IS NULL OR b IS NULL;
```

![Full Outer Join Only](full_outer_join_only.png "Full Outer Join Only")

<br>


## Cross Join

```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
CROSS JOIN basket_b;
```

![Cross Join](cross_join.png "Cross Join")

<br>
<h2 text-align="center"> <b>References:</b> </h2>

![Alt text](image.png)