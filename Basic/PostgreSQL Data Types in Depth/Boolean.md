# Mantiqiy ma'lumot turi: `Boolean`

Ushbu qo'llanmada siz PostgreSQL mantiqiy ma'lumotlar turi va undan ma'lumotlar bazasi jadvallarini loyihalashda qanday foydalanish haqida bilib olasiz.

PostgreSQL bitta mantiqiy ma'lumot turini qo'llab-quvvatlaydi: `BOOLEAN`, uchta qiymatga ega bo'lishi mumkin: `true`, `false` va `NULL`.

![boolena](https://www.postgresqltutorial.com/wp-content/uploads/2016/06/PostgreSQL-Boolean-300x146.png)

PostgreSQL ma'lumotlar bazasida mantiqiy qiymatni saqlash uchun `bir bayt`dan foydalanadi. `BOOLEAN`ni `BOOL` deb qisqartirish mumkin.

Standart SQLda mantiqiy qiymat `TRUE`, `FALSE` yoki `NULL` bo'lishi mumkin. Biroq, PostgreSQL `TRUE` va `FALSE` qiymatlari bilan ishlashda juda moslashuvchan.

Quyidagi jadvalda PostgreSQLda `TRUE` va `FALSE` uchun haqiqiy harf qiymatlari ko'rsatilgan.

| True | False |
|------|-------|
| true | false |
| 't'  | 'f'   |
|'true'|'false'|
| 'y'  | 'n'   |
| 'yes'| 'no'  |
| '1'  | '0'   |

Esda tutingki, bosh yoki keyingi boʻshliq muhim emas va `true` va `false`dan tashqari barcha doimiy qiymatlar bitta qoʻshtirnoq ichiga olinishi kerak.

Keling, PostgreSQL Boolean ma'lumotlar turidan foydalanishning ba'zi misollarini ko'rib chiqaylik.

Birinchidan, qaysi mahsulotlar mavjudligini qayd qilish uchun `stock_availability` nomli yangi jadval yarating.

```sql
CREATE TABLE stock_availability (
   product_id INT PRIMARY KEY,
   available BOOLEAN NOT NULL
);
```

Ikkinchidan, `stock_availability` jadvaliga namuna maʼlumotlarini kiriting. Biz mantiqiy qiymatlar uchun har xil harf qiymatlaridan foydalanamiz.

```sql
INSERT INTO stock_availability (product_id, available) 
VALUES 
  (100, TRUE), 
  (200, FALSE), 
  (300, 't'), 
  (400, '1'), 
  (500, 'y'), 
  (600, 'yes'), 
  (700, 'no'), 
  (800, '0');
```

Uchinchidan, mahsulotlarning mavjudligini tekshiring:

```sql
SELECT *
FROM stock_availability
WHERE available = 'yes';
```
```sql
product_id | available
------------+-----------
        100 | t
        300 | t
        400 | t
        500 | t
        600 | t
(5 rows)
```

Mantiqiy ustundan foydalanib, hech qanday operatorsiz haqiqiy qiymatni ko'rsatishingiz mumkin. Masalan, quyidagi so'rov barcha mavjud mahsulotlarni qaytaradi:

```sql
SELECT *
FROM stock_availability
WHERE available;
```

Xuddi shunday, agar siz false qiymatlarni qidirmoqchi bo'lsangiz, mantiqiy ustun qiymatini har qanday haqiqiy mantiqiy doimiylar bilan solishtirasiz.

Quyidagi so'rov mavjud bo'lmagan mahsulotlarni qaytaradi.

```sql
SELECT 
  * 
FROM 
  stock_availability 
WHERE 
  available = 'no';
```

```sql
 product_id | available
------------+-----------
        200 | f
        700 | f
        800 | f
(3 rows)
```

Shu bilan bir qatorda, mantiqiy ustundagi qiymatlar false ekanligini tekshirish uchun `NOT` operatoridan foydalanishingiz mumkin:

```sql
SELECT 
  * 
FROM 
  stock_availability 
WHERE 
  NOT available;
```

## Mantiqiy ustunlar uchun standart qiymatlarni o'rnating

Mavjud mantiqiy ustun uchun standart qiymatni o'rnatish uchun siz `ALTER TABLE` iborasida `SET DEFAULT` bandidan foydalanasiz.

Masalan, quyidagi `ALTER TABLE` iborasi `stock_availability` jadvalidagi `available` ustun uchun standart qiymatni o'rnatadi:

```sql
ALTER TABLE stock_availability 
ALTER COLUMN available
SET DEFAULT FALSE;
```

`available` ustun qiymatini ko'rsatmasdan qator qo'shsangiz, PostgreSQL sukut bo'yicha `FALSE` dan foydalanadi:

```sql
INSERT INTO stock_availability (product_id)
VALUES (900);
```

```sql
SELECT *
FROM stock_availability
WHERE product_id = 900;
```
```sql
 product_id | available
------------+-----------
        900 | f
(1 row)
```

Xuddi shunday, agar siz jadval yaratishda mantiqiy ustun uchun standart qiymatni o'rnatmoqchi bo'lsangiz, ustun ta'rifida `DEFAULT` cheklovidan quyidagi tarzda foydalanasiz:

```sql
CREATE TABLE boolean_demo (
   ...
   is_ok BOOL DEFAULT 't'
);
```

## Xulosa
* Mantiqiy ma'lumotlarini saqlash uchun PostgreSQL `BOOLEAN` ma'lumotlar turidan foydalaning.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-boolean/)