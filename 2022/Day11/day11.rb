# input

input = File.read("input.txt").split("\n\n").map { |monkey| monkey.split("\n").map(&:strip) }

monkeys = {}
input.each_with_index do |monkey_info, index|
  monkeys[index] = {}
  monkey = monkeys[index]
  monkey_info.each do |info|
    if info.start_with?("Starting items:")
      monkey['items'] = info.split(" ")[2..].map(&:to_i)
    elsif info.start_with?("Operation:")
      monkey['operation'] = info.split(" ")[-2]
      monkey['increment'] = info.split(" ").last
    elsif info.start_with?("Test:")
      monkey['test'] = info.split(" ").last.to_i
    elsif info.split(" ")[1] == 'true:'
      monkey['true_to'] = info.split(" ").last.to_i
    elsif info.split(" ")[1] == 'false:'
      monkey['false_to'] = info.split(" ").last.to_i
    end
  end
end

number_of_monkey = monkeys.size
monkey_inspect_count = Array.new(number_of_monkey, 0)

def new_worry(worry, operation, increment)
  worry = case operation
          when '+' then worry + increment.to_i
          when '*' then increment =~ /\d+/ ? worry * increment.to_i : worry * worry
          end
end

def print_items(monkeys)
  monkeys.each_value do |monkey|
    monkey.each_pair do |key, value|
      p value if key == "items"
    end
  end
end

# part 1

# round = 20

# round.times do
#   (0...number_of_monkey).each do |m|
#     items = monkeys[m]['items']
#     number_of_item = items.size

#     (0...number_of_item).each do |i|
#       monkey_inspect_count[m] += 1

#       worry = items[i]
#       operation = monkeys[m]['operation']
#       increment = monkeys[m]['increment']    
#       new_worry = new_worry(worry, operation, increment)

#       new_worry /= 3

#       if new_worry % monkeys[m]['test'] == 0
#         to_monkey = monkeys[m]['true_to']
#         monkeys[to_monkey]['items'] << new_worry
#       else
#         to_monkey = monkeys[m]['false_to']
#         monkeys[to_monkey]['items'] << new_worry
#       end
#     end

#     monkeys[m]['items'].shift(number_of_item)
#   end
# end

# p monkey_inspect_count.max(2).reduce(:*)

# part 2

modulo = 1
monkeys.values.each do |monkey|
  monkey.each_pair do |key, value|\
    modulo *= value if key == 'test'
  end
end

round = 10000

round.times do
  (0...number_of_monkey).each do |m|
    items = monkeys[m]['items']
    number_of_item = items.size

    (0...number_of_item).each do |i|
      monkey_inspect_count[m] += 1

      worry = items[i]
      operation = monkeys[m]['operation']
      increment = monkeys[m]['increment']

      new_worry = new_worry(worry, operation, increment)

      if new_worry % monkeys[m]['test'] == 0
        to_monkey = monkeys[m]['true_to']
        monkeys[to_monkey]['items'] << new_worry % modulo
      else
        to_monkey = monkeys[m]['false_to']
        monkeys[to_monkey]['items'] << new_worry % modulo
      end
    end

    monkeys[m]['items'].shift(number_of_item)
  end
end

p monkey_inspect_count.max(2).reduce(:*)
