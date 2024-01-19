# Change Column data type

Ushbu qo'llanma sizga `ALTER TABLE` iborasi yordamida ustunning ma'lumotlar turini qanday o'zgartirishni bosqichma-bosqich ko'rsatib beradi.

Ustunning ma'lumotlar turini o'zgartirish uchun siz `ALTER TABLE` iborasidan quyidagi tarzda foydalanasiz:

```sql
ALTER TABLE table_name
ALTER COLUMN column_name [SET DATA] TYPE new_data_type;
```

Keling, bayonotni batafsil ko'rib chiqaylik:

* Birinchidan, `ALTER TABLE` kalit so'zlaridan keyin ustunni o'zgartirmoqchi bo'lgan jadval nomini belgilang.
* Ikkinchidan, `ALTER COLUMN` bandidan keyin ma'lumotlar turini o'zgartirmoqchi bo'lgan ustun nomini belgilang.
* Uchinchidan, `TYPE` kalit so'zidan keyin ustun uchun yangi ma'lumotlar turini kiriting. `SET DATA TYPE` va `TYPE` ekvivalentdir.

Bitta bayonotda bir nechta ustunlarning ma'lumotlar turlarini o'zgartirish uchun siz bir nechta `ALTER COLUMN` bandlaridan foydalanasiz:

```sql
ALTER TABLE table_name
ALTER COLUMN column_name1 [SET DATA] TYPE new_data_type,
ALTER COLUMN column_name2 [SET DATA] TYPE new_data_type,
...;
```

Ushbu sintaksisda siz har bir `ALTER COLUMN` bandidan keyin vergul (`,`) qo'shasiz.

PostgreSQL sizga quyidagi tarzda `USING` bandini qo'shish orqali ma'lumotlar turini o'zgartirganda ustun qiymatlarini yangilariga aylantirish imkonini beradi:

```sql
ALTER TABLE table_name
ALTER COLUMN column_name TYPE new_data_type USING expression;
```

`USING` bandi eski qiymatlarni yangilariga aylantirish imkonini beruvchi ifodani belgilaydi.

Agar siz `USING` bandini o'tkazib yuborsangiz, PostgreSQL qiymatlarni bilvosita yangilariga o'tkazadi. Translatsiya muvaffaqiyatsiz bo'lsa, PostgreSQL xatolik chiqaradi va ma'lumotlarni konvertatsiya qilish uchun `USING` bandini taqdim etishingizni tavsiya qiladi.

`USING` kalit so'zidan keyingi ibora `column_name::new_data_type` kabi oddiy bo'lishi mumkin, masalan, `price::numeric` yoki maxsus funksiya kabi murakkab.

## PostgreSQL ustun turini o'zgartirishga misollar

Keling, `assets` deb nomlangan yangi jadval yaratamiz va namoyish qilish uchun jadvalga bir nechta qatorlarni kiritamiz.

```sql
CREATE TABLE assets (
    id serial PRIMARY KEY,
    name TEXT NOT NULL,
    asset_no VARCHAR NOT NULL,
    description TEXT,
    location TEXT,
    acquired_date DATE NOT NULL
);

INSERT INTO assets(name,asset_no,location,acquired_date)
VALUES('Server','10001','Server room','2017-01-01'),
      ('UPS','10002','Server room','2017-01-01');
```

![assets](https://www.postgresqltutorial.com/wp-content/uploads/2020/07/PostgreSQL-Change-Column-Type-assets-table.png)

`name` ustunining ma'lumotlar turini `VARCHAR` ga o'zgartirish uchun siz quyidagi bayonotdan foydalanasiz:

```sql
ALTER TABLE assets 
ALTER COLUMN name TYPE VARCHAR;
```

Quyidagi bayonot `description` va `location` ustunlarining ma'lumotlar turlarini `TEXT` dan `VARCHAR` ga o'zgartiradi:

```sql
ALTER TABLE assets 
    ALTER COLUMN location TYPE VARCHAR,
    ALTER COLUMN description TYPE VARCHAR;
```

`asset_no` ustunining ma'lumotlar turini butun songa o'zgartirish uchun siz quyidagi bayonotdan foydalanasiz:

```sql
ALTER TABLE assets 
ALTER COLUMN asset_no TYPE INT;
```

PostgreSQL xato va juda foydali maslahat berdi:

```sql
ERROR:  column "asset_no" cannot be cast automatically to type integer
HINT:  You might need to specify "USING asset_no::integer".
```

Quyidagi bayonot yuqoridagi bayonotga `USING` bandini qo'shadi:

```sql
ALTER TABLE assets
ALTER COLUMN asset_no TYPE INT 
USING asset_no::integer;
```

Kutilganidek ishladi.

Ushbu qo'llanmada siz ustun turini o'zgartirish uchun `ALTER TABLE ALTER COLUMN` bayonotidan qanday foydalanishni o'rgandingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-change-column-type/)