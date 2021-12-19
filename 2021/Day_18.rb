### Input ###

nums = File.read("./Input/Day_18_Input.txt").chomp.split("\n")

# nums.each do |num|
#   p num
# end

### Methods ###

def to_explode?(num)
  to_explode = false
  count = 0
  num.split('').each do |element|
    count += 1 if element == '['
    count -= 1 if element == ']'
    if count > 4
      to_explode = true
      break
    end
  end
  to_explode
end

# to return the start and end indices of the array (first-encountered) that is going to explode
def explode_range(num)
  if to_explode?(num)
    count = 0
    start_index = nil; end_index = nil
    num.split('').each_with_index do |element, index|
      count += 1 if element == '['
      count -= 1 if element == ']'      
      start_index = index if count > 4 && element == '['
      if !!start_index && element == ']'
        end_index = index
        break
      end
    end
    return start_index, end_index
  end
end

# to find the exploding pair's left value, return it and its index
def left_value(num)
  if to_explode?(num)
    start_index, end_index = explode_range(num)  # start and end indices of the exploding pair

    number_start_index = nil; number_end_index = nil
    num_left_part = num[0...start_index]
    num_left_part.split('').reverse.each_with_index do |element, index|
      if element.match(/[0-9]/) && !number_start_index
        number_start_index = index
      end
      if !element.match(/[0-9]/) && !!number_start_index
        number_end_index = index - 1
        left_value_start_index = num_left_part.length - 1 - number_end_index
        left_value_end_index = num_left_part.length - 1 - number_start_index
        left_value = num_left_part[left_value_start_index..left_value_end_index].to_i
        return left_value, left_value_start_index
      end
    end
    return 0, nil
  end
end

# to find the exploding pair's right value, return it and its index
def right_value(num)
  if to_explode?(num)
    start_index, end_index = explode_range(num)  # start and end indices of the exploding pair

    number_start_index = nil; number_end_index = nil
    num_right_part = num[(end_index + 1)..]
    num_right_part.split('').each_with_index do |element, index|
      if element.match(/[0-9]/) && !number_start_index
        number_start_index = index
      end
      if !element.match(/[0-9]/) && !!number_start_index
        number_end_index = index - 1
        right_value = num_right_part[number_start_index..number_end_index].to_i
        right_value_start_index = end_index + 1 + number_start_index
        return right_value, right_value_start_index
      end
    end
    return 0, nil
  end
end

def explode(num)
  if to_explode?(num)
    right_number, right_number_index = right_value(num)  # the closet right value of the exploding pair
    left_number, left_number_index = left_value(num)

    exploding_pair_indices = explode_range(num)
    exploding_pair = num[exploding_pair_indices[0]..exploding_pair_indices[1]]
    exploding_pair_left = exploding_pair[(exploding_pair.index('[') + 1)...exploding_pair.index(',')].to_i
    exploding_pair_right = exploding_pair[(exploding_pair.index(',') + 1)...exploding_pair.index(']')].to_i

    num = "#{num[0..(right_number_index - 1)]}#{exploding_pair_right + right_number}#{num[(right_number_index + right_number.to_s.length)..]}" if !!right_number_index
    num = "#{num[0..(exploding_pair_indices[0] - 1)]}0#{num[(exploding_pair_indices[1] + 1)..]}"
    num = "#{num[0..(left_number_index - 1)]}#{left_number + exploding_pair_left}#{num[(left_number_index  + left_number.to_s.length)..]}" if !!left_number_index
  end
  return num
end

def to_split?(num)
  to_split = false
  num.gsub(/[\[\]]/, '').split(',').map(&:to_i).each do |number|
    to_split = true if number >= 10
  end
  to_split
end

# to return the start and end indices of the number (first-encountered) that is going to split
def split_range(num)  ###
  if to_split?(num)
    count = 0
    start_index = nil; end_index = nil
    num.split('').each_with_index do |element, index|
      count += 1
      if (element == ',' || element == ']') && count > 2
        start_index = index - (count - 1); end_index = index - 1
        break
      end
      count = 0 if ['[', ',', ']'].include?(element)
    end
    return start_index, end_index
  end
end

def split(num)  ###
  if to_split?(num)
    split_start_index, split_end_index = split_range(num)
    split_number = num[split_start_index..split_end_index].to_f
    num = "#{num[0...split_start_index]}[#{(split_number / 2).floor},#{(split_number / 2).ceil}]#{num[(split_end_index + 1)..]}"
  end
  return num
end

def add(num1, num2)
  num = "[#{num1},#{num2}]"
  reduce(num)
end

def reduce(num)
  loop do
    while to_explode?(num)
      num = explode(num)
    end
    if to_split?(num)
      num = split(num)
    end
    break if !to_explode?(num) && !to_split?(num)
  end
  num
end

def find_innermost_array_index(num)
  stack = []
  num.split('').each_with_index do |element, index|
    stack << index if element == '['
    return stack.last, index if element == ']'
  end
  nil
end

def magnitude(num)
  while find_innermost_array_index(num) != nil
    start_index, end_index = find_innermost_array_index(num)
    innermost_array = num[start_index..end_index]
    array_left = innermost_array[(innermost_array.index('[') + 1)...(innermost_array.index(','))].to_i
    array_right = innermost_array[(innermost_array.index(',') + 1)...(innermost_array.index(']'))].to_i
    magnitude = array_left * 3 + array_right * 2
    num = "#{num[0...start_index]}#{magnitude}#{num[(end_index + 1)..]}"
    magnitude(num) if !find_innermost_array_index(num) 
  end
  return num.to_i
end

### Part 1 ###

result = nums[0]
for index in 1..(nums.size - 1)
  result = add(result, nums[index])
end

answer = magnitude(result)
p answer

### Part 2 ###

magnitudes = []
for i in 0..(nums.size - 1)
  for j in 0..(nums.size - 1)
    magnitudes << magnitude(add(nums[i], nums[j]))
  end
end
p magnitudes.max
