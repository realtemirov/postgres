# Correlated Subquery

Ushbu qo'llanmada siz joriy satrning qayta ishlanayotgan qiymatlariga bog'liq bo'lgan so'rovni bajarish uchun PostgreSQL `korrelyatsiyali quyi so'rovi(Correlated Subquery)` haqida bilib olasiz.

PostgreSQL-da korrelyatsiya qilingan pastki so'rov tashqi so'rovdagi ustunlarga havola qiluvchi pastki so'rovdir.

Oddiy quyi so'rovdan farqli o'laroq, PostgreSQL tashqi so'rov tomonidan qayta ishlangan har bir satr uchun korrelyatsiya qilingan quyi so'rovni bir marta baholaydi.

PostgreSQL tashqi so'rovdagi har bir qator uchun korrelyatsiya qilingan pastki so'rovni qayta baholaganligi sababli, bu, ayniqsa, katta ma'lumotlar to'plami bilan ishlashda ishlash muammolariga olib kelishi mumkin.

O'zaro bog'liq bo'lgan pastki so'rov qayta ishlanayotgan oqim qiymatlariga bog'liq bo'lgan so'rovni bajarish kerak bo'lganda foydali bo'lishi mumkin.

Namoyish uchun [namunaviy](https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip) ma'lumotlar bazasidagi `film` jadvalidan foydalanamiz.

![film table](https://www.postgresqltutorial.com/wp-content/uploads/2019/05/film.png)

Quyidagi misolda tegishli reytinglari bo'yicha o'rtachadan yuqori uzunlikdagi filmlarni topish uchun korrelyatsiya qilingan pastki so'rovdan foydalaniladi:

```sql
SELECT film_id, title, length, rating
FROM film f
WHERE length > (
    SELECT AVG(length)
    FROM film
    WHERE rating = f.rating
);
```

Chiqish:
```sql
film_id |            title            | length | rating
---------+-----------------------------+--------+--------
     133 | Chamber Italian             |    117 | NC-17
       4 | Affair Prejudice            |    117 | G
       5 | African Egg                 |    130 | G
       6 | Agent Truman                |    169 | PG
...
```

U qanday ishlaydi.

Tashqi so'rov `f` taxallusli `film` jadvalidan id, sarlavha, uzunlik va reytingni oladi:

```sql
SELECT film_id, title, length, rating
FROM film f
WHERE length > (...)
```

Tashqi so'rov tomonidan qayta ishlangan har bir qator uchun korrelyatsiya qilingan pastki so'rov joriy qator bilan bir xil `reytingga` ega bo'lgan filmlarning o'rtacha `uzunligini` hisoblab chiqadi (`f.rating`).

`WHERE` bandi (`WHERE length > (...)`) joriy film uzunligi o'rtachadan kattaroq yoki yo'qligini tekshiradi.

Korrelyatsiya qilingan pastki so'rov tashqi so'rovdagi joriy qator bilan bir xil reytingga ega filmlar uchun o'rtacha uzunlikni hisoblab chiqadi:

```sql
SELECT AVG(length)
FROM film
WHERE rating = f.rating
```

`WHERE` bandi korrelyatsiya qilingan pastki so'rov faqat tashqi so'rovdagi joriy qator bilan bir xil reytingga ega filmlarni ko'rib chiqishni ta'minlaydi. Shart `rating = f.rating` korrelyatsiyani yaratadi.

Natijada, tashqi so'rov filmning `uzunligi` bir xil `reytingga` ega filmlar uchun o'rtacha `uzunlikdan` kattaroq bo'lgan qatorlarni qaytaradi.

Ishlanayotgan joriy satrning qiymatlariga bog'liq bo'lgan so'rovni bajarish uchun korrelyatsiya qilingan pastki so'rovdan foydalaning.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-correlated-subquery/)