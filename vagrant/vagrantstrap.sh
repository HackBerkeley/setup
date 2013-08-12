#!/usr/bin/env bash

# Configurable variables
database='vagrant'
username='vagrant'
password='vagrant'

echo ''
echo ' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo '  Bootstrapping Ubuntu Precise 32bit               '
echo ' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo '        Apache 2.2.22, PHP                         '
echo '      Vim, cURL, Git, Composer, pip, HTTPie'
echo '               Node, Ruby, Python                  '
echo ''
#echo ' Derived from github.com/andrew13/Laravel-4-Bootstrap-Starter-Site'
echo ''
# ---------------
#  Various fixes
# ---------------


echo '- Fixing locales issues with Ubuntu...'
#dpkg-reconfigure locales >/dev/null
echo '- Locale'

update-locale LANG=en_US.UTF-8 >/dev/null

echo '- Configuring timezone to UTC...'
echo \"America/Los_Angeles\" | sudo tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

# ------------------------
#  Update and basic tools
# ------------------------
echo '- Updating apt-get repositories...'
apt-get update >/dev/null
echo '...done'
echo '- Installing python-software-properties...'
apt-get install -y python-software-properties >/dev/null
echo '...done'
# Install help app
echo 'Installing core components'
apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc apache2-utils g++ 
# ----------
#  Node
# ----------
echo '- Installing Node...'
add-apt-repository ppa:chris-lea/node.js-devel <<EOF
EOF
apt-get update >/dev/null
apt-get install nodejs -y >/dev/null
apt-get install build-essential -y >/dev/null
apt-get install nodejs-dev -y >/dev/null
ln -s /usr/include/nodejs /usr/include/node 
echo '...done'



# ---------
#  PHP 5.4
# ---------
echo '- Adding PHP 5.4 PPA...'
add-apt-repository ppa:ondrej/php5  <<EOF
EOF
echo '...done'
echo '- Updating apt-get repositories...'
apt-get update >/dev/null
echo '...done'
echo '- Installing PHP 5.4...'
apt-get install -y php5 >/dev/null
echo '...done'
echo '- Installing required PHP modules'
apt-get install -y php5-mcrypt >/dev/null
apt-get install -y php5-mysql >/dev/null
apt-get install -y php5-curl >/dev/null
echo '...done'

# ---------------
#  Apache 2.2.22
# ---------------
echo '- Installing Apache 2...'
apt-get install -y apache2 >/dev/null
echo "ServerName localhost" > /etc/apache2/httpd.conf
echo '...done'
echo '- Enabling Apache 2 mod_rewrite...'
a2enmod rewrite >/dev/null
# Restart apache
service apache2 restart >/dev/null
echo '...done'


# ------
#  cURL
# ------
echo '- Installing cURL...'
apt-get install -y curl >/dev/null
echo '...done'

# -----
#  Git
# -----
echo '- Installing Git...'
apt-get install -y git-core >/dev/null
echo '...done'

# ----------
#  Composer
# ----------
echo '- Installing Composer...'
curl -s https://getcomposer.org/installer | php
# Make Composer available globally
mv composer.phar /usr/local/bin/composer
echo '...done'

# --------------
#  pip & HTTPie
# --------------
echo '- Installing pip...'
curl -s http://python-distribute.org/distribute_setup.py | python
easy_install pip >/dev/null
echo '...done'
echo '- Installing HTTPie...'
pip install --upgrade httpie >/dev/null
rm distribute-0.6.48.tar.gz
echo '...done'

#Install MongoDB 
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 &&
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list &&
apt-get -y update &&
apt-get -y install mongodb-10gen &&
echo "Installed MongoDB" &&
echo "Configuring MongoDB to listen only on localhost" &&
echo "bind_ip = 127.0.0.1" >> /etc/mongodb.conf &&
# The default configuration for MongoDB assumes taking up 6GB off the bat for every single
# database is cool and also inhales tons of space for journal files. This is overkill for
# most deployments, so we instruct MongoDB to use smaller files
echo "smallfiles = true" >> /etc/mongodb.conf &&
/usr/sbin/service mongodb restart &&
npm install -g forever &&

# -------------
#  Final setup
# -------------

# Add aliases
sed -i '$a alias art="php artisan"' /home/vagrant/.bashrc

## Ruby 

git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
apt-get install rbenv

rbenv install 2.0.0-p247 >/dev/null
rbenv global 2.0.0-p247 >/dev/null
ruby -v
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
rbenv rehash

sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update >/dev/null
sudo apt-get install postgresql-common -t raring >/dev/null
sudo apt-get install postgresql-9.2 libpq-dev >/dev/null
cd /vagrant

## Rails
gem install rails


echo ''
echo ' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo '                 Bootstrapping done!'
echo ' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo ''
echo ' Your next steps are:'
echo ' $ vagrant ssh'
echo ' Open http://127.0.0.1:8080 in your host OS'
echo ''
echo ''
echo ' Enjoy your new  virtual machine!'
echo ''
echo ' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo ''
echo 'For more information to setup other projects just as fast check the vagrantfile'
echo ''