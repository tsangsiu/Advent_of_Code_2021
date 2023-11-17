### part 1

strs = File.read("input.txt").split("\n")

a = strs.join.length

strs.map! { |str| str[1...-1] }
strs.map! do |str|
  str.gsub(/(\\\\|\\\"|\\x\h{2})/, '.')
end
b = strs.join.length

puts a - b

### part 2

strs = File.read("input.txt").split("\n")

c = strs.map do |str|
  str.dump.length - str.length
end.sum

puts c

# problematic string: "atyfxioy\x2b\\"
