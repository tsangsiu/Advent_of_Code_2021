# Input

input = File.read("input.txt")

muls = []
until input.index(/mul\(\d+,\d+\)/).nil? do
  start_index = input.index(/mul\(\d+,\d+\)/)
  input = input[start_index..]
  end_index = input.index(/\)/)
  muls << input[0..end_index]
  input = input[(end_index + 1)..]
end

muls = muls.map do |mul|
  mul = mul[4...-1].split(",").map(&:to_i)
  mul.first * mul.last
end

p muls.sum

# Part 2

input = File.read("input.txt")

instructions = []
until input.index(/mul\(\d+,\d+\)|do\(\)|don't\(\)/).nil? do
  start_index = input.index(/mul\(\d+,\d+\)|do\(\)|don't\(\)/)
  input = input[start_index..]
  end_index = input.index(/\)/)
  instructions << input[0..end_index]
  input = input[(end_index + 1)..]
end

to_do = true
muls = []
instructions.each do |instruction|
  if instruction == "do()" then
    to_do = true
  elsif instruction == "don't()" then
    to_do = false
  else
    muls << instruction if to_do == true
  end
end

muls = muls.map do |mul|
  mul = mul[4...-1].split(",").map(&:to_i)
  mul.first * mul.last
end

p muls.sum
