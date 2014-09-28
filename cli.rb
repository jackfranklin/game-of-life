require_relative 'world'

# starting_board = gets

# # 1,0:2,0:3,0

# board = []
# starting_board.split(":").each do |cell|
#   board.push(cell.split(",").map(&:to_i))
# end

board = [[2, 1], [3, 2], [1, 3], [2, 3], [3, 3]]

world = World.new(board)

def find_smallest_x(world)
  smallest_x = 99
  world.board.each do |cell|
    if cell[0] < smallest_x
      smallest_x = cell[0]
    end
  end
  smallest_x
end

def find_largest_x(world)
  largest_x = -99
  world.board.each do |cell|
    if cell[0] > largest_x
      largest_x = cell[0]
    end
  end
  largest_x
end

def find_smallest_y(world)
  smallest_y = 99
  world.board.each do |cell|
    if cell[1] < smallest_y
      smallest_y = cell[1]
    end
  end
  smallest_y
end

def find_largest_y(world)
  largest_y = -99
  world.board.each do |cell|
    if cell[1] > largest_y
      largest_y = cell[1]
    end
  end
  largest_y
end

def print_world(world)
  smallest_x = find_smallest_x(world)
  smallest_y = find_smallest_y(world)
  largest_x = find_largest_x(world)
  largest_y = find_largest_y(world)

  smallest_y = 0 if smallest_y > 0
  smallest_x = 0 if smallest_x > 0

  (smallest_y..largest_y).each do |y|
    out = ""
    (smallest_x..largest_x).each do |x|
      if world.board.include?([x, y])
         out = out + "A"
      else
        out = out + " "
      end
    end
    puts out
  end
end

while true
  print_world(world)
  world.tick!
  sleep 0.5
  puts ''
end

