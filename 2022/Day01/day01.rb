# input

input = File.read("input.txt")
input = input.split("\n\n").map { |input| input.split("\n") }
calories = input.map { |calories| calories.map(&:to_i) }

# part 1

calories = calories.map { |calories| calories.sum }
p calories.max

# part 2

p calories.max(3).sum
