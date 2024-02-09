# Belgili ma'lumot turlari: `CHAR`, `VARCHAR` va `TEXT`

Ushbu qo'llanmada siz PostgreSQL belgilar ma'lumotlari turlari, jumladan `CHAR`, `VARCHAR` va `TEXT` haqida ma'lumot olasiz va jadvallaringiz uchun mos belgilar turlarini qanday tanlashni bilib olasiz.

PostgreSQL uchta asosiy belgilar turini taqdim etadi:

* `CHARACTER(n)` yoki `CHAR(n)`
* `CHARACTER VARYING(n)` yoki `VARCHAR(n)`
* `TEXT`

Bu sintaksisda `n` belgilar sonini bildiruvchi musbat butun sondir.

Quyidagi jadvalda PostgreSQLdagi belgilar turlari ko'rsatilgan:

<table>
    <tr>
        <th>Belgi turi</th>
        <th>Tavsif</th>
    </tr>
    <tr>
        <td>CHARACTER VARYING(n), VARCHAR(n)</td>
        <td>uzunlik chegarasi bilan o'zgaruvchan uzunlik</td>
    </tr>
    <tr>
        <td>CHARACTER(n), CHAR(n)</td>
        <td>belgilangan uzunlikdagi, bo'sh to'ldirilgan</td>
    </tr>
    <tr>
        <td>TEXT, VARCHAR</td>
        <td>o'zgaruvchan cheksiz uzunlik</td>
    </tr>
</table>

`CHAR(n)` ham, `VARCHAR(n)` ham `n` tagacha belgi saqlashi mumkin. Agar siz `n` dan ortiq belgidan iborat satrni saqlashga harakat qilsangiz, PostgreSQL xatolik chiqaradi.

Biroq, istisnolardan biri shundaki, agar ortiqcha belgilar barcha bo'shliqlar bo'lsa, PostgreSQL bo'shliqlarni maksimal uzunlikka `(n)` qisqartiradi va kesilgan belgilarni saqlaydi.

Agar satr aniq `CHAR(n)` yoki `VARCHAR(n)` ga uzatilsa, PostgreSQL uni jadvalga kiritishdan oldin uni `n` ta belgiga qisqartiradi.

`TEXT` ma'lumotlar turi cheksiz uzunlikdagi satrni saqlashi mumkin.

`VARCHAR` ma'lumotlar turi uchun `n` butun sonni ko'rsatmasangiz, u `TEXT` ma'lumotlar turi kabi ishlaydi. `VARCHAR` (`n` o'lchamisiz) va `TEXT` ning ishlashi bir xil.

`VARCHAR` ma'lumotlar turi uchun uzunlik spetsifikatorini belgilashning afzalligi shundaki, agar siz `VARCHAR(n)` ustuniga `n` dan ortiq belgidan iborat qatorni kiritishga harakat qilsangiz, PostgreSQL xatolik chiqaradi.

`VARCHAR` dan farqli o'laroq, `CHARACTER` yoki `CHAR` uzunliksiz, spetsifikatsiya `(n)` `CHARACTER(1)` yoki `CHAR(1)` bilan bir xil.

Boshqa ma'lumotlar bazasi tizimlaridan farqli o'laroq, PostgreSQLda uchta belgi turi o'rtasida unumdorlik farqi yo'q.

Ko'pgina hollarda siz `TEXT` yoki `VARCHAR` dan foydalanishingiz va `VARCHAR(n)` dan faqat PostgreSQL uzunligini tekshirishni xohlaganingizda foydalaning.

## PostgreSQL belgilar turiga misollar
`CHAR`, `VARCHAR` va `TEXT` ma'lumotlar turlari qanday ishlashini tushunish uchun misolni ko'rib chiqamiz.

Birinchidan, `character_tests` deb nomlangan yangi jadval yarating:

```sql
CREATE TABLE character_tests (
  id serial PRIMARY KEY, 
  x CHAR (1), 
  y VARCHAR (10), 
  z TEXT
);
```

Keyin, `character_tests` jadvaliga yangi qator qo'shing:

```sql
INSERT INTO character_tests (x, y, z) 
VALUES 
  (
    'Yes', 'This is a test for varchar', 
    'This is a very long text for the PostgreSQL text column'
  );
```

PostgreSQL xatolik yuz berdi:

```sql
ERROR:  value too long for type character(1)
```

Buning sababi shundaki, `x` ustunining ma'lumotlar turi `char(1)` va biz ushbu ustunga uchta belgidan iborat qatorni kiritishga harakat qildik.

Keling, tuzatamiz:

```sql
INSERT INTO character_tests (x, y, z) 
VALUES 
  (
    'Y', 
    'This is a test for varchar', 
    'This is a very long text for the PostgreSQL text column'
  );
```

PostgreSQL boshqa xato chiqaradi:

```sql
ERROR:  value too long for type character varying(10)
```

Buning sababi, biz `varchar(10)` ma'lumotlar turiga ega bo'lgan `y` ustuniga 10 dan ortiq belgidan iborat qatorni kiritishga harakat qildik.

Quyidagi bayonot `character_tests` jadvaliga yangi qatorni muvaffaqiyatli kiritadi.

```sql
INSERT INTO character_tests (x, y, z) 
VALUES 
  (
    'Y', 
    'varchar(n)', 
    'This is a very long text for the PostgreSQL text column'
  )
RETURNING *;
```

Chiqish:

```sql
 id | x |     y      |                            z
----+---+------------+---------------------------------------------------------
  1 | Y | varchar(n) | This is a very long text for the PostgreSQL text column
(1 row)
```

## Xulosa
* PostgreSQL `CHAR`, `VARCHAR` va `TEXT` ma'lumotlar turlarini qo'llab-quvvatlaydi. `CHAR` - belgilangan uzunlikdagi belgilar turi, `VARCHAR` va `TEXT` esa har xil uzunlikdagi belgilar turlari.

* Agar ustunga kiritish yoki uni yangilashdan oldin satr uzunligini (`n`) tekshirishni istasangiz, `VARCHAR(n)` dan foydalaning.

* `VARCHAR` (uzunlik ko'rsatkichisiz) va `TEXT` ekvivalentdir.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-char-varchar-text/)