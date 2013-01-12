def readFile(filename)
    File.open(filename, 'r').read
end

ipv6 = '::1        '
home = '127.0.0.1  '

config = readFile("config").split("&")
hosts = config[0].split(" ")
ips = config[1].split(" ")

out = File.open('newhosts', 'w+')

out.write readFile "header"
(0..hosts.length - 1).each do |i|
    out.write "#{ipv6}#{hosts[i]}\n"
    out.write "#{home}#{hosts[i]}\n"
    (0..ips.length - 1).each do |j|
        out.write "#{ipv6}#{hosts[i]}.#{ips[j]}.xip.io\n"
        out.write "#{home}#{hosts[i]}.#{ips[j]}.xip.io\n"
    end
end
out.close
