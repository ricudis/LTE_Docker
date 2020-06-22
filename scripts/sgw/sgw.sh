#!/bin/bash
OPEN5GS_SGW_CONFIG=${LTE_BASE_DIR}/open5gs/etc/open5gs/sgw.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/sgw/sgw.yaml.in ${OPEN5GS_SGW_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/open5gs/bin/open5gs-sgwd -c ${OPEN5GS_SGW_CONFIG}

