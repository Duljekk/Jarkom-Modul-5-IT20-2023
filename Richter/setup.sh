echo 'nameserver 192.168.122.1' >/etc/resolv.conf

apt get-update
apt get-install netcat -y
apt get-install bind9 -y

echo '
options {
  directory "/var/cache/bind";
  forwarders { 192.168.122.1; };
  allow-query { any; };
  auth-nxdomain no; // conform to RFC1035
  listen-on-v6 { any; };
};' > /etc/bind/named.conf.options 

service bind9 restart

## Nomor 3
iptables -I INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

## Nomor 10
iptables -A INPUT  -j LOG --log-level debug --log-prefix 'Dropped Packet' -m limit --limit 1/second --limit-burst 10