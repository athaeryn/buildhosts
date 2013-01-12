require "json"

def readFile(filename)
    contents = ''
    File.open(filename, "r") { |f|
        contents = f.read
    }
    return contents
end

puts readFile("header") + readFile("footer")
