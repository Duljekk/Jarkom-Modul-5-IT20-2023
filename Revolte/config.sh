echo '
# A3
subnet 192.243.8.0 netmask 255.255.252.0 {
  range 192.243.8.2 192.243.11.254;
  option routers 192.243.8.1;
  option broadcast-address 192.243.11.255; 
  option domain-name-servers 192.243.14.146;
  default-lease-time 720;
  max-lease-time 7200;
}

# A2
subnet 192.243.0.0 netmask 255.255.248.0 {
  range 192.243.0.2 192.243.7.254;
  option routers 192.243.0.1;
  option broadcast-address 192.243.7.255;
  option domain-name-servers 192.243.14.146;
  default-lease-time 720;
  max-lease-time 7200;
}

# A7
subnet 192.243.12.0 netmask 255.255.254.0 {
  range 192.243.12.2 192.243.13.254;
  option routers 192.243.12.1;
  option broadcast-address 192.243.13.255;
  option domain-name-servers 192.243.14.146;
  default-lease-time 720;
  max-lease-time 7200;
}

# A8
subnet 192.243.14.0 netmask 255.255.255.128 {
  range 192.243.14.2 192.243.14.126;
  option routers 192.243.14.1;
  option broadcast-address 192.243.14.127;
  option domain-name-servers 192.243.14.146;
  default-lease-time 720;
  max-lease-time 7200;
}

# A1
subnet 192.243.14.128 netmask 255.255.255.252 {}

# A4
subnet 192.243.14.132 netmask 255.255.255.252 {}

# A5
subnet 192.243.14.136 netmask 255.255.255.252 {}

# A6
subnet 192.243.14.140 netmask 255.255.255.252 {}

# A9
subnet 192.243.14.144 netmask 255.255.255.252 {}

# A10
subnet 192.243.14.148 netmask 255.255.255.252 {}
' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server start

### Nomor 2
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -j DROP
iptables -A INPUT -p udp -j DROP

## Nomor 3
iptables -I INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

## Nomor 10
iptables -A INPUT  -j LOG --log-level debug --log-prefix 'Dropped Packet' -m limit --limit 1/second --limit-burst 10