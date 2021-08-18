#!/bin/bash

docker-compose up lte_dns &

sleep 5

eval `grep LTE_DOCKER_GW_IP ./environment`
export TCPDUMP_INTERFACE=`ip -o addr | grep ${LTE_DOCKER_GW_IP} | tr -s " "  | cut -f2 -d" "`
export TCPDUMP_FILE=dump-`date | tr -s ":" "_" | tr -s " " "_"`.pcap
mkdir -p log/traces/
( cd log/traces ; sudo tcpdump -n -i ${TCPDUMP_INTERFACE} -s 0 -w ${TCPDUMP_FILE} ) &

