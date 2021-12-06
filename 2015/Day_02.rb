require_relative "./Input/Day_02_Input.rb"

dimensions = Input::DIMENSIONS
dimensions.map! do |dimension|
  dimension = dimension.split('x')
  dimension.map! do |sides|
    sides.to_i
  end
end

### Part 1 ###

paper_required = 0
dimensions.each do |dimension|
  surface_area = [ dimension[0] * dimension[1],
                    dimension[1] * dimension[2],
                    dimension[2] * dimension[0] ]
  paper_required += (surface_area.sum * 2 + surface_area.min)
end

p paper_required

### Part 2 ###

ribbon_required = 0
dimensions.each do |dimension|
  ribbon_required += (dimension.min(2).sum * 2 + dimension.reduce(:*))
end

p ribbon_required
