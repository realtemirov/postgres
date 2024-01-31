# UNIQUE

Ushbu qo'llanmada siz ustun yoki ustunlar guruhida saqlangan qiymatlar jadvaldagi qatorlar bo'ylab yagona bo'lishiga ishonch hosil qilish uchun PostgreSQL `UNIQUE` cheklovi haqida bilib olasiz.

Ba'zan siz ustun yoki ustunlar guruhida saqlangan qiymatlar elektron pochta manzillari yoki foydalanuvchi nomlari kabi butun jadval bo'ylab yagona bo'lishini ta'minlashni xohlaysiz.

PostgreSQL sizga ma'lumotlarning o'ziga xosligini to'g'ri saqlaydigan `UNIQUE` cheklovini taqdim etadi.

`UNIQUE` cheklovi mavjud bo'lganda, har safar yangi qator qo'shganingizda, qiymat jadvalda allaqachon mavjudligini tekshiradi. U o'zgartirishni rad etadi va agar qiymat allaqachon mavjud bo'lsa, xatolik chiqaradi. Xuddi shu jarayon mavjud ma'lumotlarni yangilash uchun ham amalga oshiriladi.

`UNIQUE` cheklovni ustun yoki ustunlar guruhiga qo'shsangiz, PostgreSQL avtomatik ravishda ustun yoki ustunlar guruhida noyob indeks yaratadi.

Quyidagi bayonot `email` ustuni uchun `UNIQUE` chekloviga ega bo'lgan shaxs nomli yangi jadval yaratadi.

```sql
CREATE TABLE person (
  id SERIAL PRIMARY KEY, 
  first_name VARCHAR (50), 
  last_name VARCHAR (50), 
  email VARCHAR (50) UNIQUE
);
```

Esda tutingki, yuqoridagi `UNIQUE` cheklov quyidagi soʻrovda koʻrsatilganidek, jadval cheklovi sifatida qayta yozilishi mumkin:

```sql
CREATE TABLE person (
  id SERIAL PRIMARY KEY, 
  first_name VARCHAR (50), 
  last_name VARCHAR (50), 
  email VARCHAR (50), 
  UNIQUE(email)
);
```

Birinchidan, `INSERT` iborasidan foydalanib, `person` jadvaliga yangi qator qo'shing:

```sql
INSERT INTO person(first_name,last_name,email)
VALUES('john','doe','j.doe@postgresqltutorial.com');
```

Ikkinchidan, takroriy elektron pochta bilan boshqa qatorni kiriting.

```sql
INSERT INTO person(first_name,last_name,email)
VALUES('jack','doe','j.doe@postgresqltutorial.com');
```

PostgreSQL xato xabarini chiqardi.

```sql
[Err] ERROR:  duplicate key value violates unique constraint "person_email_key"
DETAIL:  Key (email)=(j.doe@postgresqltutorial.com) already exists.
```

## Bir nechta ustunlarda `UNIQUE` cheklash yaratish
PostgreSQL sizga quyidagi sintaksisdan foydalangan holda ustunlar guruhiga `UNIQUE` cheklov yaratish imkonini beradi:
```sql
CREATE TABLE table (
    c1 data_type,
    c2 data_type,
    c3 data_type,
    UNIQUE (c2, c3)
);
```
c2 va c3 ustunlaridagi qiymatlar kombinatsiyasi butun jadval bo'ylab yagona bo'ladi. c2 yoki c3 ustunining qiymati yagona boʻlishi shart emas.

## Noyob indeks yordamida noyob cheklovlarni qo'shish
Ba'zan mavjud ustun yoki ustunlar guruhiga noyob cheklov qo'shishni xohlashingiz mumkin. Keling, quyidagi misolni ko'rib chiqaylik.

Birinchidan, sizda `equipment` deb nomlangan jadval bor deylik:
```sql
CREATE TABLE equipment (
  id SERIAL PRIMARY KEY, 
  name VARCHAR (50) NOT NULL, 
  equip_id VARCHAR (16) NOT NULL
);
```

Ikkinchidan, `equip_id` ustuniga asoslangan noyob indeks yarating.

```sql
CREATE UNIQUE INDEX CONCURRENTLY equipment_equip_id 
ON equipment (equip_id);
```

Uchinchidan, `equipment_equip_id` indeksidan foydalanib, `equipment` jadvaliga noyob cheklov qo'shing.

```sql
ALTER TABLE equipment 
ADD CONSTRAINT unique_equip_id 
UNIQUE USING INDEX equipment_equip_id;
```

E'tibor bering, `ALTER TABLE` iborasi stolda eksklyuziv qulfga ega bo'ladi. Agar sizda kutilayotgan tranzaktsiyalaringiz bo'lsa, jadvalni o'zgartirishdan oldin u barcha tranzaktsiyalar tugashini kutadi. Shuning uchun, quyidagi soʻrov yordamida davom etayotgan joriy kutilayotgan tranzaksiyalarni koʻrish uchun `pg_stat_activity` jadvalini tekshiring:

```sql
SELECT 
  datid, 
  datname, 
  usename, 
  state 
FROM 
  pg_stat_activity;
```

Tranzaksiyada boʻsh turgan qiymatga ega holat ustunini topish uchun natijaga qarashingiz kerak. Bular yakunlanishi kutilayotgan tranzaktsiyalar.

Bir jadvaldagi satrlar bo'ylab noyob ustun yoki ustunlar guruhida saqlangan qiymatlarni qo'llash uchun `UNIQUE` cheklovlaridan foydalaning.

### Xulosa
* Bir jadvaldagi satrlar bo'ylab noyob ustun yoki ustunlar guruhida saqlangan qiymatlarni qo'llash uchun `UNIQUE` cheklovlaridan foydalaning.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-unique-constraint/)