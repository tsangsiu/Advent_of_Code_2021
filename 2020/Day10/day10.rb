###
### input
###

input = File.read("input.txt").split("\n").map(&:to_i)

###
### part 1
###

input = input.sort.prepend(0).append(input.max + 3)
diff1 = 0; diff3 = 0
(1...input.size).each do |idx|
  diff = input[idx] - input[idx - 1]
  if diff == 1
    diff1 += 1
  elsif diff == 3
    diff3 += 1
  end
end

puts diff1 * diff3

###
### part 2
###

def n(joltages, idx, memo = {})
  joltage = joltages[idx]

  diff1 = joltages[idx + 1] - joltage if idx <= joltages.size - 2
  diff2 = joltages[idx + 2] - joltage if idx <= joltages.size - 3
  diff3 = joltages[idx + 3] - joltage if idx <= joltages.size - 4

  if idx == joltages.size - 2
    memo[joltage] = diff1 <= 3 ? 1 : 0
    return memo[joltage]
  elsif idx == joltages.size - 3
    memo[joltage] = (diff1 <= 3 ? 1 : 0) + (diff2 <= 3 ? 1 : 0)
    return memo[joltage]
  elsif idx == joltages.size - 4
    memo[joltage] = (diff1 <= 3 ? 1 : 0) + (diff2 <= 3 ? 1 : 0) + (diff3 <= 3 ? 1 : 0)
    return memo[joltage]
  end

  memo[joltage] = (diff1 <= 3 ? (memo.has_key?(joltages[idx + 1]) ? memo[joltages[idx + 1]] : n(joltages, idx + 1, memo)) : 0) +
                  (diff2 <= 3 ? (memo.has_key?(joltages[idx + 2]) ? memo[joltages[idx + 2]] : n(joltages, idx + 2, memo)) : 0) +
                  (diff3 <= 3 ? (memo.has_key?(joltages[idx + 3]) ? memo[joltages[idx + 3]] : n(joltages, idx + 3, memo)) : 0)
  memo[joltage]
end

puts n(input, 0)
