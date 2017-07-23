apt-get update
apt-get install -y hostapd dnsmasq nginx python3-pip
/etc/init.d/nginx stop

cd /opt/hello
pip3 install -r requirements.txt

systemctl enable hello

systemctl enable ssh

mkdir -p /opt/nltk_data
python3 -m nltk.downloader -d /opt/nltk_data wordnet punkt stopwords vader_lexicon

