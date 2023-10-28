# postgresqltutorial.com

## PostgreSQL Tutorial

### Initial Setup

We have a makefile that will help you setup the database and run the queries.\
\


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

\


## Sample Database for use with PostgreSQL

Please, download this db: [Download Link](https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip)

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

\


### Keep learning . . . 👨‍💻
