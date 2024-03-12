# Timestamp Data Types

Ushbu qo'llanmada siz PostgreSQL `timestamp` ma'lumotlar turlari, shu jumladan `timestamp` va `timestamptz` haqida bilib olasiz. Shuningdek, `timestamptz` ma'lumotlarini samarali boshqarish uchun ba'zi qulay funktsiyalardan qanday foydalanishni o'rganasiz.

PostgreSQL sizga vaqt belgilari bilan ishlash uchun ikkita vaqtinchalik ma'lumotlar turini taqdim etadi:
* `timestamp`: vaqt mintaqasi bo'lmagan vaqt tamg'asi. * `timestamptz`: vaqt mintaqasi bilan vaqt tamg'asi.

`timestamp` maʼlumotlar turi sana va vaqtni saqlash imkonini beradi. Biroq, unda hech qanday vaqt mintaqasi ma'lumotlari yo'q. Bu shuni anglatadiki, ma'lumotlar bazasi serveringizning vaqt mintaqasini o'zgartirganingizda, ma'lumotlar bazasida saqlangan vaqt tamg'asi qiymati avtomatik ravishda o'zgarmaydi.

`timestamptz` maʼlumotlar turi — vaqt mintaqasi boʻlgan vaqt tamgʻasi. `timestamptz` ma'lumotlar turi - bu vaqt mintaqasidan xabardor sana va vaqt ma'lumotlari turi.

Ichki sifatida PostgreSQL `timestamptz` UTC qiymatida saqlaydi.
* `timestamptz` ustuniga qiymat kiritganingizda, PostgreSQL `timestamptz` qiymatini UTC qiymatiga o'zgartiradi va UTC qiymatini jadvalda saqlaydi.
* `timestamptz` ustunidan ma'lumotlarni olganingizda, PostgreSQL UTC qiymatini ma'lumotlar bazasi serveri, foydalanuvchi yoki joriy ma'lumotlar bazasi ulanishi tomonidan belgilangan vaqt mintaqasining vaqt qiymatiga qaytaradi.

Eʼtibor bering, `timestamp` ham, `timestamptz` ham quyidagi soʻrovda koʻrsatilganidek, vaqt tamgʻasi qiymatlarini saqlash uchun 8 baytdan foydalanadi:

```sql
SELECT 
  typname, 
  typlen 
FROM 
  pg_type 
WHERE 
  typname ~ '^timestamp';
```

Chiqish:

```sql
typname   | typlen
-------------+--------
 timestamp   |      8
 timestamptz |      8
(2 rows)
```

Shuni ta'kidlash kerakki, PostgreSQL `timestamptz` qiymatlarini UTC qiymatlaridan foydalangan holda ma'lumotlar bazasida saqlaydi. `timestamptz` qiymati bilan vaqt mintaqasi ma'lumotlarini saqlamaydi.

## PostgreSQL `timestamp` misoli
Keling, PostgreSQL tomonidan qanday ishlashini yaxshiroq tushunish uchun `timestamp` va `timestamptz` dan foydalanish misolini ko'rib chiqaylik.

Birinchidan, `timestamp` ustunlarining ikkala `timestamptz`dan iborat jadval yarating.

```sql
CREATE TABLE timestamp_demo (
    ts TIMESTAMP, 
    tstz TIMESTAMPTZ
);
```

Keyin maʼlumotlar bazasi serverining vaqt mintaqasini  `America/Los_Angeles`ga oʻrnating.

```sql
SET timezone = 'America/Los_Angeles';
```

Aytgancha, siz joriy vaqt mintaqasini `SHOW TIMEZONE` buyrug'i yordamida ko'rishingiz mumkin:

```sql
SHOW TIMEZONE;
```
```sql
      TimeZone
---------------------
 America/Los_Angeles
(1 row)
```

Keyin `timstamp_demo` jadvaliga yangi qator kiriting:
```sql
INSERT INTO timestamp_demo (ts, tstz)
VALUES('2016-06-22 19:10:25-07','2016-06-22 19:10:25-07');
```

Shundan so'ng, `timestamp` va `timestamptz` ustunlaridan ma'lumotlarni so'rang.
```sql
SELECT 
   ts, tstz
FROM 
   timestamp_demo;
```
```sql
         ts          |          tstz
---------------------+------------------------
 2016-06-22 19:10:25 | 2016-06-22 19:10:25-07
(1 row)
```

So'rov kiritilgan qiymatlar bilan bir xil vaqt tamg'asi qiymatlarini qaytaradi.

Nihoyat, joriy seansning vaqt mintaqasini `America/New_York` ga o'zgartiring va ma'lumotlarni qayta so'rang.

```sql
SET timezone = 'America/New_York';
```

```sql
SELECT 
  ts, 
  tstz 
FROM 
  timestamp_demo;
```

```sql
         ts          |          tstz
---------------------+------------------------
 2016-06-22 19:10:25 | 2016-06-22 22:10:25-04
(1 row)
```

`timestamp` ustunidagi qiymat o'zgarmaydi, `timestamptz` ustunidagi qiymat esa `"Amerika/Nyu_York"`ning yangi vaqt mintaqasiga o'rnatiladi.

Umuman olganda, `timestamptz` ma'lumotlarini saqlash uchun vaqt tamg'asi ma'lumotlar turidan foydalanish yaxshi amaliyotdir.

## PostgreSQL timestamp funksiyalari
`timestamp` ma'lumotlarini samarali boshqarish uchun PostgreSQL quyidagi kabi ba'zi qulay funktsiyalarni taqdim etadi:

