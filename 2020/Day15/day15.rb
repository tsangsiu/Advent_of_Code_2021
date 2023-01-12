###
### input
###

list = File.read("input.txt").split(",").map(&:to_i)

###
### part 1
###

number_to_rounds = {}
spoken = [nil]
(1..2020).each do |round|
  if round <= list.size
    num = list[round - 1]
  else
    last_spoke = spoken.last
    if number_to_rounds[last_spoke].size == 1
      num = 0
    else
      a, b = number_to_rounds[last_spoke][-2..-1]  
      num = b - a
    end
  end
  number_to_rounds.has_key?(num) ? number_to_rounds[num] << round : number_to_rounds[num] = [round]
  spoken << num
end

puts spoken.last

###
### part 2
###

number_to_rounds = {}
spoken = [nil]
(1..30000000).each do |round|
  if round <= list.size
    num = list[round - 1]
  else
    last_spoke = spoken.last
    if number_to_rounds[last_spoke].size == 1
      num = 0
    else
      a, b = number_to_rounds[last_spoke][-2..-1]  
      num = b - a
    end
  end
  number_to_rounds.has_key?(num) ? number_to_rounds[num] << round : number_to_rounds[num] = [round]
  spoken << num
end

puts spoken.last
