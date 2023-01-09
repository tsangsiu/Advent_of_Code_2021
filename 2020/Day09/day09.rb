###
### input
###

input = File.read("input.txt").split("\n").map(&:to_i)

###
### part 1
###

def sum_to?(arr, sum)
  arr.each_with_index do |num, idx|
    return true if arr[idx + 1..].include?(sum - num)
  end
  false
end

idx = 0
window = 25
while idx < input.size - window
  num = input[idx + window]
  if !sum_to?(input[idx, window], num)
    invalid_num = num
    break
  end
  idx += 1
end

puts invalid_num

###
### part 2
###

set = nil
size = 2
idx = 0
loop do
  if input[idx, size].sum == invalid_num
    set = input[idx, size]
    break
  elsif input[idx, size].sum != invalid_num
    idx += 1
  end
  
  if idx + size >= input.size
    size += 1
    idx = 0
  end
end

puts set.min + set.max
