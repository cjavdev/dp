require 'rspec/autorun'
require 'set'

class Node
  attr_reader :value, :neighbors
  def initialize(value)
    @value = value
    @neighbors = Set.new
  end
end


class Graph
  attr_reader :adj, :nodes

  def initialize
    @adj = Hash.new {|h, k| h[k] = Hash.new{|h, k| h[k] = Float::INFINITY }}
    @nodes = Set.new
  end

  def add_edge(source, dest, weight)
    @adj[source][dest] = weight
    @adj[dest][source] = weight
    @nodes << source
    @nodes << dest
  end

  def [](n)
    @adj[n]
  end
end

def dij(graph, source, dest)
  costs = {}
  graph.nodes.each do |n|
    if n == source
      costs[n] = 0
    else
      costs[n] = Float::INFINITY
    end
  end

  nodes_to_visit = [source]
  seen = {}
  while !nodes_to_visit.empty?
    current_node = nodes_to_visit.shift
    current_weight = costs[current_node]
    neighbors = graph[current_node]
    neighbors.sort_by {|k, v| v}.each do |neighbor, weight|
      new_weight = weight + current_weight
      if costs[neighbor] > new_weight
        costs[neighbor] = new_weight
      end
      nodes_to_visit << neighbor if !seen[neighbor]
    end
    seen[current_node] = true
  end

  costs[dest]
end

describe 'dijkstra' do
  let(:graph) { Graph.new }
  before(:each) do
    graph.add_edge('A', 'B', 3)
    graph.add_edge('A', 'C', 1)
    graph.add_edge('C', 'B', 7)
    graph.add_edge('C', 'D', 2)
    graph.add_edge('D', 'E', 7)
    graph.add_edge('B', 'E', 1)
  end

  it 'does things' do
    expect(dij(graph, 'C', 'E')).to eq(5)
    expect(dij(graph, 'A', 'B')).to eq(3)
    expect(dij(graph, 'C', 'B')).to eq(4)
  end
end
