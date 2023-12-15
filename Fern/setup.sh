# To Himmel
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.243.14.1

## Nomor 10
iptables -A INPUT  -j LOG --log-level debug --log-prefix 'Dropped Packet' -m limit --limit 1/second --limit-burst 10