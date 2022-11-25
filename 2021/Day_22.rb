### Input ###

input = File.read("./Input/Day_22_Input.txt").chomp.split("\n")

steps = []
input.each do |step|
  steps << {
             on: step.split(' ')[0] == 'on' ? 1 : 0,
             x: step.split(' ')[1].split(',')[0][2..].split('..').inject { |s, e| s.to_i..e.to_i },
             y: step.split(' ')[1].split(',')[1][2..].split('..').inject { |s, e| s.to_i..e.to_i },
             z: step.split(' ')[1].split(',')[2][2..].split('..').inject { |s, e| s.to_i..e.to_i }
           }
end

### Part 1 ###

cubes_on = []
steps.each do |step|
  cube = ''
  for x in step[:x]
    for y in step[:y]
      for z in step[:z]
        cube = "#{x},#{y},#{z}"
        cubes_on << cube if step[:on] == 1 && !cubes_on.include?(cube)
        cubes_on.delete(cube) if step[:on] == 0
      end  
    end
  end
end

p cubes_on.size
