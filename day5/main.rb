filename = ARGV[0]
contents = File.open(filename).read

stack_def, moves = contents.split("\n\n")

stack = {}

def parse_crate (crate)
    return crate[1]
end

stack_def.split("\n")[0..-2].each do |line| 
    index = 1 
    while line != nil
        puts "#{line}, #{index}"
        if not stack.key? index
            stack[index] = []
        end

        crate = line[0..2]

        if crate != "   "
            stack[index].insert(0, parse_crate(crate))
        end

        line = line[4..]
        index += 1
    end
end

puts stack

stack_part_2 = Marshal.load(Marshal.dump(stack))

moves.split("\n").each do |move|
    re = /move (?<count>\d+) from (?<from>\d+) to (?<to>\d+)/

    match = re.match(move)

    count, from, to = match["count"].to_i, match["from"].to_i, match["to"].to_i

    for i in 1..count do
        stack[to].append(stack[from].pop())
    end


    stack_part_2[to].concat(stack_part_2[from].pop(count))
    puts stack_part_2
end

puts stack.keys.sort.map { |key| stack[key][-1] }.join("")
puts stack_part_2.keys.sort.map { |key| stack_part_2[key][-1] }.join("")