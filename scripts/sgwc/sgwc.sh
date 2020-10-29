#!/bin/bash
if [ "`arch`" = "aarch64" ] ; then
        export LTE_BUILD_ARCH=aarch64-linux-gnu
else
        export LTE_BUILD_ARCH=x86_64-linux-gnu
fi
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${LTE_BASE_DIR}/open5gs/lib/${LTE_BUILD_ARCH}/
mkdir -p ${LTE_BASE_DIR}/config/sgwc
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${LTE_BASE_DIR}/open5gs/lib/x86_64-linux-gnu/
OPEN5GS_SGWC_CONFIG=${LTE_BASE_DIR}/open5gs/etc/open5gs/sgwc.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/sgwc/sgwc.yaml.in ${OPEN5GS_SGWC_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
${LTE_BASE_DIR}/open5gs/bin/open5gs-sgwcd -c ${OPEN5GS_SGWC_CONFIG}

