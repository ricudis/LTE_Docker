#!/bin/bash
if [ "`arch`" = "aarch64" ] ; then
        export LTE_BUILD_ARCH=aarch64-linux-gnu
else
        export LTE_BUILD_ARCH=x86_64-linux-gnu
fi
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${LTE_BASE_DIR}/open5gs/lib/${LTE_BUILD_ARCH}/
mkdir -p ${LTE_BASE_DIR}/config/mme
OPEN5GS_MME_CONFIG=${LTE_BASE_DIR}/open5gs/etc/open5gs/mme.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/mme/mme.yaml.in ${OPEN5GS_MME_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/open5gs/bin/open5gs-mmed -c ${OPEN5GS_MME_CONFIG}

