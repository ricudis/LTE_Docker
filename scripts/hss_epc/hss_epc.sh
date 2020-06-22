#!/bin/bash
OPEN5GS_HSS_EPC_CONFIG=${LTE_BASE_DIR}/open5gs/etc/open5gs/hss_epc.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/hss_epc/hss_epc.yaml.in ${OPEN5GS_HSS_EPC_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/open5gs/bin/open5gs-hssd -c ${OPEN5GS_HSS_EPC_CONFIG}
