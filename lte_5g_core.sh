#!/bin/sh

docker-compose down
docker container prune -f
docker network prune -f
docker image prune -f

for cnt in dns mongo amf ausf nrf sgwc sgwu smf udm udr upf nr_gnb nr_ue; do
	mkdir -p log/$cnt 2> /dev/null 
	echo -n "Starting $cnt..."
	docker-compose up lte_$cnt &
	sleep 5
	echo ""
done

echo -n "Starting bash in lte_nr_ue context in window $window_no..."
docker-compose exec lte_nr_ue /bin/bash

