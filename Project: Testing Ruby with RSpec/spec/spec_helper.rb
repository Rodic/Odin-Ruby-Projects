require 'connect_four'

def fill_column(table, col, val)
  table.pin(val, col, 0)
  table.pin(val, col, 1)
  table.pin(val, col, 2)
  table.pin(val, col, 3)
  table.pin(val, col, 4)
  table.pin(val, col, 5)
end

def fill_row(table, row, val)
  table.pin(val, 0, row)
  table.pin(val, 1, row)
  table.pin(val, 2, row)
  table.pin(val, 3, row)
  table.pin(val, 4, row)
  table.pin(val, 5, row)
  table.pin(val, 6, row)
end
