#!/bin/bash
mkdir -p /etc/srsran/
cp -arv ${LTE_BASE_DIR}/config/enb_zmq/* /etc/srsran/

for i in /etc/srsran/* ; do
	FNAME=`echo $i | sed -e 's/.in$//'`
	if [ -f $FNAME.in ] ; then
		${LTE_BASE_DIR}/scripts/common/subst.sh $FNAME.in $FNAME
	fi
done

echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
export LD_LIBRARY_PATH=/opt/LTE/srsran/lib/:$LD_LIBRARY_PATH

${LTE_BASE_DIR}/srsran/bin/srsenb /etc/srsran/enb.conf

