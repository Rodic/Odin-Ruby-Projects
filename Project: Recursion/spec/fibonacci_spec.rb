require 'fibonacci'

describe "#fibs" do
  it "should return 1 for 1" do
    expect(fibs(1)).to eq(1)
  end

  it "should return 5 for 5" do
    expect(fibs(5)).to eq(5)
  end

  it "should return 55 for 10" do
    expect(fibs(10)).to eq(55)
  end

  it "should return 20 for 6765" do
    expect(fibs(20)).to eq(6765)
  end
end


describe "#fibs_rec" do
  it "should return 1 for 1" do
    expect(fibs_rec(1)).to eq(1)
  end

  it "should return 5 for 5" do
    expect(fibs_rec(5)).to eq(5)
  end

  it "should return 55 for 10" do
    expect(fibs_rec(10)).to eq(55)
  end

  it "should return 20 for 6765" do
    expect(fibs_rec(20)).to eq(6765)
  end
end
