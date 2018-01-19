#!/bin/sh

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
wget https://raw.githubusercontent.com/BigOrt/cen7/master/softethervpn/vpnserver;
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
./vpncmd
