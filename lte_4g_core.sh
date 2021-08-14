#!/bin/sh

echo "Starting CORE"

sh ./tcpdump.sh

mkdir -p log

for cnt in lte_dns lte_mongo lte_mysql lte_hss_epc lte_hss_epc_web lte_pcrf lte_sgwc lte_sgwu lte_nrf lte_smf lte_upf lte_mme ; do
	echo -n "Starting $cnt..."
	docker-compose up $cnt &
	sleep 5
	echo ""
done
