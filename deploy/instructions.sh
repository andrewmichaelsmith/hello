apt-get install -y hostapd dnsmasq nginx python3-pip
/etc/init.d/nginx stop

cd /opt/hello
pip3 install -r requirements.txt
systemctl enable hello

