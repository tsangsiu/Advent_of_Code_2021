# Input

input = File.read("input.txt")
_wires, _gates = input.split("\n\n")

_wires = _wires.split("\n")
               .map { |wire| wire.split(": ") }
               .map { |wire, value| [wire, value.to_i] }
_gates = _gates.split("\n")
               .map { |gate| gate.split(" -> ") }

$wires = {}
_wires.each do |wire, value|
  $wires[wire] = value
end

def output(wire_1, op, wire_2)
  if op == "AND"
    $wires[wire_1] & $wires[wire_2]
  elsif op == "OR"
    $wires[wire_1] | $wires[wire_2]
  elsif op == "XOR"
    $wires[wire_1] ^ $wires[wire_2]
  end
end

# Part 1

loop do
  _gates.each do |gate|
    wire_1, op, wire_2 = gate[0].split(" ")
    next unless $wires.has_key?(wire_1) && $wires.has_key?(wire_2)
    $wires[gate[1]] = output(wire_1, op, wire_2)
    _gates.delete(gate)
  end

  break if _gates.empty?
end

z_s = $wires.to_a
            .select { |wire| wire[0].start_with?('z') }
            .sort
            .reverse
            .map { |wire| wire[1] }
z = z_s.join("").to_i(2)

puts z

# Part 2
