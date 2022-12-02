filename = ARGV[0]
contents = File.open(filename).readlines

scores = {
    'X'=> 1, # rock
    'Y'=> 2, # paper
    'Z'=> 3 # scissors
}


def winner (opp, yours)
    opps_to_yours = {
        'A'=> 'X',
        'B'=> 'Y',
        'C'=> 'Z'
    }
    return :draw if opps_to_yours[opp] == yours
    case opp
    when 'A'
        yours == 'Z' ? :opp : :yours
    when 'B'
        yours == 'X' ? :opp : :yours
    when 'C'
        yours == 'Y' ? :opp : :yours
    end
end

def get_target_shape (opp, goal)
    opps_to_yours = {
        'A'=> 'X',
        'B'=> 'Y',
        'C'=> 'Z'
    }
    return opps_to_yours[opp] if goal == 'Y'

    if goal == 'X' then # lose
        case opp
        when 'A' # rock
            return 'Z' # scissors
        when 'B' # paper
            return 'X' # rock
        when 'C' # scissors
            return 'Y' # paper
        end
    else  # win
        case opp
        when 'A' # rock
            return 'Y' # paper
        when 'B' # paper 
            return 'Z' # scissors
        when 'C' # scissors
            return 'X' # rock
        end
    end

end

score = 0
score_part_2 = 0

contents.map do |line| 
    opp,  yours = line.split

    score += scores[yours]



    case winner(opp, yours)
    when :draw
        score += 3
    when :yours
        score += 6
    when :opp
        score += 0
    end

    target_shape = get_target_shape(opp, yours)

    score_part_2 += scores[target_shape]
    case winner(opp, target_shape)
    when :draw
        score_part_2 += 3
    when :yours
        score_part_2 += 6
    when :opp
        score_part_2 += 0
    end

    puts "#{opp}, #{yours}, #{get_target_shape(opp, yours)}, #{winner(opp, target_shape)}, #{score_part_2}"
end

puts score
puts score_part_2