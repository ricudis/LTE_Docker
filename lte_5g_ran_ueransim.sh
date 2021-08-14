#!/bin/sh

for cnt in nr_gnb nr_ue; do
	mkdir -p log/$cnt 2> /dev/null 
	echo -n "Starting $cnt..."
	docker-compose up lte_$cnt &
	sleep 5
	echo ""
done

echo "Starting bash in lte_nr_ue context..."
# docker-compose exec lte_nr_ue /bin/bash

