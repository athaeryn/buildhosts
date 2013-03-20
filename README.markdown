Buildhosts
=========

This is just some info about this script. It will:

+ change your life
+ make you smarter
+ grant you three wishes, and
+ do none of the above.

But really, this is just a script I wrote to write my /etc/hosts file for me.
Configuring all the entries was a hassle, especially when using [xip.io](http://xip.io).
This script takes your local hostnames (and the various IP address you need to pass
to xip.io) and create all the necessary entries to access any of the hosts while
passing any of the IPs to xip.io.

### Manginx

Also included in `manginx`, a script that helps with using xip.io with nginx.

Installing & Running the Script
-------------------------------

+ BACK UP YOUR CURRENT HOSTS FILE!
+ To reiterate, **BACK UP YOUR CURRENT HOSTS FILE!**
+ Set shell variable `HOSTSPATH` to the script directory (i.e. ~/git/buildhosts)
+ Symlink the `buildhosts.sh` file to `~/bin/hosts` or something
+ Use `hosts -e` to edit your config file (explained below and in the `sample-config` file)
+ Any custom hosts can be put in a file named `custom`
+ Running `hosts` will recompile your `/etc/hosts` file
+ Running `hosts -l` will list the entries in your `/etc/hosts` file

### Example installation:
    mkdir -p ~/git
    cd ~/git
    git clone https://github.com/athaeryn/buildhosts.git
    sudo cp /etc/hosts /etc/hosts.bak
    export HOSTSPATH=~/git/buildhosts
    ln -s ~/git/buildhosts/buildhosts.sh ~/bin/hosts
    cp sample-config config


About the IP Address Section
----------------------------

The IP section is for working with xip.io, a DNS server that makes testing local
websites on mobile devices much simpler. You can read more about it [here](http://xip.io).
If you don't want to work with xip.io, don't include IP addresses in your config file (the ampersand is also not necessary).

Configuring the Script
----------------------

If you run `hosts` with this `config` file:

### sample-config:
    
    [hosts]
        foobar.local
        example.local
    [ips]
        192.168.1.1
        192.168.0.1
        10.0.1.1

it will produce this output:

### /etc/hosts
    ##
    # Host Database
    #
    # localhost is used to configure the loopback interface
    # when the system is booting.  Do not change this entry.
    ##
    127.0.0.1       localhost
    255.255.255.255 broadcasthost
    ::1             localhost
    fe80::1%lo0     localhost
    
    ::1             example.local
    127.0.0.1       example.local
    ::1             example.local.10.0.1.1.xip.io
    127.0.0.1       example.local.10.0.1.1.xip.io
    ::1             example.local.192.168.0.1.xip.io
    127.0.0.1       example.local.192.168.0.1.xip.io
    ::1             example.local.192.168.1.1.xip.io
    127.0.0.1       example.local.192.168.1.1.xip.io
    ::1             foobar.local
    127.0.0.1       foobar.local
    ::1             foobar.local.10.0.1.1.xip.io
    127.0.0.1       foobar.local.10.0.1.1.xip.io
    ::1             foobar.local.192.168.0.1.xip.io
    127.0.0.1       foobar.local.192.168.0.1.xip.io
    ::1             foobar.local.192.168.1.1.xip.io
    127.0.0.1       foobar.local.192.168.1.1.xip.io

Simple enough? I thought so.

Manginx
-------

To run manginx, just do `hosts --nginx`.
As far as configuring goes, just make sure you have an `xip` directory in the same directory as your `nginx.conf`.
Then just duplicate and server_name lines and alter them like so:

### Before:
    server_name foobar.local;

### After:
    server_name foobar.local;
    include xip/foobar.local;
