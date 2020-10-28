#!/bin/bash
OPEN5GS_SGWC_CONFIG=${LTE_BASE_DIR}/open5gs/etc/open5gs/sgwc.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/sgwc/sgwc.yaml.in ${OPEN5GS_SGWC_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/open5gs/bin/open5gs-sgwcd -c ${OPEN5GS_SGWC_CONFIG}

