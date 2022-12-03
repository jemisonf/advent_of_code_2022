require 'set'

filename = ARGV[0]
contents = File.open(filename).readlines
def score (char)
    return char.ord - 38 if char >= 'A' and char <= 'Z'

    return char.ord - 96
end

total_part_1 = 0

contents.map do |rucksack| 
    left, right = rucksack[0..rucksack.length / 2 -1], rucksack[rucksack.length/2..rucksack.length]

    letters = [].to_set
    left.chars.map do |char|
        if right.include? char
            letters.add(char)
        end
    end

    letters.map do |char|
        total_part_1 += score(char)
        puts "#{char}, #{score(char)}, #{total_part_1}"
    end
end

puts total_part_1

total_part_2 = 0

while contents.length > 0 do
    first, second, third = contents.slice!(0..2)

    shared = first.chars.intersection(second.chars).intersection(third.chars)[0]

    total_part_2 += score(shared)    
end

puts total_part_2