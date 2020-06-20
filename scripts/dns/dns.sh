#!/bin/bash
LTE_DNS_CONFIG=${LTE_BASE_DIR}/config/dns/dnsmasq.conf
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_DNS_CONFIG}.in ${LTE_DNS_CONFIG}
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/usr/sbin/dnsmasq -C ${LTE_DNS_CONFIG} -d --log-facility=${LTE_BASE_DIR}/log/dns/dns.log
