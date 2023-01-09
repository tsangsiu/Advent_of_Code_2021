###
### input
###

input = File.read("input.txt")
list = input.split("\n").map { |pw| pw.split }

###
### part 1
###

count = 0
list.each do |policy|
  min, max = policy[0].split("-").map(&:to_i)
  alphabet = policy[1][0]
  pw = policy[2]
  alphabet_count = pw.count(alphabet)
  count += 1 if alphabet_count >= min && alphabet_count <= max
end
puts count

###
### part 2
###

count = 0
list.each do |policy|
  idx1, idx2 = policy[0].split("-").map(&:to_i)
  alphabet = policy[1][0]
  pw = policy[2]
  count += 1 if (pw[idx1 - 1] == alphabet) ^ (pw[idx2 - 1] == alphabet)
end
puts count
