#!/bin/bash

apt install -y git
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
