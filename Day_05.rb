require_relative "./Input/Day_05_Input.rb"

def reorganise_lines_of_vents(lines_of_vents)
  lines_of_vents_reorganised = []
  n_line = 0
  lines_of_vents.each_with_index do |coordinates, index|
    if (index + 1) % 3 == 1
      lines_of_vents_reorganised[n_line] = []
      lines_of_vents_reorganised[n_line][0] = coordinates.split(',')
    elsif (index + 1) % 3 == 0
      lines_of_vents_reorganised[n_line][1] = coordinates.split(',')
      n_line += 1
    end
  end

  lines_of_vents_reorganised.each do |line|
    line.each do |point|
      point.map! do |coordinate|
          coordinate.to_i
      end
    end
  end

  lines_of_vents_reorganised
end

def find_max_coordinate(lines_of_vents)
  max_coordinate = 0
  lines_of_vents.each do |line|
    line.each do |point|
      point.each do |coordinate|
        max_coordinate = coordinate if coordinate > max_coordinate
      end
    end
  end

  max_coordinate
end

def initialise_field_of_vent(max_coordinate)
  field_of_vent = []
  0.upto(max_coordinate) do
    field_of_vent << Array.new(max_coordinate + 1, 0)
  end

  field_of_vent
end

def count_points(field_of_vent, overlap_point)
  count = 0
  field_of_vent.each do |y|
    y.each do |x|
      count += 1 if x >= overlap_point
    end
  end

  count
end

### Part 1 ###

lines_of_vents = Input::LINES_OF_VENTS

lines_of_vents = reorganise_lines_of_vents(lines_of_vents)

max_coordinate = find_max_coordinate(lines_of_vents)

field_of_vent = initialise_field_of_vent(max_coordinate)

lines_of_vents.each do |line|
  x1 = line[0][0]; y1 = line[0][1]
  x2 = line[1][0]; y2 = line[1][1]
  if x1 == x2 # vertical line
    if y1 >= y2
      y1.downto(y2) do |y|
        field_of_vent[y][x1] += 1
      end
    elsif y1 < y2
      y1.upto(y2) do |y|
        field_of_vent[y][x1] += 1
      end      
    end  
  elsif y1 == y2  # horizontal line
    if x1 >= x2
      x1.downto(x2) do |x|
        field_of_vent[y1][x] += 1
      end
    elsif x1 < x2
      x1.upto(x2) do |x|
        field_of_vent[y1][x] += 1
      end
    end
  end
end

answer = count_points(field_of_vent, 2)

p answer # => 7269

### Part 2 ###

lines_of_vents = Input::LINES_OF_VENTS

lines_of_vents = reorganise_lines_of_vents(lines_of_vents)

max_coordinate = find_max_coordinate(lines_of_vents)

field_of_vent = initialise_field_of_vent(max_coordinate)

lines_of_vents.each do |line|
  x1 = line[0][0]; y1 = line[0][1]
  x2 = line[1][0]; y2 = line[1][1]
  if x1 == x2 # vertical line
    if y1 >= y2
      y1.downto(y2) do |y|
        field_of_vent[y][x1] += 1
      end
    elsif y1 < y2
      y1.upto(y2) do |y|
        field_of_vent[y][x1] += 1
      end      
    end  
  elsif y1 == y2  # horizontal line
    if x1 >= x2
      x1.downto(x2) do |x|
        field_of_vent[y1][x] += 1
      end
    elsif x1 < x2
      x1.upto(x2) do |x|
        field_of_vent[y1][x] += 1
      end
    end
  elsif x1 > x2
    x = x1; y = y1
    if y1 > y2
      until x < x2 && y < y2
        field_of_vent[y][x] += 1
        x -= 1; y -= 1
      end
    elsif y1 < y2
      until x < x2 && y > y2
        field_of_vent[y][x] += 1
        x -= 1; y += 1
      end
    end
  elsif x1 < x2
    x = x1; y = y1
    if y1 > y2
      until x > x2 && y < y2
        field_of_vent[y][x] += 1
        x += 1; y -= 1
      end
    elsif y1 < y2
      until x > x2 && y > y2
        field_of_vent[y][x] += 1
        x += 1; y += 1
      end
    end
  end
end

answer = count_points(field_of_vent, 2)

p answer # => 21140
