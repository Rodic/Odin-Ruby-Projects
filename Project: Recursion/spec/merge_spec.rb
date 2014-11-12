require 'merge'

describe "#merge_sort" do
  it "should return empty list when input is empty list" do
    expect(merge_sort([])).to eq([])
  end

  it "should sort already sorted list" do
    expect(merge_sort([1, 2, 3, 4])).to eq([1, 2, 3, 4])
  end

  it "should sort unsorted list" do
    expect(merge_sort([5, 2, 1, 4, 3])).to eq([1, 2, 3, 4, 5])
  end

  it "should sort list with negative numbers" do
    expect(merge_sort([-1, 3, 0, 2, 1, -2])).to eq([-2, -1, 0, 1, 2, 3])
  end
end
