class World
  def initialize(cells)
    @cells = cells
  end

  def tick
    new_world = []
    @cells.each do |cell|
      neighbours = neighbours_for_cell(cell)
      if [2, 3].include?(neighbours)
        new_world.push(cell)
      end
    end
    (new_world + check_dead_cells_for_new_life).uniq
  end

  def check_dead_cells_for_new_life
    new_cells = []
    @cells.each do |live_cell|
      cell_x, cell_y = live_cell
      (cell_x-1..cell_x+1).each do |x|
        (cell_y-1..cell_y+1).each do |y|
          next if cell_x == x && cell_y == y
          if neighbours_for_cell([x, y]) == 3
            new_cells.push([x, y])
          end
        end
      end
    end
    new_cells.uniq
  end

  def neighbours_for_cell(cell)
    x, y = cell
    neighbour_count = 0
    (x-1..x+1).each do |x|
      (y-1..y+1).each do |y|
        if @cells.include?([x, y]) && [x, y] != cell
          neighbour_count = neighbour_count + 1
        end
      end
    end
    neighbour_count
  end
end
