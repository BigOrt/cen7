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

a=`uname -p`;
echo "version : $a ";
echo "----------------------------";
echo "go....";
if [ "$a" = "x86_64" ]
then
 wget http://www.softether-download.com/files/softether/v4.25-9656-rtm-2018.01.15-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x64-64bit.tar.gz;
 tar xzvf softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x64-64bit.tar.gz;
else
 wget http://www.softether-download.com/files/softether/v4.25-9656-rtm-2018.01.15-tree/Linux/SoftEther_VPN_Server/32bit_-_Intel_x86/softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x86-32bit.tar.gz;
 tar xzvf softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x86-32bit.tar.gz
fi

cd vpnserver;
echo "running make ......! just follow step [yes]...";
echo "..............................................";
W=$(expect -c "
spawn make; sleep 1
  expect \"\"; sleep 6; send \"1\r\"; 
  expect \"\"; sleep 3; send \"1\r\"; 
  expect \"\"; sleep 3; send \"1\r\";
  expect eof; 
 "); 
 echo "$W";

echo "moving dir vpnserver................................";
echo "....................................................";
echo "....................................................";
echo "....................................................";
echo "....................................................";
cd
mv vpnserver /usr/local;
cd /usr/local/vpnserver;
chmod 600 *;
chmod 700 vpncmd;
chmod 700 vpnserver;
cd /etc/init.d/;
wget -O vpnserver https://raw.githubusercontent.com/BigOrt/cen7/master/softethervpn/vpnserver;
cd

echo "creating vpnserver service ................................";
echo "....................................................";
echo "....................................................";
echo "....................................................";

cd /usr/local/vpnserver;
chmod 755 /etc/init.d/vpnserver;
mkdir /var/lock/subsys;
update-rc.d vpnserver defaults;
chkconfig --add vpnserver;
chkconfig vpnserver on;

echo "running ./vpncmd ................................";
echo "....................................................";
echo "....................................................";
echo "....................................................";

/etc/init.d/vpnserver start;
cd /usr/local/vpnserver;

echo "INPUT Password for SoftetherVPN mode Admin : ";
read pass;
while true; do
    read -p "INPUT [ipvps]:5555 -> (example: 100.100.100.1:5555) :" yn
    case $yn in
        *[.]*[.]*[.]*[:5555] ) echo "..TY -_-..";  break;;
        * ) echo "WRONG !please type \" [ipvps]:[5555] \" ....";;
    esac
done
#echo "$yn";

W1=$(expect -c "
spawn ./vpncmd; sleep 3
expect \"\"; send \"3\r\"; sleep 3
expect \"\"; send \"check\r\"; sleep 3
expect eof; ")
echo "$W1"
W2=$(expect -c "
spawn ./vpncmd; sleep 3
expect \"\";  sleep 3; send \"1\r\"
expect \"\";  sleep 3; send \"$yn\r\"
expect \"\";  sleep 3; send \"\r\"
expect \"\";  sleep 3; send \"ServerPasswordSet\r\"
expect \"\";  sleep 3; send \"$pass\r\"
expect \"\";  sleep 3; send \"$pass\r\"
expect eof; ")
echo "$W2";

echo "---------------------------------------------------";
echo "-- IS DONE YOUR hostname : $yn & your pass : $pass ";
echo "-- !Not include local bridge vpn --";
