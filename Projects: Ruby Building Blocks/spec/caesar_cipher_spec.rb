require 'caesar'

describe "#caesar_cipher" do
  it "should work only on letters" do
    str = "?! ~#.,;'\n\t"
    expect(caesar_cipher(str, 5)).to eq(str)
  end

  it "shouldn't change empty string" do
    expect(caesar_cipher("", 5)).to eq("")
  end

  it "should shift letters to the right when factor is positive" do
    expect(caesar_cipher("a", 1)).to eq("b")
  end

  it "should shift letters to the left when factor is negative" do
    expect(caesar_cipher("a", -1)).to eq("z")
  end

  it "should work on upper cases" do
    expect(caesar_cipher("IBM", -1)).to eq("HAL")
  end

  it "should work on sentences" do
    expect(caesar_cipher("What a string!", 5)).to eq("Bmfy f xywnsl!")
  end
end
