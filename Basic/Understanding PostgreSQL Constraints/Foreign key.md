# Foreign Key
Ushbu qo'llanmada siz PostgreSQL `foreign key`i va `foreign key` cheklovlaridan foydalangan holda jadvallarning `foreign key`larini qanday qo'shish mumkinligi haqida bilib olasiz.

PostgreSQL-da `foreign key` **boshqa jadvaldagi** qatorni noyob tarzda identifikatsiya qiluvchi jadvaldagi ustun yoki ustunlar guruhidir.

`Foreign key` `primary key`ga yoki havola qilingan jadvalning `unique` chekloviga murojaat qilish orqali ikkita jadvaldagi ma'lumotlar o'rtasida bog'lanishni o'rnatadi.

`Foreign key`ni o'z ichiga olgan jadval **havolalar jadvali** yoki **bolalar jadvali** deb ataladi. Aksincha, `foreign key` bilan havola qilingan jadval **havola qilingan** jadval yoki **ota-jadval** deb nomlanadi.

`Foreign key`larning asosiy maqsadi relyatsion ma'lumotlar bazasida havolalar yaxlitligini ta'minlash, **ota-ona** va **pastki** jadvallar o'rtasidagi munosabatlarning haqiqiyligini ta'minlashdir.

Masalan, `foreign key` havola qilingan jadvalga mos qiymatlarga ega bo'lmagan qiymatlarni kiritishni oldini oladi.

Bundan tashqari, `foreign key` asosiy jadvalda o'zgarishlar sodir bo'lganda, bolalar jadvalidagi tegishli qatorlarni avtomatik ravishda yangilash yoki o'chirish orqali barqarorlikni saqlaydi.

Jadval boshqa jadvallar bilan aloqasiga qarab bir nechta `foreign key`larga ega bo'lishi mumkin.

`Foreign key`ini aniqlash uchun siz `foreign key` cheklovidan foydalanishingiz mumkin.

## PostgreSQL `foreign key`ni cheklash sintaksisi
Quyida `foreign key` cheklovi sintaksisi tasvirlangan:

```sql
[CONSTRAINT fk_name]
   FOREIGN KEY(fk_columns) 
   REFERENCES parent_table(parent_key_columns)
   [ON DELETE delete_action]
   [ON UPDATE update_action]
```
Ushbu sintaksisda:
* Birinchidan, `CONSTRAINT` kalit so'zidan keyin `foreign key` cheklovi nomini belgilang. `CONSTRAINT` bandi ixtiyoriy. Agar siz uni o'tkazib yuborsangiz, PostgreSQL avtomatik yaratilgan nomni tayinlaydi.
* Ikkinchidan, `FOREIGN KEY` kalit so'zlaridan keyin qavslar ichida bir yoki bir nechta `foreign key` ustunlarini belgilang.
* Uchinchidan, `REFERENCES` bandidagi `foreign key` ustunlari tomonidan havola qilingan asosiy jadval va asosiy kalit ustunlarini belgilang.
* Nihoyat, `ON DELETE` va `ON UPDATE` bandlarida kerakli o'chirish va yangilash amallarini belgilang.

Yo'q qilish va yangilash harakatlari ota-ona jadvalidagi asosiy kalit o'chirilganda va yangilanganda xatti-harakatlarni aniqlaydi.

Asosiy kalit kamdan-kam yangilanganligi sababli, `ON UPDATE action` amalda kamdan-kam qo'llaniladi. Biz e'tiborni `ON DELETE` amaliga qaratamiz.

PostgreSQL quyidagi amallarni qo'llab-quvvatlaydi:
* `SET NULL`
* `SET DEFAULT`
* `RESTRICT`
* `NO ACTION`
* `CASCADE`

## PostgreSQL `foreign key` constraint examples
Quyidagi bayonotlar `customers` va `contacts` jadvallarini yaratadi:
```sql
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS contacts;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
        REFERENCES customers(customer_id)
);
```

Bu misolda `customers` jadvali ota-ona jadvali, `contacts` jadvali esa bolalar jadvalidir.

Har bir mijoz nol yoki ko'p kontaktga ega va har bir kontakt nol yoki bitta mijozga tegishli.

`contacts` jadvalidagi `customer_id` ustuni `customers` jadvalidagi bir xil nomdagi asosiy kalit ustuniga havola qiluvchi `foreign key` ustunidir.

`contacts` jadvalidagi `fk_customer` `foreign key` cheklovi `customer_id` ni `foreign key` sifatida belgilaydi:
```sql
CONSTRAINT fk_customer
   FOREIGN KEY(customer_id) 
      REFERENCES customers(customer_id)
```

`Foreign key` cheklovida `ON DELETE` va `ON UPDATE` amallari mavjud emasligi sababli ular sukut bo'yicha `NO ACTION` ga o'rnatiladi.

### NO ACTION
Quyidagilar `customers` va `contacts` jadvallariga ma'lumotlarni kiritadi:
```sql
INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');	   
	   
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');
```

Quyidagi bayonot `customers` jadvalidan mijoz identifikatori 1ni o'chiradi:
```sql
DELETE FROM customers
WHERE customer_id = 1;
```

