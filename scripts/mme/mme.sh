#!/bin/bash
OPEN5GS_MME_CONFIG=${LTE_BASE_DIR}/open5gs/etc/open5gs/mme.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/mme/mme.yaml.in ${OPEN5GS_MME_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/open5gs/bin/open5gs-mmed -c ${OPEN5GS_MME_CONFIG}
