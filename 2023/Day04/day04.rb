### input

input = File.read("input_test.txt").split("\n")
input = File.read("input.txt").split("\n")

cards = input.map { |card| card.split(/[:|]/)[1..] }
cards = cards.map do |card|
  card.map do |num|
    num.split.map(&:to_i)
  end
end

n_card = input.size

### part 1

scores = cards.map do |win_num, my_num|
  n_win_num = my_num.select { |num| win_num.include?(num) }.size
  n_win_num.zero? ? 0 : 2 ** (n_win_num - 1)
end

puts scores.sum

### part 2

# original solution
=begin

all_cards = []
cards.each_with_index do |(win_num, my_num), index|
  card = index + 1
  all_cards << card
  n_win_num = my_num.select { |num| win_num.include?(num) }.size
  (1..n_win_num).each { |delta| all_cards.count(card).times { all_cards << card + delta } }
end

p all_cards.select { |card| card <= n_card }.size

=end

all_cards = Hash.new(0)
cards.each_with_index do |(win_num, my_num), index|
  card = index + 1
  all_cards[card] += 1
  n_win_num = (my_num & win_num).size
  (1..n_win_num).each do |delta|
    all_cards[card].times do
      next if card + delta > n_card
      all_cards[card + delta] += 1
    end
  end
end

p all_cards.values.sum