### Joriy vaqtni olish
Joriy vaqt tamg'asini olish uchun `NOW()` funksiyasidan quyidagi tarzda foydalanasiz:
```sql
SELECT NOW();
```

Chiqish:
```sql
   now
-------------------------------
 2024-01-31 21:01:58.985943-05
(1 row)
```

Shu bilan bir qatorda, siz `CURRENT_TIMESTAMP` funksiyasidan foydalanishingiz mumkin:

```sql
SELECT CURRENT_TIMESTAMP;
```

Chiqish:
```sql
current_timestamp
-------------------------------
 2024-01-31 21:02:04.715486-05
(1 row)
```

Joriy vaqtni sanasiz olish uchun siz `CURRENT_TIME` funksiyasidan foydalanasiz:

```sql
SELECT CURRENT_TIME;
```

Chiqish:
```sql
 current_time
--------------------
 21:02:13.648512-05
(1 row)
```

Esda tutingki, `CURRENT_TIMESTAMP` ham, `CURRENT_TIME` ham joriy vaqtni vaqt mintaqasi bilan qaytaradi.

Kunning vaqtini string formatida olish uchun siz `timeofday()` funksiyasidan foydalanasiz.

```sql
SELECT TIMEOFDAY();
```

```sql
              timeofday
-------------------------------------
 Wed Jan 31 21:02:20.840159 2024 EST
(1 row)
```

### Vaqt mintaqalari oʻrtasida konvertatsiya qilish

Vaqt tamg'asini boshqa vaqt mintaqasiga aylantirish uchun siz `timezone(zone, timestamp)` funksiyasidan foydalanasiz.

```sql
SHOW TIMEZONE;
```

```sql
     TimeZone
------------------
 America/New_York
(1 row)
```

Joriy vaqt mintaqasi `Amerika/Nyu_York`.

`2016-06-01 00:00` ni `Amerika/Los_Anjeles` vaqt mintaqasiga aylantirish uchun siz `timezone()` funksiyasidan quyidagi tarzda foydalanasiz:

```sql
SELECT timezone('America/Los_Angeles','2016-06-01 00:00');
```

```sql
      timezone
---------------------
 2016-05-31 21:00:00
(1 row)
```

E'tibor bering, biz vaqt tamg'asini satr sifatida `timezone()` funksiyasiga o'tkazamiz, PostgreSQL uni bilvosita `timestamptz`ga o'tkazadi. `timestamp` qiymatini `timestamptz` ma'lumotlar turiga quyidagi bayonot sifatida aniq ko'rsatish yaxshiroqdir:

```sql
SELECT timezone('America/Los_Angeles','2016-06-01 00:00'::timestamptz);
```

Chiqish:
```sql
timezone
---------------------
 2016-05-31 21:00:00
(1 row)
```

## `timestamp` ustunlari uchun standart qiymatlardan foydalanish

Birinchidan, `department` deb nomlangan yangi jadval yarating:

```sql
CREATE TABLE department (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
```

`created_at` va `updated_at` ustunlari uchun standart qiymatlar `CURRENT_TIMESTAMP` funksiyasi tomonidan taqdim etilgan joriy vaqt tamg'asidir.

Ikkinchidan, `created_at` va `updated_at` ustunlari uchun qiymatlarni ko'rsatmasdan, `department` jadvaliga yangi qator qo'shing:

```sql
INSERT INTO department(name)
VALUES('IT')
RETURNING *;
```

Chiqarish shuni ko'rsatadiki, PostgreSQL `created_at` va `created_at` ustunlariga kiritish uchun joriy vaqtdan foydalanadi.

`Bo'lim` jadvalidagi qatorni yangilaganingizda, `updated_at` ustuni joriy vaqtga avtomatik ravishda yangilanmaydi.

`updated_at` ustunidagi qiymatni satr yangilangan vaqtga yangilash uchun siz `updated_at` ustunidagi qiymatni o'zgartirish uchun `BEFORE UPDATE` triggerini yaratishingiz mumkin.

> Esda tutingki, MySQL `TIMESTAMP` ustunini joriy vaqt tamg'asiga avtomatik yangilash uchun `ON UPDATE CURRENT_TIMESTAMP` ni taklif qiladi. PostgreSQL hozirda bu xususiyatni qo'llab-quvvatlamaydi.

Uchinchidan, `department` jadvalining `updated_at` ustunini yangilash uchun `BEFORE UPDATE` triggerini yarating:

```sql
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = current_timestamp;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER department_updated_at_trigger
BEFORE UPDATE ON department
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();
```

To'rtinchidan, `updated_at` ustuniga qiymat ko'rsatmasdan IT bo'limi nomini `ITD` ga yangilang:

```sql
UPDATE department
SET name = 'ITD'
WHERE id = 1
RETURNING *;
```

Chiqish:

```sql
id | name |          created_at           |          updated_at
----+------+-------------------------------+-------------------------------
  1 | ITD  | 2024-01-31 21:25:31.162808-05 | 2024-01-31 21:25:51.318803-05
(1 row)
```

Chiqish `updated_at` ustunidagi qiymat trigger tomonidan avtomatik ravishda yangilanganligini bildiradi.

## Xulosa
* Vaqt tamg'asi ma'lumotlarini saqlash uchun `timestamp` va `timestamptz`dan foydalaning

* PostgreSQL ma'lumotlar bazasida `timestamptz` qiymatlarini UTC qiymatlari sifatida saqlaydi.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-timestamp/)