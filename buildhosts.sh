#!/bin/bash
if [ "$1" == "-e" ]; then
    vim /Users/mike/git/buildhosts/config
fi
cd /Users/mike/git/buildhosts
ruby buildhosts.rb
sudo cp newhosts /etc/hosts
