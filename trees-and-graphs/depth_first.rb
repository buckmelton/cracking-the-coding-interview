class Graph

  attr_accessor :nodes

  @nodes

  def initialize(nodes=[])
    @nodes = nodes
  end

  def print_graph
    nodes.each do |node|
      print "Node data " + node.data.to_s + ", neighbors: "
      node.neighbors.each {|neighbor| print neighbor.data.to_s + " "}
      puts
    end
  end

end

class GraphNode

  attr_accessor :data, :neighbors, :marked

  @data
  @neighbors
  @marked

  def initialize(data, neighbors=[])
    @data = data
    @neighbors = neighbors
    @marked = false
  end

  def route_dfs?(dest)
    if self.equal?(dest)
      return true
    end
    @marked = true
    @neighbors.each do |neighbor|
      if !neighbor.marked && neighbor.route_dfs?(dest)
        return true
      end
    end

    return false

  end

end


node0 = GraphNode.new(0)
node1 = GraphNode.new(1)
node2 = GraphNode.new(2)
node3 = GraphNode.new(3)
node4 = GraphNode.new(4)
node5 = GraphNode.new(5)

node0.neighbors << node1
node0.neighbors << node4
node0.neighbors << node5
node1.neighbors << node3
node1.neighbors << node4
node2.neighbors << node1
node3.neighbors << node2
node3.neighbors << node4

my_graph = Graph.new([node0, node1, node2, node3, node4, node5])
my_graph.print_graph

puts "node0 object id: " + node0.object_id.to_s
puts "node5 object id: " + node5.object_id.to_s
puts node5.route_dfs?(node0) ? ("yes") : ("no")
