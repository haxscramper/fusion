## Generic implementation of graph data structure

import std/[intsets]

type
  Node[N, E] = ref NodeObj[N, E]
  NodeObj[N, E] = object
    id: int
    value*: N


  EdgeProperty = enum
    epOutgoing
    epIngoing

  Edge[N, E] = ref EdgeObj[N, E]
  EdgeObj[N, E] = object
    properties: set[EdgeProperty]
    id: int
    value*: E

  GraphProperty = enum
    gpDirected
    gpUndirected
    gpAllowSelfLoops

  Graph[N, E] = ref Graph[N, E]

  GraphObj[N, E] = object
    maxId: int
    elements: IntSet


type
  GraphError = ref object of CatchableError

  GraphCyclesError = ref object of GraphError


template testProperty*[N, E](edge: Edge[N, E], property: EdgeProperty): bool =
  # when not defined(release):
  #   if len({gpDirected, gpUndirected} * edge.properties) != 1:
  #     raise newException(
  #       GraphError, "Edge must only countain single direction property")



  property in edge.properties

proc addNode*[N, E](graph: var Graph[N, E], value: N): Node[N, E] =
  result = Node[N, E](id: graph.maxId, value: value)
  graph.members.incl result.id
  inc graph.maxId

proc addEdge*[N, E](
    graph: var Graph[N, E], fromNode, toNode: Node[N, E], value: E): Edge[N, E] =

    result = Node[N, E](id: graph.maxId, value: value)
    graph.members.incl result.id
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

iterator dfs*[N, E](graph: Graph[N, E], node: Node[N, E]): Node[N, E] =
  ## Perform depth-first iteration of parent graph, starting from `node`
  discard

iterator bfs*[N, E](graph: Graph[N, E], node: Node[N, E]): Node[N, E] =
  ## Perform breadth-first iteration of parent graph, starting from `node`
  discard

proc topologicalOrdering*[N, E](graph: Graph[N, E]): seq[Node[N, E]] =
  ## Return graph nodes in topological ordering if possible. Otherwise (if
  ## graph contains cycles raise `GraphCyclesError`)
  discard


when isMainModule:
  discard
