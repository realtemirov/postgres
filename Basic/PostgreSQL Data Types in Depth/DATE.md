# DATE

Ushbu o'quv qo'llanma PostgreSQL `DATE` ma'lumotlar turini muhokama qiladi va sana qiymatlarini boshqarish uchun ba'zi qulay sana funktsiyalaridan qanday foydalanishni ko'rsatadi.

PostgreSQL sana ma'lumotlarini saqlash imkonini beruvchi `DATE` turini taklif etadi.

PostgreSQL sana qiymatini saqlash uchun `4 baytdan` foydalanadi. `DATE` maʼlumotlar turining eng past va eng yuqori qiymatlari miloddan avvalgi `4713` va `5874897` milodiy.

Agar siz `DATE` ustuniga ega jadval yaratsangiz va PostgreSQL serverining joriy sanasidan standart qiymat sifatida foydalanmoqchi bo'lsangiz, `DEFAULT` kalit so'zidan keyin `CURRENT_DATE` ko'rsatkichidan foydalanishingiz mumkin.

Misol uchun, quyidagi bayonot `DATE` ma'lumotlar turi bilan `posting_date` ustuniga ega bo'lgan `documents` jadvalini yaratadi.

```sql
CREATE TABLE documents (
  document_id serial PRIMARY KEY, 
  header_text VARCHAR (255) NOT NULL, 
  posting_date DATE NOT NULL DEFAULT CURRENT_DATE
);
```

`posting_date` ustuni joriy sanani standart qiymat sifatida qabul qiladi. Bu shuni anglatadiki, agar siz yangi qator kiritishda qiymat ko'rsatmasangiz, PostgreSQL joriy sanani `posting_date` ustuniga kiritadi. Masalan:

```sql
INSERT INTO documents (header_text) 
VALUES ('Billing to customer XYZ')
RETURNING *;
```

```sql
document_id |       header_text       | posting_date
-------------+-------------------------+--------------
           1 | Billing to customer XYZ | 2024-02-01
(1 row)
```

E'tibor bering, ma'lumotlar bazasi serveringizning joriy sanasiga qarab siz boshqa e'lon qilingan sana qiymatini olishingiz mumkin.

PostgreSQL DATE funktsiyalari

Namoyish uchun biz `employee_id`, `first_name`, `last_name`, birth_date va `hire_date` ustunlaridan iborat yangi `employees` jadvalini yaratamiz, bu erda `birth_date` va `hire_date` ustunlarining ma'lumotlar turlari `DATE` bo'ladi.

```sql
CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY, 
  first_name VARCHAR (255) NOT NULL, 
  last_name VARCHAR (255) NOT NULL, 
  birth_date DATE NOT NULL, 
  hire_date DATE NOT NULL
);

INSERT INTO employees (first_name, last_name, birth_date, hire_date)
VALUES ('Shannon','Freeman','1980-01-01','2005-01-01'),
       ('Sheila','Wells','1978-02-05','2003-01-01'),
       ('Ethel','Webb','1975-01-01','2001-01-01')
RETURNING *;
```

Chiqish:

```sql
 employee_id | first_name | last_name | birth_date | hire_date
-------------+------------+-----------+------------+------------
           1 | Shannon    | Freeman   | 1980-01-01 | 2005-01-01
           2 | Sheila     | Wells     | 1978-02-05 | 2003-01-01
           3 | Ethel      | Webb      | 1975-01-01 | 2001-01-01
(3 rows)


INSERT 0 3
```
## 1. Hozirgi sana

Joriy sana va vaqtni olish uchun siz o'rnatilgan `NOW()` funksiyasidan foydalanasiz:

```sql
SELECT NOW();
```

Chiqish:

```sql
              now
-------------------------------
 2024-02-01 08:48:09.599933+07
(1 row)
```

Faqat sana qismini (vaqt qismisiz) olish uchun siz `DATETIME` qiymatini `DATE` qiymatiga uzatish uchun cast operatoridan `(::)` foydalanasiz: 

```sql
SELECT NOW()::date;
```

Chiqish:

```sql
    now
------------
 2024-02-01
(1 row)
```

Joriy sanani olishning tezkor usuli `CURRENT_DATE` funksiyasidan foydalanishdir:

```sql
SELECT CURRENT_DATE;
```

Chiqish:

```sql
 current_date
--------------
 2024-02-01
(1 row)
```

Natija `yyyy-mm-dd` formatida bo'ladi. Biroq, `TO_CHAR()` funksiyasidan foydalanib sana qiymatini formatlash orqali boshqa formatdan foydalanishingiz mumkin.

## 2. Muayyan formatda PostgreSQL sana qiymatini chiqaring

