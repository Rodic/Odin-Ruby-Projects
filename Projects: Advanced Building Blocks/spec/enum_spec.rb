require 'enum'

describe "Enumerable module" do

  before(:each) do
    class Array
      include(Enumerable)
    end
  end
  
  describe "#my_each" do
    it "should work just as #each" do
      sum = 0
      [ 2, 4, 6].my_each { |i| sum += i }
      expect(sum).to eq(12)
    end
  end

  describe "#my_each_with_index" do
    it "should work just as #each_with_index" do
      sum = 0
      [ 2, 4, 6 ].my_each_with_index { |x, i| sum += x*i }
      expect(sum).to eq(16)
    end
  end

  before(:each) do
    @arr = [ 6, 3, 4, 1, 7, 2, 9, 8, 5 ]
  end

  describe "#my_select" do
    it "should work just as #select" do
      p = Proc.new { |x| x % 2 == 0}
      expect(@arr.my_select(&p)).to eq(@arr.select(&p))
    end
  end

  describe "#my_all?" do
    it "should work just as #all?" do
      p = Proc.new { |x| x < 10 }
      expect(@arr.my_all?(&p)).to eq(@arr.all?(&p))
    end
  end

  describe "#my_any?" do
    it "should work just as #any?" do
      p = Proc.new { |x| x == 5 }
      expect(@arr.my_any?(&p)).to eq(@arr.any?(&p))
    end
  end

  describe "#my_none?" do
    it "should work just as #none?" do
      p = Proc.new { |x| x > 10 }
      expect(@arr.my_none?(&p)).to eq(@arr.none?(&p))
    end
  end

  describe "#my_count" do
    it "should work just as #count" do
      p = Proc.new { |x| x % 3 == 0 }
      expect(@arr.my_count(&p)).to eq(@arr.count(&p))
    end
  end

  describe "#my_map" do
    it "should work just as #map but with proc" do
      p = Proc.new { |x| x * x }
      expect(@arr.my_map(p)).to eq(@arr.map(&p))
    end
  end

  describe "#my_inject" do
    it "should work just as #inject" do
      p = Proc.new { |acc, x| acc + x }
      expect(@arr.my_inject(&p)).to eq(@arr.inject(&p))
    end

    it "should work just as #inject with acc given" do
      p = Proc.new { |acc, x| acc * x }
      expect(@arr.my_inject(10, &p)).to eq(@arr.inject(10, &p))
    end
  end

  describe "#multiply_els" do
    it "should mult nums in the array" do
      expect(@arr.multiply_els).to eq(362880)
    end
  end
end
