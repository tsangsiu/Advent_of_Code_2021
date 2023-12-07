### input

input = File.read("input_test.txt").split("\n").map(&:split)
input = File.read("input.txt").split("\n").map(&:split)

input = input.map do |line|
  hand, bid = line
  [hand, bid.to_i]
end

### part 1

strength = %w(A K Q J T 9 8 7 6 5 4 3 2).reverse

def five_of_a_kind?(hand)
  hand.chars.uniq.size == 1
end

def four_of_a_kind?(hand)
  hand.chars.uniq.any? { |char| hand.count(char) == 4 }
end

def full_house?(hand)
  hand.chars.uniq.any? { |char| hand.count(char) == 3 } &&
    hand.chars.uniq.any? { |char| hand.count(char) == 2 }
end

def three_of_a_kind?(hand)
  hand.chars.uniq.any? { |char| hand.count(char) == 3 } &&
    hand.chars.uniq.none? { |char| hand.count(char) == 2 }
end

def two_pair?(hand)
  hand.chars.uniq.size == 3 && !three_of_a_kind?(hand)
end

def one_pair?(hand)
  hand.chars.uniq.size == 4
end

def high_card?(hand)
  hand.chars.uniq.size == 5
end

def hand_type_to_score(hand)
  if five_of_a_kind?(hand)
    7
  elsif four_of_a_kind?(hand)
    6
  elsif full_house?(hand)
    5
  elsif three_of_a_kind?(hand)
    4
  elsif two_pair?(hand)
    3
  elsif one_pair?(hand)
    2
  elsif high_card?(hand)
    1
  end
end

hands_bids = input.sort_by { |hand, _| hand_type_to_score(hand) }

hands_bids = hands_bids.slice_when do |(hand_1, _), (hand_2, _)|
  hand_type_to_score(hand_1) != hand_type_to_score(hand_2)
end.to_a

hands_bids = hands_bids.map do |hand_type|
  hand_type.sort do |(hand_1, _), (hand_2, _)|
    card_1 = nil; card_2 = nil
    (0..4).each do |index|
      card_1 = hand_1[index]; card_2 = hand_2[index]
      next if card_1 == card_2
      break
    end
    strength.index(card_1) <=> strength.index(card_2)
  end
end

total_winnings = hands_bids.flatten(1).map.with_index do |(_, bid), index|
  (index + 1) * bid
end.sum

puts total_winnings

### part 2

strength = %w(A K Q T 9 8 7 6 5 4 3 2 J).reverse

def j_five_of_a_kind?(hand)
  five_of_a_kind?(hand) ||
    (four_of_a_kind?(hand) && hand.count('J') == 1) ||
    (four_of_a_kind?(hand) && hand.count('J') == 4) ||
    (full_house?(hand) && hand.count('J') == 2) ||
    (full_house?(hand) && hand.count('J') == 3)
end

def j_four_of_a_kind?(hand)
  four_of_a_kind?(hand) ||
    (three_of_a_kind?(hand) && hand.count('J') == 1) ||
    (three_of_a_kind?(hand) && hand.count('J') == 3) ||
    (two_pair?(hand) && hand.count('J') == 2)
end

def j_full_house?(hand)
  full_house?(hand) ||
    (two_pair?(hand) && hand.count('J') == 1) ||
    (two_pair?(hand) && hand.count('J') == 2)
end

def j_three_of_a_kind?(hand)
  three_of_a_kind?(hand) ||
    (one_pair?(hand) && hand.count('J') == 1) ||
    (one_pair?(hand) && hand.count('J') == 2)
end

def j_two_pair?(hand)
  two_pair?(hand)
end

def j_one_pair?(hand)
  one_pair?(hand) ||
    (high_card?(hand) && hand.count('J') == 1)
end

def j_high_card?(hand)
  high_card?(hand) &&
    hand.count('J') == 0
end

def j_hand_type_to_score(hand)
  if j_five_of_a_kind?(hand)
    7
  elsif j_four_of_a_kind?(hand)
    6
  elsif j_full_house?(hand)
    5
  elsif j_three_of_a_kind?(hand)
    4
  elsif j_two_pair?(hand)
    3
  elsif j_one_pair?(hand)
    2
  elsif j_high_card?(hand)
    1
  end
end

hand_bids = input.sort_by { |hand, _| j_hand_type_to_score(hand) }

hand_bids = hand_bids.slice_when do |(hand_1, _), (hand_2, _)|
  j_hand_type_to_score(hand_1) != j_hand_type_to_score(hand_2)
end.to_a

hand_bids = hand_bids.map do |hand_type|
  hand_type.sort do |(hand_1, _), (hand_2, _)|
    card_1 = nil; card_2 = nil
    (0..4).each do |index|
      card_1 = hand_1[index]; card_2 = hand_2[index]
      next if card_1 == card_2
      break
    end
    strength.index(card_1) <=> strength.index(card_2)
  end
end

total_winnings = hand_bids.flatten(1).map.with_index do |(_, bid), index|
  (index + 1) * bid
end.sum

puts total_winnings
