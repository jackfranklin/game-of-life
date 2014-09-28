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
    self.class.new((new_world + check_dead_cells_for_new_life).uniq)
  end

  def board
    @cells
  end

  def check_dead_cells_for_new_life
    new_cells = []
    @cells.each do |live_cell|
      cell_x, cell_y = live_cell
      each_surrounding_cells_for_cell_do(live_cell) do |x, y|
        next if cell_x == x && cell_y == y || @cells.include?([x, y])
        if neighbours_for_cell([x, y]) == 3
          new_cells.push([x, y])
        end
      end
    end
    new_cells.uniq
  end

  def neighbours_for_cell(cell)
    neighbour_count = 0
    each_surrounding_cells_for_cell_do(cell) do |x, y|
      if @cells.include?([x, y]) && [x, y] != cell
        neighbour_count = neighbour_count + 1
      end
    end
    neighbour_count
  end

  def each_surrounding_cells_for_cell_do(cell)
    x, y = cell
    (x-1..x+1).each do |current_x|
      (y-1..y+1).each do |current_y|
        yield(current_x, current_y)
      end
    end
  end
end
