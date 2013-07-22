require "buildhosts/version"
require "buildhosts/ConfigParser"

module Buildhosts
    class Main
        attr_reader :files
        attr_reader :path

        def initialize
            @path = File.expand_path('../../files/', __FILE__)
            @files = Hash.new
            ['config', 'custom', 'header', 'newhosts', 'temp'].each do |f|
                if (File.exist?(File.expand_path("~/.buildhosts/#{f}")))
                    @files[f] = File.expand_path("~/.buildhosts/#{f}").chomp
                else
                    @files[f] = "#{@path}/#{f}".chomp
                end
            end
        end

        def build
            # Prefixy strings
            ipv6 = '::1             '
            home = '127.0.0.1       '

            # Grab that parser and parse
            conf = Buildhosts::ConfigParser.parse @files['config']

            # Write the lines to a "newhosts" file
            out = File.open(@files['newhosts'], 'w+')
            conf['hosts'].each do |host|
                out.write "#{ipv6}#{host}\n"
                out.write "#{home}#{host}\n"
                conf['ips'].each do |ip|
                    out.write "#{ipv6}#{host}.#{ip}.xip.io\n"
                    out.write "#{home}#{host}.#{ip}.xip.io\n"
                end
            end
            out.close
            system("cat #{@files['header']} #{@files['custom']} #{@files['newhosts']} > #{@files['temp']}")
            system("sudo cp #{@files['temp']} /etc/hosts")
            system("rm #{@files['newhosts']} #{@files['temp']}")
        end
    end
end
