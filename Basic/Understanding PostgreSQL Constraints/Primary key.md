# Primary key

Ushbu qo'llanmada biz sizga asosiy kalit nima ekanligini va SQL bayonotlari orqali PostgreSQL primary key cheklovlarini qanday boshqarishni ko'rsatamiz.

`Primary key`(asosiy kalit) - bu jadvaldagi satrni yagona aniqlash uchun ishlatiladigan ustun yoki ustunlar guruhi.

Siz primary keylarni primary key cheklovlar orqali aniqlaysiz. Texnik jihatdan, primary key `null` boʻlmagan cheklov va `UNIQUE` cheklovning kombinatsiyasi hisoblanadi.

Jadvalda bitta va faqat bitta primary key bo'la oladi. Har bir jadvalga primary keyni qo'shish yaxshi amaliyotdir. Jadvalga primary key qo'shsangiz, PostgreSQL ustunda noyob `B-tree indeksini` yoki `primary key`ni aniqlash uchun foydalaniladigan ustunlar guruhini yaratadi.

Odatda, biz `CREATE TABLE` iborasi yordamida jadval tuzilishini aniqlaganimizda, jadvalga primary keyni qo'shamiz.

```sql
CREATE TABLE TABLE (
	column_1 data_type PRIMARY KEY,
	column_2 data_type,
	…
);
```

Quyidagi bayonot `po_headers` nomi bilan xarid buyurtmasi (PO-purchase order) sarlavhalari jadvalini yaratadi.

```sql
CREATE TABLE po_headers (
	po_no INTEGER PRIMARY KEY,
	vendor_no INTEGER,
	description TEXT,
	shipping_address TEXT
);
```

`po_no` - `po_headers` jadvalining primary keyi bo'lib, u `po_headers` jadvalidagi xarid tartibini noyob tarzda aniqlaydi.

Agar primary key ikki yoki undan ortiq ustundan iborat bo'lsa, siz primary key cheklovini quyidagicha belgilaysiz:

```sql
CREATE TABLE TABLE (
	column_1 data_type,
	column_2 data_type,
	… 
        PRIMARY KEY (column_1, column_2)
);
```

Masalan, quyidagi bayonot xarid buyurtmasi satrlari jadvalini yaratadi, uning primary keyi xarid buyurtmasi raqami ( `po_no`) va qator elementi raqami ( `item_no`) kombinatsiyasidan iborat.

```sql
CREATE TABLE po_items (
	po_no INTEGER,
	item_no INTEGER,
	product_no INTEGER,
	qty INTEGER,
	net_price NUMERIC,
	PRIMARY KEY (po_no, item_no)
);
```

Agar siz birlamchi kalit cheklovi nomini aniq belgilamasangiz, PostgreSQL primary key chekloviga standart nom tayinlaydi. Odatiy bo'lib, PostgreSQL primary key cheklovi uchun standart nom sifatida `table-name_pkey` dan foydalanadi. Ushbu misolda PostgreSQL `po_items` jadvali uchun `po_items_pkey` nomi bilan primary key cheklovini yaratadi.

Agar siz primary key cheklovi nomini belgilamoqchi boʻlsangiz, `CONSTRAINT` bandidan quyidagi tarzda foydalanasiz:

```sql
CONSTRAINT constraint_name PRIMARY KEY(column_1, column_2,...);
```

## Mavjud jadval tuzilmasini o'zgartirishda primary keyni aniqlash

Mavjud jadval uchun primary keyni aniqlash kamdan-kam uchraydi. Agar buni qilish kerak bo'lsa, primary key cheklovini qo'shish uchun `ALTER TABLE` iborasidan foydalanishingiz mumkin.

```sql
ALTER TABLE table_name ADD PRIMARY KEY (column_1, column_2);
```

Quyidagi bayonot hech qanday primary keyni belgilamasdan `products` nomli jadval yaratadi.

```sql
CREATE TABLE products (
	product_no INTEGER,
	description TEXT,
	product_cost NUMERIC
);
```

Siz `mahsulotlar` jadvaliga primary key cheklovini qo'shmoqchi bo'lsangiz, quyidagi bayonotni bajarishingiz mumkin:

```sql
ALTER TABLE products 
ADD PRIMARY KEY (product_no);
```

## Mavjud jadvalga avtomatik ravishda oshirilgan primary keyni qanday qo'shish mumkin

Aytaylik, bizda primary keyga ega bo'lmagan `vendors` jadvali bor.

```sql
CREATE TABLE vendors (name VARCHAR(255));
```

Va biz `INSERT` iborasi yordamida `vendors` jadvaliga bir nechta qatorlarni qo'shamiz:

```sql
INSERT INTO vendors (NAME)
VALUES
	('Microsoft'),
	('IBM'),
	('Apple'),
	('Samsung');
```

Qo'shish amalini tekshirish uchun quyidagi `SELECT` iborasi yordamida `vendors` jadvalidagi ma'lumotlarni so'raymiz:

```sql
SELECT
	*
FROM
	vendors;
```

![vendors table](https://www.postgresqltutorial.com/wp-content/uploads/2015/08/vendors-table.jpg)

Endi, agar biz `vendors` jadvaliga `id` nomli primary keyni qo'shishni istasak va `id` maydoni avtomatik ravishda bittaga ko'paytirilsa, biz quyidagi bayonotdan foydalanamiz:

```sql
ALTER TABLE vendors ADD COLUMN ID SERIAL PRIMARY KEY;
```

Keling, `vendors` jadvalini yana bir bor tekshiramiz.

```sql
SELECT
	id,name
FROM
	vendors;
```

![vendors table](https://www.postgresqltutorial.com/wp-content/uploads/2015/08/vendors-table-with-primary-key.jpg)

## Primary keyni olib tashlash

Mavjud primary key cheklovini olib tashlash uchun siz quyidagi sintaksis bilan `ALTER TABLE` iborasidan ham foydalanasiz.

```sql
ALTER TABLE table_name DROP CONSTRAINT primary_key_constraint;
```

Masalan, `mahsulotlar` jadvalidagi primary keyni olib tashlash uchun siz quyidagi bayonotdan foydalanasiz:

```sql
ALTER TABLE products
DROP CONSTRAINT products_pkey;
```

Ushbu qo'llanmada siz `CREATE TABLE` va `ALTER TABLE` iboralari yordamida primary key cheklovlarini qanday qo'shish va olib tashlashni o'rgandingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-primary-key/)