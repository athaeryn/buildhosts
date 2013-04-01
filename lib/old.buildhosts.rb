require './ConfigParser.rb'

# Prefixy strings
ipv6 = '::1             '
home = '127.0.0.1       '

# Grab that parser and parse
p = ConfigParser.new
conf = p.parse 'config'

# Write the lines to a "newhosts" file
out = File.open('newhosts', 'w+')
conf['hosts'].each do |host|
    out.write "#{ipv6}#{host}\n"
    out.write "#{home}#{host}\n"
    conf['ips'].each do |ip|
        out.write "#{ipv6}#{host}.#{ip}.xip.io\n"
        out.write "#{home}#{host}.#{ip}.xip.io\n"
    end
end
out.close

