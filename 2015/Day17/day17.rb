### input

containers = File.read("input_test.txt").split("\n").map(&:to_i)
liters_to_store = 25

containers = File.read("input.txt").split("\n").map(&:to_i)
liters_to_store = 150


### part 1

combinations = []
(1..containers.size).each do |n|
  combinations += containers.combination(n).to_a
end

combinations = combinations.select { |combination| combination.sum == liters_to_store }
puts combinations.size

### part 2

minimum_size = combinations.map { |combination| combination.size }.min
puts combinations.select { |combination| combination.size == minimum_size }.size
