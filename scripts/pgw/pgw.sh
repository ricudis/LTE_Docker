#!/bin/bash

ip tuntap del name ogstun_internet mode tun >/dev/null 2>&1
ip tuntap del name ogstun_ims mode tun >/dev/null 2>&1

ip tuntap add name ogstun_internet mode tun
ip tuntap add name ogstun_ims mode tun

sysctl net.ipv6.conf.ogstun_internet.disable_ipv6=0
sysctl net.ipv6.conf.ogstun_ims.disable_ipv6=0

ip addr add ${LTE_UE_SUBNET_IP4} dev ogstun_internet
ip addr add ${LTE_UE_SUBNET_IP6} dev ogstun_internet

ip addr add ${LTE_UE_SUBNET_IMS_IP4} dev ogstun_ims
ip addr add ${LTE_UE_SUBNET_IMS_IP6} dev ogstun_ims

ip link set ogstun_internet up
ip link set ogstun_ims up

ip addr del fe80::2 dev lo 2> /dev/null
ip addr del fe80::3 dev lo 2> /dev/null
ip addr del fe80::4 dev lo 2> /dev/null
ip addr del fe80::5 dev lo 2> /dev/null
ip addr add fe80::2 dev lo
ip addr add fe80::3 dev lo
ip addr add fe80::4 dev lo
ip addr add fe80::5 dev lo

ip addr show
iptables -t nat -A POSTROUTING -s ${LTE_UE_SUBNET_IP4} ! -o ogstun+ -j MASQUERADE

mkdir -p /opt/LTE/pgw/etc
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/pgw/pgw.yaml.in /opt/LTE/pgw/etc/pgw.yaml
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_BASE_DIR}/config/pgw/radvd.conf.in /opt/LTE/pgw/etc/radvd.conf
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
radvd -C /opt/LTE/pgw/etc/radvd.conf -m stderr_syslog
/opt/LTE/open5gs/bin/open5gs-pgwd -c /opt/LTE/pgw/etc/pgw.yaml

