# Basic PostgreSQL

Birinchi, siz ma'lumotlarni tanlash, natijalar to'plamini saralash va qatorlarni filtrlashni o'z ichiga olgan asosiy so'rov usullaridan foydalangan holda bitta jadvaldan ma'lumotlarni so'rashni o'rganasiz.

Keyin bir nechta jadvallarni birlashtirish, oʻrnatilgan operatsiyalardan foydalanish va quyi soʻrovni yaratish kabi ilgʻor soʻrovlar haqida bilib olasiz.

Va nihoyat, siz yangi jadval yaratish yoki mavjud jadval tuzilishini oʻzgartirish kabi maʼlumotlar bazasi jadvallarini qanday boshqarishni oʻrganasiz.

## Section 1. Querying Data
* [**SELECT**](<./Querying Data/1. SELECT.md>) - bitta jadvaldan ma'lumotlarni qanday olish
* [**Column aliases**](<./Querying Data/2. COLUMN_ALIAS.md>) - so'rovdagi ustunlar yoki ifodalarga vaqtinchalik nomlar berishni o'rganish.
* [**Order By**](<./Querying Data/3. ORDER_BY.md>) - so'rovdan qaytarilgan natijalar to'plamini qanday saralash bo'yicha sizga ko'rsatma beradi.
* [**Select Distinct**](<./Querying Data/4. SELECT_DISTINCT.md>) sizga natijalar to'plamidagi takroriy qatorlarni olib tashlaydigan bandni taqdim eting.

## Section 2. Filtering Data
* [**WHERE**](<./Filtering Data/1. WHERE.md>) - belgilangan shart asosida qatorlarni filtrlash.
* [**AND operator**](<./Filtering Data/2. AND.md>) - ikkita mantiqiy ifodani birlashtirish va agar ikkala ibora ham to'g'ri bo'lsa, true qiymatini qaytarish.
* [**OR operator**](<./Filtering Data/3. OR.md>) - ikkita mantiqiy ifodani birlashtiring va agar ikkala ifoda noto'g'ri bo'lsa, false qiymatini qaytarish.
* [**LIMIT**](<./Filtering Data/4. LIMIT.md>) - so'rov tomonidan yaratilgan qatorlar to'plamini oling.
* [**FETCH**](<./Filtering Data/5. FETCH.md>) - so'rov orqali qaytariladigan qatorlar sonini cheklash.
* [**IN**](<./Filtering Data/6. IN.md>) - qiymatlar ro'yxatidagi istalgan qiymatga mos keladigan ma'lumotlarni tanlash.
* [**BETWEEN**](<./Filtering Data/7. BETWEEN.md>) - qiymatlar oralig'i bo'lgan ma'lumotlarni tanlash.
* [**LIKE**](<./Filtering Data/8. LIKE.md>) - naqsh moslashuvi asosida ma'lumotlarni filtrlash.
* [**IS NULL**](<./Filtering Data/9. IS_NULL.md>) - qiymat null yoki yo'qligini tekshirish.

## Section 3. Joining Multiple Tables
* [**Joins**](<./Joining Multiple Tables/1. JOINS.md>) - sizga PostgreSQLda qo'shilishlarning qisqacha ko'rinishini ko'rsatish.
* [**Table aliases**](<./Joining Multiple Tables/2. TABLE ALIASES.md>) - so'rovda jadval taxalluslaridan qanday foydalanishni tavsiflaydi.
* [**INNER JOIN**](<./Joining Multiple Tables/3. INNER JOIN.md>) - bitta jadvaldan boshqa jadvallarda mos keladigan satrlarni tanlash.
* [**LEFT JOIN**](<./Joining Multiple Tables/4. LEFT JOIN.md>) - bitta jadvaldan boshqa jadvallarda mos keladigan satrlar bo'lishi yoki bo'lmasligi mumkin bo'lgan qatorlarni tanlash.
* [**RIGHT JOIN**](<./Joining Multiple Tables/5. RIGHT JOIN.md>) - bitta jadvaldan boshqa jadvallarda mos keladigan satrlar bo'lishi yoki bo'lmasligi mumkin bo'lgan qatorlarni tanlash.
* [**SELF JOIN**](<./Joining Multiple Tables/6. SELF JOIN.md>) - jadvalni o'zi bilan taqqoslash orqali jadvalni o'ziga qo'shish.
* [**FULL OUTER JOIN**](<./Joining Multiple Tables/7. FULL OUTER JOIN.md>) - boshqa jadvalda mos keladigan qatorga ega bo'lmagan jadvaldagi qatorni topish uchun to'liq qo'shilishdan foydalanish.
* [**CROSS JOIN**](<./Joining Multiple Tables/8. CROSS JOIN.md>) - ikki yoki undan ortiq jadvaldagi qatorlarning Kartezian mahsulotini ishlab chiqarish.
* [**NATURAL JOIN**](<./Joining Multiple Tables/9. NATURAL JOIN.md>) - birlashtirilgan jadvallardagi umumiy ustun nomlari asosida yashirin birlashma shartlaridan foydalangan holda ikki yoki undan ortiq jadvallarni birlashtirish.

