#!/bin/sh

docker-compose down
docker container prune -f
docker network prune -f
docker image prune -f

docker-compose up lte_dns lte_amf lte_ausf lte_nrf lte_sgwc lte_sgwu lte_smf lte_udm lte_udr lte_upf

for cnt in lte_dns lte_mongo lte_amf lte_ausf lte_nrf lte_sgwc lte_sgwu lte_smf lte_udm lte_udr lte_upf ; do
	mkdir -p log/$cnt 2> /dev/null 
	echo -n "Starting $cnt in window $window_no..."
	docker-compose up $cnt &
	sleep 5
	echo ""
done

#echo -n "Starting bash in lte_ue_zmq context in window $window_no..."
#docker-compose exec lte_ue_zmq /bin/bash

