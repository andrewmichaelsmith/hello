apt-get install -y hostapd dnsmasq nginx python3-pip
/etc/init.d/nginx stop

cd /opt/hello
pip3 install -r requirements.txt
python3 -m nltk.downloader -d ~/nltk_data wordnet punkt stopwords vader_lexicon
systemctl enable hello

systemctl enable ssh


