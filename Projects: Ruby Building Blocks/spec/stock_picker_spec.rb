require 'stock'

describe "#stock_picker" do
  it "should pick first and last day when there are only two days" do
    expect(stock_picker([2, 1])).to eq([0, 1])
  end

  it "should pick index of min day as first result when max day is last day" do
    expect(stock_picker([2, 1, 2, 3])).to eq([1,3])
  end

  it "should pick index of max day as second result when min day is first day" do
    expect(stock_picker([1, 2, 3, 2])).to eq([0,2])
  end

  it "should pick right indices regardles the order of min and max days" do
    expect(stock_picker([17,3,6,9,15,8,6,1,10])).to eq([1,4])
  end

  it "should pick min loss when there's no profit available" do
    expect(stock_picker([10, 8, 2, 1])).to eq([2,3])
  end
end
