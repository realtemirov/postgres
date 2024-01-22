# Temporary Table

Ushbu qo'llanmada siz PostgreSQL vaqtinchalik jadvali va uni qanday samarali boshqarish haqida bilib olasiz.

![image](https://www.postgresqltutorial.com/wp-content/uploads/2017/02/PostgreSQL-Temporary-Table-300x254.png)

Vaqtinchalik jadval, nomidan ko'rinib turibdiki, ma'lumotlar bazasi sessiyasi davomida mavjud bo'lgan qisqa muddatli jadvaldir. PostgreSQL seans yoki tranzaksiya oxirida vaqtinchalik jadvallarni avtomatik ravishda tushiradi.

Vaqtinchalik jadval yaratish uchun siz `CREATE TEMPORARY TABLE` iborasidan foydalanasiz:

```sql
CREATE TEMPORARY TABLE temp_table_name(
   column_list
);
```

Ushbu sintaksisda:

* Birinchidan, `CREATE TEMPORARY TABLE` kalit so'zlaridan keyin vaqtinchalik jadval nomini belgilang.

* Ikkinchidan, `CREATE TABLE` bayonotidagi bilan bir xil bo'lgan ustunlar ro'yxatini belgilang.

`TEMP` va `TEMPORARY` kalit so'zlari ekvivalentdir, shuning uchun ularni bir-birining o'rnida ishlatishingiz mumkin:

```sql
CREATE TEMP TABLE temp_table(
   ...
);
```

Vaqtinchalik jadval faqat uni yaratgan seansga ko'rinadi. Boshqacha qilib aytganda, u boshqa seanslarga ko'rinmaydi.

Keling, bir misolni ko'rib chiqaylik.

Birinchidan, `psql` dasturi yordamida PostgreSQL ma'lumotlar bazasi serveriga kiring va `test` nomli yangi ma'lumotlar bazasini yarating:

```sql
postgres=# CREATE DATABASE test;
CREATE DATABASE
postgres-# \c test;
You are now connected to database "test" as user "postgres".
```

Keyin `mytemp` nomli vaqtinchalik jadvalni quyidagicha yarating:

```sql
test=# CREATE TEMP TABLE mytemp(c INT);
CREATE TABLE
test=# SELECT * FROM mytemp;
 c
---
(0 rows)
```

Keyin `test` ma'lumotlar bazasiga ulanadigan boshqa seansni ishga tushiring va `mytemp` jadvalidagi ma'lumotlarni so'rang:

```sql
test=# SELECT * FROM mytemp;
ERROR:  relation "mytemp" does not exist
LINE 1: SELECT * FROM mytemp;
```

Natijadan aniq ko'rinib turibdiki, ikkinchi seans `mytemp` jadvalini ko'ra olmadi. Unga faqat birinchi seans kirishi mumkin.

Shundan so'ng, barcha seanslarni to'xtating:

```sql
test=# \q
```

Nihoyat, ma'lumotlar bazasi serveriga qayta kiring va `mytemp` jadvalidan ma'lumotlarni so'rang:

```sql
test=# SELECT * FROM mytemp;
ERROR:  relation "mytemp" does not exist
LINE 1: SELECT * FROM mytemp;
^
```

`mytemp` jadvali mavjud emas, chunki seans tugagandan so'ng u avtomatik ravishda o'chirilgan, shuning uchun PostgreSQL xatoga yo'l qo'ydi.

## PostgreSQL vaqtinchalik jadval nomi

Vaqtinchalik jadval doimiy jadval bilan bir xil nomga ega bo'lishi mumkin, garchi u tavsiya etilmasa ham.

Doimiy jadval bilan bir xil nomga ega bo'lgan vaqtinchalik jadvalni yaratganingizda, vaqtinchalik jadval o'chirilmaguncha doimiy jadvalga kira olmaysiz. Quyidagi misolni ko'rib chiqing:

First, create a table named `customers`:

```sql
CREATE TABLE customers(
   id SERIAL PRIMARY KEY, 
   name VARCHAR NOT NULL
);
```

Ikkinchidan, xuddi shu nom bilan vaqtinchalik jadval yarating: `customers`

```sql
CREATE TEMP TABLE customers(
    customer_id INT
);
```

Endi, `customers` jadvalidan maʼlumotlarni soʻrang:

```sql
SELECT * FROM customers;
 customer_id
-------------
(0 rows)
```

Bu safar PostgreSQL doimiy `customers` o'rniga vaqtinchalik jadvalga kirdi.

E'tibor bering, PostgreSQL maxsus sxemada vaqtinchalik jadvallarni yaratadi, shuning uchun siz `CREATE TEMP TABLE` bayonotida sxemani ko'rsata olmaysiz.

Agar siz `test` maʼlumotlar bazasida jadvallarni roʻyxatga kiritsangiz, doimiy jadvalni emas, faqat vaqtinchalik `customers` jadvalini  koʻrasiz:

```sql
                 List of relations
  Schema   |       Name       |   Type   |  Owner
-----------+------------------+----------+----------
 pg_temp_3 | customers        | table    | postgres
 public    | customers_id_seq | sequence | postgres
(2 rows)
```

Chiqish `customers` vaqtinchalik jadvalining `pg_temp_3.` sxemasini ko'rsatadi.

Bunday holda, doimiy jadvalga kirish uchun siz to'liq malakali nomdan foydalanishingiz kerak, ya'ni sxema bilan prefiks. Masalan:

```sql
SELECT * FROM public.customers;
```

## PostgreSQL vaqtinchalik jadvalini olib tashlash

Vaqtinchalik jadvalni tushirish uchun siz ``DROP TABLE`` iborasidan foydalanasiz. Quyidagi bayonot vaqtinchalik jadvalni tashlash uchun `DROP TABLE` iborasidan foydalanadi:

```sql
DROP TABLE temp_table_name;
```

`CREATE TABLE` iborasidan farqli o'laroq, `DROP TABLE` operatorida vaqtinchalik jadvallar uchun maxsus yaratilgan `TEMP` yoki `TEMPORARY` kalit so'zlari mavjud emas.

Misol uchun, quyidagi bayonot biz yuqoridagi misolda yaratgan vaqtinchalik `customers` jadvalini olib tashlaydi:

```sql
DROP TABLE customers;
```

Jadvallarni `test` maʼlumotlar bazasida yana roʻyxatga kiritsangiz, doimiy jadval `customers` quyidagicha koʻrinadi:

```sql
test=# \d
                List of relations
 Schema |       Name       |   Type   |  Owner
--------+------------------+----------+----------
 public | customers        | table    | postgres
 public | customers_id_seq | sequence | postgres
(2 rows)
```

Ushbu qo'llanmada siz vaqtinchalik jadval va uni `CREATE TEMP TABLE` va `DROP TABLE` iboralari yordamida qanday yaratish va tushirish haqida bilib oldingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-temporary-table/)