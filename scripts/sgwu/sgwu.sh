#!/bin/bash
OPEN5GS_SGWU_CONFIG=${LTE_BASE_DIR}/open5gs/etc/open5gs/sgwu.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/sgwu/sgwu.yaml.in ${OPEN5GS_SGWU_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/open5gs/bin/open5gs-sgwud -c ${OPEN5GS_SGWU_CONFIG}

