# NOT NULL
Ushbu qo'llanmada siz ustun qiymatlari `null` bo'lmasligini ta'minlash uchun PostgreSQL-ning `null bo'lmagan` cheklovlari haqida bilib olasiz.

Maʼlumotlar bazasi dunyosida `NULL` notanish yoki etishmayotgan maʼlumotlarni ifodalaydi. `NULL` bo'sh satr yoki nol raqami bilan bir xil emas.

Kontaktning elektron pochta manzilini jadvalga kiritishingiz kerak deylik. Siz uning elektron pochta manzilini so'rashingiz mumkin.

Biroq, agar siz kontaktning elektron pochta manziliga ega yoki yo'qligini bilmasangiz, elektron pochta manzili ustuniga NULL qo'shishingiz mumkin. Bunday holda, NULL elektron pochta manzili yozib olish vaqtida noma'lum ekanligini bildiradi.

`NULL` juda o'ziga xosdir. U hech narsaga teng kelmaydi, hatto o'zi ham. `NULL = NULL` ifodasi `NULL`ni qaytaradi, chunki ikkita nomaʼlum qiymat teng boʻlmasligi kerak.

Qiymat `NULL` yoki yo'qligini tekshirish uchun siz `IS NULL` mantiqiy operatoridan foydalanasiz. Misol uchun, agar elektron pochta manzilidagi qiymat `NULL` bo'lsa, quyidagi ifoda rost qaytaradi.

```sql
email_address IS NULL
```

`IS NOT NULL` operatori `IS NULL` operatorining natijasini inkor etadi.

## PostgreSQL `NOT NULL` cheklovlari
Ustun `NULL`ni qabul qila oladimi yoki yo'qligini nazorat qilish uchun siz `NOT NULL` cheklovidan foydalanasiz:

```sql
CREATE TABLE invoices(
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  qty numeric NOT NULL CHECK(qty > 0),
  net_price numeric CHECK(net_price > 0) 
);
```

Bu misolda `NOT NULL` cheklovlarini eʼlon qilish uchun `product_id` va qty ustunlarining maʼlumotlar turiga mos keladigan `NOT NULL` kalit soʻzlaridan foydalaniladi.

Esda tutingki, ustunda bir-birining yonida paydo boʻladigan `NOT NULL`, chek, noyob, xorijiy kalit kabi bir nechta cheklovlar boʻlishi mumkin. Cheklovlar tartibi muhim emas. PostgreSQL cheklovlarni istalgan tartibda tekshirishi mumkin.

Agar `NOT NULL` o'rniga `NULL` dan foydalansangiz, ustun ham `NULL`, ham `NULL` bo'lmagan qiymatlarni qabul qiladi. Agar siz `NULL` yoki `NOT NULL` ni aniq belgilamasangiz, u sukut bo'yicha `NULL`ni qabul qiladi.

## Mavjud ustunlarga `NOT NULL` cheklovlarini qo'shish
Mavjud jadval ustuniga `NOT NULL` cheklovini qo'shish uchun siz `ALTER TABLE` iborasining quyidagi shaklidan foydalanasiz:

```sql
ALTER TABLE table_name
ALTER COLUMN column_name SET NOT NULL;
```

Bir nechta ustunlarga bir nechta `NOT NULL` cheklovlarini qo'shish uchun siz quyidagi sintaksisdan foydalanasiz:

```sql
ALTER TABLE table_name
ALTER COLUMN column_name_1 SET NOT NULL,
ALTER COLUMN column_name_2 SET NOT NULL,
...;
```

Keling, quyidagi misolni ko'rib chiqaylik.

Birinchidan, ishlab chiqarish buyurtmalari (`production_orders`) deb nomlangan yangi jadval yarating:

```sql
CREATE TABLE production_orders (
	id SERIAL PRIMARY KEY,
	description VARCHAR (40) NOT NULL,
	material_id VARCHAR (16),
	qty NUMERIC,
	start_date DATE,
	finish_date DATE
);
```

Keyin, `production_orders` jadvaliga yangi qator qo'shing:

```sql
INSERT INTO production_orders (description)
VALUES('Make for Infosys inc.');
```

Keyin, `qty` maydoni null emasligiga ishonch hosil qilish uchun siz `qty` ustuniga null bo'lmagan cheklovni qo'shishingiz mumkin. Biroq, ustunda allaqachon ma'lumotlar mavjud. Agar siz null bo'lmagan cheklovni qo'shmoqchi bo'lsangiz, PostgreSQL xatolik chiqaradi.

`NULL` ni o'z ichiga olgan ustunga `NOT NULL` cheklovini qo'shish uchun avval `NULL`ni NULL bo'lmaganga yangilashingiz kerak, masalan:

```sql
UPDATE production_orders
SET qty = 1;
```

`qty` ustunidagi qiymatlar bittaga yangilanadi. Endi siz `qty` ustuniga `NOT NULL` cheklovini qo'shishingiz mumkin:

```sql
ALTER TABLE production_orders 
ALTER COLUMN qty
SET NOT NULL;
```

Shundan so'ng siz `material_id`, `start_date` va `finish_date` ustunlari uchun null bo'lmagan cheklovlarni yangilashingiz mumkin:

```sql
UPDATE production_orders
SET material_id = 'ABC',
    start_date = '2015-09-01',
    finish_date = '2015-09-01';
