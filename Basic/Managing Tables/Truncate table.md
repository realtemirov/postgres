# TRUNCATE TABLE

Ushbu qo'llanmada siz katta jadvallardagi barcha ma'lumotlarni tezda o'chirish uchun PostgreSQL `TRUNCATE TABLE` bayonotidan qanday foydalanishni o'rganasiz.

Jadvaldagi barcha ma'lumotlarni o'chirish uchun siz `DELETE` iborasidan foydalanasiz. Biroq, juda ko'p ma'lumotlarga ega bo'lgan jadvaldagi barcha ma'lumotlarni o'chirish uchun `DELETE` iborasidan foydalansangiz, u samarali emas. Bunday holda siz `TRUNCATE TABLE` bayonotidan foydalanishingiz kerak:

```sql
TRUNCATE TABLE table_name;
```

`TRUNCATE TABLE` bayonoti jadvaldagi barcha maʼlumotlarni skanerdan oʻtkazmasdan oʻchirib tashlaydi. Shuning uchun u `DELETE` iborasidan tezroq ishlaydi.

Bundan tashqari, `TRUNCATE TABLE` iborasi xotirani darhol qaytarib oladi, shuning uchun siz keyingi `VACUMM` operatsiyasini bajarishingiz shart emas, bu katta jadvallar uchun foydalidir.

## Barcha ma'lumotlarni bitta jadvaldan olib tashlang

`TRUNCATE TABLE` bayonotining eng oddiy shakli quyidagicha:

```sql
TRUNCATE TABLE table_name;
```

Quyidagi misolda `invoices` jadvalidagi barcha ma'lumotlarni o'chirish uchun `TRUNCATE TABLE` iborasi qo'llaniladi:

```sql
TRUNCATE TABLE invoices;
```

Maʼlumotni oʻchirishdan tashqari, identifikator ustunidagi qiymatlarni quyidagi kabi `RESTART IDENTITY` opsiyasidan foydalanib tiklashingiz mumkin:

```sql
TRUNCATE TABLE table_name 
RESTART IDENTITY;
```

Masalan, quyidagi bayonot `invoices` jadvalidagi barcha qatorlarni olib tashlaydi va `invoice_no` ustuni bilan bog'langan ketma-ketlikni tiklaydi:

```sql
TRUNCATE TABLE invoices 
RESTART IDENTITY;
```

Odatiy boʻlib, `TRUNCATE TABLE` iborasi `CONTINUE IDENTITY` opsiyasidan foydalanadi. Ushbu parametr, asosan, jadvaldagi ustun bilan bog'langan qiymatni ketma-ketlikda qayta ishga tushirmaydi.

## Barcha ma'lumotlarni bitta jadvaldan olib tashlang

Bir vaqtning o'zida bir nechta jadvaldagi barcha ma'lumotlarni o'chirish uchun har bir jadvalni vergul (,) bilan quyidagicha ajratasiz:

```sql
TRUNCATE TABLE 
    table_name1, 
    table_name2,
    ...;
```

Masalan, quyidagi bayonot `invoices` va `customers` jadvallaridan barcha ma'lumotlarni olib tashlaydi:

```sql
TRUNCATE TABLE invoices, customers;
```

## `Foreign key` kalitlari havolalari bo'lgan jadvaldan barcha ma'lumotlarni olib tashlang

Amalda, siz kesmoqchi bo'lgan jadvalda ko'pincha  `TRUNCATE TABLE` bayonotida ko'rsatilmagan boshqa jadvallarning xorijiy kalit havolalari mavjud.

Odatiy boʻlib,  `TRUNCATE TABLE` iborasi tashqi kalit havolalari boʻlgan jadvaldan hech qanday maʼlumotni olib tashlamaydi.

Jadval va boshqa jadvallardan ma'lumotlarni olib tashlash uchun chet el kalitlari jadvalga havola qilinadi, siz `TRUNCATE TABLE` bayonotida `CASCADE` opsiyasidan quyidagi tarzda foydalanasiz:

```sql
TRUNCATE TABLE table_name 
CASCADE;
```

Quyidagi misol `invoices` jadvalidan ma'lumotlarni o'chiradi va xorijiy kalit cheklovlari orqali `invoices` jadvaliga havola qiladigan boshqa jadvallar:

```sql
TRUNCATE TABLE invoices CASCADE;
```

`CASCADE` opsiyasi qoʻshimcha eʼtibor bilan qoʻllanilishi kerak, aks holda siz istamagan jadvallardan maʼlumotlarni oʻchirib tashlashingiz mumkin.

Odatiy bo'lib, `TRUNCATE TABLE` iborasi `RESTRICT` opsiyasidan foydalanadi, bu sizga tashqi kalit cheklash havolalariga ega bo'lgan jadvalni kesishingizga to'sqinlik qiladi.

## PostgreSQL `TRUNCATE TABLE` va `ON DELETE` trigger

`TRUNCATE TABLE` iborasi jadvaldagi barcha maʼlumotlarni oʻchirib tashlasa ham, jadval bilan bogʻliq boʻlgan `ON DELETE` triggerlarini ishga tushirmaydi.

Jadvalga  `TRUNCATE TABLE` buyrug'i qo'llanilganda, triggerni ishga tushirish uchun siz ushbu jadval uchun  `BEFORE TRUNCATE` va/yoki `AFTER TRUNCATE` triggerlarini belgilashingiz kerak.

## PostgreSQL `TRUNCATE TABLE` va tranzaksiya
`TRUNCATE TABLE` tranzaksiya uchun xavfsizdir. Bu shuni anglatadiki, agar siz uni tranzaktsiyaga joylashtirsangiz, uni xavfsiz tarzda qaytarib olishingiz mumkin.

## Xulosa
* Katta jadvaldagi barcha ma'lumotlarni o'chirish uchun `TRUNCATE TABLE` iborasidan foydalaning.

* Jadvalni va jadvalga tashqi kalit cheklovi orqali murojaat qiladigan boshqa jadvallarni kesish uchun `CASCADE` opsiyasidan foydalaning.

* `TRUNCATE TABLE` `DELETE` triggerida ishga tushmaydi. Buning o'rniga, `BEFORE TRUNCATE` va `AFTER TRUNCATE` triggerlarini ishga tushiradi.

* `TRUNCATE TABLE` bayonoti tranzaksiya uchun xavfsizdir.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-truncate-table/)