require 'rspec/autorun'


class Node
  attr_reader :value
  attr_accessor :child

  def initialize(value, child=nil)
    @value = value
    @child = child
  end

  def insert(x)
    current = self
    while !current.child.nil?
      current = current.child
    end
    current.child = Node.new(x)
  end

  def print
    current = self
    p current.value
    while !current.child.nil?
      current = current.child
      p current.value
    end
  end
end

def reverse(node)
  node.child = nil
  current = node
  prev = nil
  while !current.child.nil?
    p prev
    nxt = current.child
    current.child = prev
    prev = current
    current = nxt
    nxt.child = prev
  end
  current
end

describe 'reverse' do
  let(:list) do
    Node.new(1)
  end

  before(:each) do
    list.insert(2)
    list.insert(3)
    list.insert(4)
    list.insert(5)
    list.insert(6)
    list.print
  end

  it 'reverses a linked list' do
    reverse(list)
  end
end
