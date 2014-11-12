
# Note:
# Few classes are added so that final code is a bit clearer
# @parent is removed since it's unused!
# For simplicity, Queue has 'push'&'pop' methods instead of 'enqueue'&'dequeue'

class MyQueue < Array
  def push(elem)
    self.unshift(elem)
  end
end

class Stack < Array
end

class Tree
  def self.build_tree(arr)
    arr.inject(Leaf.new) { |t, elem| t.add(elem) }
  end
end

class Leaf
  def add(val)
    Node.new(val, Leaf.new, Leaf.new)
  end

  def is_leaf?
    true
  end
  
  def dfs_rec(val)
    nil
  end
  
  def to_s
    "Leaf"
  end
end

class Node
  attr_accessor :value, :left, :right
  
  def initialize(value, left, right)
    @value = value
    @left  = left
    @right = right
  end
    
  def add(val)
    if val < @value
      Node.new(@value, @left.add(val), @right)
    else
      Node.new(@value, @left, @right.add(val))
    end
  end

  def is_leaf?
    false
  end

  def search(val, container)
    container.push(self)
    
    until container.empty?
      t = container.pop
      unless t.is_leaf?
        return t if t.value == val
        container.push(t.left)
        container.push(t.right)
      end
    end
    return nil
  end
  
  def bfs(val)
    search(val, MyQueue.new)
  end

  def dfs(val)
    search(val, Stack.new)
  end

  def dfs_rec(val)
    if self.is_leaf?    then nil
    elsif @value == val then self
    else
      @left.dfs_rec(val) || @right.dfs_rec(val)
    end
  end
  
  def to_s
    "(#{left}) <= #{value} => (#{right})"
  end
end
