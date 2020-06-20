#!/bin/bash
cp -av ${LTE_BASE_DIR}/config/rtpengine/*.conf.in /etc/rtpengine/
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/rtpengine/rtpengine.conf.in /etc/rtpengine/rtpengine.conf
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/rtpengine/rtpengine-recording.conf.in /etc/rtpengine/rtpengine-recording.conf

echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf

mkdir -p /var/spool/rtpengine
modprobe xt_RTPENGINE
/usr/sbin/ngcp-rtpengine-iptables-setup start
/usr/sbin/rtpengine-recording -E --no-log-timestamps --pidfile /ngcp-rtpengine-recording-daemon.pid --config-file /etc/rtpengine/rtpengine-recording.conf
/usr/sbin/rtpengine -f -E --no-log-timestamps --pidfile ngcp-rtpengine-daemon.pid --config-file /etc/rtpengine/rtpengine.conf --table 0 --interface=$LTE_RTPENGINE_IP --listen-ng=$LTE_RTPENGINE_IP:2223

