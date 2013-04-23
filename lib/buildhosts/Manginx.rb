require 'buildhosts/ConfigParser'

module Buildhosts
    class Manginx
        
        def initialize config
            # Set up teh parser and parse with it
            @conf = Buildhosts::ConfigParser.parse config
        end

        # Helper methods to print common messages
        def configuring what
            puts "Configuring: #{what}..."
        end
        def done next_step=''
            puts "Done! #{next_step}"
        end

        def run
            # If you don't have any IP addresses in your config, what are you doing here?
            if @conf['ips'].nil? || @conf['ips'].empty?
                puts 'What\'s the point?'
                exit
            end
            system('mkdir -p /usr/local/etc/nginx/xip')
            # Let's find out what nginx is expecting from us...
            expected = Array.new
            n = File.open('/usr/local/etc/nginx/nginx.conf', 'r')
            n.each_line do |line|
                # So basically, if the line goes "include xip/derp.local;", we want to
                # set up a file with that name with the appropriate server_name directives.
                match = line.match(/include\s+xip\/([\w\.]+);/) 
                if !match.nil? # We don't want to try to convert nil to an array...
                   expected << match.to_a[1..-1][0]
                end
            end

            # This is where the files will be stored.
            base_path = '/usr/local/etc/nginx/xip'
            `rm -f #{base_path}/*`

            # Le bread and buttere
            expected.each do |file|
                configuring file
                out = File.open("#{base_path}/#{file}", 'w+')
                @conf['ips'].each do |ip|
                    # Simple. Just put a line in there for each IP in our config file.
                    out.write "server_name #{file}.#{ip}.xip.io;\n"
                end
                out.close
            end

            # Now we just reload nginx and apologize if something goes rotten.
            done 'Reloading nginx...'
            if system('sudo nginx -s reload')
                done
            else
                puts "Oops!\nSomething went wrong... Sorry."
            end
        end

    end
end





