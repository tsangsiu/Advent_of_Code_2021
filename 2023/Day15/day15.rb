### input

input = File.read("input_test.txt").split(",")
input = File.read("input.txt").split(",")

def hash_it(str)
  value = 0
  str.each_char do |char|
    value += char.ord
    value *= 17
    value %= 256
  end
  value
end

### part 1

value = 0
input.each do |str|
  value += hash_it(str)
end

puts value

### part 2

steps = input.map do |step|
  index = step.index(/[-=]/)
  [step[0...index], step[index], step[(index + 1)..]]
end

boxes = {}
(0...256).each { |box| boxes[box] = [] }

steps.each do |label, op, focal|
  box = hash_it(label)
  focal = focal.to_i unless focal.nil?

  if op == "-"
    idx = boxes[box].index { |lab, _| lab == label }
    boxes[box].delete_at(idx) unless idx.nil?
  elsif op == "="
    idx = boxes[box].index { |lab, _| lab == label }
    if !idx.nil?
      boxes[box][idx] = [label, focal]
    else
      boxes[box] << [label, focal]
    end
  end
end

lenses = Hash.new(0)
boxes.each do |box, arr_lenses|
  arr_lenses.each_with_index do |(label, focal), index|
    lenses[label] += (box + 1) * (index + 1) * focal
  end
end

puts lenses.values.sum
