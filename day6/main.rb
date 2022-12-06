filename = ARGV[0]
contents = File.open(filename).read


chars = {}

last_four = []
contents.chars.each_with_index do |char, index|
    last_four.insert(0, char)

    last_four.pop() if last_four.length > 4

    puts last_four.join("")
    if last_four.length == 4 and last_four.uniq == last_four
        puts index + 1
        break
    end
end

last_fourteen = []

count = 0

contents.chars.each do |char|
    last_fourteen.insert(0, char)
    last_fourteen.pop() if last_fourteen.length > 14

    count += 1

    if last_fourteen.length == 14 and last_fourteen.uniq == last_fourteen
        puts count
        break
    end
end