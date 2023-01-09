###
### input
###

input = File.read("input.txt")
expenses = input.split("\n").map(&:to_i)

###
### part 1
###

expenses.each_with_index do |expense, idx|
  if expenses[(idx + 1)..].index(2020 - expense).nil?
    next
  else
    puts expense * (2020 - expense)
    break
  end
end

###
### part 2
###

expenses.each_with_index do |expense1, idx1|
  expenses[(idx1 + 1)..].each_with_index do |expense2, idx2|
    if expenses[(idx2 + 1)..].index(2020 - expense1 - expense2).nil?
      next
    else
      puts expense1 * expense2 * (2020 - expense1 - expense2)
      break
    end
  end
end
