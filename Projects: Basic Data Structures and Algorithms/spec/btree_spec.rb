require 'btree'

describe "#build_tree" do
  it "should create Leaf tree for empty input" do
    expect(Tree.build_tree([])).to be_instance_of(Leaf)
  end

  it "should create node with leafs for input of size 1" do
    expect(Tree.build_tree([1]).to_s).to eq("(Leaf) <= 1 => (Leaf)")
  end

  it "for sorted list, all inputs should be in the right branch" do
    expect(Tree.build_tree([1, 2, 3]).to_s)
      .to eq("(Leaf) <= 1 => ((Leaf) <= 2 => ((Leaf) <= 3 => (Leaf)))")
  end

  it "should keep smaller values on the left and bigger on the right" do
    expect(Tree.build_tree([2, 1, 3]).to_s)
      .to eq("((Leaf) <= 1 => (Leaf)) <= 2 => ((Leaf) <= 3 => (Leaf))")
  end
end

describe "#bfs" do
  before(:each) do
    @t = Tree.build_tree([2, 1, 3, 4])
  end
  
  it "should return nil if elem is not in the tree" do
    expect(@t.bfs(5)).to eq(nil)
  end

  it "should return correct subtree when elem is in the tree" do
    expect(@t.bfs(3).to_s).to eq("(Leaf) <= 3 => ((Leaf) <= 4 => (Leaf))")
  end
end

describe "#dfs" do
  before(:each) do
    @t = Tree.build_tree([2, 1, 3, 4])
  end
  
  it "should return nil if elem is not in the tree" do
    expect(@t.dfs(5)).to eq(nil)
  end

  it "should return correct subtree when elem is in the tree" do
    expect(@t.dfs(3).to_s).to eq("(Leaf) <= 3 => ((Leaf) <= 4 => (Leaf))")
  end
end

describe "#dfs_rec" do
  before(:each) do
    @t = Tree.build_tree([2, 1, 3, 4])
  end
  
  it "should return nil if elem is not in the tree" do
    expect(@t.dfs_rec(5)).to eq(nil)
  end

  it "should return correct subtree when elem is in the tree" do
    expect(@t.dfs_rec(3).to_s).to eq("(Leaf) <= 3 => ((Leaf) <= 4 => (Leaf))")
  end
end
