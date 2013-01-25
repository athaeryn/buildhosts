def readFile(filename)
    if File.exist? filename
        File.open(filename, 'r').read
    else
        ''
    end
end

def sanitize(string)
    string.split("\n").sort.delete_if {|x| x.start_with?('#') || x.strip == ''}
end

config = readFile('config').split('&').each {|x| x.strip!}
ips    = sanitize config[1]

conf = ''

File.readlines("/usr/local/etc/nginx/nginx.conf.src").each do |line|
    if (line.include?("server_name") && !line.include?("xip.io") && !line.include?("#ignore"))
            conf += line
            line.chomp!(";\n")
            ips.each do |ip|
                conf += "#{line}.#{ip}.xip.io;\n"
            end
    else
        conf += line
    end
end

File.open("/usr/local/etc/nginx/nginx.conf", "w").write(conf)

system("nginx -s reload")
