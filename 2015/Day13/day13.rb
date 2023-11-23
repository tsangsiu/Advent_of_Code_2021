### input

input = File.read("input.txt").split("\n")

pair_happiness = Hash.new(0)
input.each do |pair|
  pair = pair[0...-1].split
  if pair[2] == 'gain'
    pair_happiness[[pair[0], pair[-1]].sort] += pair[3].to_i
  else
    pair_happiness[[pair[0], pair[-1]].sort] -= pair[3].to_i
  end  
end

### part 1

participants = pair_happiness.keys.flatten.uniq

happiness = participants.permutation.to_a.map do |plan|
  happiness_value = 0
  ((-1...plan.size)).each_cons(2) do |index_1, index_2|
    participant_1 = plan[index_1]
    participant_2 = plan[index_2]
    happiness_value += pair_happiness[[participant_1, participant_2].sort]
  end
  happiness_value
end

puts happiness.max

### part 2

participants.each do |participant|
  pair_happiness[[participant, "Me"].sort] = 0
end
participants << "Me"

happiness = participants.permutation.to_a.map do |plan|
  happiness_value = 0
  ((-1...plan.size)).each_cons(2) do |index_1, index_2|
    participant_1 = plan[index_1]
    participant_2 = plan[index_2]
    happiness_value += pair_happiness[[participant_1, participant_2].sort]
  end
  happiness_value
end

puts happiness.max
