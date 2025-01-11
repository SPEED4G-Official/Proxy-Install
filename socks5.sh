echo -e "Start Install SOCKS5 Proxy ..."
usernamesocks5="$1"
passwordsocks5="$2"
yum install -y gcc openldap-devel pam-devel openssl-devel wget
wget http://jaist.dl.sourceforge.net/project/ss5/ss5/3.8.9-8/ss5-3.8.9-8.tar.gz
tar -vzx -f ss5-3.8.9-8.tar.gz
cd ss5-3.8.9/
./configure
make
make install
chmod a+x /etc/init.d/ss5
echo "auth    0.0.0.0/0               -               u" >> /etc/opt/ss5/ss5.conf
echo "permit u	0.0.0.0/0	-	0.0.0.0/0	-	-	-	-	-	" >> /etc/opt/ss5/ss5.conf
echo "$usernamesocks5 $passwordsocks5" >> /etc/opt/ss5/ss5.passwd
service ss5 restart
cd ~

GREEN='\033[0;32m'
NC='\033[0m'
response=$(curl -s https://api.myip.com)
ip=$(echo "$response" | jq -r '.ip')
clear
echo -e "${NC}"
echo -e "${GREEN}SOCKS5 Proxy Install Successfully. SOCKS5 Proxy: socks5://${ip}:1080:${usernamesquid}:${passwordsquid}${NC}"
echo -e "${NC}"
