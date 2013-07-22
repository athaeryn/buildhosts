module Buildhosts
    class ConfigParser
        def self.parse file
            if !File.exists? file
                puts "Error: File does not exist."
                return false
            end
            conf = Hash.new
            last_key = String.new
            raw = File.open(file, "r")
            raw.each_line do |line|
                match = line.match(/\[(\w*)\]/)
                if !match.nil?
                    key = match.to_a[1..-1][0]
                    conf [key] = Array.new
                    last_key = key
                else
                    conf[last_key] << line.strip if (!line.strip.empty?)
                end
            end
            raw.close
            return conf
        end
    end
end
