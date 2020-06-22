#!/bin/sh

docker-compose down
docker container prune -f
docker network prune -f
docker image prune -f

for cnt in lte_dns lte_mongo lte_mysql lte_hss_epc lte_hss_epc_web lte_pcrf lte_sgw lte_pgw lte_mme lte_enb_zmq lte_ue_zmq ; do
	mkdir -p log/$cnt 2> /dev/null 
	echo -n "Starting $cnt in window $window_no..."
	docker-compose up $cnt &
	sleep 5
	echo ""
done

echo -n "Starting bash in lte_ue_zmq context in window $window_no..."
docker-compose exec lte_ue_zmq /bin/bash

