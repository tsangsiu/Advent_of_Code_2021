# Input

input = File.read("input.txt")
rules, pages = input.split("\n\n")

rules = rules.split("\n").map { |rule| rule.split("|").map(&:to_i) }
pages = pages.split("\n").map { |page| page.split(",").map(&:to_i) }

rules_hash = {}
rules.each do |rule|
  rules_hash[rule] = true  
end

# Part 1

correct = []
incorrect = []
pages.each do |pages|
  (0..(pages.size - 2)).each do |index|
    unless rules_hash[pages[index, 2]] then
      incorrect << pages
      break
    end
    correct << pages if index == pages.size - 2
  end
end

puts correct.map { |pages| pages[pages.size / 2] }.sum

# Part 2

incorrect.each do |pages|
  loop do
    swapped = false
    (0..(pages.size - 2)).each do |index|
      unless rules_hash[pages[index, 2]] then
        pages[index], pages[index + 1] = pages[index + 1], pages[index]
        swapped = true
      end
    end
    break unless swapped
  end
end

puts incorrect.map { |pages| pages[pages.size / 2] }.sum
