filename = ARGV[0]
contents = File.open(filename).readlines

count = 0
count_part_2 = 0

contents.map do |pair|
    first, second = pair.split(",")

    firstStart, firstEnd = first.split("-")
    secondStart, secondEnd = second.split("-")

    firstArr = (firstStart.to_i..firstEnd.to_i).to_a
    secondArr = (secondStart.to_i..secondEnd.to_i).to_a

    puts "#{firstArr}, #{secondArr}"
    count += 1 if firstArr.intersection(secondArr) == secondArr or secondArr.intersection(firstArr) == firstArr
    count_part_2 += 1 if firstArr.intersection(secondArr) != []

end

puts count
puts count_part_2