```

Bir nechta ustunlarga null bo'lmagan cheklovlar qo'shing:

```sql
ALTER TABLE production_orders 
ALTER COLUMN material_id SET NOT NULL,
ALTER COLUMN start_date SET NOT NULL,
ALTER COLUMN finish_date SET NOT NULL;
```

Nihoyat, `qty` ustunidagi qiymatlarni NULL ga yangilashga harakat qiling:

```sql
UPDATE production_orders
SET qty = NULL;
```

PostgreSQL xato xabarini chiqardi:

```sql
[Err] ERROR:  null value in column "qty" violates not-null constraint
DETAIL:  Failing row contains (1, make for infosys inc., ABC, null, 2015-09-01, 2015-09-01).
```

## NOT NULL cheklovining maxsus holati
`NOT NULL` cheklovidan tashqari, ustunni NULL bo'lmagan qiymatlarni qabul qilishga majburlash uchun `CHECK` cheklovidan foydalanishingiz mumkin. `NOT NULL` cheklovi quyidagi `CHECK` chekloviga teng:

```sql
CHECK(column IS NOT NULL)
```

Bu foydalidir, chunki ba'zan `a` yoki `b` ustunlari null bo'lmasligi mumkin, lekin ikkalasi ham emas.

Masalan, foydalanuvchi jadvallarining `username` yoki `email` ustuni null yoki bo'sh bo'lmasligini xohlashingiz mumkin. Bunday holda siz `CHECK` cheklovidan quyidagi tarzda foydalanishingiz mumkin:

```sql
CREATE TABLE users (
  id serial PRIMARY KEY, 
  username VARCHAR (50), 
  password VARCHAR (50), 
  email VARCHAR (50), 
  CONSTRAINT username_email_notnull CHECK (
    NOT (
      (
        username IS NULL 
        OR username = ''
      ) 
      AND (
        email IS NULL 
        OR email = ''
      )
    )
  )
);
```

Quyidagi bayonot ishlaydi.

```sql
INSERT INTO users (username, email)
VALUES
	('user1', NULL),
	(NULL, 'email1@example.com'),
	('user2', 'email2@example.com'),
	('user3', '');
```

Biroq, quyidagi bayonot ishlamaydi, chunki u `CHECK` cheklovini buzadi:

```sql
INSERT INTO users (username, email)
VALUES
	(NULL, NULL),
	(NULL, ''),
	('', NULL),
	('', '');
```

```sql
[Err] ERROR:  new row for relation "users" violates check constraint "username_email_notnull"
```

Xulosa
* NULLni qabul qilmaydigan ustunni majburlash uchun ustun uchun `NOT NULL` cheklovidan foydalaning. Odatiy bo'lib, ustun `NULL`ni ushlab turishi mumkin.

* Qiymat `NULL` yoki yo'qligini tekshirish uchun siz `IS NULL` operatoridan foydalanasiz. `IS NOT NULL` `IS NULL` natijasini inkor etadi.

* Qiymatni `NULL` bilan solishtirish uchun hech qachon teng operator `=` dan foydalanmang, chunki u har doim `NULL`ni qaytaradi.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-not-null-constraint/)
