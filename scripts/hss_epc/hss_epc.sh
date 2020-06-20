#!/bin/bash
OPEN5GS_HSS_CONFIG=${LTE_BASE_DIR}/config/hss_epc/hss.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${OPEN5GS_HSS_CONFIG}.in ${OPEN5GS_HSS_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
sh /opt/LTE/scripts/common/waitfor_mongo.sh
/opt/LTE/open5gs/bin/open5gs-hssd -c ${OPEN5GS_HSS_CONFIG} 