Muayyan formatda sana qiymatini chiqarish uchun siz `TO_CHAR()` funksiyasidan foydalanasiz.

`TO_CHAR()` funksiyasi ikkita parametrni qabul qiladi. Birinchi parametr formatlashni xohlagan qiymat, ikkinchisi esa chiqish formatini belgilaydigan shablondir.

Masalan, joriy sanani `dd/mm/yyyy` formatida ko'rsatish uchun siz quyidagi bayonotdan foydalanasiz:

```sql
SELECT TO_CHAR(CURRENT_DATE, 'dd/mm/yyyy');
```

```sql
  to_char
------------
 01/02/2024
(1 row)
```

Sanani `Feb 01, 2024` kabi formatda ko'rsatish uchun siz quyidagi bayonotdan foydalanasiz:

```sql
SELECT TO_CHAR(CURRENT_DATE, 'Mon dd, yyyy');
```
```sql
   to_char
--------------
 Feb 01, 2024
(1 row)
```

## 3. Ikki sana orasidagi intervalni oling

Ikki sana orasidagi intervalni olish uchun siz minus (-) operatoridan foydalanasiz.

Quyidagi misolda bugungi kundan boshlab `hire_date` ustunidagi qiymatlarni ayirish orqali xodimlarning xizmat kunlari olinadi:

```sql
SELECT 
  first_name, 
  last_name, 
  now() - hire_date as diff 
FROM 
  employees;
```

```sql
 first_name | last_name |           diff
------------+-----------+---------------------------
 Shannon    | Freeman   | 6970 days 08:51:20.824847
 Sheila     | Wells     | 7701 days 08:51:20.824847
 Ethel      | Webb      | 8431 days 08:51:20.824847
(3 rows)
```

## 4. Yoshlarni yillar, oylar va kunlarda hisoblang
Joriy sanadagi yoshni yillar, oylar va kunlarda hisoblash uchun `AGE()` funksiyasidan foydalanasiz.

Quyidagi bayonot `employees` jadvalidagi xodimlarning yoshini hisoblash uchun `AGE()` funksiyasidan foydalanadi.

```sql
SELECT
	employee_id,
	first_name,
	last_name,
	AGE(birth_date)
FROM
	employees;
```

Chiqish:

```sql
 employee_id | first_name | last_name |           age
-------------+------------+-----------+--------------------------
           1 | Shannon    | Freeman   | 44 years 1 mon
           2 | Sheila     | Wells     | 45 years 11 mons 24 days
           3 | Ethel      | Webb      | 49 years 1 mon
(3 rows)
```

Agar siz `AGE()` funksiyasiga sana qiymatini o'tkazsangiz, u ushbu sana qiymatini joriy sanadan olib tashlaydi.

Agar siz `AGE()` funksiyasiga ikkita argumentni uzatsangiz, u birinchi argumentdan ikkinchi argumentni olib tashlaydi.

Masalan, `01/01/2015` yildagi xodimlarning yoshini olish uchun siz quyidagi bayonotdan foydalanasiz:

```sql
SELECT 
  employee_id, 
  first_name, 
  last_name, 
  age('2015-01-01', birth_date) 
FROM 
  employees;
```

Chiqish:

```sql
 employee_id | first_name | last_name |           age
-------------+------------+-----------+--------------------------
           1 | Shannon    | Freeman   | 35 years
           2 | Sheila     | Wells     | 36 years 10 mons 24 days
           3 | Ethel      | Webb      | 40 years
(3 rows)
```

## 5. Sana qiymatidan yil, chorak, oy, hafta va kunni ajratib oling
Sana qiymatidan yil, chorak, oy, hafta va kunni olish uchun siz `EXTRACT()` funksiyasidan foydalanasiz.

Quyidagi bayonotda xodimlarning tug'ilgan sanasidan yil, oy va kun ko'rsatilgan:

```sql
SELECT
	employee_id,
	first_name,
	last_name,
	EXTRACT (YEAR FROM birth_date) AS YEAR,
	EXTRACT (MONTH FROM birth_date) AS MONTH,
	EXTRACT (DAY FROM birth_date) AS DAY
FROM
	employees;
```

Chiqish:

```sql
 employee_id | first_name | last_name | year | month | day
-------------+------------+-----------+------+-------+-----
           1 | Shannon    | Freeman   | 1980 |     1 |   1
           2 | Sheila     | Wells     | 1978 |     2 |   5
           3 | Ethel      | Webb      | 1975 |     1 |   1
(3 rows)
```

Ushbu qo'llanmada siz PostgreSQL `DATE` ma'lumotlar turi va sana ma'lumotlarini qayta ishlash uchun ba'zi qulay funktsiyalar haqida bilib oldingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-date/)

