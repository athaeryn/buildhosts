#!/bin/bash
if [ "$1" == "-e" ]; then
    vim /Users/mike/git/buildhosts/config
elif [ "$1" == "-l" ]; then
    grep 127.0.0.1 /etc/hosts | grep -v xip.io | awk '{print $2}'
    exit 0
fi
cd /Users/mike/git/buildhosts
ruby buildhosts.rb
sudo cp newhosts /etc/hosts

