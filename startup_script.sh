#!/bin/bash
sudo apt update
sleep 15
sudo apt install -y ruby-full ruby-bundler build-essential
sleep 75
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
sudo apt update
sleep 5
sudo apt install -y mongodb-org
sleep 20
sudo systemctl start mongod.service
sudo systemctl enable mongod.service
sleep 3
git clone -b monolith https://github.com/express42/reddit.git
sleep 3
cd reddit && bundle install
sleep 15
puma -d
