class World
  def initialize(cells)
    @cells = cells
  end

  def tick
    self.class.new(next_cells)
  end

  def tick!
    @cells = next_cells
  end

  def board
    @cells
  end

  def neighbours_for_cell(cell)
    neighbour_count = 0
    surrounding_cells_for_cell_each(cell) do |surrounding_cell|
      if cell_is_alive?(surrounding_cell) && surrounding_cell != cell
        neighbour_count = neighbour_count + 1
      end
    end
    neighbour_count
  end

  private

  def cell_is_alive?(cell)
    @cells.include?(cell)
  end

  def find_dead_cells_to_live
    [].tap do |new_cells|
      @cells.each do |live_cell|
        surrounding_cells_for_cell_each(live_cell) do |surrounding_cell|
          if !cell_is_alive?(surrounding_cell) &&
              cell_has_three_neighbours?(surrounding_cell)
            new_cells.push(surrounding_cell)
          end
        end
      end
    end
  end

  def cell_remains_alive?(cell)
    [2, 3].include?(neighbours_for_cell(cell))
  end

  def next_cells
    new_world = @cells.select(&method(:cell_remains_alive?))
    (new_world + find_dead_cells_to_live).uniq
  end


  def cell_has_three_neighbours?(cell)
    neighbours_for_cell(cell) == 3
  end


  def surrounding_cells_for_cell_each(cell)
    x, y = cell
    (x-1..x+1).each do |current_x|
      (y-1..y+1).each do |current_y|
        yield([current_x, current_y])
      end
    end
  end
end
