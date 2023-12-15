# To Aura
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.243.14.133

# A7
route add -net 192.243.12.0 netmask 255.255.254.0 gw 192.243.14.142
# A8
route add -net 192.243.14.0 netmask 255.255.255.128 gw 192.243.14.142
# A9
route add -net 192.243.14.144 netmask 255.255.255.252 gw 192.243.14.142
# A10
route add -net 192.243.14.148 netmask 255.255.255.252 gw 192.243.14.142

## Nomor 10
iptables -A INPUT  -j LOG --log-level debug --log-prefix 'Dropped Packet' -m limit --limit 1/second --limit-burst 10