#!/bin/bash
mkdir -p /etc/srslte/
cp -arv ${LTE_BASE_DIR}/config/enb_zmq/* /etc/srslte/

for i in /etc/srslte/* ; do
	FNAME=`echo $i | sed -e 's/.in$//'`
	if [ -f $FNAME.in ] ; then
		${LTE_BASE_DIR}/scripts/common/subst.sh $FNAME.in $FNAME
	fi
done

echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
export LD_LIBRARY_PATH=/opt/LTE/srslte/lib/:$LD_LIBRARY_PATH

${LTE_BASE_DIR}/srslte/bin/srsenb /etc/srslte/enb.conf
