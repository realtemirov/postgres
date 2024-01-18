# Add column

Ushbu qo'llanmada siz mavjud jadvalga bir yoki bir nechta ustun qo'shish uchun PostgreSQL `ADD COLUMN` iborasidan qanday foydalanishni o'rganasiz.

Mavjud jadvalga yangi ustun qo'shish uchun siz `ALTER TABLE ADD COLUMN` iborasidan quyidagi tarzda foydalanasiz:

```sql
ALTER TABLE table_name
ADD COLUMN new_column_name data_type constraint;
```

Ushbu sintaksisda:

* Birinchidan, `ALTER TABLE` kalit so'zidan keyin yangi ustun qo'shmoqchi bo'lgan jadval nomini belgilang.

* Ikkinchidan, `ADD COLUMN` kalit so'zlaridan keyin yangi ustun nomini, shuningdek uning ma'lumotlar turini va cheklovini belgilang.

Jadvalga yangi ustun qo'shsangiz, PostgreSQL uni jadval oxiriga qo'shadi. PostgreSQL-da jadvaldagi yangi ustun o'rnini belgilash imkoniyati yo'q.

Mavjud jadvalga bir nechta ustunlar qo'shish uchun siz `ALTER TABLE` iborasida bir nechta `ADD COLUMN` bandlaridan quyidagi tarzda foydalanasiz:

```sql
ALTER TABLE table_name
ADD COLUMN column_name1 data_type constraint,
ADD COLUMN column_name2 data_type constraint,
...
ADD COLUMN column_namen data_type constraint;
```

## PostgreSQL ADD COLUMN bayonotiga misollar

Quyidagi `CREATE TABLE` iborasi ikkita ustundan iborat `customers` nomli yangi jadval yaratadi: `id` va `customer_name`:

```sql
DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR NOT NULL
);
```

Quyidagi bayonot `customers` jadvaliga `phone` ustunini qo'shish uchun `ALTER TABLE ADD COLUMN` bayonotidan foydalanadi:

```sql
ALTER TABLE customers 
ADD COLUMN phone VARCHAR;
```

Va quyidagi bayonot `customers` jadvaliga `fax` va `email` ustunlarini qo'shadi:

```sql
ALTER TABLE customers
ADD COLUMN fax VARCHAR,
ADD COLUMN email VARCHAR;
```

`Customers` jadvalining tuzilishini `psql` asbobida ko'rish uchun siz `\d` buyrug'ini quyidagicha ishlatishingiz mumkin:

```sql
\d customers
```

![PostgreSQL ADD COLUMN](https://www.postgresqltutorial.com/wp-content/uploads/2020/07/PostgreSQL-alter-table-add-column-customers-table.png)

Chiqishdan aniq ko'rinib turibdiki, `customers` jadvalining ustunlar ro'yxatining oxirida `phone`, `fax` va `email` ustunlari paydo bo'ldi.

## Ma'lumotlarga ega bo'lgan jadvalga `NOT NULL` cheklovi bilan ustun qo'shing

Quyidagi bayonot `customers` jadvaliga ma'lumotlarni kiritadi.

```sql
INSERT INTO 
   customers (customer_name)
VALUES
   ('Apple'),
   ('Samsung'),
   ('Sony');
```

`Customers` jadvaliga `contact_name` ustunini qo'shmoqchisiz deylik:

```sql
ALTER TABLE customers 
ADD COLUMN contact_name VARCHAR NOT NULL;
```
PostgreSQL xatolik yuz berdi:
```
ERROR:  column "contact_name" contains null values
```

Buning sababi `contact_name` ustunida `NOT NULL` cheklovi mavjud. PostgreSQL ustunni qo'shganda, bu yangi ustun `NULL`ni oladi, bu `NOT NULL` cheklovini buzadi.

Ushbu muammoni hal qilish uchun…

Birinchidan, ustunni `NOT NULL` cheklovisiz qo'shing:

```sql
ALTER TABLE customers 
ADD COLUMN contact_name VARCHAR;
```

Ikkinchidan, `contact_name` ustunidagi qiymatlarni yangilang.

```sql
UPDATE customers
SET contact_name = 'John Doe'
WHERE id = 1;

UPDATE customers
SET contact_name = 'Mary Doe'
WHERE id = 2;

UPDATE customers
SET contact_name = 'Lily Bush'
WHERE id = 3;
```

Uchinchidan, `contact_name` ustuni uchun `NOT NULL` cheklovini o'rnating.

```sql
ALTER TABLE customers
ALTER COLUMN contact_name SET NOT NULL;
```

Ushbu qo'llanmada siz jadvalga bir yoki bir nechta ustun qo'shish uchun PostgresSQL `ADD COLUMN` iborasidan qanday foydalanishni o'rgandingiz

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-add-column/)