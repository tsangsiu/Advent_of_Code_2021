
def not16(int)
  bin = int.to_s(2)
  bin = '0' * (16 - bin.length) + bin
  bin.chars.map { |digit| digit == "0" ? "1" : "0" }.join.to_i(2)
end

def to_signal(wire, memo = {})
  return wire.to_i if wire =~ /^\d+$/
  return memo[wire] unless memo[wire].nil?

  logic = $wires[wire]
  if logic.size == 1 && logic.first =~ /^\d+$/
    memo[wire] = logic.first.to_i
  elsif logic.size == 1 && logic.first =~ /^[a-z]+$/
    memo[wire] = to_signal(logic.first, memo)
  elsif logic.include?("NOT")    
    memo[wire] = not16(to_signal(logic.last, memo))
  elsif logic.include?("AND")
    wire_1, _, wire_2 = logic
    memo[wire] = to_signal(wire_1, memo) & to_signal(wire_2, memo)
  elsif logic.include?("OR")
    wire_1, _, wire_2 = logic
    memo[wire] = to_signal(wire_1, memo) | to_signal(wire_2, memo)
  elsif logic.include?("LSHIFT")
    wire_, _, n_shift = logic
    memo[wire] = to_signal(wire_, memo) << n_shift.to_i
  elsif logic.include?("RSHIFT")
    wire_, _, n_shift = logic
    memo[wire] = to_signal(wire_, memo) >> n_shift.to_i
  end
end

### part 1

instructions = File.read("input.txt").split("\n")

$wires = {}
instructions.each do |instruction|
  logic, wire = instruction.split(" -> ")
  $wires[wire] = logic.split
end

p to_signal('a')

### part 2

instructions = File.read("input2.txt").split("\n")

$wires = {}
instructions.each do |instruction|
  logic, wire = instruction.split(" -> ")
  $wires[wire] = logic.split
end

p to_signal('a')
