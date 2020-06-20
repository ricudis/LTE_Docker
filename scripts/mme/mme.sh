#!/bin/bash
OPEN5GS_MME_CONFIG=${LTE_BASE_DIR}/config/mme/mme.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${OPEN5GS_MME_CONFIG}.in ${OPEN5GS_MME_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/open5gs/bin/open5gs-mmed -c ${OPEN5GS_MME_CONFIG} 
