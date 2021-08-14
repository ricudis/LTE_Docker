#!/bin/sh

for cnt in nr_gnb nr_ue; do
	mkdir -p log/$cnt 2> /dev/null
	echo -n "Starting $cnt..."
	docker-compose up lte_$cnt &
	sleep 5
	echo ""
done

echo "Sleeping for 10 seconds"

sleep 10

echo "Run inside the container:"
echo ""
echo "root@b1f934badf91:/opt/LTE/src# route add -host 10.45.0.1 dev uesimtun0"
echo "root@b1f934badf91:/opt/LTE/src# route add -net default gw 10.45.0.1"
echo "root@b1f934badf91:/opt/LTE/src# ping 8.8.8.8"
echo ""
echo "Starting bash in lte_nr_ue context..."
docker-compose exec lte_nr_ue /bin/bash

