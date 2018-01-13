#!/bin/sh
echo "updating yum ...."
echo "................................"
echo '.................................'
yum update
yum -y install epel-release
yum groupinstall "Development Tools"
yum -y install gcc*
yum -y install libpcap*
yum -y install gcc zlib-devel openssl-devel readline-devel ncurses-devel

echo "downloading softether vpn .................."
echo "................................................"
echo "..................................................."
wget http://www.softether-download.com/files/softether/v4.24-9652-beta-2017.12.21-tree/Linux/SoftEther_VPN_Server/32bit_-_Intel_x86/softether-vpnserver-v4.24-9652-beta-2017.12.21-linux-x86-32bit.tar.gz
tar xzvf softether-vpnserver-v4.24-9652-beta-2017.12.21-linux-x86-32bit.tar.gz
cd vpnserver
make
