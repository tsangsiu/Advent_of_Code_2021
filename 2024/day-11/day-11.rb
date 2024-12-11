# Input

input = File.read("input.txt")
stones = input.split(" ").map { |stone| stone.to_i }

def change(stone)
  stone_s = stone.to_s
  if stone == 0
    1
  elsif stone_s.length % 2 == 0
    [stone_s[0...(stone_s.length / 2)].to_i, stone_s[(stone_s.length / 2)..].to_i]
  else
    stone * 2024
  end
end

# Part 1

memo = Hash.new(nil)

25.times do |idx|
  stones.map! do |stone|
    if memo[stone].nil?
      change = change(stone)
      memo[stone] = change
      change
    else
      memo[stone]
    end
  end.flatten!
end

puts stones.size
