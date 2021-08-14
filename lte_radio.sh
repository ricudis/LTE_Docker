#!/bin/sh

for cnt in lte_dns lte_mongo lte_mysql lte_hss_epc lte_hss_epc_web lte_pcrf lte_sgw lte_pgw lte_mme lte_enb_radio ; do
	mkdir -p log/$cnt 2> /dev/null 
	echo -n "Starting $cnt in window $window_no..."
	docker-compose up $cnt &
	sleep 5
	echo ""
done

