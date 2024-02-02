# CHECK
Ushbu qo'llanmada siz PostgreSQL CHECK cheklovlari va ulardan mantiqiy ifodaga asoslangan jadval ustunlaridagi qiymatlarni cheklash uchun qanday foydalanish haqida bilib olasiz.

PostgreSQL-da `CHECK` cheklovi ustun yoki ustunlar guruhidagi qiymatlar ma'lum bir shartga javob berishini ta'minlaydi.

Tekshirish cheklovi ma'lumotlar bazasi darajasida ma'lumotlar yaxlitligi qoidalarini qo'llash imkonini beradi. Tekshirish cheklovi qiymatlarni baholash uchun mantiqiy ifodadan foydalanadi va jadvalga faqat haqiqiy ma'lumotlar kiritilishi yoki yangilanishini ta'minlaydi.

## CHECK cheklovlarini yaratish

Odatda, `CREATE TABLE` iborasidan foydalanib, jadval yaratishda chek cheklovini yaratasiz:

```sql
CREATE TABLE table_name(
   column1 datatype,
   ...,
   CONSTRAINT constraint_name CHECK(condition)
);
```

Ushbu sintaksisda:
* Birinchidan, `CONSTRAINT` kalit so'zidan keyin cheklov nomini belgilang. Bu ixtiyoriy. Agar siz uni o'tkazib yuborsangiz, PostgreSQL avtomatik ravishda `CHECK` cheklovi uchun nom yaratadi.

* Ikkinchidan, cheklovning haqiqiy bo'lishi uchun bajarilishi kerak bo'lgan shartni aniqlang.

Agar `CHECK` cheklovi faqat bitta ustunni o'z ichiga olsa, uni quyidagi kabi ustun cheklovi sifatida belgilashingiz mumkin:

```sql
CREATE TABLE table_name(
   column1 datatype,
   column1 datatype CHECK(condition),
   ...,
);
```

Odatiy bo'lib, PostgreSQL quyidagi formatdan foydalangan holda `CHECK` chekloviga nom beradi:

```sql
{table}_{column}_check
```

## Jadvallarga `CHECK` cheklovlarini qo'shish

Mavjud jadvalga `CHECK` cheklovini qo'shish uchun siz `ALTER TABLE ... ADD CONSTRAINT` iborasidan foydalanasiz:

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name CHECK (condition);
```

## `CHECK` cheklovlarini olib tashlash

`CHECK` cheklovini olib tashlash uchun siz `ALTER TABLE ... DROP CONSTRAINT` iborasidan foydalanasiz:

```sql
ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
```

## PostgreSQL `CHECK` cheklash misollari

Keling, `CHECK` cheklovlaridan foydalanishning ba'zi misollarini ko'rib chiqaylik.

## Yangi jadval uchun PostgreSQL `CHECK` cheklovini aniqlash

### 1. Birinchidan, ba'zi `CHECK` cheklovlari bilan `employees` deb nomlangan yangi jadval yarating:

```sql
CREATE TABLE employees (
  id SERIAL PRIMARY KEY, 
  first_name VARCHAR (50) NOT NULL, 
  last_name VARCHAR (50) NOT NULL,  
  birth_date DATE NOT NULL, 
  joined_date DATE NOT NULL, 
  salary numeric CHECK(salary > 0)
);
```

Ushbu bayonotda, `employees` jadvalida ish haqi ustunidagi qiymatlarni noldan kattaroq qilib qoʻyadigan bitta `CHECK` cheklovi mavjud.

Ikkinchidan, `employees` jadvaliga salbiy ish haqi bilan yangi qator qo'shishga harakat qiling:

```sql
INSERT INTO employees (first_name, last_name, birth_date, joined_date, salary) 
VALUES ('John', 'Doe', '1972-01-01', '2015-07-01', -100000);
```

Xato:

```sql
ERROR:  new row for relation "employees" violates check constraint "employees_salary_check"
DETAIL:  Failing row contains (1, John, Doe, 1972-01-01, 2015-07-01, -100000).
```

Qo'shish muvaffaqiyatsiz tugadi, chunki `salary` ustunidagi `CHECK` cheklovi faqat ijobiy qiymatlarni qabul qiladi.

### 2. Mavjud jadvallar uchun PostgreSQL `CHECK` cheklovlarini qo'shish
Birinchidan, `employees` jadvaliga `CHECK` cheklovini qo'shish uchun `ALTER TABLE ... ADD CONSTRAINT` iborasidan foydalaning:

```sql
ALTER TABLE employees
ADD CONSTRAINT joined_date_check
CHECK ( joined_date >  birth_date );
```

`CHECK` cheklovi qo'shilgan sana tug'ilgan kundan kechroq bo'lishini ta'minlaydi.

Ikkinchidan, `employees` jadvaliga yangi qatorni qo'shilgan sana tug'ilgan kundan oldinroq kiritishga harakat qiling:

```sql
INSERT INTO employees (first_name, last_name, birth_date, joined_date, salary) 
VALUES ('John', 'Doe', '1990-01-01', '1989-01-01', 100000);
```

Chiqish:

```sql
ERROR:  new row for relation "employees" violates check constraint "joined_date_check"
DETAIL:  Failing row contains (2, John, Doe, 1990-01-01, 1989-01-01, 100000).
```

Chiqish ma'lumotlarning `"joined_date_check"` chek cheklovini buzganligini ko'rsatadi.

### 3. `CHECK` cheklovlarida funksiyalardan foydalanish

Quyidagi misolda ismning kamida 3 ta belgidan iborat boʻlishini taʼminlash uchun `CHECK` cheklovi qoʻshilgan:

```sql
ALTER TABLE employees
ADD CONSTRAINT first_name_check
CHECK ( LENGTH(TRIM(first_name)) >= 3);
```

Ushbu misolda biz `TRIM()` va `LENGTH()` funksiyalari yordamida shartni aniqlaymiz:

* Birinchidan, `TRIM()` funksiyasi birinchi_nomdan oldingi va keyingi bo'shliqlarni olib tashlaydi.
* Ikkinchidan, `LENGTH()` funksiyasi `TRIM()` funksiyasi natijasining belgilar uzunligini qaytaradi.

Butun `LENGTH(TRIM(first_name)) >= 3` iborasi birinchi nomda uch yoki undan ortiq belgidan iborat boʻlishini taʼminlaydi.

Quyidagi bayonot muvaffaqiyatsiz bo'ladi, chunki u `employees` jadvaliga 2 ta belgidan iborat birinchi ismli qator qo'shishga harakat qiladi:

```sql
INSERT INTO employees (first_name, last_name, birth_date, joined_date, salary) 
VALUES ('Ab', 'Doe', '1990-01-01', '2008-01-01', 100000);
```

Xato:

```sql
ERROR:  new row for relation "employees" violates check constraint "first_name_check"
DETAIL:  Failing row contains (4, Ab, Doe, 1990-01-01, 2008-01-01, 100000).
```

### `CHECK` cheklash misolini olib tashlash

Quyidagi bayonot `employees` jadvalidan `joined_date_check` `CHECK` cheklovini olib tashlaydi:

```sql
ALTER TABLE employees
DROP CONSTRAINT joined_date_check;
```

### Xulosa
* Boolean ifodaga asoslangan ustunlar qiymatlarini tekshirish uchun PostgreSQL `CHECK` cheklovidan foydalaning.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-check-constraint/)