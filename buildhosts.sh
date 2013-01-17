#!/bin/bash
cd /Users/mike/git/buildhosts
if [ "$1" == "-e" ]; then
    vim config
elif [ "$1" == "-l" ]; then
    grep 127.0.0.1 /etc/hosts | grep -v xip.io | grep -v localhost | awk '{print $2}'
    exit 0
fi
ruby buildhosts.rb
sudo cp newhosts /etc/hosts

