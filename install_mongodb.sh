#!/bin/bash

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
  if [ $? -eq 0 ]; then
    echo "Command executed successfully!"
  else
    echo "Command apt-key completed with error. FAIL!!!"
    exit 1
  fi

bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
  if [ $? -eq 0 ]; then
    echo "Command executed successfully!"
  else
    echo "Command add repo.mongodb completed with error. FAIL!!!"
    exit 1
  fi

apt update
apt install -y mongodb-org
  if [ $? -eq 0 ]; then
    echo "Command executed successfully!"
  else
    echo "Command apt install mongodb completed with error. FAIL!!!"
    exit 1
  fi

systemctl start mongod
systemctl enable mongod
