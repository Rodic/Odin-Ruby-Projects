require 'substrings'

describe "#substrings" do
  it "should return empty hash for empty dict" do
    expect(substrings("aaa", [])).to eq({})
  end

  it "should return empty hash for empty string" do
    expect(substrings("", ["a", "b"])).to eq({})
  end

  it "should return empty hash when there are no substrings" do
    expect(substrings("bbb", ["a"])).to eq({})
  end

  before(:each) do
    @dict = [
      "below","down","go","going","horn","how","howdy",
      "it","i","low","own","part","partner","sit"
    ]
  end

  it "should count exact number of substrings" do    
    expect(substrings("below", @dict)).to eq({"below" => 1, "low" => 1})
  end

  it "should be case insensitive" do
    str  = "Howdy partner, sit down! How's it going?"
    res  = {
      "down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1,
      "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1
    }
    expect(substrings(str, @dict)).to eq(res)
  end
end
