# DROP COLUMN

Ushbu qo'llanma sizga jadvalning bir yoki bir nechta ustunlarini olib tashlash uchun `ALTER TABLE` bayonotidagi PostgreSQL `DROP COLUMN` bandidan qanday foydalanishni ko'rsatadi.

Jadval ustunini o'chirish uchun siz `ALTER TABLE` iborasida quyidagi tarzda `DROP COLUMN` bandidan foydalanasiz:


```sql
ALTER TABLE table_name 
DROP COLUMN column_name;
```

Jadvaldan ustunni olib tashlaganingizda, PostgreSQL o'chirilgan ustunga taalluqli barcha indekslar va cheklovlarni avtomatik ravishda olib tashlaydi. Agar siz olib tashlamoqchi bo'lgan ustun ko'rinishlar, triggerlar, saqlangan protseduralar va boshqalar kabi boshqa ma'lumotlar bazasi ob'ektlarida ishlatilsa, ustunni o'chirib bo'lmaydi, chunki boshqa ob'ektlar unga bog'liq. Bunday holda, ustunni va unga bog'liq bo'lgan barcha ob'ektlarni tushirish uchun `CASCADE` opsiyasini `DROP COLUMN` bandiga qo'shishingiz kerak:

```sql
ALTER TABLE table_name 
DROP COLUMN column_name CASCADE;
```

Agar mavjud bo'lmagan ustunni olib tashlasangiz, PostgreSQL xatolik chiqaradi. Ustunni faqat mavjud bo'lsa olib tashlash uchun `IF EXISTS` opsiyasini quyidagi tarzda qo'shishingiz mumkin:

```sql
ALTER TABLE table_name 
DROP COLUMN IF EXISTS column_name;
```

Ushbu shaklda mavjud bo'lmagan ustunni olib tashlasangiz, PostgreSQL xato o'rniga xabar beradi.

Agar bitta buyruqda jadvalning bir nechta ustunlarini tashlamoqchi bo'lsangiz, quyidagi kabi bir nechta `DROP COLUMN` bandidan foydalanasiz:

```sql
ALTER TABLE table_name
DROP COLUMN column_name1,
DROP COLUMN column_name2,
...;
```

E'tibor bering, har bir `DROP COLUMN` bandidan keyin vergul `(,)` qo'shishingiz kerak.

Jadvalda bitta ustun bo'lsa, uni `ALTER TABLE DROP COLUMN` iborasi yordamida tashlab qo'yishingiz mumkin. Jadvalda ustun yo'q. Bu PostgreSQL-da mumkin, ammo SQL standartiga ko'ra mumkin emas.

`ALTER TABLE DROP COLUMN` bayonoti qanday ishlashini ko'rish uchun ba'zi misollarni ko'rib chiqamiz.

## PostgreSQL `DROP COLUMN` misollari

Biz uchta jadval yaratamiz: `books`, `categories` va namoyish uchun `publishers`.

![tables](https://www.postgresqltutorial.com/wp-content/uploads/2017/02/PostgreSQL-DROP-COLUMN-Example-Diagram.png)

Ushbu diagrammada har bir kitobda faqat bitta nashriyot bor va har bir nashriyot ko'plab kitoblarni nashr etishi mumkin. Har bir kitob toifaga ajratilgan va har bir turkumda ko'plab kitoblar bo'lishi mumkin

Quyidagi bayonotlar uchta jadvalni yaratadi:

```sql
CREATE TABLE publishers (
    publisher_id serial PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE categories (
    category_id serial PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE books (
    book_id serial PRIMARY KEY,
    title VARCHAR NOT NULL,
    isbn VARCHAR NOT NULL,
    published_date DATE NOT NULL,
    description VARCHAR,
    category_id INT NOT NULL,
    publisher_id INT NOT NULL,
    FOREIGN KEY (publisher_id) 
       REFERENCES publishers (publisher_id),
    FOREIGN KEY (category_id) 
       REFERENCES categories (category_id)
);
```

Bundan tashqari, biz `books` va `publishers` jadvallari asosida quyidagi ko'rinishni yaratamiz:

```sql
CREATE VIEW book_info 
AS SELECT
    book_id,
    title,
    isbn,
    published_date,
    name
FROM
    books b
INNER JOIN publishers 
    USING(publisher_id)
ORDER BY title;
```

Quyidagi bayonot `books` jadvalidan `category_id` ustunini olib tashlash uchun `ALTER TABLE DROP COLUMN` iborasidan foydalanadi:

```sql
ALTER TABLE books 
DROP COLUMN category_id;
```

Keling, `books` jadvalining tuzilishini ko'rsatamiz:

```sql
test=# \d books;
                                     Table "public.books"
     Column     |       Type        |                        Modifiers
----------------+-------------------+---------------------------------------------------------
 book_id        | integer           | not null default nextval('books_book_id_seq'::regclass)
 title          | character varying | not null
 isbn           | character varying | not null
 published_date | date              | not null
 description    | character varying |
 publisher_id   | integer           | not null
Indexes:
    "books_pkey" PRIMARY KEY, btree (book_id)
Foreign-key constraints:
    "books_publisher_id_fkey" FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
```

Natijadan ko'rinib turibdiki, bayonot nafaqat `category_id` ustunini, balki `category_id` ustunini o'z ichiga olgan tashqi kalit cheklovini ham olib tashladi.

Quyidagi bayonot `publisher_id` ustunini olib tashlashga harakat qiladi:

```sql
ALTER TABLE books 
DROP COLUMN publisher_id;
```

PostgreSQL quyidagi xatoni chiqardi:

```sql
ERROR:  cannot drop table books column publisher_id because other objects depend on it
DETAIL:  view book_info depends on table books column publisher_id
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
```

Unda aytilishicha, `book_info` koʻrinishi `books` jadvalining `publisher_id` ustunidan foydalanmoqda. Quyidagi bayonotda ko'rsatilganidek, `publisher_id` ustuni va `book_info` ko'rinishini olib tashlash uchun `CASCADE` opsiyasidan foydalanishingiz kerak:

```sql
ALTER TABLE books 
DROP COLUMN publisher_id CASCADE;
```

Bayonotda biz kutgan narsa bo'lgan quyidagi xabarnoma e'lon qilindi.

```sql
NOTICE:  drop cascades to view book_info
```

Bitta bayonot yordamida `isbn` va `description` ustunlarini olib tashlash uchun siz quyidagi tarzda bir nechta `DROP COLUMN` bandlarini qo'shishingiz kerak:

```sql
ALTER TABLE books 
  DROP COLUMN isbn,
  DROP COLUMN description;
```

Kutilganidek ishladi.

Ushbu qo'llanmada siz jadvaldan bir yoki bir nechta ustunlarni tushirish uchun `ALTER TABLE` bayonotidagi PostgreSQL `DROP COLUMN` bandidan qanday foydalanishni o'rgandingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-drop-column/)