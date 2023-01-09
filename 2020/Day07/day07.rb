###
### input
###

input = File.read("input.txt").split("\n")

$bags = {}
input.each do |bag|
  bag, bags_contained = bag.split(" contain ")
  bag = bag.chomp("s")
  $bags[bag] = []
  next if bags_contained == "no other bags."
  bags_contained.split(", ").each do |bag_contained|
    count = bag_contained.to_i
    bag_contained = bag_contained.split(/[0-9]+ /).last.chomp(".").chomp("s")
    $bags[bag] << [bag_contained, count]
  end
end

target = "shiny gold bag"

###
### part 1
###

contain = Hash.new(false)
def contain?(bag, target)
  return false if $bags[bag] == []
  return true if $bags[bag].flatten.include?(target)
  sub_bags = $bags[bag].flatten.select { |element| element.class == String }
  sub_bags.map { |sub_bag| contain?(sub_bag, target) }.any? { |contain| contain == true }
end

$bags.keys.each do |bag|
  contain[bag] = contain?(bag, target)
end

puts contain.select { |_, contain| contain == true }.count

###
### part 2
###

def count_sub_bag(bag, total = 0)
  return total += 1 if $bags[bag] == []
  $bags[bag].each do |sub_bag|
    sub_bag, count = sub_bag
    if $bags[sub_bag] == []
      total += count
    else
      total += count + count_sub_bag(sub_bag) * count
    end
  end
  total
end

puts count_sub_bag(target)
