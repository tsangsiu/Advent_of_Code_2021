# input

input = File.read("input.txt")
rucksacks = input.split("\n")

# part 1

compartments = rucksacks.map do |rucksack|
  midpoint = rucksack.size / 2
  [rucksack[0...midpoint], rucksack[midpoint..]]
end

common_items = compartments.map do |sucksack|
  sucksack.first.split('') & sucksack.last.split('')
end
common_items.flatten!

priorities = ['', ('a'..'z').to_a, ('A'..'Z').to_a].flatten

priorities_sum = 0
common_items.each do |item|
  priorities_sum += priorities.index(item)
end

puts priorities_sum

# part 2

common_items = []

index = 0
loop do
  common_items << (rucksacks[index].split('') & rucksacks[index+1].split('') & rucksacks[index+2].split('')).first
  index += 3
  break if index >= rucksacks.size
end

priorities_sum = 0
common_items.each do |item|
  priorities_sum += priorities.index(item)
end

puts priorities_sum
