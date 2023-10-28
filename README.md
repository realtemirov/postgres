## PostgreSQL Tutorial

PostgreSQL - bu Postgres nomi bilan ham tanilgan, bepul va ochiq manbali relyatsion ma'lumotlar bazasini boshqarish tizimi (RDBMS) kengaytirilishi va SQL muvofiqligini ta'kidlaydi. 

U dastlab Berkli Kaliforniya universitetida ishlab chiqilgan Ingres ma'lumotlar bazasining davomchisi sifatida kelib chiqishiga ishora qilib, POSTGRES deb nomlangan. 1996 yilda loyiha SQL ni qoʻllab-quvvatlashini aks ettirish uchun PostgreSQL deb oʻzgartirildi . 2007 yilda ko'rib chiqilgandan so'ng, ishlab chiqish guruhi PostgreSQL nomini va Postgres taxallusini saqlab qolishga qaror qildi.

Postgresni postgresqltutorial.com saytidan boshlaymiz.
Unda tayyor ma'lumotlar bazasi bor. Biz uni Docker orqali ishga tushiramiz.
Kodlashni osonlashtirish uchun `makefile` faylidan foydalanamiz.

# postgresqltutorial.com

### Initial Setup
We have a makefile that will help you setup the database and run the queries. <br> We use Docker to run the database.
<br>
#### Create Database with Docker
```bash
$ make run 
```


#### Login to container with Docker
```bash
$ make bash
```

#### Login to Database with Docker
```bash
$ make exec
```

#### Start container
```bash
$ make start
```

#### Stop container
```bash
$ make stop
```

#### Delete container
```bash
$ make delete
```


## Sample Database for use with PostgreSQL
Please, download this db: [ Download Link ](https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip)

First, extract the file.\
Second, you need to login to docker container:

### Copy file to docker container
```bash
$ docker cp <file_path> <container_name>:<file_path>
```

Example:
```bash
$ docker cp ~/Downdloads/dvdrental.tar postgres:/
```

After login to docker container, you need to restore the database:

### Restore database
```bash
$ pg_restore -U postgres -d <db_name> <file_path>
```

Exapmle:
```bash
$ pg_restore -U postgres -d dvdrental /dvdrental.tar
```

### Keep learning . . . 👨‍💻