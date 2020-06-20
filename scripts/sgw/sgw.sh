#!/bin/bash
OPEN5GS_SGW_CONFIG=${LTE_BASE_DIR}/config/sgw/sgw.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${OPEN5GS_SGW_CONFIG}.in ${OPEN5GS_SGW_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/open5gs/bin/open5gs-sgwd -c ${OPEN5GS_SGW_CONFIG} 
