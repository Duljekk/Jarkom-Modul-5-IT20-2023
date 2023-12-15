echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt update
apt install netcat -y
apt install apache2 -y
service apache2 start

echo '# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 443

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/ports.conf

echo 'Selamat datang di Web Server - Stark!' > /var/www/html/index.html

## Nomor 4
iptables -A INPUT -p tcp --dport 22 -m iprange --src-range 192.243.8.2-192.243.8.255 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m iprange --src-range 192.243.9.0-192.243.9.255 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m iprange --src-range 192.243.10.0-192.243.10.255 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m iprange --src-range 192.243.11.0-192.243.11.254 -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -j DROP

## Nomor 5
iptables -A INPUT -m time --timestart 08:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -j REJECT

## Nomor 6
iptables -A INPUT -m time --timestart 12:00 --timestop 13:00 --weekdays Mon,Tue,Wed,Thu -j REJECT
iptables -A INPUT -m time --timestart 11:00 --timestop 13:00 --weekdays Fri -j REJECT

## Nomor 8
iptables -A INPUT -p tcp --dport 80 -s 192.243.14.148/30 -m time --datestart 2023-12-10 --datestop 2024-02-15 -j DROP

## Nomor 9
iptables -N portscan

iptables -A INPUT -m recent --name portscan --update --seconds 600 --hitcount 20 -j DROP
iptables -A FORWARD -m recent --name portscan --update --seconds 600 --hitcount 20 -j DROP

iptables -A INPUT -m recent --name portscan --set -j ACCEPT
iptables -A FORWARD -m recent --name portscan --set -j ACCEPT

## Nomor 10
iptables -A INPUT  -j LOG --log-level debug --log-prefix 'Dropped Packet' -m limit --limit 1/second --limit-burst 10