def readFile(filename)
    contents = ''
    File.open(filename, "r") { |f|
        contents = f.read
    }
    return contents
end

config = readFile("config").split("&")
hosts = config[0].split(" ")
ips = config[1].split(" ")

puts readFile "header"
(0..hosts.length - 1).each do |i|
    puts "::1        #{hosts[i]}"
    puts "127.0.0.1  #{hosts[i]}"
    (0..ips.length - 1).each do |j|
        puts "::1        #{hosts[i]}.#{ips[j]}"
        puts "127.0.0.1  #{hosts[i]}.#{ips[j]}"
    end
end
