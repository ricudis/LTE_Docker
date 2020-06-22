#!/bin/bash
cp -arv ${LTE_BASE_DIR}/config/icscf/* ${LTE_BASE_DIR}/kamailio/etc/kamailio/

for i in ${LTE_BASE_DIR}/kamailio/etc/kamailio/* ; do
	FNAME=`echo $i | sed -e 's/.in$//'`
	if [ -f $FNAME.in ] ; then
		${LTE_BASE_DIR}/scripts/common/subst.sh $FNAME.in $FNAME
	fi
done

echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
sh /opt/LTE/scripts/common/waitfor_mysql.sh
${LTE_BASE_DIR}/kamailio/sbin/kamailio -dd
sh /opt/LTE/scripts/common/waitfor_ever.sh

