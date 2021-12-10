### Input ###

syntax = File.read("./Input/Day_10_Input.txt").chomp.split("\n")

OPEN = ['(', '[', '{', '<']
CLOSE = [')', ']', '}', '>']
POINTS_1 = [3, 57, 1197, 25137]
POINTS_2 = [1, 2, 3, 4]

### Part 1 ###

point = 0

syntax.each do |code|
  stack = []
  chunks = code.split('')
  chunks.each do |chunk|
    if OPEN.include?(chunk)
      stack << chunk
    else  # close chunk
      last_chunk = stack.last
      open_chunk_index = OPEN.index(last_chunk)
      close_chunk_index = CLOSE.index(chunk)
      if chunk != CLOSE[open_chunk_index]
        point += POINTS_1[close_chunk_index]
        break
      else
        stack.pop
      end
    end
  end
end

p point

### Part 2 ###

points = []

syntax.each do |code|
  stack = []
  chunks = code.split('')
  chunks.each do |chunk|
    if OPEN.include?(chunk)
      stack << chunk
    else  # close chunk
      last_chunk = stack.last
      open_chunk_index = OPEN.index(last_chunk)
      close_chunk_index = CLOSE.index(chunk)
      if chunk != CLOSE[open_chunk_index]  # mis-match closing chunk case
        stack = []
        break
      else
        stack.pop
      end
    end
  end
  
  if stack.empty? == false
    close_chunks = stack.reverse.map do |chunk|
      CLOSE[OPEN.index(chunk)]
    end
    
    p stack
    p close_chunks
  
    point = 0
    close_chunks.each do |chunk|
      point = point * 5 + POINTS_2[CLOSE.index(chunk)]
    end
    
    points << point
  end
end

p points.sort[(points.size - 1) / 2]
