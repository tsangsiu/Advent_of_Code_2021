position = File.read("./Input/Day_07_Input.txt").chomp.split(",").map(&:to_i)

### Part 1 ###

distance = Array.new(position.max + 1, 0)

0.upto(position.max) do |pos|
  position.each do |crab|
    distance[pos] += (crab - pos).abs
  end
end

min_fuel = distance.min
p min_fuel

### Part 2 ###

fuel = Array.new(position.max + 1, 0)

0.upto(position.max) do |pos|
  position.each do |crab|
    fuel[pos] += (crab - pos).abs * ((crab - pos).abs + 1) / 2
  end
end

min_fuel = fuel.min
p min_fuel
