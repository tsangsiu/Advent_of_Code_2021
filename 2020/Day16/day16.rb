###
### input
###

input = File.read("input.txt").split("\n\n")

fields_hash = {}
fields = input[0].split("\n")
fields.each do |field|
  key = field[0...field.index(":")]
  ranges = field.split(" "); range1 = ranges[-3]; range2 = ranges[-1]
  lower1, upper1 = range1.split("-").map(&:to_i)
  lower2, upper2 = range2.split("-").map(&:to_i)
  fields_hash[key] = [lower1..upper1, lower2..upper2]
end
fields = fields_hash

my_ticket = input[1].split("\n")[1..].map { |line| line.split(",").map(&:to_i) }.flatten
other_tickets = input[2].split("\n")[1..].map { |line| line.split(",").map(&:to_i) }

###
### part 1
###

ranges = fields.values.flatten
ans = (other_tickets.flatten.reject do |field|
  ranges.any? do |range|
    range.cover?(field)
  end
end).sum

puts ans

###
### part 2
###

# discard the invalid tickets
other_tickets = other_tickets.select do |ticket|
  ticket.all? do |field|
    ranges.any? do |range|
      range.cover?(field)
    end
  end
end

n_field = my_ticket.size
final_field_name = Array.new(n_field, nil)
while final_field_name.any?(&:nil?)
  (0...n_field).each do |field_idx|
    field_values = other_tickets.map { |ticket| ticket[field_idx] }
    field_names = fields.select do |name, (range1, range2)|
      field_values.all? { |field_value| range1.cover?(field_value) || range2.cover?(field_value) }  
    end.keys.reject { |name| final_field_name.include?(name) }
    final_field_name[field_idx] = field_names.first if field_names.size == 1
  end
  p final_field_name
end

ans = 1
final_field_name.each_with_index do |name, idx|
  ans *= my_ticket[idx] if name.start_with?("departure ")
end

puts ans