## Section 4. Grouping Data
* [**GROUP BY**](<./Grouping Data/1. GROUP BY.md>) - qatorlarni guruhlarga bo'lish va har biriga agregat funksiyasini qo'llash.
* [**HAVING**](<./Grouping Data/2. HAVING.md>) - guruhlarga shartlarni qo'llash.

## Section 5. Set Operations
* [**UNION**](<./Set Operations/1. UNION.md>) - bir nechta so'rovlarning natijalar to'plamini bitta natijalar to'plamiga birlashtirish.
* [**INTERSECT**](<./Set Operations/2. INTERSECT.md>) - ikki yoki undan ortiq soʻrovlarning natijalar toʻplamini birlashtirib, ikkala natija toʻplamida qatorlar paydo boʻladigan bitta natija toʻplamini qaytaradi.
* [**EXCEPT**](<./Set Operations/3. EXCEPT.md>) - ikkinchi so'rovning chiqishida ko'rinmaydigan birinchi so'rovdagi qatorlarni qaytarish.

## Section 6. Grouping sets, Cube, and Rollup
* [**Grouping sets**](<./Grouping sets, Cube, and Rollup/1. Grouping SETS.md>) - hisobotda bir nechta guruhlash to'plamlarini yaratish.
* [**CUBE**](<./Grouping sets, Cube, and Rollup/2. Cube.md>) - o'lchamlarning barcha mumkin bo'lgan kombinatsiyalarini o'z ichiga olgan bir nechta guruhlash to'plamlarini aniqlash.
* [**ROLLUP**](<./Grouping sets, Cube, and Rollup/3. Rollup.md>) - jami va oraliq summalarni o'z ichiga olgan hisobotlarni yaratish.

## Section 7. Subquery
* [**Subquery**](<./Subquery/Subquery.md>) - boshqa so'rov ichiga joylashtirilgan so'rovni yozish.
* [**CORRELATED_SUBQUERY**](<./Subquery/CORRELATED_SUBQUERY.md>) - ishlov berilayotgan joriy satr qiymatlariga bog'liq bo'lgan so'rovni bajarish uchun korrelyatsiya qilingan quyi so'rovdan qanday foydalanish.
* [**ANY**](<./Subquery/ANY.md>) - qiymatni pastki so'rov tomonidan qaytarilgan qiymatlar to'plami bilan solishtirish orqali ma'lumotlarni olish.
* [**ALL**](<./Subquery/ALL.md>) - qiymatni pastki so'rov tomonidan qaytarilgan qiymatlar ro'yxati bilan solishtirish orqali ma'lumotlarni so'rash.
* [**EXISTS**](<./Subquery/EXISTS.md>) - pastki so'rov tomonidan qaytarilgan qatorlar mavjudligini tekshirish.

## Section 8. Common Table Expressions
* [**PostgreSQL CTE**](<./Common Table Expressions/PostgreSQL CTE.md>) - sizni PostgreSQL umumiy jadval ifodalari yoki CTE bilan tanishtiradi.
* [**Recursive query using CTEs**](<./Common Table Expressions/Recursive query using CTEs.md>) - rekursiv so'rovni muhokama qiling va uni turli kontekstlarda qanday qo'llashni o'rganing.

## Section 9. Modifying Data
Ushbu bo'limda siz `INSERT` iborasi bilan jadvalga ma'lumotlarni qanday kiritishni, `UPDATE` bayonoti yordamida mavjud ma'lumotlarni o'zgartirishni va `DELETE` iborasi yordamida ma'lumotlarni o'chirishni o'rganasiz. Bundan tashqari, siz ma'lumotlarni birlashtirish uchun `UPSERT` bayonotidan qanday foydalanishni o'rganasiz.
* [**INSERT**](<./Modifying Data/Insert.md>) - jadvalga bitta qatorni qanday kiritish haqida sizga ko'rsatma beradi.
* [**Insert multiple rows**](<./Modifying Data/Insert multiple rows.md>) - jadvalga bir nechta qatorlarni qanday kiritishni ko'rsatish.
* [**UPDATE**](<./Modifying Data/Update.md>) - jadvaldagi mavjud ma'lumotlarni yangilash.
* [**UPDATE JOIN**](<./Modifying Data/Update join.md>) - jadvaldagi qiymatlarni boshqa jadvaldagi qiymatlar asosida yangilash.
* [**DELETE**](<./Modifying Data/Delete.md>) - jadvaldagi ma'lumotlarni o'chirish.
* [**UPSERT**](<./Modifying Data/Upsert.md>) - agar jadvalda yangi qator allaqachon mavjud boʻlsa, maʼlumotlarni kiritish yoki yangilash

