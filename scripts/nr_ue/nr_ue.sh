#!/bin/bash
if [ "`arch`" = "aarch64" ] ; then
        export LTE_BUILD_ARCH=aarch64-linux-gnu
else
        export LTE_BUILD_ARCH=x86_64-linux-gnu
fi
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${LTE_BASE_DIR}/open5gs/lib/${LTE_BUILD_ARCH}/
UERANSIM_NR_UE_CONFIG=${LTE_BASE_DIR}/ueransim/config/ue.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/nr_ue/ue.yaml.in ${UERANSIM_NR_UE_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/opt/LTE/ueransim/bin/nr-ue -c ${UERANSIM_NR_UE_CONFIG}


root@b1f934badf91:/opt/LTE/src# route add -host 10.45.0.1 dev uesimtun0
root@b1f934badf91:/opt/LTE/src# route add -net default gw 10.45.0.1
root@b1f934badf91:/opt/LTE/src# ping 8.8.8.8
