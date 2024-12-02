# Input

input = File.read("input.txt")
lines = input.split("\n").map { |line| line.split("   ").map(&:to_i) }

# Part 1

left = []
right = []

lines.each do |pair|
  left << pair.first
  right << pair.last
end

left.sort!
right.sort!

distances = []
(0...(left.size)).each do |index|
  distances << (left[index] - right[index]).abs
end

puts distances.sum

# Part 2

score = 0

left.sort!.each do |left|
  score += left * right.count(left)
end

puts score
