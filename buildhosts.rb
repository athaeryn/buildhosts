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

ipv6 = '::1             '
home = '127.0.0.1       '

config = readFile('config').split('&').each {|x| x.strip!}
hosts = sanitize config[0]
ips   = sanitize config[1]

out = File.open('newhosts', 'w+')
out.write readFile 'header'
out.write readFile 'custom'
hosts.each do |host|
    out.write "#{ipv6}#{host}\n"
    out.write "#{home}#{host}\n"
    ips.each do |ip|
        out.write "#{ipv6}#{host}.#{ip}.xip.io\n"
        out.write "#{home}#{host}.#{ip}.xip.io\n"
    end
end
out.close
