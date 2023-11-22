# Recursive query using CTEs

Ushbu qo'llanmada siz Rekursiv umumiy jadval ifodalari yoki CTE-lardan foydalangan holda PostgreSQL rekursiv so'rovi haqida bilib olasiz.

PostgreSQL so'rovda foydalanish uchun yordamchi bayonotlar yaratish imkonini beruvchi `WITH` bayonotini taqdim etadi.

Ushbu bayonotlar ko'pincha umumiy jadval ifodalari(`common table expressions`) yoki `CTE` deb ataladi. CTElar faqat so'rovni bajarish paytida mavjud bo'lgan vaqtinchalik jadvallarga o'xshaydi.

Rekursiv so'rov - bu rekursiv CTE ga tegishli so'rov. Rekursiv so'rovlar tashkiliy tuzilma, materiallar ro'yxati va boshqalar kabi ierarxik ma'lumotlarni so'rash kabi ko'p holatlarda foydalidir.

Quyida rekursiv CTE sintaksisi tasvirlangan:

```sql
WITH RECURSIVE cte_name AS(
    CTE_query_definition -- non-recursive term
    UNION [ALL]
    CTE_query definion  -- recursive term
) SELECT * FROM cte_name;
```

Rekursiv CTE uchta elementga ega:

* Rekursiv bo'lmagan atama: rekursiv bo'lmagan atama CTE tuzilmasining asosiy natijalar to'plamini tashkil etuvchi CTE so'rovi ta'rifidir.

* Rekursiv atama: rekursiv atama `UNION` yoki `UNION ALL` operatori yordamida rekursiv bo'lmagan atama bilan birlashtirilgan bir yoki bir nechta CTE so'rov ta'riflari. Rekursiv atama CTE nomining o'ziga ishora qiladi.

* Tugatishni tekshirish: oldingi iteratsiyadan hech qanday satr qaytarilmasa, rekursiya to'xtaydi.

PostgreSQL rekursiv CTE ni quyidagi ketma-ketlikda bajaradi:

1. Asosiy natijalar toʻplamini (R0) yaratish uchun rekursiv boʻlmagan atamani bajaradi

2. Ri+1 natija toʻplamini chiqish sifatida qaytarish uchun kirish sifatida Ri bilan rekursiv atamani bajaradi.

3. Bo'sh to'plam qaytarilmaguncha 2-bosqichni takrorlanadi. (tugatishni tekshirish)

4. R0, R1, … Rn natijalar toʻplamining `UNION` yoki `UNION ALL` boʻlgan yakuniy natijalar toʻplamini qaytaradi.

## PostgreSQL rekursiv so'rovlar misoli

PostgreSQL rekursiv so'rovini namoyish qilish uchun yangi jadval yaratamiz.

```sql
CREATE TABLE employees (
	employee_id serial PRIMARY KEY,
	full_name VARCHAR NOT NULL,
	manager_id INT
);
```

`employees` jadvali uchta ustundan iborat: `employee_id`, `manager_id`, va `full_name`. `manager_id` ustuni xodimning menejer identifikatorini belgilaydi.

Quyidagi bayonot `employees` jadvaliga namunaviy ma'lumotlarni kiritadi.

```sql
INSERT INTO employees (
	employee_id,
	full_name,
	manager_id
)
VALUES
	(1, 'Michael North', NULL),
	(2, 'Megan Berry', 1),
	(3, 'Sarah Berry', 1),
	(4, 'Zoe Black', 1),
	(5, 'Tim James', 1),
	(6, 'Bella Tucker', 2),
	(7, 'Ryan Metcalfe', 2),
	(8, 'Max Mills', 2),
	(9, 'Benjamin Glover', 2),
	(10, 'Carolyn Henderson', 3),
	(11, 'Nicola Kelly', 3),
	(12, 'Alexandra Climo', 3),
	(13, 'Dominic King', 3),
	(14, 'Leonard Gray', 4),
	(15, 'Eric Rampling', 4),
	(16, 'Piers Paige', 7),
	(17, 'Ryan Henderson', 7),
	(18, 'Frank Tucker', 8),
	(19, 'Nathan Ferguson', 8),
	(20, 'Kevin Rampling', 8);
```

Quyidagi soʻrov 2-identifikatorli menejerning barcha boʻysunuvchilarini qaytaradi.


```sql
WITH RECURSIVE subordinates AS (
	SELECT
		employee_id,
		manager_id,
		full_name
	FROM
		employees
	WHERE
		employee_id = 2
	UNION
		SELECT
			e.employee_id,
			e.manager_id,
			e.full_name
		FROM
			employees e
		INNER JOIN subordinates s ON s.employee_id = e.manager_id
) SELECT
	*
FROM
	subordinates;
```

U qanday ishlaydi:
* Rekursiv CTE, subordinatlar, bitta rekursiv bo'lmagan atama va bitta rekursiv atamani belgilaydi.

* Rekursiv bo'lmagan atama identifikator 2 bo'lgan xodim bo'lgan R0 asosiy natija to'plamini qaytaradi.

```sql
 employee_id | manager_id |  full_name
-------------+------------+-------------
           2 |          1 | Megan Berry
```

Rekursiv atama xodim identifikatorining 2-to'g'ridan-to'g'ri bo'ysunuvchi(lar)ini qaytaradi. Bu xodimlar jadvali va CTE bo'ysunuvchilari o'rtasida qo'shilish natijasidir. Rekursiv atamaning birinchi iteratsiyasi quyidagi natijalar to'plamini qaytaradi:

```sql
 employee_id | manager_id |    full_name
-------------+------------+-----------------
           6 |          2 | Bella Tucker
           7 |          2 | Ryan Metcalfe
           8 |          2 | Max Mills
           9 |          2 | Benjamin Glover
```

PostgreSQL rekursiv atamani qayta-qayta bajaradi. Rekursiv a'zoning ikkinchi iteratsiyasi kirish qiymati sifatida yuqoridagi natija to'plamidan foydalanadi va bu natijalar to'plamini qaytaradi:

```sql
employee_id | manager_id |    full_name
-------------+------------+-----------------
          16 |          7 | Piers Paige
          17 |          7 | Ryan Henderson
          18 |          8 | Frank Tucker
          19 |          8 | Nathan Ferguson
          20 |          8 | Kevin Rampling
```

Uchinchi iteratsiya bo'sh natijalar to'plamini qaytaradi, chunki 16, 17, 18, 19 va 20 identifikatorli xodimga hisobot beradigan xodim yo'q.

PostgreSQL rekursiv bo'lmagan va rekursiv atamalar tomonidan yaratilgan birinchi va ikkinchi iteratsiyalardagi barcha natijalar to'plamlarining birlashmasi bo'lgan yakuniy natijalar to'plamini qaytaradi.

```sql
employee_id | manager_id |    full_name
-------------+------------+-----------------
           2 |          1 | Megan Berry
           6 |          2 | Bella Tucker
           7 |          2 | Ryan Metcalfe
           8 |          2 | Max Mills
           9 |          2 | Benjamin Glover
          16 |          7 | Piers Paige
          17 |          7 | Ryan Henderson
          18 |          8 | Frank Tucker
          19 |          8 | Nathan Ferguson
          20 |          8 | Kevin Rampling
(10 rows)
```

Ushbu qo'llanmada siz PostgreSQL rekursiv so'rovlarini yaratish uchun rekursiv CTE-lardan qanday foydalanishni o'rgandingiz.

© [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-recursive-query/)