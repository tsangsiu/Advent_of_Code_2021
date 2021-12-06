require_relative "./Input/Day_06_Input.rb"

def reorganise_ages_fish(ages_fish)
  ages_fish_hash = Hash.new(0)
  ages_fish.each do |age|
    ages_fish_hash[age] += 1
  end
  ages_fish_hash
end

def count_fish(ages_fish)
  total = 0
  ages_fish.each do |key, value|
    total += value
  end
  total
end

### Part 1 ###

ages_fish = Input::AGES_FISH
ages_fish = reorganise_ages_fish(ages_fish)

80.times do
  ages_fish[9] = ages_fish[0]
  ages_fish[7] += ages_fish[0] 
  ages_fish[0] = 0
  1.upto(9) do |age|
    ages_fish[age - 1] = ages_fish[age]
    ages_fish[age] = 0 if age == 9
  end
end

number_of_fish = count_fish(ages_fish)
p number_of_fish

### Part 2 ###

ages_fish = Input::AGES_FISH
ages_fish = reorganise_ages_fish(ages_fish)

256.times do
  ages_fish[9] = ages_fish[0]
  ages_fish[7] += ages_fish[0] 
  ages_fish[0] = 0
  1.upto(9) do |age|
    ages_fish[age - 1] = ages_fish[age]
    ages_fish[age] = 0 if age == 9
  end
end

number_of_fish = count_fish(ages_fish)
p number_of_fish

### Original Solution for Part 1 ###

# ages_fish = Input::AGES_FISH

# 80.times do
#   ages_fish.each_with_index do |age, index|
#     if age == 0
#       ages_fish[index] = 7
#       ages_fish << 9
#     end
#     ages_fish[index] -= 1
#   end
# end

# number_of_fish = ages_fish.size
# p number_of_fish