`ON DELETE NO ACTION` tufayli PostgreSQL cheklovni buzadi, chunki mijoz identifikatori 1 ning havola qatorlari hali ham `contacts` jadvalida mavjud:
```sql
ERROR:  update or delete on table "customers" violates foreign key constraint "fk_customer" on table "contacts"
DETAIL:  Key (customer_id)=(1) is still referenced from table "contacts".
SQL state: 23503
```

`RESRICT` amali `NO ACTION`ga o'xshaydi. Farq faqat `foreign key` cheklovi `INITIALLY DEFERRED` yoki `INITIALLY IMMEDIATE` `DEFERRABLE` rejimi bilan `foreign key` cheklovi belgilaganingizdagina yuzaga keladi. Kelgusi darsda bu haqda ko'proq gaplashamiz.

### SET NULL
`SET NULL`, ota-jadvaldagi havola qilingan satrlar o'chirilganda, avtomatik ravishda `NULL`ni pastki jadvalning havola qiluvchi satrlaridagi `foreign key` ustunlariga o'rnatadi.

Birinchidan, namunaviy jadvallarni tashlang va ularni `ON DELETE` bandidagi `SET NULL` amalidan foydalanadigan `foreign key` yordamida qayta yarating:
```sql
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
	  ON DELETE SET NULL
);
```

Ikkinchidan, `customers` va `contacts` jadvallariga ma'lumotlarni kiriting:
```sql
INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');	   
	   
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');
```

Uchinchidan, `customers` jadvalidan 1 identifikatorli mijozni o'chirib tashlang:
```sql
DELETE FROM customers
WHERE customer_id = 1;
```

`ON DELETE SET NULL` amali tufayli `contacts` jadvalidagi havola satrlari `NULL`ga o'rnatiladi.

Nihoyat, `contacts` jadvalidagi ma'lumotlarni ko'rsating:
```sql
SELECT * FROM contacts;
````

Chiqish:
```sql
 contact_id | customer_id | contact_name |     phone      |          email
------------+-------------+--------------+----------------+--------------------------
          3 |           2 | David Wright | (408)-222-1234 | david.wright@dolphin.dev
          1 |        null | John Doe     | (408)-111-1234 | john.doe@bluebird.dev
          2 |        null | Jane Doe     | (408)-111-1235 | jane.doe@bluebird.dev
(3 rows)
```

Chiqish shuni ko'rsatadiki, mijoz identifikatori 1 qiymatlari `NULL`ga o'zgargan.

### CASCADE
`ON DELETE CASCADE` ota-jadvaldagi havola qilingan satrlar o'chirilganda, bolalar jadvalidagi barcha havola qiluvchi qatorlarni avtomatik ravishda o'chiradi. Amalda, `ON DELETE CASCADE` eng ko'p ishlatiladigan variant hisoblanadi.

Quyidagi bayonotlar `fk_customer`ning `CASCADE` ga o'zgartirishlarini o'chirish amali bilan namunaviy jadvallarni qayta yaratadi:
```sql
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
	  ON DELETE CASCADE
);

INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');	   
	   
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');
```

Quyidagi bayonot mijoz identifikatori 1ni o'chirib tashlaydi:
```sql
DELETE FROM customers
WHERE customer_id = 1;
```

`ON DELETE CASCADE` amali tufayli `contacts` jadvalidagi barcha havola qatorlari avtomatik ravishda oʻchiriladi:

```sql
SELECT * FROM contacts;
```

Chiqish:
```sql
 contact_id | customer_id | contact_name |     phone      |          email
------------+-------------+--------------+----------------+--------------------------
          3 |           2 | David Wright | (408)-222-1234 | david.wright@dolphin.dev
(1 row)
```

### SET DEFAULT
`ON DELETE SET DEFAULT` ota-jadvaldagi havola qilingan satrlar o'chirilganda, ichki jadvaldagi havola qiluvchi qatorlarning `foreign key` ustuniga standart qiymatni o'rnatadi.

## Mavjud jadvalga `foreign key` cheklovini qo'shing
Mavjud jadvalga `foreign key` cheklovini qo'shish uchun siz `ALTER TABLE` bayonotining quyidagi shaklidan foydalanasiz:

```sql
ALTER TABLE child_table 
ADD CONSTRAINT constraint_name 
FOREIGN KEY (fk_columns) 
REFERENCES parent_table (parent_key_columns);
```

Mavjud jadvalga `ON DELETE CASCADE` opsiyasi bilan `foreign key` cheklovini qo'shganda, siz quyidagi amallarni bajarishingiz kerak:

Birinchidan, mavjud `Foreign key`i cheklanishini bekor qiling:

```sql
ALTER TABLE child_table
DROP CONSTRAINT constraint_fkey;
```

Ikkinchidan, `ON DELETE CASCADE` amali bilan yangi `foreign key` cheklovini qoʻshing:

```sql
ALTER TABLE child_table
ADD CONSTRAINT constraint_fk
FOREIGN KEY (fk_columns)
REFERENCES parent_table(parent_key_columns)
ON DELETE CASCADE;
```

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-foreign-key/)