###
### input
###

input = File.read("input.txt").split("\n")

###
### part 1
###

def mask_it1(mask, dec)
  mask = mask.chars.reverse
  bin = dec.to_i.to_s(2).chars.reverse
  mask.each_with_index do |bit, idx|
    bin[idx] = mask[idx] if bit != "X"
  end
  bin = bin.map do |bit|
    bit.nil? ? "0" : bit
  end
  bin.reverse.join('')
end

mem = Hash.new(0)
mask = nil
input.each do |line|
  type, value = line.split(" = ")
  if type == "mask"
    mask = value
  else
    address = type[4..-2].to_i
    num = value.to_i
    mem[address] = mask_it1(mask, num)
  end
end

puts mem.values.map { |bin| bin.to_i(2) }.sum

###
### part 2
###

def mask_it2(mask, dec)
  mask = mask.chars.reverse
  bin = dec.to_i.to_s(2).chars.reverse
  mask.each_with_index do |bit, idx|
    bin[idx] = bit if ["X", "1"].include?(bit)
  end
  bin = bin.map do |bit|
    bit.nil? ? "0" : bit
  end
  bin.reverse.join('')
end

def all_address(address_mask)
  address_mask = address_mask.chars
  number_of_x = address_mask.count("X")
  combo = ([0, 1] * number_of_x).combination(number_of_x).to_a.uniq
  index_of_x = address_mask.map
                           .with_index { |bit, idx| bit == "X" ? idx : nil }
                           .reject { |element| element.nil? }

  addresses = []
  combo.each do |combo|
    index_of_x.each_with_index do |x_idx, combo_idx|
      address_mask[x_idx] = combo[combo_idx].to_s
    end
    addresses << address_mask.join('').to_i(2)
  end

  addresses
end

mem = Hash.new(0)
mask = nil
input.each do |line|
  type, value = line.split(" = ")
  if type == "mask"
    mask = value
  else
    address = type[4..-2].to_i
    num = value.to_i
    addresses = all_address(mask_it2(mask, address))
    addresses.each { |address| mem[address] = num }
  end
end

p mem.values.sum
