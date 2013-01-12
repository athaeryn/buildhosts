def readFile(filename)
    File.open(filename, 'r').read
end

config = readFile("config").split("&")
hosts = config[0].split(" ")
ips = config[1].split(" ")

out = File.open('newhosts', 'w+')

puts readFile "header"
(0..hosts.length - 1).each do |i|
    puts "::1        #{hosts[i]}"
    puts "127.0.0.1  #{hosts[i]}"
    (0..ips.length - 1).each do |j|
        puts "::1        #{hosts[i]}.#{ips[j]}"
        puts "127.0.0.1  #{hosts[i]}.#{ips[j]}"
    end
end

out.close
