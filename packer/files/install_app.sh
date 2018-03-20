#!/bin/bash

cd /home/appuser/
git clone https://github.com/Artemmkin/reddit.git
cd reddit && bundle install
puma -d
puma -d
