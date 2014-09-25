require 'minitest/autorun'

require_relative '../world'

class TestTick < MiniTest::Unit::TestCase

  def test_an_empty_world_the_tick_is_empty
    assert_equal [], World.new([]).tick
  end

  def test_cell_with_no_neighbours_dies
    assert_equal [], World.new([[1, 0]]).tick
  end

  def test_cell_with_two_neighbours_lives
    assert World.new([
      [0, 0], [1, 0], [2, 0]
    ]).tick.include?([1, 0])
  end

  def test_cell_with_three_neighbours_lives
    board = World.new([[0, 0], [1, 0], [2, 0], [1, 1]]).tick
    assert board.include?([1, 0])
  end

  def test_cell_with_one_neighbour_dies
    assert_equal [], World.new([[0, 0], [1, 0]]).tick
  end

  def test_cell_with_four_neighbours_dies
    board = World.new([
      [0, 0], [0, 1],
      [1, 0], [1, 1], [1, 2]
    ]).tick
    refute board.include?([1, 1])
  end

  def test_dead_cell_with_three_neighbours_becomes_alive
    board = World.new([
      [0, 0], [0, 1],
      [1, 0]
    ]).tick
    assert board.include?([1, 1])
  end

  def test_check_dead_cells
    board = World.new([
      [0, 0], [1, 0], [2, 0]
    ])
    assert_equal [[1, -1], [1, 1]], board.check_dead_cells_for_new_life
  end

  def test_spinner
    starting_board = [[0, 0], [1, 0], [2, 0]]
    result = World.new(World.new(starting_board).tick).tick
    result.sort! { |cell_one, cell_two| cell_one[0] <=> cell_two[0] }
    assert_equal starting_board, result
  end
end
