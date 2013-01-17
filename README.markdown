Buildhosts
=========

This is just some info about this script. It will:

+ change your life
+ make you smarter
+ grant you three wishes, and
+ do none of the above.

Installing & Running the Script
-------------------------------

+ BACK UP YOUR CURRENT HOSTS FILE!
+ To reiterate, **BACK UP YOUR CURRENT HOSTS FILE!**
+ Set shell variable `HOSTSPATH` to the script directory (i.e. ~/git/buildhosts)
+ Symlink the `buildhosts.sh` file to `~/bin/hosts` or something
+ Use `hosts -e` to edit your config file (explained below and in the `sample-config` file)
+ Any custom hosts can be put in a file named `custom`
+ Running `hosts` will recompile your `/etc/hosts` file
+ Running `hosts -e` will list the entries in your `/etc/hosts` file

### Example installation:
    mkdir -p ~/git/buildhosts
    git clone https://github.com/athaeryn/buildhosts.git ~/git/buildhosts
    sudo cp /etc/hosts ~/git/buildhosts/hosts.bak
    export HOSTSPATH=/Users/mike/git/buildhosts
    ln -s ~/git/buildhosts/buildhosts.sh ~/bin/hosts


About the IP Address Section
----------------------------

The IP section is for working with xip.io, a DNS server that makes testing local
websites on mobile devices mush simpler. You can read more about it [here](http://twolves-eb.local:8080/_membership_card_name/Gold%20Member/2012/gold).
If you don't want to work with xip.io, don't include IP addresses in your config file (the ampersand is also not necessary).

Configuring the Script
----------------------

This `config` file:

### sample-config:

    # Hostnames go here, one per line
    foobar.local
    example.local

    # Don't delete the ampersand
    # (unless you also delete
    # everything below it).
    &

    # IP addresses for xip.io.
    # You can just leave this blank
    # if you're not using it.
    192.168.1.1
    192.168.0.1
    10.0.1.1

will produce this output:

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
