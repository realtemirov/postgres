# DROP TABLE

Ushbu qo'llanmada siz mavjud jadvallarni ma'lumotlar bazasidan olib tashlash uchun PostgreSQL `DROP TABLE` bayonotidan qanday foydalanishni o'rganasiz.

Ma'lumotlar bazasidan jadvalni olib tashlash uchun siz `DROP TABLE` iborasidan quyidagi tarzda foydalanasiz:

```sql
DROP TABLE [IF EXISTS] table_name 
[CASCADE | RESTRICT];
```

Ushbu sintaksisda:
* Birinchidan, `DROP TABLE` kalit so'zlaridan keyin qo'ymoqchi bo'lgan jadval nomini belgilang.
* Ikkinchidan, agar mavjud bo'lsa, jadvalni o'chirish uchun `IF EXISTS` variantidan foydalaning.

Agar mavjud bo'lmagan jadvalni olib tashlasangiz, PostgreSQL xatolik chiqaradi. Bunday vaziyatdan qochish uchun siz `IF EXISTS` opsiyasidan foydalanishingiz mumkin.

Agar siz olib tashlamoqchi bo'lgan jadval ko'rinishlar, triggerlar, funktsiyalar va saqlangan protseduralar kabi boshqa ob'ektlarda ishlatilsa, `DROP TABLE` jadvalni o'chira olmaydi. Bunday holda sizda ikkita variant mavjud:
* `CASCADE` opsiyasi jadval va unga bog'liq ob'ektlarni olib tashlash imkonini beradi.
* `RESTRICT` opsiyasi jadvalga bog'liq bo'lgan ob'ekt mavjud bo'lsa, olib tashlashni rad etadi. Agar siz uni `DROP TABLE` bayonotida aniq ko'rsatmasangiz, `RESTRICT` opsiyasida default bo'ladi.

Bir vaqtning o'zida bir nechta jadvallarni o'chirish uchun `DROP TABLE` kalit so'zlaridan keyin vergul bilan ajratilgan jadvallar ro'yxatini qo'yishingiz mumkin:

```sql
DROP TABLE [IF EXISTS] 
   table_name_1,
   table_name_2,
   ...
[CASCADE | RESTRICT];
```

Jadvallarni o'chirish uchun siz superuser, sxema egasi yoki jadval egasi rollariga ega bo'lishingiz kerakligini unutmang.

## PostgreSQL `DROP TABLE` misollari

Keling, PostgreSQL `DROP TABLE` bayonotidan foydalanishga misollar keltiraylik

### 1. Mavjud bo'lmagan jadvalni tashlang

Quyidagi bayonot ma'lumotlar bazasida `author` deb nomlangan jadvalni olib tashlaydi:

```sql
DROP TABLE author;
```

PostgreSQL xatolik yuz beradi, chunki `author` jadvali mavjud emas.

```sql
[Err] ERROR:  table "author" does not exist
```

Xatolikka yo'l qo'ymaslik uchun siz `IF EXISST` opsiyasidan foydalanishingiz mumkin.

```sql
DROP TABLE IF EXISTS author;

NOTICE:  table "author" does not exist, skipping DROP TABLE
```

Natijadan aniq ko'rinib turibdiki, PostgreSQL xato o'rniga bildirishnoma chiqardi.

### 2. Bog'liq ob'ektlari bo'lgan jadvalni tashlang

Quyidagilar `authors` va `pages` deb nomlangan yangi jadvallarni yaratadi:

```sql
CREATE TABLE authors (
	author_id INT PRIMARY KEY,
	firstname VARCHAR (50),
	lastname VARCHAR (50)
);

CREATE TABLE pages (
	page_id serial PRIMARY KEY,
	title VARCHAR (255) NOT NULL,
	contents TEXT,
	author_id INT NOT NULL,
	FOREIGN KEY (author_id) 
          REFERENCES authors (author_id)
);
```

Quyidagi ibora muallif jadvalini o'chirish uchun `DROP TABLE` dan foydalanadi:

```sql
DROP TABLE IF EXISTS authors;
```

`page` jadvalidagi cheklov `author` bog'liq bo'lgani uchun PostgreSQL xato xabari chiqaradi:

```sql
ERROR:  cannot drop table authors because other objects depend on it
DETAIL:  constraint pages_author_id_fkey on table pages depends on table authors
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
SQL state: 2BP01
```

Bunday holda, `author` jadvalini o'chirishdan oldin barcha bog'liq ob'ektlarni olib tashlashingiz yoki `CASCADE` opsiyasini quyidagicha ishlatishingiz kerak:

```sql
DROP TABLE authors CASCADE;
```

PostgreSQL `page` jadvalidagi `author` va cheklovni olib tashlaydi

Agar `DROP TABLE` iborasi o'chirilayotgan jadvalning bog'liq ob'ektlarini olib tashlasa, u shunday xabar beradi:

```sql
NOTICE:  drop cascades to constraint pages_author_id_fkey on table pages
```

### 3. Bir nechta jadvallarni tashlang
Quyidagi bayonotlar demo maqsadlari uchun ikkita jadval yaratadi:

```sql
CREATE TABLE tvshows(
	tvshow_id INT GENERATED ALWAYS AS IDENTITY,
	title VARCHAR,
	release_year SMALLINT,
	PRIMARY KEY(tvshow_id)
);

CREATE TABLE animes(
	anime_id INT GENERATED ALWAYS AS IDENTITY,
	title VARCHAR,
	release_year SMALLINT,
	PRIMARY KEY(anime_id)
);
```

Quyidagi misolda `tvshows` va `animes` jadvallarini o'chirish uchun bitta `DROP TABLE` iborasidan foydalaniladi:

```sql
DROP TABLE tvshows, animes;
```

## Xulosa
* Jadvalni tushirish uchun `DROP TABLE` iborasidan foydalaning.
* Jadvalni va unga bog'liq bo'lgan barcha ob'ektlarni tushirish uchun `CASCADE` opsiyasidan foydalaning.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-drop-table/)