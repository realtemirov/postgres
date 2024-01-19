# Copy Table

Ushbu qo'llanmada biz sizga PostgreSQL nusxa ko'chirish jadvali bayonotining turli shakllaridan foydalangan holda mavjud jadvalni, jumladan jadval tuzilishi va ma'lumotlarini qanday nusxalashni bosqichma-bosqich ko'rsatamiz.

![copy a table](https://www.postgresqltutorial.com/wp-content/uploads/2017/03/PostgreSQL-Copy-Table-300x260.png)

Jadvalning tuzilishi va ma'lumotlarini o'z ichiga olgan holda to'liq nusxa ko'chirish uchun siz quyidagi bayonotdan foydalanasiz:

```sql
CREATE TABLE new_table AS 
TABLE existing_table;
```

Jadval strukturasini ma'lumotlarsiz nusxalash uchun siz `CREATE TABLE` iborasiga `WITH NO DATA` bandini quyidagi tarzda qo'shishingiz kerak:

```sql
CREATE TABLE new_table AS 
TABLE existing_table 
WITH NO DATA;
```

Mavjud jadvaldan qisman ma'lumotlarga ega jadvalni nusxalash uchun siz quyidagi bayonotdan foydalanasiz:

```sql
CREATE TABLE new_table AS 
SELECT
*
FROM
    existing_table
WHERE
    condition;
```

So'rovning `WHERE` bandidagi shart mavjud jadvalning qaysi qatorlari yangi jadvalga ko'chirilishini belgilaydi.

E'tibor bering, yuqoridagi barcha bayonotlar jadval tuzilishi va ma'lumotlarini nusxa ko'chiradi, lekin mavjud jadvalning indekslari va cheklovlarini ko'chirmang.

## PostgreSQL jadval nusxasiga misol

Quyidagi bayonot namoyish uchun `contacts` nomli yangi jadval yaratadi:

```sql
CREATE TABLE contacts(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE
);
```

Ushbu jadvalda bizda ikkita indeks mavjud: biri asosiy kalit uchun, ikkinchisi esa `UNIQUE` cheklovi uchun.

`contacts` jadvaliga bir nechta qatorlarni kiritamiz:

```sql
INSERT INTO contacts(first_name, last_name, email) 
VALUES('John','Doe','john.doe@postgresqltutorial.com'),
      ('David','William','david.william@postgresqltutorial.com');
```

`contacts`ni yangi jadvalga, masalan, `contacts_backup` jadvaliga nusxalash uchun siz quyidagi bayonotdan foydalanasiz:

```sql
CREATE TABLE contact_backup 
AS TABLE contacts;
```

Ushbu bayonot strukturasi `contacts` jadvali bilan bir xil bo'lgan `contact_backup` nomli yangi jadvalni yaratadi. Bundan tashqari, u `contacts` jadvalidagi ma'lumotlarni `contact_backup` jadvaliga ko'chiradi.

Quyidagi `SELECT` iborasidan foydalanib `contact_backup` jadvali maʼlumotlarini tekshiramiz:

```sql
SELECT * FROM contact_backup;

id | first_name | last_name |                email
----+------------+-----------+--------------------------------------
  1 | John       | Doe       | john.doe@postgresqltutorial.com
  2 | David      | William   | david.william@postgresqltutorial.com

(2 rows)
```

U kutilganidek ikki qatorni qaytaradi.

`contact_backup` jadvalining tuzilishini tekshirish uchun:

```sql
test=# \d contact_backup;
       Table "public.contact_backup"
   Column   |       Type        | Modifiers
------------+-------------------+-----------
 id         | integer           |
 first_name | character varying |
 last_name  | character varying |
 email      | character varying |
```

Chiqishda ko'rib turganingizdek, `contact_backup` jadvalining tuzilishi indekslardan tashqari `contacts` jadvali bilan bir xil.

`contact_backup` jadvaliga asosiy kalit va `UNIQUE` cheklovlarni qoʻshish uchun quyidagi `ALTER TABLE` iboralaridan foydalanasiz:

```sql
ALTER TABLE contact_backup ADD PRIMARY KEY(id);
ALTER TABLE contact_backup ADD UNIQUE(email);
```

`contact_backup` jadvalining tuzilishini qayta ko'rish uchun `\d` buyrug'idan foydalanasiz:

```sql
test=# \d contact_backup;
       Table "public.contact_backup"
   Column   |       Type        | Modifiers
------------+-------------------+-----------
 id         | integer           | not null
 first_name | character varying |
 last_name  | character varying |
 email      | character varying |
Indexes:
    "contact_backup_pkey" PRIMARY KEY, btree (id)
    "contact_backup_email_key" UNIQUE CONSTRAINT, btree (email)
```

Ushbu qo'llanmada siz PostgreSQL nusxa ko'chirish jadvali bayonotidan foydalanib, mavjud jadvalni yangisiga ko'chirishni o'rgandingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-copy-table/)