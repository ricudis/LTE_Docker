#!/bin/bash
if [ "`arch`" = "aarch64" ] ; then
        export LTE_BUILD_ARCH=aarch64-linux-gnu
else
        export LTE_BUILD_ARCH=x86_64-linux-gnu
fi
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${LTE_BASE_DIR}/open5gs/lib/${LTE_BUILD_ARCH}/
UERANSIM_NR_GNB_CONFIG=${LTE_BASE_DIR}/ueransim/config/gnb.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/nr_gnb/gnb.yaml.in ${UERANSIM_NR_GNB_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/ueransim/bin/nr-gnb -c ${UERANSIM_NR_GNB_CONFIG}

