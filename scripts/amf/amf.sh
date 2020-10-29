#!/bin/bash
if [ "`arch`" = "aarch64" ] ; then
        export LTE_BUILD_ARCH=aarch64-linux-gnu
else
        export LTE_BUILD_ARCH=x86_64-linux-gnu
fi
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${LTE_BASE_DIR}/open5gs/lib/${LTE_BUILD_ARCH}/
mkdir -p ${LTE_BASE_DIR}/config/amf
OPEN5GS_AMF_CONFIG=${LTE_BASE_DIR}/open5gs/etc/open5gs/amf.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/amf/amf.yaml.in ${OPEN5GS_AMF_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/open5gs/bin/open5gs-amfd -c ${OPEN5GS_AMF_CONFIG}
