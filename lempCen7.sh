#!/bin/sh
echo "installing nginx ..........................................."
echo "............................................................"
echo "............................................................"
yum install epel-release
yum install nginx -y

systemctl start nginx
systemctl stop nginx 
systemctl enable nginx

service nginx restart

#firewall-cmd --zone=public --permanent --add-service=http
#firewall-cmd --zone=public --permanent --add-service=https
#firewall-cmd --reload

#setup mariadb
echo "installing mariadb.............................................."
echo "............................................................"
echo "............................................................"
cd /etc/yum.repos.d/
wget https://raw.githubusercontent.com/BigOrt/cen7/master/MariaDB.repo
cd
yum install MariaDB-server MariaDB-client
systemctl start mariadb
systemctl stop mariadb
systemctl enable mariadb
systemctl start mariadb
service mariadb restart
echo "runnning mysql_secure_installation............"
echo ".............................................."
echo "just follow the step.........................."
echo ".............................................."
mysql_secure_installation


#setup php7
echo "installing php7.........................................."
echo "............................................................"
echo "............................................................"
cd
wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm
yum install yum-utils -y
yum-config-manager --enable remi-php71
yum --enablerepo=remi,remi-php71 install php-fpm php-common
yum --enablerepo=remi,remi-php71 install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml

#config_nginx&php7
echo "config php7 + nginx .............................................."
echo "............................................................"
echo "............................................................"
cd /etc/nginx/
cp nginx.conf nginx.conf.backup1
wget -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/BigOrt/cen7/master/nginx.conf
cd
cd /etc/nginx/default.d/
wget https://raw.githubusercontent.com/BigOrt/cen7/master/rigel.conf
cd
ln -s /etc/nginx/default.d/rigel.conf /etc/nginx/conf.d/
sed -i 's/;cgi.fix_pathinfo=1/;cgi.fix_pathinfo=0/g' /etc/php.ini
cp /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.backup
wget -O /etc/php-fpm.d/www.conf https://raw.githubusercontent.com/BigOrt/cen7/master/www.conf
cd
chmod -R 755 /usr/share/nginx/html
chmod 644 * /usr/share/nginx/html
ps -ef | grep nginx
cd /usr/share/nginx/html
chown -R nginx:nginx *
cd
service nginx restart
service php-fpm restart
cd /usr/share/nginx/html
wget https://raw.githubusercontent.com/BigOrt/cen7/master/info.php
cd
wget https://raw.githubusercontent.com/BigOrt/cen7/master/log && cat log
