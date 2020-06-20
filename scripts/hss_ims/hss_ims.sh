#!/bin/bash
cd ${LTE_BASE_DIR}/config/hss_ims/
for i in * ; do
	${LTE_BASE_DIR}/scripts/common/subst.sh ./$i /opt/OpenIMSCore/FHoSS/deploy/$i
done
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
cd /opt/OpenIMSCore/FHoSS/deploy/
sh /opt/LTE/scripts/common/waitfor_mysql.sh
sh startup.sh
