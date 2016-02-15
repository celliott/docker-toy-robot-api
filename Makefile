# docker-robot-api makefile

MODULE := toy_robot_api

PORTS = -p 80:5000
#ENVS = -e MODULE=${MODULE}

VOLUMES = -v `pwd`/app:/opt/django/app
CONTAINER = toy-robot-api

.PHONY: container run

clean :
	rm -rf build

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
