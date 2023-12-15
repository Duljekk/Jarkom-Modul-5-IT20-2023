# A2
route add -net 192.243.0.0 netmask 255.255.248.0 gw 192.243.14.130
# A3
route add -net 192.243.8.0 netmask 255.255.252.0 gw 192.243.14.130

# A5
route add -net 192.243.14.136 netmask 255.255.255.252 gw 192.243.14.134
# A6
route add -net 192.243.14.140 netmask 255.255.255.252 gw 192.243.14.134
# A7
route add -net 192.243.12.0 netmask 255.255.254.0 gw 192.243.14.134
# A8
route add -net 192.243.14.0 netmask 255.255.255.128 gw 192.243.14.134
# A9
route add -net 192.243.14.144 netmask 255.255.255.252 gw 192.243.14.134
# A10
route add -net 192.243.14.148 netmask 255.255.255.252 gw 192.243.14.134

## Nomor 1
ETH0_IP=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source $ETH0_IP

## Nomor 10
iptables -A INPUT  -j LOG --log-level debug --log-prefix 'Dropped Packet' -m limit --limit 1/second --limit-burst 10