# Buildhosts

This script will:

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

## Installation

That's easy:

    $ gem install buildhosts

You will want to *back up your current `hosts` file*, though.

## Usage

To edit your config file, type

    $ buildhosts -e


You can add custom hosts by typing

    $ buildhosts -c


List your hosts with

    $ buildhosts -l


Run manginx with

    $ buildhosts --nginx


Just running `buildhosts` will recompile your hosts file.


About the IP Address Section
----------------------------

The IP section is for working with xip.io, a DNS server that makes testing local
websites on mobile devices much simpler. You can read more about it [here](http://xip.io).
If you don't want to work with xip.io, don't include the IP address section in your config file.

Configuring the Script
----------------------

If you run `buildhosts` with this `config` file:

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

To run manginx, just do 

    $ buildhosts --nginx


As far as configuring goes, just make sure you have an `xip` directory in the same directory as your `nginx.conf`.
Then just duplicate any server_name lines in your `nginx.conf` and alter them like so:

### Before:
    server_name foobar.local;

### After:
    server_name foobar.local;
    include xip/foobar.local;

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
