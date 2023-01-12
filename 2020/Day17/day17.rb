###
### input
###

input = File.read("input.txt").split("\n").map(&:chars)

###
### part 1
###

on = Hash.new(false)
input.each_with_index do |row, y|
  row.each_with_index do |point, x|
    on[[x, y, 0]] = true if point == "#"
  end
end

offset = [-1, 0, 1].product([-1, 0, 1], [-1, 0, 1])
offset.delete([0, 0, 0])

6.times do
  on_clone = on.clone
  x = on.keys.map { |coord| coord[0] }
  y = on.keys.map { |coord| coord[1] }
  z = on.keys.map { |coord| coord[2] }
  ((z.min - 1)..(z.max + 1)).each do |z|
    ((y.min - 1)..(y.max + 1)).each do |y|
      ((x.min - 1)..(x.max + 1)).each do |x|
        n_on = 0
        offset.each do |dx, dy, dz|
          n_on += 1 if on[[x + dx, y + dy, z + dz]]
        end
        on_clone[[x, y, z]] = false if !(on[[x, y, z]] && [2, 3].include?(n_on))    
        on_clone[[x, y, z]] = true if !on[[x, y, z]] && n_on == 3
      end
    end
  end
  on = on_clone
end

puts on.values.flatten.count(true)

###
### part 2
###

on = Hash.new(false)
input.each_with_index do |row, y|
  row.each_with_index do |point, x|
    on[[x, y, 0, 0]] = true if point == "#"
  end
end

offset = [-1, 0, 1].product([-1, 0, 1], [-1, 0, 1], [-1, 0, 1])
offset.delete([0, 0, 0, 0])

6.times do
  on_clone = on.clone
  x = on.keys.map { |coord| coord[0] }
  y = on.keys.map { |coord| coord[1] }
  z = on.keys.map { |coord| coord[2] }
  w = on.keys.map { |coord| coord[3] }
  ((z.min - 1)..(z.max + 1)).each do |z|
    ((y.min - 1)..(y.max + 1)).each do |y|
      ((x.min - 1)..(x.max + 1)).each do |x|
        ((w.min - 1)..(w.max + 1)).each do |w|
          n_on = 0
          offset.each do |dx, dy, dz, dw|
            n_on += 1 if on[[x + dx, y + dy, z + dz, w + dw]]
          end
          on_clone[[x, y, z, w]] = false if !(on[[x, y, z, w]] && [2, 3].include?(n_on))    
          on_clone[[x, y, z, w]] = true if !on[[x, y, z, w]] && n_on == 3
        end
      end
    end
  end
  on = on_clone
end

puts on.values.flatten.count(true)
