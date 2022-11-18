## Input

input = File.readlines("Input/Day06.txt")
input.map! { |input| input.chomp.split(")") }

# To reorganize the given input
map = [input.first]
input[1..].each do |pair|
  branch_tails = map.map { |branch| branch.last }
  if branch_tails.include?(pair.first)
    branch_index = map.index { |branch| branch.last == pair.first }
    map[branch_index] << pair.last
  else
    map << pair
  end
end

## Part 1

# To count
count = 0
map.each do |current_branch|
  count += (current_branch.size - 1) * current_branch.size / 2
  
  current_branch_head = current_branch.first
  until current_branch_head == "COM" do
    located_branch = map.select { |branch| branch.include?(current_branch_head) && branch.first != current_branch_head }.first
    count += located_branch.index(current_branch_head) * (current_branch.size - 1)
    current_branch_head = located_branch.first
  end
end

p count

## Part 2

