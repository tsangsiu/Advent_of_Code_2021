### input

input = File.read("input_test.txt").split("\n")
input = File.read("input.txt").split("\n")

games = input.map do |game|
  game.split(/[,:;] /)
end

games = games.map do |game|
  game[1..].map(&:split)
end

### part 1

impossible_indices = []
games.each_with_index do |game, index|
  game.each do |info|
    cube, color = info
    cube = cube.to_i
    impossible_indices << index + 1 if color == 'red' && cube > 12
    impossible_indices << index + 1 if color == 'green' && cube > 13
    impossible_indices << index + 1 if color == 'blue' && cube > 14
  end
end

number_of_games = input.size
puts (1..number_of_games).to_a.sum - impossible_indices.uniq.sum

### part 2

sum = 0
games.each do |game|
  hash = Hash.new(0)
  game.each do |info|
    cube, color = info
    cube = cube.to_i
    hash[color] = [hash[color], cube].max    
  end
  sum += hash.values.reduce(:*)
end

puts sum
