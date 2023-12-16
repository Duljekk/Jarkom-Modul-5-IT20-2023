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

## Nomor 7
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.243.8.2 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.243.8.2

iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.243.8.2 -j DNAT --to-destination 192.243.14.138

iptables -A PREROUTING -t nat -p tcp --dport 443 -d 192.243.14.138 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.243.14.138

iptables -A PREROUTING -t nat -p tcp --dport 443 -d 192.243.14.138 -j DNAT --to-destination 192.243.8.2

## Nomor 10
iptables -A INPUT  -j LOG --log-level debug --log-prefix 'Dropped Packet' -m limit --limit 1/second --limit-burst 10