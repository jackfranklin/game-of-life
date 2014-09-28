require_relative "../world"

describe World do
  let(:next_board) { world.tick.board }
  describe "World#tick" do
    describe "with an empty world" do
      let(:world) { World.new([]) }
      it "stays empty" do
        expect(next_board).to eq([])
      end
    end

    describe "cell with no neighbours" do
      let(:world) { World.new([[1, 0]]) }
      it "dies" do
        expect(next_board).to eq([])
      end
    end

    describe "cell with two neighbours" do
      let(:world) { World.new([[0, 0], [1, 0], [2, 0]]) }
      it "lives" do
        expect(next_board).to include([1, 0])
      end
    end

    describe "cell with three neighbours" do
      let(:world) { World.new([[0, 0], [1, 0], [2, 0], [1, 1]]) }
      it "lives" do
        expect(next_board).to include([1, 0])
      end
    end

    describe "cell with four neighbours" do
      let(:world) { World.new([[0, 0], [0, 1], [1, 0], [2, 0], [1, 1]]) }
      it "dies" do
        expect(next_board).to_not include([1, 1])
      end
    end

    describe "dead cell with three neighbours" do
      let(:world) { World.new([[0, 0], [0, 1], [1, 0]]) }
      it "comes to life" do
        expect(next_board).to include([1, 1])
      end
    end

    describe "the spinner" do
      let(:world) { World.new([[0, 0], [1, 0], [2, 0]]) }
      it "goes round and round" do
        expect(world.tick.tick.board).to match_array(world.board)
      end
    end
  end

  describe "World#neighbours_for_cell" do
    let(:neighbours) { world.neighbours_for_cell(cell) }
    describe "given a cell with two neighbours" do
      let(:cell) { [1, 0] }
      let(:world) { World.new([[0, 0], [1, 0], [2, 0]]) }
      it "returns 2" do
        expect(neighbours).to eq(2)
      end
    end

    describe "given a cell with three neighbours" do
      let(:cell) { [1, 0] }
      let(:world) { World.new([[0, 0], [1, 0], [2, 0], [1, 1]]) }
      it "returns 3" do
        expect(neighbours).to eq(3)
      end
    end

  end
end
