# Sequences

Ushbu qo'llanmada siz PostgreSQL ketma-ketliklari va raqamlar ketma-ketligini yaratish uchun `Sequence`(ketma-ketlik) ob'ektidan qanday foydalanish haqida bilib olasiz.

Ta'rifga ko'ra, ketma-ketlik butun sonlarning tartiblangan ro'yxatidir. Ketma-ketlikdagi raqamlarning tartibi muhim ahamiyatga ega. Masalan, `{1,2,3,4,5}` va `{5,4,3,2,1}` butunlay boshqa ketma-ketliklardir.

PostgreSQLdagi `sequence (ketma-ketlik)` ma'lum bir spetsifikatsiya asosida butun sonlar ketma-ketligini hosil qiluvchi foydalanuvchi tomonidan belgilangan sxemaga bog'langan ob'ektdir.

PostgreSQLda ketma-ketlikni yaratish uchun siz `CREATE SEQUENCE` iborasidan foydalanasiz.

Quyida `CREATE SEQUENCE` iborasining sintaksisi tasvirlangan:
```sql
CREATE SEQUENCE [ IF NOT EXISTS ] sequence_name
    [ AS { SMALLINT | INT | BIGINT } ]
    [ INCREMENT [ BY ] increment ]
    [ MINVALUE minvalue | NO MINVALUE ] 
    [ MAXVALUE maxvalue | NO MAXVALUE ]
    [ START [ WITH ] start ] 
    [ CACHE cache ] 
    [ [ NO ] CYCLE ]
    [ OWNED BY { table_name.column_name | NONE } ]
```

`CREATE SEQUENCE` bandidan keyin sequence nomini belgilang. `IF NOT EXISTS` shartli ravishda yangi `sequence`ni faqat mavjud bo'lmasa yaratadi.

Tartib nomi bir xil sxemadagi boshqa `sequence`lar, jadvallar, indekslar, ko'rinishlar yoki xorijiy jadvallardan farqli bo'lishi kerak.

* **[ AS { SMALLINT | INT | BIGINT } ]**

> Ketma-ketlikning ma'lumotlar turini belgilang. Yaroqli ma'lumotlar turi `SMALLINT`, `INT` va `BIGINT`. Agar uni oʻtkazib yuborsangiz, standart maʼlumotlar turi `BIGINT` boʻladi.

Ketma-ketlikning minimal va maksimal qiymatlarini belgilaydigan ma'lumotlar turi.

* **[ INCREMENT [ BY ] increment ]**

> `Increment` yangi qiymat yaratish uchun joriy ketma-ketlik qiymatiga qaysi qiymat qo'shilishi kerakligini belgilaydi. 

Ijobiy son ortib boruvchi ketma-ketlikni hosil qiladi, salbiy son esa kamayib boruvchi ketma-ketlikni hosil qiladi.

Standart increment qiymati - 1.

* **[ MINVALUE minvalue | NO MINVALUE ]**
* **[ MAXVALUE maxvalue | NO MAXVALUE ]**

> Ketma-ketlikning minimal qiymati va maksimal qiymatini aniqlang. Agar siz `NO MINVALUE` va `NO MAXVALUE` dan foydalansangiz, ketma-ketlik standart qiymatdan foydalanadi.

Ko'tarilgan ketma-ketlik uchun standart maksimal qiymat ketma-ketlik ma'lumotlar turining maksimal qiymati va standart minimal qiymat 1 dir.

Kamayuvchi ketma-ketlik bo'lsa, standart maksimal qiymat -1, standart minimal qiymat esa ketma-ketlik ma'lumotlar turining minimal qiymatidir.

* **[ START [ WITH ] start ]**

> `START` bandi ketma-ketlikning boshlang'ich qiymatini belgilaydi.

Odatiy boshlang'ich qiymat ortib borayotgan ketma-ketliklar uchun `minvalue` va kamayib borayotganlar uchun `maxvalue`.

* **[ CACHE cache ]**

> `CACHE` tezroq kirish uchun qancha ketma-ketlik raqamlari oldindan ajratilganligini va xotirada saqlanganligini aniqlaydi. Bir vaqtning o'zida bitta qiymat yaratilishi mumkin.

Odatiy bo'lib, ketma-ketlik bir vaqtning o'zida bitta qiymat hosil qiladi, ya'ni kesh yo'q.

* **[ [ NO ] CYCLE ]**

> `CYCLE`, agar chegaraga erishilgan bo'lsa, qiymatni qayta ishga tushirishga imkon beradi. Keyingi raqam ortib boruvchi ketma-ketlikning minimal qiymati va kamayib borayotgan ketma-ketlikning maksimal qiymati bo'ladi.

Agar siz `NO CYCLE`dan foydalansangiz, chegaraga yetganda, keyingi qiymatni olishga urinish xatolikka olib keladi.

Agar siz `CYCLE` yoki `NO CYCLE`ni aniq belgilamasangiz, `NO CYCLE` standart hisoblanadi.

* **[ OWNED BY { table_name.column_name | NONE } ]**

> `OWNED` BY bandi jadval ustunini ketma-ketlik bilan bog'lash imkonini beradi, shunda siz ustun yoki jadvalni tashlaganingizda PostgreSQL bog'langan ketma-ketlikni avtomatik ravishda tashlab qo'yadi.

E'tibor bering, jadvalning ustuni uchun `SERIAL` psevdo-turidan foydalanganda, PostgreSQL avtomatik ravishda ustun bilan bog'langan ketma-ketlikni yaratadi.

