###

LOWERCASE_LETTERS = ('a'..'z').to_a

def password_to_numbers(password)
  password.chars.map { |char| LOWERCASE_LETTERS.index(char) }
end

def numbers_to_password(numbers)
  numbers.map { |index| LOWERCASE_LETTERS[index] }.join
end

def at_least_three_consecutive_letters?(password)
  numbers = password_to_numbers(password)
  numbers = numbers.slice_when { |num1, num2| num2 - num1 != 1 }.to_a
  numbers.any? { |grp| grp.size >= 3 }
end

def contain_i_o_l?(password)
  password.match?(/[iol]/)
end

def at_least_two_different_pairs?(password)
  grps = password.chars.slice_when { |char1, char2| char1 != char2 }.to_a
  pairs = grps.select { |grp| grp.size >= 2 }
  return false if pairs.size < 2
  letter_in_pairs = pairs.map { |pair| pair.first }
  letter_in_pairs == letter_in_pairs.uniq
end

def valid_password?(password)
  at_least_three_consecutive_letters?(password) &&
    !contain_i_o_l?(password) &&
    at_least_two_different_pairs?(password)
end

def next_password(password)
  loop do
    numbers = password_to_numbers(password)
    
    index = 7
    numbers[index] += 1

    loop do
      break if numbers[index] < 26
      numbers[index] %= 26
      index -= 1
      numbers[index] += 1
    end

    password = numbers_to_password(numbers)
    return password if valid_password?(password)
  end
end

### part 1

puts next_password('vzbxkghb')

### part 2

puts next_password('vzbxxyzz')
