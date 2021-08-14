#!/bin/bash
for i in 1 2 3 ; do
	docker-compose down
	docker system prune -f
	docker container prune -f
	docker network prune -f
	docker image prune -f
done
