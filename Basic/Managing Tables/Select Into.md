# SELECT INTO

Ushbu qo'llanmada siz so'rov natijalari to'plamidan yangi jadval yaratish uchun PostgreSQL `SELECT INTO` bayonotidan qanday foydalanishni o'rganasiz.

> Agar siz ma'lumotlarni o'zgaruvchilarga tanlash usulini izlayotgan bo'lsangiz, uni PL/pgSQL SELECT INTO bayonotiga qarang.

PostgreSQL `SELECT INTO` bayonoti yangi jadval yaratadi va so'rovdan qaytarilgan ma'lumotlarni jadvalga kiritadi.

Yangi jadvalda so'rov natijalari to'plamining ustunlari bilan bir xil nomlarga ega ustunlar bo'ladi. Oddiy `SELECT` bayonotidan farqli o'laroq, `SELECT INTO` bayonoti mijozga natijani qaytarmaydi.

Quyida PostgreSQL `SELECT INTO` bayonotining sintaksisi tasvirlangan:

```sql
SELECT
    select_list
INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table_name
FROM
    table_name
WHERE
    search_condition;
```

Natijalar to'plamidan olingan struktura va ma'lumotlar bilan yangi jadval yaratish uchun siz INTO kalit so'zidan keyin yangi jadval nomini ko'rsatasiz.

`TEMP` yoki `TEMPORARY` kalit so'zi ixtiyoriy; o'rniga vaqtinchalik jadval yaratish imkonini beradi.

Agar mavjud bo'lsa, `UNLOGGED` kalit so'zi yangi jadvalni o'chirilgan jadvalga aylantiradi.

`WHERE` bandi asl jadvallardan yangi jadvalga kiritilishi kerak bo'lgan qatorlarni belgilash imkonini beradi. `WHERE` bandidan tashqari siz `SELECT INTO` iborasi uchun `SELECT` iborasida `INNER JOIN`, `LEFT JOIN`, `GROUP BY` va `HAVING` kabi boshqa bandlardan ham foydalanishingiz mumkin.

PL/pgSQL da `SELECT INTO` iborasidan foydalana olmaysiz, chunki u `INTO` bandini boshqacha izohlaydi. Bunday holda siz `SELECT INTO` iborasidan koʻra koʻproq funksionallikni taʼminlovchi `CREATE TABLE AS` iborasidan foydalanishingiz mumkin.

## PostgreSQL SELECT INTO misollar

Namoyish uchun biz [namunaviy](https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip) ma'lumotlar bazasidagi `film` jadvalidan foydalanamiz.

![table](https://www.postgresqltutorial.com/wp-content/uploads/2018/03/film_table.png)

Quyidagi bayonot `film_r` deb nomlangan yangi jadvalni yaratadi, unda `film` jadvalidan 5 kunlik ijara muddati va `R` reytingiga ega filmlar mavjud.

```sql
SELECT
    film_id,
    title,
    rental_rate
INTO TABLE film_r
FROM
    film
WHERE
    rating = 'R'
AND rental_duration = 5
ORDER BY
    title;
```

Jadval yaratilishini tekshirish uchun `film_r` jadvalidan ma'lumotlarni so'rashingiz mumkin:

```sql
SELECT * FROM film_r;
```

![output](https://www.postgresqltutorial.com/wp-content/uploads/2020/07/PostgreSQL-Select-Into-Example.png)

Quyidagi bayonot uzunligi 60 daqiqadan kam bo'lgan filmlarni o'z ichiga olgan `short_film` nomli vaqtinchalik jadvalni yaratadi.

```sql
SELECT
    film_id,
    title,
    length 
INTO TEMP TABLE short_film
FROM
    film
WHERE
    length < 60
ORDER BY
    title;
```

Quyida short_film jadvalidagi ma'lumotlar ko'rsatilgan:

```sql
SELECT * FROM short_film;
```

![output](https://www.postgresqltutorial.com/wp-content/uploads/2020/07/PostgreSQL-Select-Into-Temp-table-example.png)

Ushbu qo'llanmada siz so'rov natijalari to'plamidan yangi jadval yaratish uchun PostgreSQL `SELECT INTO` bayonotidan qanday foydalanishni o'rgandingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-select-into/)