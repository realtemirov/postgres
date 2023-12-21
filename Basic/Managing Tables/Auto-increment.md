# Auto-increment

Ushbu qoʻllanmada siz PostgreSQL `SERIAL` psevdo-turi va jadvallardagi avtomatik oʻsish ustunlarini aniqlash uchun `SERIAL` psevdo-turidan qanday foydalanish haqida bilib olasiz.

PostgreSQL-da `ketma-ketlik` butun sonlar ketma-ketligini hosil qiluvchi maxsus turdagi ma'lumotlar bazasi ob'ektidir. `Ketma-ketlik` ko'pincha jadvalda `asosiy kalit (primary key)` ustuni sifatida ishlatiladi.

Yangi jadval yaratishda ketma-ketlik `SERIAL` psevdo-tipi orqali quyidagicha yaratilishi mumkin:

```sql
CREATE TABLE table_name(
    id SERIAL
);
```

`Id` ustuniga `SERIAL` psevdo-turini belgilash orqali PostgreSQL quyidagilarni amalga oshiradi:
* Birinchidan, `ketma-ketlik` ob'ektini yarating va `ketma-ketlik` tomonidan yaratilgan keyingi qiymatni ustun uchun standart qiymat sifatida o'rnating.
* Ikkinchidan, `id` ustuniga `NOT NULL` cheklovini qo'shing, chunki `ketma-ketlik` har doim butun sonni hosil qiladi, bu esa `null` bo'lmagan qiymatdir.
* Uchinchidan, `id` ustuniga `ketma-ketlik` egasini tayinlang; natijada `id` ustuni yoki jadvali tushirilganda ketma-ketlik ob'ekti o'chiriladi

Sahna ortida quyidagi bayonot:
```sql
CREATE TABLE table_name(
    id SERIAL
);
```

Quyidagi bayonotlarga ekvivalentdir:
```sql
CREATE SEQUENCE table_name_id_seq;

CREATE TABLE table_name (
    id integer NOT NULL DEFAULT nextval('table_name_id_seq')
);

ALTER SEQUENCE table_name_id_seq
OWNED BY table_name.id;
```

PostgreSQL quyidagi xususiyatlarga ega `SMALLSERIAL`, `SERIAL` va `BIGSERIAL` uchta `ketma-ket` psevdo-turlarini taqdim etadi:

> |    Name     | Storage Size |              Range              |
> |-------------|--------------|---------------------------------|
> | SMALLSERIAL |	2 bytes    | 1 to 32,767                     |
> | SERIAL      | 4 bytes      | 1 to 2,147,483,647              |
> | BIGSERIAL   | 8 bytes      | 1 to 9,223,372,036,854,775,807  |

## PostgreSQL `SERIAL` misoli

Shuni ta'kidlash kerakki, `SERIAL` so'zsiz ustunda indeks yaratmaydi yoki ustunni asosiy kalit ustuni sifatida qilmaydi. Biroq, buni `SERIAL` ustuni uchun `PRIMARY KEY` cheklovini belgilash orqali osonlik bilan amalga oshirish mumkin.

Quyidagi bayonot `SERIAL` ustuni sifatida `id` ustuni bilan `fruits` jadvalini yaratadi:
```sql
CREATE TABLE fruits(
   id SERIAL PRIMARY KEY,
   name VARCHAR NOT NULL
);
```

Jadvalga qator qo'shganda ketma-ket ustunga standart qiymatni belgilash uchun siz ustun nomiga e'tibor bermaysiz yoki `INSERT` iborasida `DEFAULT` kalit so'zidan foydalanasiz.

Quyidagi misolga qarang:
```sql
INSERT INTO fruits(name) 
VALUES('Orange');
```

yoki

```sql
INSERT INTO fruits(id,name) 
VALUES(DEFAULT,'Apple');
```

PostgreSQL `fruits` jadvaliga `id` ustuni uchun qiymatlar 1 va 2 bo'lgan ikkita qatorni kiritdi.

```sql
SELECT * FROM fruits;
```
```
 id |  name
----+--------
  1 | Apple
  2 | Orange

(2 rows)
```

Jadvaldagi `SERIAL` ustunining ketma-ketlik nomini olish uchun siz `pg_get_serial_sequence()` funksiyasidan quyidagi tarzda foydalanasiz:

```sql
pg_get_serial_sequence('table_name','column_name')
```

`Ketma-ketlik` tomonidan yaratilgan oxirgi qiymatni olish uchun `currval()` funksiyasiga `ketma-ketlik` nomini berishingiz mumkin. Misol uchun, quyidagi bayonot `fruits_id_seq` obyekti tomonidan yaratilgan oxirgi qiymatni qaytaradi:

```sql
SELECT currval(pg_get_serial_sequence('fruits', 'id'));
```
```
currval
---------
2
(1 row)
```
Agar siz jadvalga yangi qator qo'shganda `ketma-ketlik` tomonidan yaratilgan qiymatni olishni istasangiz, `INSERT` iborasida `RETURNING id` bandidan foydalanasiz.

Quyidagi bayonot `fruits` jadvaliga yangi qator qo'shadi va id ustuni uchun yaratilgan qiymatni qaytaradi.

```sql
INSERT INTO fruits(name) 
VALUES('Banana')
RETURNING id;
```
```
id
----
3
(1 row)
```

`Sequence generator` ishi tranzaksiya uchun xavfsiz emas. Bu shuni anglatadiki, agar ikkita bir vaqtning o'zida ma'lumotlar bazasi ulanishi ketma-ketlikdan keyingi qiymatni olishga harakat qilsa, har bir mijoz boshqa qiymatga ega bo'ladi.

Ushbu qo'llanmada siz PostgreSQL psevdo-tipi `SERIAL`dan jadval uchun avtomatik o'sish ustunini yaratish uchun qanday foydalanishni o'rgandingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-serial/)