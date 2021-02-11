## Generic implementation of graph data structure

import std/[intsets]

type
  Node[N, E] = ref NodeObj[N, E]
  NodeObj[N, E] = object
    id: int
    nodeValue: N


  EdgeProperty = enum
    epOutgoing
    epIngoing

  Edge[N, E] = ref EdgeObj[N, E]
  EdgeObj[N, E] = object
    properties: set[EdgeProperty]
    id: int
    source*: Node[N, E]
    target*: Node[N, E]
    edgeValue: E

  GraphProperty = enum
    gpDirected
    gpUndirected
    gpAllowSelfLoops

  Graph[N, E] = ref GraphObj[N, E]

  GraphObj[N, E] = object
    properties: set[GraphProperty]
    maxId: int
    elements: IntSet


type
  GraphError = ref object of CatchableError

  GraphCyclesError = ref object of GraphError



func newGraph*[N, E](
    properties: set[GraphProperty] = {gpDirected, gpAllowSelfLoops}
  ): Graph[N, E] =

  Graph[N, E](properties: properties)

template testProperty*[N, E](edge: Edge[N, E], property: EdgeProperty): bool =
  # when not defined(release):
  #   if len({gpDirected, gpUndirected} * edge.properties) != 1:
  #     raise newException(
  #       GraphError, "Edge must only countain single direction property")

  property in edge.properties

func value*[N, E](node: Node[N, E]): N {.inline.} = node.nodeValue

func value*[N, E](edge: Edge[N, E]): E {.inline.} = edge.edgeValue

func `value=`*[N, E](node: var Node[N, E], value: N) {.inline.} =
  node.nodeValue = value

func `value=`*[N, E](edge: var Node[N, E], value: E) {.inline.} =
  edge.edgeValue = value

proc addNode*[N, E](graph: var Graph[N, E], value: N): Node[N, E] =
  result = Node[N, E](id: graph.maxId, nodeValue: value)
  graph.elements.incl result.id
  inc graph.maxId

proc addEdge*[N, E](
    graph: var Graph[N, E],
    source, target: Node[N, E], value: E): Edge[N, E] =

    result = Edge[N, E](id: graph.maxId, edgeValue: value)
    graph.elements.incl result.id
    inc graph.maxId

proc removeNode*[N, E](graph: var Graph[N, E], node: Node[N, E]) =
  ## Remove `node` from graph.
  ##
  ## Note that related edges will be removed too, if they completely loose
  ## all related nodes. So calling `removeNode("a -> b", "b")` will not
  ## only remove node `"b"`, but also an edge.
  discard

proc removeEdge*[N, E](graph: var Graph[N, E], edge: Edge[N, E]) =
  ## Remove `edge` from graph. Note that starting/ending nodes will not be
  ## removed.
  discard

proc contains*[N, E](graph: Graph[N, E], node: Node[N, E]): bool =
  ## Check if graph contains `node`
  discard

proc contains*[N, E](graph: Graph[N, E], edge: Edge[N, E]): bool =
  ## Check if graph contains `edge`
  discard

proc adjacent*[N, E](graph: Graph[N, E], node1, node2: Node[N, E]): bool =
  ## Tests whether there is an edge from the vertex x to the vertex y;
  discard

iterator outgoing*[N, E](graph: Graph[N, E], node: Node[N, E]): Edge[N, E] =
  ## Iterate over outgoing edges for `node`
  discard

iterator ingoing*[N, E](graph: Graph[N, E], node: Node[N, E]): Edge[N, E] =
  ## Iterate over ingoing edges for `node`
  discard

iterator neighbours*[N, E](graph: Graph[N, E], node: Node[N, E]): Node[E, E] =
  ## Iterate over neighbour nodes for `node`
  discard

template depthFirstAux(): untyped {.dirty.} =
  discard

iterator depthFirst*[N, E](graph: Graph[N, E], node: Node[N, E]): Node[N, E] =
  ## Perform depth-first iteration of **immutable** nodes in graph,
  ## starting from `node`
  depthFirstAux()

iterator mDepthFirst*[N, E](graph: var Graph[N, E], node: Node[N, E]): Node[N, E] =
  ## Perform depth-first iteration of **mutable** nodes in graph, starting
  ## from `node`
  depthFirstAux()

iterator breadthFirst*[N, E](graph: Graph[N, E], node: Node[N, E]): Node[N, E] =
  ## Perform breadth-first iteration of parent graph, starting from `node`
  discard

proc topologicalOrdering*[N, E](graph: Graph[N, E]): seq[Node[N, E]] =
  ## Return graph nodes in topological ordering if possible. Otherwise (if
  ## graph contains cycles raise `GraphCyclesError`)
  discard


when isMainModule:
  var graph = newGraph[string, int]()

  let node1 = graph.addNode("test1")
  let node2 = graph.addNode("test2")
  let edge = graph.addEdge(node1, node2, 190)

  for node in graph.mDepthFirst(node1):
    echo node.value

  for node in graph.topologicalOrdering():
    echo node.value

