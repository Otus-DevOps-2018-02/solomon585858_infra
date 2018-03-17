#!/bin/bash

apt update
apt install -y ruby-full ruby-bundler build-essential
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
