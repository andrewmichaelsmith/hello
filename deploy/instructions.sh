apt-get update --fix-missing
apt-get install -y hostapd dnsmasq nginx python3-pip
/etc/init.d/nginx stop

cd /opt/hello
pip3 install -r requirements.txt
systemctl enable hello

systemctl enable ssh

openssl req -x509 -nodes -days 3650 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=hello.hello" -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem
