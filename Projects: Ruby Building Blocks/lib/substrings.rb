
def substrings(str, dict)
  result = {}
  dict.each do |sub|
    freq = str.scan(/#{sub}/i).size
    result[sub] = freq if freq > 0
  end
  result
end
