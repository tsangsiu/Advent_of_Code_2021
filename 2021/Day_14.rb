### Input ###

input = File.read("./Input/Day_14_Input.txt").chomp.split("\n")

polymer = input[0]

### Part 1 ###

# def count_element(polymer)
#   count = {}
#   keys = polymer.split('').uniq
#   keys.each do |element|
#     count[element] = polymer.count(element)
#   end
#   count
# end

# rules = Hash.new()
# rules_array = input[2..]
# rules_array.each do |rule|
#   pair = rule.split(' -> ')[0]
#   insert = rule.split(' -> ')[1]
#   rules[pair.split('').join(' ')] = pair.split('').join(insert)
# end

# 10.times do
#   polymer = polymer.split('').join(' ')
#   0.upto(polymer.length - 3) do |index|
#     pair = polymer[index..(index + 2)]
#     polymer[index..(index + 2)] = rules[pair] if rules.key?(pair)
#   end
#   polymer = polymer.split(' ').join('')
# end

# counts = count_element(polymer).values
# result = counts.max - counts.min
# p result

### Part 2 ###

rules = Hash.new()
rules_array = input[2..]
rules_array.each do |rule|
  rules[rule.split(' -> ')[0]] = rule.split(' -> ')[1]
end

# to initialise a hash for pair counts
pair_count = {}
rules.keys.each do |pair|
  pair_count[pair] = 0
end

# the hash for counts for the initial polymer
0.upto(polymer.size - 2) do |index|
  pair_count[polymer[index..(index + 1)]] += 1
end

# the polymerization process
40.times do
  new_pair_count = pair_count.clone
  pair_count.each_pair do |pair, freq|
    if freq > 0
      insert = rules[pair]
      new_pair_count[[pair[0], insert].join] += freq
      new_pair_count[[insert, pair[1]].join] += freq
      new_pair_count[pair] -= freq
    end
  end
  pair_count = new_pair_count
end

# to count the elements
element_count = Hash.new(0)
pair_count.each_pair do |pair, freq|
  element_count[pair[0]] += freq
  element_count[pair[1]] += freq
end
element_count[polymer[0]] += 1
element_count[polymer[-1]] += 1

element_count.each_pair do |pair, freq|
  element_count[pair] /= 2
end

# answer
counts = element_count.values
answer = counts.max - counts.min
p answer
