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

def deduct_length_subpacket(stack_track, length_subpacket)
  if stack_track.size > 0
    stack_track.reverse.each do |hash|
      hash[:length_subpacket] -= length_subpacket if hash.key?(:length_subpacket) && hash[:length_subpacket] > 0
    end
  end
end

def deduct_n_packet(stack_track, n_subpacket)
  if stack_track.size > 0
    stack_track.reverse.each do |hash|
      hash[:n_subpacket] -= n_subpacket if hash.key?(:n_subpacket) && hash[:n_subpacket] > 0
      break if hash.key?(:length_subpacket) && hash[:length_subpacket] > 0
    end
  end
end

def display(stack)
  stack.each { |packet| p packet }
end

### Part 1 ###

packet = (input.split('').map do |hex|
  HEX_TO_BIN[hex]
end).join

def read_packet(stack_track, stack, packet_ids, packet_id, length_subpacket = 0, n_subpacket = 0, packet)
  if stack_track != []
    packet_ids = packet_ids.clone[0...-1] if stack_track.last.values == [0]
  end

  version = packet[0..2].to_i(2); packet = trim_digits(packet, 3); deduct_length_subpacket(stack_track, 3)
  type = packet[0..2].to_i(2); packet = trim_digits(packet, 3); deduct_length_subpacket(stack_track, 3)
  if type != 4
    id = packet[0].to_i; packet = trim_digits(packet, 1); deduct_length_subpacket(stack_track, 1);
  end

  if type != 4  # operator packet
    if id == 0  # next 15 bits represents the total length in bits of the sub-packets
      deduct_length_subpacket(stack_track, 15); deduct_n_packet(stack_track, 1)
      length_subpacket = packet[0..14].to_i(2); packet = trim_digits(packet, 15)
      packet_id += 1; packet_ids = (packet_ids.clone << packet_id)
      stack_track << { length_subpacket: length_subpacket }
    elsif id == 1  # next 11 bits represents the number of sub-packets
      deduct_length_subpacket(stack_track, 11); deduct_n_packet(stack_track, 1)
      n_subpacket = packet[0..10].to_i(2); packet = trim_digits(packet, 11)
      packet_id += 1; packet_ids = (packet_ids.clone << packet_id)
      stack_track << { n_subpacket: n_subpacket }
    end
  elsif type == 4  # literal value
    value = ''
    loop do  # loop to get the whole literal value
      is_continue = packet[0].to_i; packet = trim_digits(packet, 1); deduct_length_subpacket(stack_track, 1)
      value << packet[0..3]; packet = trim_digits(packet, 4); deduct_length_subpacket(stack_track, 4)
      if is_continue == 0
        deduct_n_packet(stack_track, 1)
        break
      end
    end
    value = value.to_i(2)
  end

  stack << { packet_ids: packet_ids, version: version, type: type, id: id, length_subpacket: length_subpacket, n_subpacket: n_subpacket, value: value }

  is_continue = false
  stack_track.each do |hash|
    hash.each_value do |value|
      if value > 0
        is_continue = true
        break
      end
    end
  end

  read_packet(stack_track, stack, packet_ids, packet_id, 0, 0, packet) if is_continue || (packet.length > 0 && packet.split('').uniq != ['0'])
end

stack = []; stack_track = []; packet_ids = []; packet_id = 0
read_packet(stack_track, stack, packet_ids, packet_id, 0, 0, packet)
display(stack)  ###

version_sum = 0
stack.each do |element|
  version_sum += element[:version]
end
p version_sum

### Part 2 ###
