#!/bin/sh

sh ./cleanup.sh

# lte_enb_zmq
# lte_ue_zmq

echo "Starting CORE"

for cnt in lte_dns lte_mongo lte_mysql lte_hss_epc lte_hss_epc_web lte_pcrf lte_sgwc lte_sgwu lte_nrf lte_smf lte_upf lte_mme ; do
	mkdir -p log/$cnt 2> /dev/null 
	echo -n "Starting $cnt..."
	docker-compose up $cnt &
	sleep 5
	echo ""
done

mkdir -p log/lte_enb
mkdir -p log/lte_ue

#echo -n "Starting bash in lte_ue_zmq context"
#docker-compose exec lte_ue_zmq /bin/bash

