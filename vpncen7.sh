#!/bin/sh
yum update
yum -y install epel-release
yum groupinstall "Development Tools"
yum -y install gcc*
yum -y install libpcap*
yum -y install gcc zlib-devel openssl-devel readline-devel ncurses-devel
wget http://www.softether-download.com/files/softether/v4.24-9652-beta-2017.12.21-tree/Linux/SoftEther_VPN_Server/32bit_-_Intel_x86/softether-vpnserver-v4.24-9652-beta-2017.12.21-linux-x86-32bit.tar.gz
tar xzvf softether-vpnserver-v4.24-9652-beta-2017.12.21-linux-x86-32bit.tar.gz
cd vpnserver
make
cd ..
mv vpnserver /usr/local
cd /usr/local/vpnserver
chmod 600*
chmod 700 vpncmd
chmod 700 vpnserver
cd /etc/init.d/
wget https://raw.githubusercontent.com/BigOrt/cen7/master/vpnserver
cd
chmod 755 /etc/init.d/vpnserver
mkdir /var/lock/subsys
update-rc.d vpnserver defaults
chkconfig --add vpnserver
chkconfig vpnserver on
/etc/init.d/vpnserver start
./vpncmd

