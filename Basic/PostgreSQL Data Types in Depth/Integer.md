# INTEGER

Ushbu qo'llanma sizni turli xil PostgreSQL butun son turlari, jumladan `SMALLINT`, `INTEGER` va `BIGINT` bilan tanishtiradi.

Butun sonlarni PostgreSQL da saqlash uchun quyidagi son;ar turlaridan birini ishlatishingiz mumkin:
* `SMALLINT`
* `INTEGER`
* `BIGINT`

Quyidagi jadvalda har bir butun son turining spetsifikatsiyasi ko'rsatilgan:

<table>
    <tr>
        <th>Name</th>
        <th>Storage Size</th>
        <th>Min</th>
        <th>Max</th>
    </tr>
    <tr>
        <td>SMALLINT</td>
        <td>2 bytes</td>
        <td>-32,768</td>
        <td>+32,767</td>
    </tr>
    <tr>
        <td>INTEGER</td>
        <td>4 bytes</td>
        <td>-2,147,483,648</td>
        <td>+2,147,483,647</td>
    </tr>
    <tr>
        <td>BIGINT</td>
        <td>8 bytes</td>
        <td>-9,223,372,036,854,775,808</td>
        <td>+9,223,372,036,854,775,807</td>
    </tr>
</table>

Agar qiymatni ruxsat etilgan diapazonlardan tashqarida saqlashga harakat qilsangiz, PostgreSQL xatolik chiqaradi.

`MySQL` butun sonidan farqli o'laroq, PostgreSQL `unsigned integer` turlarini ta'minlamaydi.

## SMALLINT
SMALLINT `(-32,767, 32,767)` oralig'idagi har qanday butun sonlarni saqlashi mumkin bo'lgan `2 bayt` saqlash hajmini talab qiladi.

`SMALLINT` turidan odamlarning yoshi, kitob sahifalari soni va hokazolarni saqlash uchun foydalanishingiz mumkin.

Quyidagi bayonot `books` nomli jadval yaratadi:

```sql
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR (255) NOT NULL,
    pages SMALLINT NOT NULL CHECK (pages > 0)
);
```

Ushbu misolda `title` ustuni `SMALLINT` ustunidir. Sahifalar soni ijobiy boʻlishi kerakligi sababli, biz ushbu qoidani qoʻllash uchun `CHECK` cheklovini qoʻshdik.

## INTEGER
`INTEGER` butun son turlari orasida eng keng tarqalgan tanlovdir, chunki u saqlash hajmi, diapazoni va unumdorligi o'rtasidagi eng yaxshi muvozanatni ta'minlaydi.

`INTEGER` turi raqamlarni `(-2,147,483,648, 2,147,483,647)` oralig'ida saqlashi mumkin bo'lgan `4 bayt` saqlash hajmini talab qiladi.

Quyidagi misol sifatida shahar yoki hatto mamlakat aholisi kabi juda katta butun sonlarni saqlaydigan ustun uchun `INTEGER` turidan foydalanishingiz mumkin:

```sql
CREATE TABLE cities (
    city_id serial PRIMARY KEY,
    city_name VARCHAR (255) NOT NULL,
    population INT NOT NULL CHECK (population >= 0)
);
```

E'tibor bering, `INT` `INTEGER` so'zining sinonimidir.

## BIGINT
Agar siz `INTEGER` tipidagi diapazondan tashqarida bo'lgan butun sonlarni saqlamoqchi bo'lsangiz, `BIGINT` turidan foydalanishingiz mumkin.

`BIGINT` turi har qanday raqamni `(-9,223,372,036,854,775,808,+9,223,372,036,854,775,807)` oralig'ida saqlashi mumkin bo'lgan `8 bayt` hajmli saqlash hajmini talab qiladi.

`BIGINT` turidan foydalanish nafaqat koʻp xotirani, shu bilan birga, ma'lumotlar bazasining ishlashini pasaytiradi, shuning uchun siz uni ishlatish uchun yaxshi sababga ega bo'lishingiz kerak.

## Xulosa
* Ma'lumotlar bazasida butun sonlarni saqlash uchun `SMALLINT`, `INT` va `BIGINT` ma'lumotlar turlaridan foydalaning.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-integer/)