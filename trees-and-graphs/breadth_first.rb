class Queue

  @head
  @tail

  def initialize
    @head = nil
    @tail = nil
  end

  def enqueue(data)
    new_node = QueueNode.new(data)
    if @tail != nil
      @tail.nxt = new_node
    end
    @tail = new_node
    if @head == nil
      @head = new_node
    end
  end

  def dequeue
    return_node = @head
    if @head != nil
      @head = @head.nxt
    end
    return_node.nxt = nil
    return return_node
  end

  def peek
    return head
  end

  def empty?
    return @head == nil
  end

end

class QueueNode
  attr_accessor :data, :nxt

  @data
  @nxt

  def initialize(data)
    @data = data
    @nxt = nil
  end

end

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

  def route_bfs?(dest_node)

    # For breadth-first search, we use a queue and iterate through it.
    the_queue = Queue.new

    # We've processed this node, put it in the queue.
    @marked = true
    the_queue.enqueue(self)

    # Iterate through queue
    while !the_queue.empty?

      # Pull first node out of queue
      node = the_queue.dequeue

      # If the node we pulled off the queue is the destination we're looking for,
      # there's a route from this node to the destination, and we're done.
      if node.data.equal?(dest_node)
        return true
      end

      # Otherwise grab all the neighbors of the node currently being inspected,
      # mark them as processed and stick them in the queue.
      node.data.neighbors.each do |neighbor|
        if !neighbor.marked
          neighbor.marked = true
          the_queue.enqueue(neighbor)
        end
      end

    end

    # We've worked through all nodes reachable from self and never found a route.
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

#puts "node5 object id: " + node5.object_id.to_s
#puts "node3 object id: " + node3.object_id.to_s
node5.route_bfs?(node3) ? (puts "yes") : (puts "no")
