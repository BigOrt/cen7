#!/bin/sh

#upgrade php
yum remove php-common mod_php php-cl

yum-config-manager --enable remi-php71
yum --enablerepo=remi,remi-php71 install php-fpm php-common

yum --enablerepo=remi,remi-php71 install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml

#check www.conf /etc/php-fpm.d/

cp www.conf.rpmsave www.conf