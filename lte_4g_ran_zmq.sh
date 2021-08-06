#!/bin/sh

echo "Starting 4G RAN in ZMQ mode"

for cnt in lte_enb_zmq lte_ue_zmq ; do
	echo -n "Starting $cnt..."
	docker-compose up $cnt &
	sleep 5
	echo ""
done

echo -n "Starting bash in lte_ue_zmq context"
docker-compose exec lte_ue_zmq /bin/bash

