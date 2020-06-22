#!/bin/bash
LTE_DNS_CONFIG=${LTE_BASE_DIR}/config/dns/dnsmasq.conf
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/dns/dnsmasq.conf.in /etc/dnsmasq.conf
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
/usr/sbin/dnsmasq -C /etc/dnsmasq.conf -d --log-facility=${LTE_BASE_DIR}/log/dns/dns.log

