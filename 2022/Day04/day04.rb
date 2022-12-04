# input

input = File.read("input.txt")
input = input.split("\n")
input = input.map { |pair| pair.split(',') }
input = input.map { |pair| pair.map { |pair| pair.split('-') } }
input = input.map { |pair| pair.map { |pair| pair.map { |pair| pair.to_i } } }

# part 1

count = 0

input.each do |pair|
  first_pair = pair.first
  second_pair = pair.last

  if (first_pair.first <= second_pair.first && first_pair.last >= second_pair.last) ||
      (second_pair.first <= first_pair.first && second_pair.last >= first_pair.last)
    count += 1
  end
end

puts count

# part 2

count = 0

input.each do |pair|
  first_pair = pair.first
  second_pair = pair.last

  (first_pair[0]..first_pair[1]).each do |num|
    if (second_pair[0]..second_pair[1]).include?(num)
      count += 1
      break
    end
  end
end

puts count
