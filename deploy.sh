#!/bin/bash
git clone -b monolith https://github.com/express42/reddit.git
sleep 3
cd reddit && bundle install
sleep 15
sudo puma –d
