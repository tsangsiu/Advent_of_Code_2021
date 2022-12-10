# input

instructions = File.read("input.txt").split("\n").map { |pair| [pair.split.first, pair.split.last.to_i] }

# part 1

x = 1
x_cycles = [nil, x]

instructions.each do |instruction|
  command = instruction.first
  v = instruction.last

  if command == 'noop'
    x_cycles << x_cycles.last
  elsif command == 'addx'
    x_cycles << x_cycles.last
    x_cycles << x_cycles.last + v
  end
end

signal_strength = x_cycles[20] * 20 + x_cycles[60] * 60 + x_cycles[100] * 100 +
                  x_cycles[140] * 140 + x_cycles[180] * 180 + x_cycles[220] * 220
puts signal_strength

# part 2

screen = Array.new(240, '.')
crt_position = 0

1.upto(240) do |cycle|
  if (crt_position - 1..crt_position + 1).include?(x_cycles[cycle] + 40 * ((cycle - 1) / 40))
    screen[crt_position] = '#'
  end
  crt_position += 1
end

puts screen[0..39].join('')
puts screen[40..79].join('')
puts screen[80..119].join('')
puts screen[120..159].join('')
puts screen[160..199].join('')
puts screen[200..239].join('')
