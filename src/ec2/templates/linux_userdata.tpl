#!/bin/bash

# Export AWS credentials and region as environment variables
export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

# Update package list and upgrade all packages
apt-get update -y
apt-get upgrade -y

# Set MySQL root password to 'r00t_p4ssw0rd' and prevent prompt during installation
debconf-set-selections <<< 'mysql-server mysql-server/root_password password r00t_p4ssw0rd'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password r00t_p4ssw0rd'

# Install nginx, php and mysql server
apt-get install -y nginx php-fpm php-mysql mysql-server

# Ensure nginx and mysql services are enabled and running
systemctl enable nginx
systemctl start nginx
systemctl enable mysql
systemctl start mysql

# Create a basic PHP info page to test PHP processing
echo "<?php phpinfo(); ?>" > /var/www/html/info.php

# Set proper permissions for web root directory
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Notify that the configuration script is done
echo "The system is updated and the LEMP stack (Nginx, PHP, MySQL) is installed"

