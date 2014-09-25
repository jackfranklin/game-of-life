require 'minitest/autorun'

require_relative '../world'

class TestNeighbours < MiniTest::Unit::TestCase
  def test_number_of_neighbour_cells
    board = World.new([[0, 0], [1, 0], [2, 0]])
    assert_equal 2, board.neighbours_for_cell([1, 0])
  end

  def test_number_of_neighbour_cells_again
    board = World.new([[0, 0], [1, 0], [2, 0], [1, 1]])
    assert_equal 3, board.neighbours_for_cell([1, 0])
  end

  def test_number_of_neighbour_cells_once_more
    board = World.new([[0, 0], [1, 0], [2, 0], [1, 1], [4, 4]])
    assert_equal 3, board.neighbours_for_cell([1, 0])
  end

  def test_number_of_neighbour_cells_another_time
    board = World.new([
      [0, 0], [0, 1],
      [1, 0], [1, 1], [1, 2]
    ])
    assert_equal 4, board.neighbours_for_cell([1, 1])
  end
end

# any live cell with fewer than two neighbours dies

# any live cell with two or three live neighbours live

# any live cell with more than three live neighbours dies

# any dead cell with exactly three neighbours becomes live
