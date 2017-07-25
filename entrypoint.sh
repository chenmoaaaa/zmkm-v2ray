#!/bin/bash

ip tuntap add tap0 mode tap 
ip addr add 10.0.0.1/24 dev tap0  
ip link set tap0 up 

iptables -P FORWARD ACCEPT 
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE 
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j DNAT --to-destination 10.0.0.2

export LD_PRELOAD=/root/liblkl-hijack.so
export LKL_HIJACK_NET_QDISC="root|fq"
export LKL_HIJACK_SYSCTL="net.ipv4.tcp_congestion_control=bbr"
export LKL_HIJACK_NET_IFTYPE=tap
export LKL_HIJACK_NET_IFPARAMS=tap0
export LKL_HIJACK_NET_IP=10.0.0.2
export LKL_HIJACK_NET_NETMASK_LEN=24
export LKL_HIJACK_NET_GATEWAY=10.0.0.1
export LKL_HIJACK_DEBUG=1

/root/v2ray -config /root/config.json
