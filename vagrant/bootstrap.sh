# Vagrant Bootstrap file for vmfoo
# 0xFE

USER=mohit
HOME=/home/$USER
USER_ID=5000
GROUP_ID=5000

groupadd -g $GROUP_ID $USER
useradd -u $USER_ID -M -d $HOME -g $USER -G sudo,www-data -s /bin/bash $USER
chown $USER:$USER $HOME

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -y \
  build-essential sqlite3 libsqlite3-dev\
  libmysqlclient-dev libxml2-dev libxslt1-dev zlib1g-dev node\
  libssl-dev lighttpd apache2-utils git-core ruby1.9.3 ruby-dev npm\
  rbenv nodejs-legacy mysql-client

gem install bundler

# For AWS
apt-get install -y openjdk-7-jre-headless

# Docker
curl -sSL https://get.docker.io/ubuntu/ | sh
usermod -a -G docker mohit

# Make "git status" faster
git config --global core.preloadindex true

