include .env

run:
	docker run --name ${DOCKER_POSTGRES_CONTAINER_NAME} -d -p ${POSTGRES_PORT}:5432 --env-file .env postgres:15-alpine3.16
exec:
	docker exec -it ${DOCKER_POSTGRES_CONTAINER_NAME} psql -U ${POSTGRES_USER} -d ${POSTGRES_DB}
start:
	docker start ${DOCKER_POSTGRES_CONTAINER_NAME}
stop:
	docker stop ${DOCKER_POSTGRES_CONTAINER_NAME}
delete:
	docker rm ${DOCKER_POSTGRES_CONTAINER_NAME}
bash:
	docker exec -it ${DOCKER_POSTGRES_CONTAINER_NAME} bash