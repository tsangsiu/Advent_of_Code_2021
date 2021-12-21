### Input ###

input = File.read("./Input/Day_16_Input.txt").chomp

### Methods/Constants ###

HEX_TO_BIN = {
  "0" => "0000", "1" => "0001", "2" => "0010", "3" => "0011",
  "4" => "0100", "5" => "0101", "6" => "0110", "7" => "0111",
  "8" => "1000", "9" => "1001", "A" => "1010", "B" => "1011",
  "C" => "1100", "D" => "1101", "E" => "1110", "F" => "1111"
}

def trim_digits(packet, no_of_digits)
  packet = packet[(no_of_digits)..] if no_of_digits >= 0
  return packet
end

def display(stack)
  stack.each { |packet| p packet }
end

# ### Part 1 ###

packet = (input.split('').map do |hex|
  HEX_TO_BIN[hex]
end).join

def read_packet(stack, packet, length_subpacket = 0, n_subpacket = 0)
  version = packet[0..2].to_i(2); packet = trim_digits(packet, 3); length_subpacket -= 3 if length_subpacket > 0
  type = packet[0..2].to_i(2); packet = trim_digits(packet, 3); length_subpacket -= 3 if length_subpacket > 0
  if type != 4
    id = packet[0].to_i; packet = trim_digits(packet, 1); length_subpacket -= 1 if length_subpacket > 0
    n_subpacket -= 1 if n_subpacket > 0 && length_subpacket == 0
  end

  stack << { version: version, type: type, id: id, length_subpacket: length_subpacket, n_subpacket: n_subpacket, value: '' }

  if stack.last[:type] != 4  # operator packet
    if id == 0
      stack.last[:length_subpacket] -= 15 if stack.last[:length_subpacket] > 0
      stack.last[:length_subpacket] += packet[0..14].to_i(2); packet = trim_digits(packet, 15)
      read_packet(stack, packet, stack.last[:length_subpacket], stack.last[:n_subpacket])
    elsif id == 1
      stack.last[:length_subpacket] -= 11 if stack.last[:length_subpacket] > 0
      stack.last[:n_subpacket] = packet[0..10].to_i(2); packet = trim_digits(packet, 11)#; stack.last[:n_subpacket] = n_subpacket
      read_packet(stack, packet, stack.last[:length_subpacket], stack.last[:n_subpacket])
    end
  elsif stack.last[:type] == 4  # literal value
    i = stack.last[:length_subpacket] == 0  # do know how to name this ;)
    loop do  # loop to get the whole literal value
      is_continue = packet[0].to_i; packet = trim_digits(packet, 1); stack.last[:length_subpacket] -= 1 if stack.last[:length_subpacket] > 0
      stack.last[:value] << packet[0..3]; packet = trim_digits(packet, 4); stack.last[:length_subpacket] -= 4 if stack.last[:length_subpacket] > 0
      if is_continue == 0
        stack.last[:n_subpacket] -= 1 if stack.last[:n_subpacket] > 0 && i
        break
      end
    end
  end

  if (packet.length > 0 && packet.split('').uniq != ['0']) && (stack.last[:length_subpacket] > 0 || stack.last[:n_subpacket] > 0)
    read_packet(stack, packet, stack.last[:length_subpacket], stack.last[:n_subpacket])
  end
end

stack = []
read_packet(stack, packet, 0, 0)
display(stack)
