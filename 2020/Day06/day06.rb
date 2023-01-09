###
### input
###

groups = File.read("input.txt").split("\n\n").map { |group| group.split("\n") }

###
### part 1
###

puts (groups.map do |group|
  group.join('').chars.uniq.size
end.sum)

###
### part 2
###

puts (groups.map do |group|
  group.map(&:chars).reduce(:&).size
end.sum)
