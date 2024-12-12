def change(num)
  num_s = num.to_s
  if num == 0
    1
  elsif num_s.length % 2 == 0
    [num_s[0...(num_s.length / 2)].to_i, num_s[(num_s.length / 2)..].to_i]
  else
    num * 2024
  end
end

# Part 1

input = File.read("input.txt")
stones = input.split(" ").map { |num| num.to_i }.tally

25.times do
  stones = stones.to_a
  stones = stones.map { |num, tally| [change(num), tally] }.to_h
  stones.dup.each_pair do |num, tally|
    next unless num.class == Array
    num.each do |num|
      stones.has_key?(num) ? stones[num] += tally : stones[num] = tally
    end
  end
  stones.delete_if { |num, _| num.class == Array }
  stones = stones.to_h
end

p stones.values.sum

# Part 2

input = File.read("input.txt")
stones = input.split(" ").map { |num| num.to_i }.tally

75.times do
  stones = stones.to_a
  stones = stones.map { |num, tally| [change(num), tally] }.to_h
  stones.dup.each_pair do |num, tally|
    next unless num.class == Array
    num.each do |num|
      stones.has_key?(num) ? stones[num] += tally : stones[num] = tally
    end
  end
  stones.delete_if { |num, _| num.class == Array }
  stones = stones.to_h
end

p stones.values.sum
