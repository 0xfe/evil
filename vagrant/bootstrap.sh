# Vagrant Bootstrap file for vmfoo
# 0xFE

USER=mohit
HOME=/home/$USER
USER_ID=5000
GROUP_ID=5000

apt-get update

debconf-set-selections <<< 'mysql-server mysql-server/root_password password foobar'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password foobar'
apt-get -y install mysql-server

apt-get install -y \
  build-essential sqlite3 libsqlite3-dev mysql-server \
  libmysqlclient-dev libxml2-dev libxslt1-dev zlib1g-dev node \
  libssl-dev lighttpd apache2-utils git-core

# For RVM
apt-get install -y \
  libreadline6-dev libyaml-dev autoconf \
  automake libtool bison pkg-config libffi-dev

# curl -L https://get.rvm.io | bash -s stable --ruby
# source /usr/local/rvm/scripts/rvm
# rvm install 1.9.3

# For AWS
apt-get install -y openjdk-7-jre-headless

groupadd -g $GROUP_ID $USER
useradd -u $USER_ID -M -d $HOME -g $USER -G sudo,www-data -s /bin/bash $USER
chown $USER:$USER $HOME

# Make "git status" faster
git config --global core.preloadindex true
