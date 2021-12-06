require_relative "./Input/Day_03_Input.rb"

report_original = Input::REPORT_ORIGINAL

### Part 1 ###

report = report_original.map { |number| number.split('') }
report = report.transpose

gamma = ''
epsilon = ''
report.each do |digit|
  if digit.count('0') > digit.count('1')
    gamma += '0'
    epsilon += '1'
  elsif digit.count('1') > digit.count('0')
    gamma += '1'
    epsilon += '0'
  end
end

gamma_dec = gamma.to_i(2)
epsilon_dec = epsilon.to_i(2)
answer = gamma_dec * epsilon_dec
p gamma_dec, epsilon_dec, answer # => 1565, 2530, 3959450

### Part 2 ###

def keep(array, index, digit)
  if array.size > 1 then
    array.select! do |element|
      element[index].to_i == digit
    end
  end
end

report = report_original

oxygen = report.clone
digit_index = 0
while oxygen.size > 1
  digit = oxygen.map { |number| number.split('') }
  digit = digit.transpose
  if digit[digit_index].count('1') >= digit[digit_index].count('0')
    keep(oxygen, digit_index, 1)
  else
    keep(oxygen, digit_index, 0)
  end
  digit_index += 1
end
oxygen = oxygen[0].to_i(2)

co2 = report.clone
digit_index = 0
while co2.size > 1
  digit = co2.map { |number| number.split('') }
  digit = digit.transpose
  if digit[digit_index].count('1') >= digit[digit_index].count('0')
    keep(co2, digit_index, 0)
  else
    keep(co2, digit_index, 1)
  end
  digit_index += 1
end
co2 = co2[0].to_i(2)

answer = oxygen * co2
p oxygen, co2, answer # 2039, 3649, 7440311
