
def bubble_sort(xs)
  bubble_sort_by(xs) { |a,b| b<=>a }
end

def bubble_sort_by(xs)
  loop do
    sorted = true
    (1...xs.size).each do |i|
      if yield(xs[i-1], xs[i]) < 0
        sorted = false
        xs[i], xs[i-1] = xs[i-1], xs[i]
      end
    end
    return xs if sorted
  end
end
