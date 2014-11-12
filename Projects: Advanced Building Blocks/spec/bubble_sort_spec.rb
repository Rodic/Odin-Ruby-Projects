require 'bubble_sort'

describe "#bubble sort" do
  it "should return empty list for empty list" do
    expect(bubble_sort([])).to eq([])
  end

  it "should leave untoched already sorted list" do
    expect(bubble_sort([1, 2, 3])).to eq([1, 2, 3])
  end

  it "should sort unsorted list" do
    expect(bubble_sort([4,3,78,2,0,2])).to eq([0, 2, 2, 3, 4, 78])
  end

  it "should sort unsorted list of negative numbers" do
    expect(bubble_sort([-3, -5, -1, -2, -4])).to eq([-5, -4, -3, -2, -1])
  end
end


describe "#bubble_sort_by" do
  it "should return empty list for empty list" do
    expect(bubble_sort([]) {|a,b| a-b}).to eq([])
  end

  it "should sort list by block" do
    expect(bubble_sort_by(["hi","hello","hey"]) { |a,b| b.size-a.size }).to eq(["hi", "hey", "hello"])
  end

  it "should sort reverse" do
    expect(bubble_sort_by(["hi","hello","hey"]) { |a,b| a.size - b.size }).to eq(["hello", "hey", "hi"])
  end
end
