require 'knight'

describe "#knight_moves" do
  it "should make no moves if it's already at the finish" do
    expect(knight_moves([0, 0], [0, 0]).size).to eq(1)
  end

  it "should make one move if only one move is needed" do
    expect(knight_moves([0, 0], [2, 1]).size).to eq(2)
  end

  it "should make two moves if only two moves are needed" do
    expect(knight_moves([3,3],[0,0]).size).to eq(3)
  end

  it "should make four moves if only four moves are needed" do
    expect(knight_moves([3,3],[4,3]).size).to eq(4)
  end
end
