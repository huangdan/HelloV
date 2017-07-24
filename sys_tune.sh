#!/bin/sh

## Linux Kernel Tuning
sysctl -w fs.file-max=2097152
sysctl -w fs.nr_open=2097152
echo 2097152 > /proc/sys/fs/nr_open
echo 2097152 > /proc/sys/fs/file-max

## The limit on opened file handles for current session
ulimit -n 1048576

## Add the ‘fs.file-max’ to /etc/sysctl.conf, make the changes permanent

## /etc/security/limits.conf
## 
## /etc/security/limits.conf持久化设置允许用户/进程打开文件句柄数:
## 
## *      soft   nofile      1048576
## *      hard   nofile      1048576


cat <<- 'EOF' >> /etc/security/limits.conf
*                soft    nofile         1048576
*                hard    nofile         1048576
EOF

## Network Tuning

## Increase number of incoming connections backlog
sysctl -w net.core.somaxconn=32768
sysctl -w net.ipv4.tcp_max_syn_backlog=16384
sysctl -w net.core.netdev_max_backlog=16384

## Local Port Range:
sysctl -w net.ipv4.ip_local_port_range="1000  65535"


## Read/Write Buffer for TCP connections:
sysctl -w net.core.rmem_default=262144
sysctl -w net.core.wmem_default=262144
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216
sysctl -w net.core.optmem_max=16777216

#sysctl -w net.ipv4.tcp_mem='16777216 16777216 16777216'
sysctl -w net.ipv4.tcp_rmem='1024 4096 16777216'
sysctl -w net.ipv4.tcp_wmem='1024 4096 16777216'

## Connection Tracking: 
sysctl -w net.nf_conntrack_max=1000000
sysctl -w net.netfilter.nf_conntrack_max=1000000
sysctl -w net.netfilter.nf_conntrack_tcp_timeout_time_wait=30

## The TIME-WAIT Buckets Pool, Recycling and Reuse:
sysctl -w net.ipv4.tcp_max_tw_buckets=1048576
# 注意: 不建议开启該设置，NAT模式下可能引起连接RST
# sysctl -w  net.ipv4.tcp_tw_recycle = 1
# sysctl -w net.ipv4.tcp_tw_reuse = 1

## Timeout for FIN-WAIT-2 sockets:
sysctl -w net.ipv4.tcp_fin_timeout=15

cat <<- 'EOF' >> /etc/sysctl.conf
net.core.somaxconn=32768
net.ipv4.tcp_max_syn_backlog=16384
net.core.netdev_max_backlog=16384
net.ipv4.ip_local_port_range="1000  65535"
net.core.rmem_default=262144
net.core.wmem_default=262144
net.core.rmem_max=16777216
net.core.wmem_max=16777216
net.core.optmem_max=16777216
net.ipv4.tcp_rmem='1024 4096 16777216'
net.ipv4.tcp_wmem='1024 4096 16777216'
net.nf_conntrack_max=1000000
net.netfilter.nf_conntrack_max=1000000
net.netfilter.nf_conntrack_tcp_timeout_time_wait=30
net.ipv4.tcp_max_tw_buckets=1048576
net.ipv4.tcp_fin_timeout=15
EOF

## Erlang VM Tuning
sed -i "s/node\.process_limit = 256000/node\.process_limit = 2097152/g" `grep node\.process_limit = 256000 -rl etc/emq.conf`
sed -i "s/node\.max_ports = 65536/node\.max_ports = 1048576/g" `grep node\.max_ports = 65536 -rl etc/emq.conf`
sed -i "s/listener\.tcp\.external\.acceptors = 16/listener\.tcp\.external\.acceptors = 64/g" `grep listener\.tcp\.external\.acceptors = 16 -rl etc/emq.conf`
sed -i "s/listener\.tcp\.external\.max_clients = 102400/listener\.tcp\.external\.max_clients = 1000000/g" `grep listener\.tcp\.external\.max_clients = 102400 -rl etc/emq.conf`
