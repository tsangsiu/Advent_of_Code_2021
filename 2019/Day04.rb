# Input

range = 256310..732736

# Part 1

legit_password1 = []

range.each do |num|
  if num.to_s.split('').slice_when { |a, b| a != b }.to_a.size < 6 &&
      num.to_s.split('') == num.to_s.split('').sort
    legit_password1 << num
  end
end

p legit_password1.size

# Part 2

legit_password2 = []

legit_password1.each do |num|
  digit_group = num.to_s.split('').slice_when { |a, b| a != b }.to_a
  
  # `num_modified` got from removing digits that occur more than twice
  num_modified = digit_group.select { |group| group.size <= 2 }.join('').to_i
  digit_group_modified = num_modified.to_s.split('').slice_when { |a, b| a != b }.to_a
  if digit_group_modified.any? { |group| group.size == 2 } &&
      num.to_s.split('') == num.to_s.split('').sort
    legit_password2 << num
  end
end

p legit_password2.size
