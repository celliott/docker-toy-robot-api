# docker-toy-robot-api makefile

ADMIN_USER=${ADMIN_USER:-'admin'}
ADMIN_PASS=${ADMIN_PASS:-'Password123'}
ADMIN_EMAIL=${ADMIN_EMAIL:-'admin@petals.io'}
MODULE := toy_robot_api

PORTS = -p 80:5000
ENVS = -e ADMIN_USER=${ADMIN_USER} -e ADMIN_PASS=${ADMIN_PASS} -e ADMIN_EMAIL=${ADMIN_EMAIL} -e MODULE=${MODULE}

VOLUMES = -v `pwd`/app:/opt/app
CONTAINER = toy-robot-api

.PHONY: container run

clean :
	rm -rf app/db.sqlite3

container :
	docker build -t $(CONTAINER) .

run :
	docker run --restart=always --name $(CONTAINER) -i -d $(PORTS) $(ENVS) $(VOLUMES) -t $(CONTAINER)

kill :
	docker kill $(CONTAINER)
	docker rm $(CONTAINER)

restart :
	docker kill $(CONTAINER)
	docker rm $(CONTAINER)
	docker run --restart=always --name $(CONTAINER) -i -d $(PORTS) $(ENVS) $(VOLUMES) -t $(CONTAINER)

attach:
	docker attach $(CONTAINER)

bash:
	docker exec -ti $(CONTAINER) /bin/bash

tail:
	docker logs -f $(CONTAINER)