## Section 10. Transactions
* [**PostgreSQL Transaction**](<./Transactions/PostgreSQL Transactions.md>) - `BEGIN`, `COMMIT` va `ROLLBACK` iboralari yordamida PostgreSQLda tranzaktsiyalarni qanday boshqarishni ko'rsatilgan.

## Section 11. Import & Export Data
Nusxa ko'chirish buyrug'i yordamida PostgreSQL ma'lumotlarini `CSV` fayl formatidan `import` va `eksport` qilishni o'rganasiz.
* [**Import CSV file into Table**](<./Import & Export Data/Import CSV file into Table.md>) - CSV faylini jadvalga qanday import qilishni ko'rsating
* [**Export PostgreSQL Table to CSV file**](<./Import & Export Data/Export PostgreSQL Table to CSV file.md>) - jadvallarni CSV fayliga qanday eksport qilishni ko'rsatilgan.

## Section 12. Managing Tables
Ushbu bo'limda siz PostgreSQL ma'lumotlar turlarini o'rganishni boshlaysiz va yangi jadvallarni qanday yaratish va mavjud jadvallarning tuzilishini o'zgartirishni ko'rsatasiz.
* [**Data Types**](<./Managing Tables/Data types.md>) - eng ko'p ishlatiladigan PostgreSQL ma'lumotlar turlarini qamrab oladi.
* [**Create a table**](<./Managing Tables/Create a table.md>) - ma'lumotlar bazasida yangi jadval yaratish bo'yicha sizga yo'l-yo'riq.
* [**Select Into**](<./Managing Tables/Select Into.md>) & [**Create table as**](<./Managing Tables/Create table as.md>) - so'rov natijalari to'plamidan qanday qilib yangi jadval yaratishni ko'rsatadi.
* [**Auto-increment column with SERIAL**](<./Managing Tables/Auto-increment.md>) - jadvalga avtomatik o'sish ustunini qo'shish uchun `SERIAL` dan foydalanadi
* [**Sequences**](<./Managing Tables/Sequences.md>) - sizni ketma-ketliklar bilan tanishtiring va raqamlar ketma-ketligini hosil qilish uchun ketma-ketlikdan qanday foydalanishni tasvirlab bering.
* [**Identity column**](<./Managing Tables/Identity column.md>) - identifikatsiya ustunidan qanday foydalanishni ko'rsating.
* [**Alter table**](<./Managing Tables/Alter table.md>) - mavjud jadvalning tuzilishini o'zgartirish
* [**Rename table**](<./Managing Tables/Rename table.md>) - jadval nomini yangisiga o'zgartiring.
* [**Add column**](<./Managing Tables/Add column.md>) mavjud jadvalga bir yoki bir nechta ustunlarni qanday qo'shishni ko'rsating.
* [**Drop column**](<./Managing Tables/Drop column.md>) - jadval ustunini qanday tushirishni ko'rsating.
* [**Change column data type**](<./Managing Tables/Change column data type.md>) - ustun ma'lumotlarini qanday o'zgartirishni ko'rsating.
* [**Rename column**](<./Managing Tables/Rename column.md>) - jadvalning bir yoki bir nechta ustunlarini qanday nomlashni ko'rsating.
* [**Drop table**](<./Managing Tables/Drop table.md>) - mavjud jadval va unga bog'liq bo'lgan barcha obyektlarni olib tashlang
* [**Truncate table**](<./Managing Tables/Truncate table.md>) - katta jadvaldagi barcha ma'lumotlarni tez va samarali tarzda olib tashlash.
* [**Temporary table**](<./Managing Tables/Temporary table.md>) - vaqtinchalik jadvaldan qanday foydalanishni ko'rsating.
* [**Copy a table**](<./Managing Tables/Copy a table.md>) - jadvalni yangisiga qanday nusxalashni ko'rsating