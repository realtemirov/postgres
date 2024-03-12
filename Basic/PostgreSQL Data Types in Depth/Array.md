# Array

Ushbu qo'llanmada siz PostgreSQL `massivi` bilan qanday ishlashni va `massivni` manipulyatsiya qilish uchun ba'zi qulay funktsiyalardan qanday foydalanishni o'rganasiz.

PostgreSQL-da bir xil ma'lumotlar turiga ega bo'lgan elementlar to'plami.

Massivlar bir o'lchovli, ko'p o'lchovli va hatto ichki qatorlar bo'lishi mumkin.

Har bir maʼlumot turi oʻzining qoʻshimcha massiv turiga ega, masalan, butun sonda `integer[]` massiv turi, belgilarda `character[]` massiv tipi mavjud.

Agar siz foydalanuvchi tomonidan belgilangan ma'lumotlar turini aniqlasangiz, `PostgreSQL` siz uchun avtomatik ravishda mos keladigan massiv turini ham yaratadi.

Massiv turiga ega ustunni aniqlash uchun siz quyidagi sintaksisdan foydalanasiz

```sql
column_name datatype []
```

Sintaksisda biz ma'lumotlar turining bir o'lchovli massivini aniqlaymiz. 

Masalan, quyidagi bayonot matn massivi bilan belgilangan `phones` ustuni bilan `contacts` deb nomlangan yangi jadval yaratadi.

```sql
CREATE TABLE contacts (
  id SERIAL PRIMARY KEY, 
  name VARCHAR (100), 
  phones TEXT []
);
```

`phones` ustuni bir o'lchovli massiv bo'lib, unda kontaktda bo'lishi mumkin bo'lgan turli telefon raqamlari mavjud.

Ko'p o'lchovli massivni aniqlash uchun siz kvadrat qavslarni qo'shishingiz kerak.

Masalan, ikki o'lchovli massivni quyidagicha belgilashingiz mumkin:

```sql
column_name data_type [][]
```

## Massivga ma'lumotlarni kiritish

Quyidagi bayonot kontaktlar jadvaliga yangi kontaktni kiritadi.

```sql
INSERT INTO contacts (name, phones)
VALUES('John Doe',ARRAY [ '(408)-589-5846','(408)-589-5555' ]);
```

Ushbu misolda biz massiv qurish va uni `contacts` jadvaliga kiritish uchun `ARRAY` konstruktoridan foydalanamiz.

Shu bilan bir qatorda, `jingalak` qavslardan quyidagi tarzda foydalanishingiz mumkin:

```sql
INSERT INTO contacts (name, phones)
VALUES('Lily Bush','{"(408)-589-5841"}'),
      ('William Gate','{"(408)-589-5842","(408)-589-58423"}');
```

Ushbu bayonotda biz `contacts` jadvaliga ikkita qatorni kiritamiz.

E'tibor bering, jingalak qavslardan foydalanganda siz massivni o'rash uchun `"yagona tirnoq" - (')` dan, matn massivi elementlarini o'rash uchun `"ikki tirnoq" - (")` dan foydalanasiz.

## Massiv maʼlumotlari soʻraash

Quyidagi bayonot `contacts` jadvalidan ma'lumotlarni oladi:

```sql
SELECT 
  name, 
  phones 
FROM 
  contacts;
```

Chiqish:
```sql
     name     |              phones
--------------+----------------------------------
 John Doe     | {(408)-589-5846,(408)-589-5555}
 Lily Bush    | {(408)-589-5841}
 William Gate | {(408)-589-5842,(408)-589-58423}
(3 rows)
```

Massiv elementiga kirish uchun siz kvadrat qavslar ichidagi pastki belgidan foydalanasiz `[]`.

Odatiy bo'lib, PostgreSQL massiv elementlari uchun bitta asoslangan raqamlashni qo'llaydi. Bu birinchi massiv elementi 1 raqamidan boshlanishini bildiradi.

Quyidagi bayonot kontaktning ismini va birinchi telefon raqamini oladi:

```sql
SELECT 
  name, 
  phones [ 1 ] 
FROM 
  contacts;
```

Chiqish:
```sql
     name     |     phones
--------------+----------------
 John Doe     | (408)-589-5846
 Lily Bush    | (408)-589-5841
 William Gate | (408)-589-5842
(3 rows)
```

Qatorlarni filtrlash sharti sifatida `WHERE` bandidagi massiv elementidan foydalanishingiz mumkin.

Masalan, quyidagi soʻrov ikkinchi telefon raqami sifatida `(408)-589-58423`  telefon raqamiga ega boʻlgan kontaktlarni topadi:

```sql
SELECT 
  name 
FROM 
  contacts 
WHERE 
  phones [ 2 ] = '(408)-589-58423';
```

Chiqish:
```sql
    name
--------------
 William Gate
(1 row)
```

## PostgreSQL massivini o'zgartirish

PostgreSQL massivning har bir elementini yoki butun massivni yangilash imkonini beradi.

Quyidagi bayonot `Uilyam Geytning` ikkinchi telefon raqamini yangilaydi.

```sql
UPDATE contacts
SET phones [2] = '(408)-589-5843'
WHERE ID = 3
RETURNING *;
```

Chiqish:
```sql
 id |     name     |             phones
----+--------------+---------------------------------
  3 | William Gate | {(408)-589-5842,(408)-589-5843}
(1 row)
```

Quyidagi bayonot butun massivni yangilaydi.

```sql
UPDATE 
  contacts 
SET 
  phones = '{"(408)-589-5843"}' 
WHERE 
  id = 3
RETURNING *;
```

Chiqish:
```sql
 id |     name     |      phones
----+--------------+------------------
  3 | William Gate | {(408)-589-5843}
(1 row)
```

## PostgreSQL massivida qidiruv:

Aytaylik, siz `(408)-589-5555` telefon raqamiga kim ega ekanligini bilmoqchi bo'lsangiz, telefon raqamining `phones` massividagi joylashuvidan qat'i nazar, `ANY()` funksiyasidan quyidagicha foydalanishingiz mumkin:

```sql
SELECT 
  name, 
  phones 
FROM 
  contacts 
WHERE 
  '(408)-589-5555' = ANY (phones);
```

Chiqish:

```sql
   name   |             phones
----------+---------------------------------
 John Doe | {(408)-589-5846,(408)-589-5555}
(1 row)
```

## Massivlarni kengaytirish
PostgreSQL massivni qatorlar roʻyxatiga kengaytirish uchun `unnest()` funksiyasini taqdim etadi. Masalan, quyidagi so'rov `phones` qatorining barcha telefon raqamlarini kengaytiradi.

```sql
SELECT 
  name, 
  unnest(phones) 
FROM 
  contacts;
```

Chiqish:
```sql
name     |     unnest
--------------+----------------
 John Doe     | (408)-589-5846
 John Doe     | (408)-589-5555
 Lily Bush    | (408)-589-5841
 William Gate | (408)-589-5843
(4 rows)
```

## Xulosa:
* PostgreSQL-da massiv bir xil turdagi ma'lumotlarga ega bo'lgan elementlar to'plamidir.

* Ustun uchun bir o'lchovli massivni aniqlash uchun `data_type []` dan foydalaning.

* Massivning `indeks` elementiga kirish uchun `[indeks]` sintaksisidan foydalaning. Birinchi element bitta indeksga ega.

* Massivni qatorlar roʻyxatiga kengaytirish uchun `unnest()` funksiyasidan foydalaning.


© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-array/)