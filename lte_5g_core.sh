#!/bin/sh
 
sh ./tcpdump.sh

for cnt in dns mongo amf ausf nrf sgwc sgwu smf bsf pcf nssf udm udr upf; do
	mkdir -p log/$cnt 2> /dev/null 
	echo -n "Starting $cnt..."
	docker-compose up lte_$cnt &
	sleep 5
	echo ""
done
