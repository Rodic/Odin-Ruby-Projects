
def merge(xs, ys)
  return ys if xs.empty?
  return xs if ys.empty?
  xs[0] < ys[0] ? [xs[0]] + merge(xs[1..-1],ys) : [ys[0]] + merge(xs,ys[1..-1])
end

def merge_sort(xs)
  return xs if xs.size < 2
  n = xs.size / 2
  merge(merge_sort(xs[0...n]), merge_sort(xs[n..-1]))
end
