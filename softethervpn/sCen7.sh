#!/bin/sh
echo "----------updating yum ----------";
echo "................................";
echo ".................................";
yum update;
yum -y install epel-release;
yum group install "Development Tools";
yum -y install gcc*;
yum -y install libpcap*;
yum -y install gcc zlib-devel openssl-devel readline-devel ncurses-devel;

echo ".................downloading softether vpn ....................";
echo "...............................................................";
echo "...............................................................";
echo "-----------------checking version-----------------------------";

a="arch";
echo "version : `eval $a` ";
echo "----------------------------";
echo "go....";
b=`eval $a`;
if [ "$b" = "`eval $a`" ]
then
 wget http://www.softether-download.com/files/softether/v4.25-9656-rtm-2018.01.15-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x64-64bit.tar.gz;
 tar xzvf softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x64-64bit.tar.gz;
else
 http://www.softether-download.com/files/softether/v4.25-9656-rtm-2018.01.15-tree/Linux/SoftEther_VPN_Server/32bit_-_Intel_x86/softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x86-32bit.tar.gz;
 tar xzvf SoftEther_VPN_Server/32bit_-_Intel_x86/softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x86-32bit.tar.gz
fi

cd vpnserver;
echo "running make ......! just follow step [yes]...";
echo "..............................................";
make


