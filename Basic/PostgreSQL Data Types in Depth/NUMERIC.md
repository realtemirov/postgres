# `NUMERIC`
Ushbu qo'llanmada siz raqamli ma'lumotlarni saqlash uchun PostgreSQL `NUMERIC` turi haqida bilib olasiz.

`NUMERIC` turi ko'p sonli raqamlarni saqlashi mumkin. Odatda, siz pul miqdori yoki miqdori kabi aniqlikni talab qiladigan raqamlar uchun `NUMERIC` turidan foydalanasiz.

Quyida NUMERIC turining sintaksisi tasvirlangan:

```sql
NUMERIC(precision, scale)
```

Ushbu sintaksisda: 
* Aniqlik(`precision`) raqamlarning umumiy sonidir 
* Masshtab(`scale`) kasr qismidagi raqamlar soni.

Masalan, `1234.567` raqami `7` aniqlik va `3` shkalaga ega.

`NUMERIC` turi o'nli kasrdan oldin `131,072` raqamgacha bo'lgan qiymatni o'nli kasrdan keyin `16,383` ta raqamga ega bo'lishi mumkin.

`NUMERIC` turining shkalasi nol yoki positive bo'lishi mumkin.

Mana, nol masshtabli NUMERIC tipidagi sintaksisi:

```sql
NUMERIC(precision)
```

Agar siz aniqlik va masshtabni o'tkazib yuborsangiz, har qanday aniqlikni saqlashingiz va yuqorida aytib o'tilgan aniqlik va o'lchov chegarasiga qadar o'lchashingiz mumkin.

```sql
NUMERIC
```

PostgreSQL-da `NUMERIC` va `DECIMAL` turlari ekvivalentdir va ikkalasi ham SQL standartining bir qismidir.

Agar aniqlik talab etilmasa, `NUMERIC` turidan foydalanmasligingiz kerak, chunki `NUMERIC` qiymatlari bo'yicha hisob-kitoblar odatda butun sonlar, floatlar va doublelarga qaraganda sekinroq.

## PostgreSQL NUMERIC misollar

Keling, PostgreSQL `NUMERIC` turidan foydalanishga misollar keltiraylik.

### 1. Raqamli qiymatlarni saqlash

Agar siz qiymatni `NUMERIC` ustunining e'lon qilingan shkalasidan kattaroq shkala bilan saqlasangiz, PostgreSQL qiymatni belgilangan kasr raqamlariga yaxlitlaydi. Masalan:

Birinchi, `products` deb nomlangan yangi jadval yarating:

```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(5,2)
);
```

Ikkinchi, `price` ustunida e'lon qilingan shkaladan oshib ketadigan narxlari bo'lgan ba'zi mahsulotlarni kiriting:

```sql
INSERT INTO products (name, price)
VALUES ('Phone',500.215), 
       ('Tablet',500.214);
```       

`price` ustunining shkalasi 2 bo'lgani uchun PostgreSQL `500.215` qiymatini `500.22` gacha va `500.214` qiymatini `500.21` gacha yaxlitlaydi:

Quyidagi so'rov `products` jadvalining barcha qatorlarini qaytaradi:

```sql
SELECT * FROM products;
```

```sql
 id |  name  | price
----+--------+--------
  1 | Phone  | 500.22
  2 | Tablet | 500.21
(2 rows)
```

Agar siz aniqligi e'lon qilingan aniqlikdan oshib ketadigan qiymatni saqlasangiz, PostgreSQL quyidagi misolda ko'rsatilganidek xatoni keltirib chiqaradi:

```sql
INSERT INTO products (name, price)
VALUES('Phone',123456.21);
```

```sql
ERROR:  numeric field overflow
DETAIL:  A field with precision 5, scale 2 must round to an absolute value less than 10^3.
```

### 2. PostgreSQL `NUMERIC` turi va `NaN`

Raqamli qiymatlarni saqlashdan tashqari, `NUMERIC` turida `NaN` nomli maxsus qiymat ham bo'lishi mumkin, bu raqam emas. Quyidagi misol mahsulot identifikatori 1 narxini `NaN` ga yangilaydi:

```sql
UPDATE products
SET price = 'NaN'
WHERE id = 1;
```

E'tibor bering, yuqoridagi `UPDATE` bayonotida ko'rsatilganidek, `NaN` ni o'rash uchun bitta tirnoqdan foydalanish kerak.

Quyidagi so'rov `products` jadvali ma'lumotlarini qaytaradi:

```sql
SELECT * FROM products;
```

```sql
 id |  name  | price
----+--------+--------
  2 | Tablet | 500.21
  1 | Phone  |    NaN
(2 rows)
```

Odatda, `NaN` hech qanday raqamga, shu jumladan o'ziga teng emas. Bu `NaN = NaN` ifodasi `false` ekanligini anglatadi.

Biroq, ikkita `NaN` qiymati teng va `NaN` boshqa raqamlardan kattaroqdir. Ushbu dastur PostgreSQL-ga `NUMERIC` qiymatlarni saralash va ularni daraxtga asoslangan indekslarda ishlatish imkonini beradi.

Quyidagi so'rov mahsulotlarni price bo'yicha saralaydi:

```sql
SELECT * FROM products
ORDER BY price DESC;
```

```sql
 id |  name  | price
----+--------+--------
  1 | Phone  |    NaN
  2 | Tablet | 500.21
(2 rows)
```

Chiqish `NaN` ning `500,21` dan katta ekanligini ko'rsatadi

## Xulosa
* Aniqlikni talab qiladigan raqamlarni saqlash uchun PostgreSQL `NUMERIC` maʼlumotlar turlaridan foydalaning.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-numeric/)