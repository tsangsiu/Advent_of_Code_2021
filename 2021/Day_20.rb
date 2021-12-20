### Methods ###

def display(image)
  image.each do |line|
    puts line
  end
end

def pixel_to_bin(pixels)
  pixels.split('').map do |pixel|
    if pixel == '.'
      '0'
    elsif pixel == '#'
      '1'
    end
  end.join
end

def count_lit_pixel(image)
  count = 0
  image.each do |line|
    count += line.count('#')
  end
  count
end

### Input ###

input = File.read("./Input/Day_20_Input.txt").chomp.split("\n")

ALGORITHM = input[0]
input_image = input[2..]

BORDER = 500
input_image.map! do |line|
  "#{'.' * BORDER}#{line}#{'.' * BORDER}"
end
BORDER.times do
  input_image.unshift('.' * input_image[0].length)
  input_image.push('.' * input_image[0].length)
end

TRIM_BORDER = 50

### Parts 1, 2 ###

output_image = []

50.times do
  output_image = input_image.map do |line|
    '.' * line.length
  end
  # output_image = input_image.clone  # why this doesn't work?
  
  for i in 1..(input_image.size - 2)
    for j in 1..(input_image[0].length - 2)
      pixels = ''
      pixels << input_image[i - 1][(j - 1)..(j + 1)]
      pixels << input_image[i][(j - 1)..(j + 1)]
      pixels << input_image[i + 1][(j - 1)..(j + 1)]
      output_image[i][j] = ALGORITHM[pixel_to_bin(pixels).to_i(2)]
    end
  end
  
  input_image = output_image.clone
end

output_image.shift(TRIM_BORDER)
output_image.pop(TRIM_BORDER)
output_image.map! do |line|
  line[TRIM_BORDER...(line.length - TRIM_BORDER)]
end

p count_lit_pixel(output_image)
