require 'mastermind'

describe "Codemaker" do
  describe "#get_feedback" do
    it "should retrun zeros if there are no hits" do
      codemaker = HumanCodemaker.new([ 0, 0, 0, 0 ])
      expect(codemaker.get_feedback([1, 1, 1, 1])).to eq("0000")
    end

    it "should return all 2's when there's total match " do
      codemaker = HumanCodemaker.new([1, 2, 3, 4])
      expect(codemaker.get_feedback([1, 2, 3, 4])).to eq("2222")
    end

    it "should return 1111 when no number is in its place " do
      codemaker = HumanCodemaker.new([1, 2, 3, 4])
      expect(codemaker.get_feedback([4, 3, 2, 1])).to eq("1111")
    end

    it "should return 2000 when there's only one hit " do
      codemaker = HumanCodemaker.new([2, 2, 2, 2])
      expect(codemaker.get_feedback([1, 2, 3, 4])).to eq("2000")
    end

    it "should return 2000 when there's only one hit " do
      codemaker = HumanCodemaker.new([1, 2, 3, 4])
      expect(codemaker.get_feedback([2, 2, 2, 2])).to eq("2000")
    end
  end
end
