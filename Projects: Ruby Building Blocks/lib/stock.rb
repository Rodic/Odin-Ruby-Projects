
def get_profit(days, indicies)
  i, j = indicies
  days[j] - days[i]
end

def stock_picker(days)
  if days.size == 2
    [ 0, 1]
  elsif days.min == days.first
    [ 0, days.index(days.max) ]
  elsif days.max == days.last
    [ days.index(days.min), days.size-1 ]
  else
    # have to increase indices by 1 since the input array was without first elem
    drop_first = stock_picker(days.drop(1)).map { |i| i+1 }
    drop_last  = stock_picker(days[0...-1])
    [ drop_first, drop_last ].max_by { |is| get_profit(days, is) }
  end
end
