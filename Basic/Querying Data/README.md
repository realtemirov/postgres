# Querying Data

## 1-bo'lim. Ma'lumotlarni so'rash

Bu bo'limda biz ma'lumotlarni olish uchun so'rovlarni ko'rib chiqamiz.

`SELECT` - bitta jadvaldan ma'lumotlarni so'rash

`column aliases` - so'rovdagi ustunlar yoki iboralarga vaqtinchalik nomlar berishni o'rganish

`ORDER` - soʻrovdan qaytarilgan natijalar toʻplamini qanday saralash boʻyicha sizga koʻrsatma beradi.

`SELECT DISTINCT` - natijalar to'plamidagi takroriy qatorlarni olib tashlaydigan bandni taqdim etish

## Summary
Bu qismda `PostgreSQL` da `SELECT` keywordi bilan tanishamiz. `SELECT` keywordi bitta jadvaldan ma'lumotlarni olish uchun ishlatiladi.

Ma'lumotlar bazasi bilan ishlashda eng keng tarqalgan vazifalardan biri bu `SELECT` iborasi yordamida jadvallardan ma'lumotlarni so'rashdir

`SELECT` bayonoti PostgreSQL-dagi eng murakkab bayonotlardan biridir. Unda moslashuvchan so'rovni shakllantirish uchun foydalanishingiz mumkin bo'lgan ko'plab bandlar mavjud.

Murakkabligi tufayli biz uni qisqaroq va tushunarli darsliklarga ajratamiz, shunda siz har bir band haqida tezroq bilib olasiz.


`SELECT` bayonotda  quyidagi bandlar mavjud:

* `DISTINCT` operatori yordamida alohida qatorlarni tanlang.

* `ORDER BY` bandi yordamida qatorlarni tartiblang.

* `WHERE` qatorlarni filtrlash uchun bu banddan foydalaning.

* `LIMIT` yoki `FETCH` bandidan jadvaldan foydalanib qatorlar to'plamini tanlang.

* `GROUP BY` bandi bilan qatorlarni guruhlarga guruhlang.

* `HAVING` guruhlarni banddan foydalanib filtrlang.

* `INNER JOIN`, `LEFT JOIN`, `FULL OUTER JOIN`, `CROSS JOIN` kabi birikmalar yordamida boshqa jadvallarga qo'shiling 

* `UNION`, `INTERSECT`, `EXCEPT` yordamida to'plam amallarini bajaring

Ushbu qo'llanmada siz `SELECT` va `FROM` bandlariga e'tibor qaratasiz  .