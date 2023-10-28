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

![Inner Join](inner\_join.png)

<figure><img src="image.png" alt=""><figcaption><p>image</p></figcaption></figure>



{% file src="image.png" %}

```go
package main
import "fmt"
func main() {
    fmt.Println("Hello world!")
}
```

> this is quoto

{% hint style="info" %}
test hint&#x20;

:thumbsup:
{% endhint %}

***

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

![Left Join](left\_outer\_join.png)

\


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

![Left Outer Join](left\_outer\_join\_only.png)

\


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

![Right Outer Join](right\_outer\_join.png)

\


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

![Right Outer Join Only](right\_outer\_join\_only.png)

\


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

![Full Outer Join](full\_outer\_join.png)

\


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

![Full Outer Join Only](full\_outer\_join\_only.png)

\


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

![Cross Join](cross\_join.png)

{% embed url="https://grokking.realtemirov.uz" %}

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th></tr></thead><tbody><tr><td></td><td>fasdfasdf</td><td></td><td><a href="cross_join.png">cross_join.png</a></td></tr><tr><td></td><td>asdfsadf</td><td></td><td></td></tr><tr><td></td><td></td><td></td><td></td></tr><tr><td>adafsadfsadfsdfsd</td><td>asdfsadfsadf</td><td>fsadfsdf</td><td><a href="image.png">image.png</a></td></tr></tbody></table>

<details>

<summary>fasdfasdfasdf</summary>

fasdfasdfasdf

</details>

$$
f(x) = x * e^{2 pi i \xi x}
$$

{% swagger method="get" path="" baseUrl="" summary="sadfasdf" %}
{% swagger-description %}
asdfasdf
{% endswagger-description %}

{% swagger-parameter in="path" name="asdfs" type="fsadf" required="true" %}
adfasdfasd
{% endswagger-parameter %}

{% swagger-parameter in="header" %}

{% endswagger-parameter %}

{% swagger-response status="200: OK" description="asdfasdfasdf" %}
asfasd
{% endswagger-response %}

{% swagger-response status="201" description="fasdfasdfsf" %}

{% endswagger-response %}
{% endswagger %}

| rest    | test  | etsa   |
| ------- | ----- | ------ |
| asf     | asdfs | asdfsd |
| fasdf   | dfads | sdaf   |
| sadfasd | fasdf | fsdfa  |

{% embed url="https://docs.google.com/spreadsheets/d/1yGvhJTm4tODUQ5SnCrEyogeGfx4-dhWGKd4WoA9CH9k/edit#gid=0" %}

* [ ] test
* [ ] test2
* [ ] test3

## References:

![Alt text](image.png)