## PostgreSQL `CREATE SEQUENCE` misollari

Keling, yaxshiroq tushunish uchun ketma-ketlikni yaratishning ba'zi misollarini olaylik.

 **1. ortib boruvchi ketma-ketlikni yaratish**

Bu ibora `CREATE SEQUENCE` iborasidan 100 dan boshlab 5 ga ortib boruvchi yangi ortib boruvchi ketma-ketlikni yaratish uchun foydalanadi:

```sql
CREATE SEQUENCE mysequence
INCREMENT 5
START 100;
```

Ketma-ketlikdan keyingi qiymatni olish uchun `nextval()` funksiyasidan foydalaning:

```sql
SELECT nextval('mysequence');
```

![output](https://www.postgresqltutorial.com/wp-content/uploads/2019/05/PostgreSQL-Sequence-simple-example.png)

Agar siz bayonotni qayta bajarsangiz, ketma-ketlikdan keyingi qiymatni olasiz:

```sql
SELECT nextval('mysequence');
```

![output](https://www.postgresqltutorial.com/wp-content/uploads/2019/05/PostgreSQL-Sequence-nextval-example.png)

**2. Kamayuvchi ketma-ketlikni yaratish**

Quyidagi ibora sikl opsiyasi bilan 3 dan 1 gacha kamayib boruvchi ketma-ketlikni yaratadi:

```sql
CREATE SEQUENCE three
INCREMENT -1
MINVALUE 1 
MAXVALUE 3
START 3
CYCLE;
```

Quyidagi bayonotni bir necha marta bajarganingizda, siz 3, 2, 1 dan boshlanadigan va 3, 2, 1 va shunga o'xshash raqamlarni ko'rasiz:

```sql
SELECT nextval('three');
```

**3. Jadval ustuni bilan bog'langan ketma-ketlikni yaratish**

Birinchidan, `order_details` nomli yangi jadval yarating:

```sql
CREATE TABLE order_details(
    order_id SERIAL,
    item_id INT NOT NULL,
    item_text VARCHAR NOT NULL,
    price DEC(10,2) NOT NULL,
    PRIMARY KEY(order_id, item_id)
);
```

Ikkinchidan, `order_details` jadvalining `item_id` ustuni bilan bog'langan yangi ketma-ketlikni yarating:

```
CREATE SEQUENCE order_item_id
START 10
INCREMENT 10
MINVALUE 10
OWNED BY order_details.item_id;
```

Uchinchidan, `order_details` jadvaliga uchta buyurtma qatorini kiriting:

```sql
INSERT INTO 
    order_details(order_id, item_id, item_text, price)
VALUES
    (100, nextval('order_item_id'),'DVD Player',100),
    (100, nextval('order_item_id'),'Android TV',550),
    (100, nextval('order_item_id'),'Speaker',250);
```

Ushbu bayonotda biz `order_item_id` qatoridan element identifikatori qiymatini olish uchun `nextval()` funksiyasidan foydalandik.

To'rtinchidan, `order_details` jadvalidagi so'rov ma'lumotlari:

```sql
SELECT
    order_id,
    item_id,
    item_text,
    price
FROM
    order_details;
```

![output](https://www.postgresqltutorial.com/wp-content/uploads/2019/05/PostgreSQL-Sequence-in-a-table.png)

## Ma'lumotlar bazasidagi barcha ketma-ketliklarni ro'yxatga olish

Joriy ma'lumotlar bazasidagi barcha ketma-ketliklarni ro'yxatga olish uchun siz quyidagi so'rovdan foydalanasiz:

```sql
SELECT
    relname sequence_name
FROM 
    pg_class 
WHERE 
    relkind = 'S';
```

## Ketmalarni yo'q qilish

Agar ketma-ketlik jadval ustuni bilan bog'langan bo'lsa, jadval ustuni olib tashlangan yoki jadval tushirilgandan so'ng u avtomatik ravishda o'chiriladi.

`DROP SEQUENCE` iborasi yordamida ketma-ketlikni qo'lda ham olib tashlashingiz mumkin:

```sql
DROP SEQUENCE [ IF EXISTS ] sequence_name [, ...] 
[ CASCADE | RESTRICT ];
```

Ushbu sintaksisda:
* Birinchidan, siz tashlamoqchi bo'lgan ketma-ketlik nomini belgilang. `IF EXISTS` varianti, agar mavjud bo'lsa, ketma-ketlikni shartli ravishda o'chiradi. Agar bir vaqtning o'zida bir nechta ketma-ketlikni tashlamoqchi bo'lsangiz, vergul bilan ajratilgan ketma-ketlik nomlari ro'yxatidan foydalanishingiz mumkin.
* Keyin, ketma-ketlikka bog'liq bo'lgan ob'ektlarni va bog'liq ob'ektlarga bog'liq bo'lgan ob'ektlarni va hokazolarni rekursiv ravishda tushirishni istasangiz, `CASCADE` opsiyasidan foydalaning.

### PostgreSQL DROP SEQUENCE bayonotiga misollar

Ushbu bayonot `order_details` jadvalini tushiradi. `order_item_id` ketma-ketligi `order_details` `item_id` bilan bog'langanligi sababli, u ham avtomatik ravishda o'chiriladi:

```sql
DROP TABLE order_details;
```

Ushbu qo'llanmada siz PostgreSQL ketma-ketliklari va ketma-ketliklar ro'yxatini yaratish uchun ketma-ketlik ob'ektidan qanday foydalanish haqida bilib oldingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-sequences/)