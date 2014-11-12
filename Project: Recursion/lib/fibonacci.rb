
def fibs(n)
  a, b = 0, 1
  n.times do
    a, b = b, a+b
  end
  a
end

def fibs_rec(n)
  n < 2 ? n : fibs_rec(n-1) + fibs_rec(n-2)
end
