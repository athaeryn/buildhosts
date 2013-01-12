def readFile(filename)
    File.open(filename, 'r').read
end

config = readFile("config").split("&")
hosts = config[0].split(" ")
ips = config[1].split(" ")

out = File.open('newhosts', 'w+')

out.write readFile "header"
(0..hosts.length - 1).each do |i|
    out.write "::1        #{hosts[i]}\n"
    out.write "127.0.0.1  #{hosts[i]}\n"
    (0..ips.length - 1).each do |j|
        out.write "::1        #{hosts[i]}.#{ips[j]}\n"
        out.write "127.0.0.1  #{hosts[i]}.#{ips[j]}\n"
    end
end
out.close
