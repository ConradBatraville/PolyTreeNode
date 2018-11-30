require 'byebug'

class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end 

  def children 
    @children
  end

  def value
    @value
  end

  def parent=(node)
    if self.parent != node && !self.parent.nil?
      @parent.children.delete(self)
    end
    @parent = node 
    unless @parent.nil? || @parent.children.include?(self) 
      @parent.children << self 
    end
  end

  def add_child(child_node)
      child_node.parent = self
  end

  def remove_child(child_node)
    if child_node.parent == self
      child_node.parent = nil
    else 
      raise "Cannot be done"
    end
  end

  def dfs(target_value)
    if target_value == @value 
      return self
    else 
      children.each do |child|
        check_value = child.dfs(target_value)
        return check_value unless check_value.nil?
      end
      nil
    end
  end

  def bfs(target_value)
    queue = []
    queue << self

    until queue.empty?

      first_in_line = queue.shift
      if first_in_line.value == target_value
        return first_in_line
      end 

      first_in_line.children.each do |child|
        queue << child
      end
    end

    nil

  end
end