# RENAME COLUMN

Ushbu qo'llanmada siz jadvalning bir yoki bir nechta ustunlari nomini o'zgartirish uchun `ALTER TABLE` iborasidagi PostgreSQL `RENAME COLUMN` bandidan qanday foydalanishni o'rganasiz.

![image](https://www.postgresqltutorial.com/wp-content/uploads/2017/02/postgresql-rename-column-300x254.png)

Jadval ustunining nomini o'zgartirish uchun siz `ALTER TABLE` iborasidagi `RENAME COLUMN` bandidan quyidagi tarzda foydalanasiz:

```sql
ALTER TABLE table_name 
RENAME COLUMN column_name TO new_column_name;
```

Ushbu bayonotda:

* Birinchidan, `ALTER TABLE` bandidan keyin nomini o'zgartirmoqchi bo'lgan ustunni o'z ichiga olgan jadval nomini belgilang.
* Ikkinchidan, `RENAME COLUMN` kalit so'zlaridan keyin nomini o'zgartirmoqchi bo'lgan ustun nomini ko'rsating.
* Uchinchidan, `TO` kalit so'zidan keyin ustun uchun yangi nomni belgilang.

Bayonotdagi `COLUMN` kalit so'zi ixtiyoriy, shuning uchun uni quyidagi tarzda o'tkazib yuborishingiz mumkin:

```sql
ALTER TABLE table_name 
RENAME column_name TO new_column_name;
```

Ba'zi sabablarga ko'ra, mavjud bo'lmagan ustun nomini o'zgartirmoqchi bo'lsangiz, PostgreSQL xatolik chiqaradi. Afsuski, PostgreSQL `RENAME` bandi uchun `IF EXISTS` opsiyani taqdim etmaydi.

Bir nechta ustunlar nomini o'zgartirish uchun siz `RENAME` buyrug'ini bir vaqtning o'zida bir ustunni bir necha marta bajarishingiz kerak:

```sql
ALTER TABLE table_name
RENAME column_name1 TO new_column_name1;

ALTER TABLE table_name
RENAME column_name2 TO new_column_name2;
```

`view`, `foreign key` cheklovlari, `trigger`lar va `stored prosedura` kabi boshqa maʼlumotlar bazasi obyektlari tomonidan havola qilingan ustun nomini oʻzgartirsangiz, PostgreSQL bogʻliq obʼyektlardagi ustun nomini avtomatik ravishda oʻzgartiradi.

Keling, yaxshiroq tushunish uchun `ALTER TABLE RENAME COLUMN` dan foydalanishga misollar keltiraylik.

#### Namuna jadvallarini o'rnatish

Birinchidan, ikkita yangi `customers` va `customer_groups` jadvalirini yarating.

```sql
CREATE TABLE customer_groups (
    id serial PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE customers (
    id serial PRIMARY KEY,
    name VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,
    email VARCHAR,
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES customer_groups (id)
);
```

Keyin, `customers` va `customers_group` jadvallari asosida `customer_data` nomli yangi ko'rinish yarating.

```sql
CREATE VIEW customer_data 
AS SELECT
    c.id,
    c.name,
    g.name customer_group
FROM
    customers c
INNER JOIN customer_groups g ON g.id = c.group_id;
```

#### Bitta ustun nomini oʻzgartirish uchun `RENAME COLUMNE` dan foydalanish

Quyidagi bayonot `customers` jadvalining `email` ustunini `contact_email` ga o'zgartirish uchun `ALTER TABLE RENAME COLUMN` bayonotidan foydalanadi:

```sql
ALTER TABLE customers 
RENAME COLUMN email TO contact_email;
```

#### Bog'liq ob'ektlarga ega bo'lgan ustun nomini o'zgartirish uchun `RENAME COLUMN` dan foydalaning

Ushbu misolda `customers` jadvalining `name` ustunini `group_name` ga o'zgartirish uchun `ALTER TABLE RENAME COLUMN` iborasidan foydalaniladi. `name` ustuni `customer_data` ko'rinishida ishlatiladi.

```sql
ALTER TABLE customer_groups 
RENAME COLUMN name TO group_name;
```

Endi siz `name` ustunining o'zgarishi `customer_data` ko'rinishiga kaskadlanganligini tekshirishingiz mumkin:

```sql
test=# \d+ customer_data;
                       View "public.customer_data"
     Column     |       Type        | Modifiers | Storage  | Description
----------------+-------------------+-----------+----------+-------------
 id             | integer           |           | plain    |
 name           | character varying |           | extended |
 customer_group | character varying |           | extended |
View definition:
 SELECT c.id,
    c.name,
    g.group_name AS customer_group
   FROM customers c
     JOIN customer_groups g ON g.id = c.group_id;
```

Ko'rinish ta'rifida ko'rib turganingizdek, `name` ustuni `group_name` ga o'zgartirildi.

#### Bir nechta ustun nomini oʻzgartirish uchun bir nechta `RENAME COLUMN`dan foydalanish misoli

Ushbu bayonotlar `customers` jadvalining ikkita ustun `name` va `phone` mos ravishda `customer_name` va `contact_phone`ga o'zgartiradi:

```sql
ALTER TABLE customers 
RENAME COLUMN name TO customer_name;

ALTER TABLE customers
RENAME COLUMN phone TO contact_phone;
```

Ushbu qo'llanmada siz ustun nomini o'zgartirish uchun `ALTER TABLE` iborasidagi PostgreSQL `RENAME COLUMN` bandidan qanday foydalanishni o'rgandingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rename-column/)