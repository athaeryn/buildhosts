#!/bin/bash
if [ -z $HOSTSPATH ]; then
    echo "Please define the \$HOSTSPATH variable."
    exit 1
fi
cd $HOSTSPATH 
if [ "$1" == "-e" ]; then
    vim config
elif [ "$1" == "-c" ]; then
    vim custom
elif [ "$1" == "-ec" ]; then
    vim config ; vim custom
elif [ "$1" == "-ce" ]; then
    vim custom ; vim config 
elif [ "$1" == "-l" ]; then
    grep 127.0.0.1 /etc/hosts | grep -Ev 'xip.io|localhost' | awk '{print $2}'
    exit 0
elif [ "$1" == "-nginx" ]; then
    ruby manginx.rb
    exit 0
fi
ruby buildhosts.rb
sudo cp newhosts /etc/hosts

