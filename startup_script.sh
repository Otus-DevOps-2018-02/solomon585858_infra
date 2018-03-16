#!/bin/bash

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
  if [ $? -eq 0 ]; then
    echo "Command executed successfully!"
  else
    echo "Command apt install ruby-full... completed with error. FAIL!!!"
    exit 1
  fi

ruby -v
  if [ $? -ne 0 ]; then
    echo "Ruby is not installed"
    exit 1
  fi

bundle -v
  if [ $? -ne 0 ]; then
    echo "Build is not installed"
    exit 1
  fi


sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
  if [ $? -eq 0 ]; then
    echo "Command executed successfully!"
  else
    echo "Command apt-key completed with error. FAIL!!!"
    exit 1
  fi

sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
  if [ $? -eq 0 ]; then
    echo "Command executed successfully!"
  else
    echo "Command add repo.mongodb completed with error. FAIL!!!"
    exit 1
  fi

sudo apt update
sudo apt install -y mongodb-org
  if [ $? -eq 0 ]; then
    echo "Command executed successfully!"
  else
    echo "Command apt install mongodb completed with error. FAIL!!!"
    exit 1
  fi

sudo systemctl start mongod
sudo systemctl enable mongod


cd /home/appuser/
git clone -b monolith https://github.com/express42/reddit.git
  if [ $? -eq 0 ]; then
    echo "Command executed successfully!"
  else
    echo "Command git clone completed with error. FAIL!!!"
    exit 1
  fi

cd reddit && bundle install
  if [ $? -eq 0 ]; then
    echo "Command executed successfully!"
  else
    echo "Command bundle install completed with error. FAIL!!!"
    exit 1
  fi

puma -d
  if [ $? -eq 0 ]; then
    echo "Command executed successfully!"
  else
    echo "Command puma -d completed with error. FAIL!!!"
    exit 1
  fi

ps aux |grep -v grep | grep -q puma
  if [ $? -eq 0 ]; then
    echo "Puma started successfully"
    exit 0
  else
    echo "Puma does not start FAIL!!!"
    exit 1
  fi
