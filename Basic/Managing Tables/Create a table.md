# CREATE TABLE

Ushbu qo'llanmada siz yangi jadval yaratish uchun PostgreSQL `CREATE TABLE` bayonotidan qanday foydalanishni o'rganasiz.

Relyatsion ma'lumotlar bazasi bir-biriga bog'liq bo'lgan bir nechta jadvallardan iborat. Jadval qatorlar va ustunlardan iborat. Jadvallar mijozlar, mahsulotlar, xodimlar va boshqalar kabi tuzilgan ma'lumotlarni saqlashga imkon beradi.

Yangi jadval yaratish uchun siz `CREATE TABLE` operatoridan foydalanasiz. Quyida `CREATE TABLE` iborasining asosiy sintaksisi tasvirlangan:

```sql
CREATE TABLE [IF NOT EXISTS] table_name (
   column1 datatype(length) column_contraint,
   column2 datatype(length) column_contraint,
   column3 datatype(length) column_contraint,
   table_constraints
);
```

Ushbu sintaksisda:

* Birinchidan, `CREATE TABLE` kalit so'zlaridan keyin jadval nomini belgilang.

* Ikkinchidan, allaqachon mavjud bo'lgan jadvalni yaratish xatolikka olib keladi. `IF NOT EXISTS` opsiyasi yangi jadval mavjud bo'lmasagina yaratish imkonini beradi. `IF NOT EXISTS` opsiyasidan foydalansangiz va jadval allaqachon mavjud bo'lsa, PostgreSQL xato o'rniga bildirishnoma chiqaradi va yangi jadval yaratishni o'tkazib yuboradi.

* Uchinchidan, jadval ustunlarining vergul bilan ajratilgan ro'yxatini belgilang. Har bir ustun ustun nomidan, ustun saqlaydigan ma'lumotlar turidan, ma'lumotlar uzunligidan va ustun cheklovidan iborat. Ustun cheklovlari ustunda saqlangan ma'lumotlarga rioya qilish kerak bo'lgan qoidalarni belgilaydi. Masalan, null bo'lmagan cheklov ustundagi qiymatlarni NULL bo'lishi mumkin emas. Ustun cheklovlari null emas, noyob, asosiy kalit, chek, tashqi kalit cheklovlarini o'z ichiga oladi.

* Nihoyat, asosiy kalit, tashqi kalit va cheklashlarni tekshirish kabi jadval cheklovlarini belgilang.

E'tibor bering, ba'zi jadval cheklovlari asosiy kalit, tashqi kalit, chek, noyob cheklovlar kabi ustun cheklovlari sifatida belgilanishi mumkin.

## Cheklovlar

PostgreSQL quyidagi ustun cheklovlarini o'z ichiga oladi:

* `NOT NULL` - ustundagi qiymatlar `NULL` boʻlmasligini taʼminlaydi.

* `UNIQUE` - bitta jadval ichidagi satrlar bo'ylab yagona ustundagi qiymatlarni ta'minlaydi.

* `PRIMARY KEY` - jadvaldagi satrlarni yagona aniqlovchi asosiy kalit ustuni. Jadvalda bitta va faqat bitta asosiy kalit bo'lishi mumkin. Asosiy kalit cheklovi jadvalning asosiy kalitini aniqlash imkonini beradi.

* `CHECK` - `CHECK` cheklovi ma'lumotlarning mantiqiy ifodani qondirishini ta'minlaydi.

* `FOREIGN KEY` - ustundagi qiymatlar yoki jadvaldagi ustunlar guruhi boshqa jadvaldagi ustunlar yoki ustunlar guruhida mavjudligini ta'minlaydi. Birlamchi kalitdan farqli o'laroq, jadvalda ko'plab xorijiy kalitlar bo'lishi mumkin.

Jadval cheklovlari ustun cheklovlariga o'xshaydi, faqat ular bir nechta ustunlarga qo'llaniladi.

## PostgreSQL CREATE TABLE misollari

Biz quyidagi ustunlarga ega `accounts` deb nomlangan yangi jadval yaratamiz:

* `user_id` - primary key
* `username` - unique va not null
* `password` - not null
* `email` - unique va not null
* `created_on` - not null
* `last_login` - null

Quyidagi bayonot `accounts` jadvalini yaratadi:

```sql
CREATE TABLE accounts (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
        last_login TIMESTAMP 
);
```

![table](https://www.postgresqltutorial.com/wp-content/uploads/2020/07/PostgreSQL-Create-Table-accounts-example.png)

Quyidagi bayonot ikkita ustundan iborat `roles` jadvalini yaratadi: `role_id` va `role_name`:

```sql
CREATE TABLE roles(
   role_id serial PRIMARY KEY,
   role_name VARCHAR (255) UNIQUE NOT NULL
);
```

![output](https://www.postgresqltutorial.com/wp-content/uploads/2020/07/PostgreSQL-Create-Table-roles-example.png)

Quyidagi bayonot uchta ustundan iborat `account_roles` jadvalini yaratadi: `user_id`, `role_id` va `grant_date`.

```sql
CREATE TABLE account_roles (
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  grant_date TIMESTAMP,
  PRIMARY KEY (user_id, role_id),
  FOREIGN KEY (role_id)
      REFERENCES roles (role_id),
  FOREIGN KEY (user_id)
      REFERENCES accounts (user_id)
);
```

![table](https://www.postgresqltutorial.com/wp-content/uploads/2020/07/PostgreSQL-Create-Table-account_roles-example.png)

`account_roles` jadvalining asosiy kaliti ikkita ustundan iborat: `user_id` va `role_id`, shuning uchun biz asosiy kalit cheklovini jadval cheklovi sifatida belgilashimiz kerak. 

```sql
PRIMARY KEY (user_id, role_id)
```

`user_id` ustuni hisoblar jadvalidagi `user_id` ustuniga havola qilgani uchun biz `user_id` ustuni uchun tashqi kalit cheklovini belgilashimiz kerak:

```sql
FOREIGN KEY (user_id)
REFERENCES accounts (user_id)
```

role_id ustuni rollar jadvalidagi role_id ustuniga havola qiladi, biz role_id ustuni uchun xorijiy kalit cheklovini ham aniqlashimiz kerak.

```sql
FOREIGN KEY (role_id)
REFERENCES roles (role_id)
```

Quyida `accounts`, `roles` va `account_roles` jadvallari o'rtasidagi munosabat ko'rsatilgan:

![table](https://www.postgresqltutorial.com/wp-content/uploads/2020/07/PostgreSQL-Create-Table-example.png)

* Yangi jadval yaratish uchun `CREATE TABLE` iborasidan foydalaning.
* Agar mavjud bo'lmasa, yangi jadval yaratish uchun `IF NOT EXISTS` opsiyasidan foydalaning.
* Birlamchi kalitni, tashqi kalitni, null emas, yagona kalitni qo'llang va jadval ustunlariga cheklovlarni tekshiring.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-create-table/)