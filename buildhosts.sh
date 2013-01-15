#!/bin/bash
if [ "$1" == "-e" ]; then
    vim /Users/mike/git/buildhosts/config
elif [ "$1" == "-l" ]; then
    grep 127.0.0.1 /etc/hosts | grep -v xip.io | grep -v localhost | awk '{print $2}'
    exit 0
fi
ruby /Users/mike/git/buildhosts/buildhosts.rb
ruby buildhosts.rb
sudo cp /Users/mike/git/buildhosts/newhosts /etc/hosts

