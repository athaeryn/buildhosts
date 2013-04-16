# Buildhosts

This is a script I wrote to write my `/etc/hosts` file for me.

Configuring all the entries was a hassle, especially when using
[xip.io](http://xip.io). This script takes your local hostnames (and the
various IP address you need to pass to xip.io) and creates all the necessary
entries to access any of the hosts while passing any of the IPs to xip.io.

Oh, and there's really no point in using this script if you're not using xip.io.

### Manginx

Also included is `manginx`, a script that keeps xip.io and nginx in harmony.
More on that later.



## Installation

That's easy:

    $ gem install buildhosts

Boom.


## Usage

Before you do anything, *back up your current `/etc/hosts` file!*

##### To edit your config file, type

    $ buildhosts -e

You should do that before doing anything else (except backing up your
`/etc/hosts` file, do that first).


##### You can add custom hosts by typing

    $ buildhosts -c


##### List your hosts with

    $ buildhosts -l

Note: this does not list the IPs, only the hosts.


##### Run manginx with

    $ buildhosts --nginx



## Configuration

If you run `buildhosts` with this `config` file:

#### sample-config

    [hosts]
        foobar.local
        example.local
    [ips]
        192.168.1.1
        10.0.1.1

it will produce this output:

#### /etc/hosts

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
    ::1             example.local.192.168.1.1.xip.io
    127.0.0.1       example.local.192.168.1.1.xip.io
    ::1             foobar.local
    127.0.0.1       foobar.local
    ::1             foobar.local.10.0.1.1.xip.io
    127.0.0.1       foobar.local.10.0.1.1.xip.io
    ::1             foobar.local.192.168.1.1.xip.io
    127.0.0.1       foobar.local.192.168.1.1.xip.io



## Manginx

For each host you specified in the `config`, manginx will create a file that
contains duplicate server_name directives for the host, but with all the
necessary xip.io URLs appended. You just need to include that file in your
`nginx.conf` (see below) and run

    $ buildhosts --nginx

Note: make sure you have a `xip/` directory in the same directory as your
`nginx.conf`.

#### To include the file,

just duplicate any server_name lines in your
`nginx.conf` and modify them like this:

##### Before:
    server_name foobar.local;

##### After:
    server_name foobar.local;
    include xip/foobar.local;


### Vim protip:

From a server_name line (in normal mode):

    yypRinclude xip/

If you've got a lot of lines to do, make that a macro; you won't regret it.
