#Project1: Caesar Cipher

def shift_letter(l, pos)
  if l =~ /[^A-Za-z]/
    l
  elsif l =~ /[a-z]/
    ((l.ord + pos - 'a'.ord) % 26 + 'a'.ord).chr
  else
    shift_letter(l.downcase, pos).upcase
  end
end

def caesar_cipher(str, factor)
  str.chars.map {|c| shift_letter(c, factor)}.join
end
