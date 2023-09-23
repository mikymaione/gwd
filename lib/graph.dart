/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'dart:collection';

import 'package:gwd/color.dart';
import 'package:gwd/node.dart';

class Graph<N> {
  final String name;
  final _vertices = <Node<N>>{};
  final _adjacent = <Node<N>, Set<Node<N>>>{};

  var _time = 0;

  Graph(this.name);

  void reset() {
    for (final v in _vertices) {
      v.reset();
    }
  }

  Node<N>? _getNodeByValue(N i) {
    for (final v in _vertices) {
      if (v.n == i) {
        return v;
      }
    }

    return null;
  }

  Node<N> _getNodeByValueOrCreate(N i) {
    return _getNodeByValue(i) ?? addVertexByValue(i);
  }

  Node<N> addVertexByValue(N i) {
    return _addVertex(Node<N>(i));
  }

  Node<N> _addVertex(Node<N> x) {
    _vertices.add(x);
    return x;
  }

  void addEdge(N from, N to) {
    final f = _getNodeByValueOrCreate(from);
    final t = _getNodeByValueOrCreate(to);

    final adjacent = _adjacent[f];

    if (adjacent == null) {
      _adjacent[f] = {t};
    } else {
      adjacent.add(t);
    }

    if (!_adjacent.containsKey(t)) {
      _adjacent[t] = {};
    }
  }

  void printGraph() {
    print('Graph $name:');

    for (final v in _vertices) {
      print('${v.n} | d: ${v.discovered} | f: ${v.finished}');
    }
  }

  int dfs() {
    reset();

    for (final v in _vertices) {
      if (v.color == Color.white) {
        _dfsVisit(v);
      }
    }

    return _time;
  }

  void _dfsVisit(Node<N> u) {
    _time++;
    u.discovered = _time;
    u.color = Color.gray;

    final adjacent = _adjacent[u];

    if (adjacent == null) {
      throw Exception('No adjacent vertex for $u');
    } else {
      for (final v in adjacent) {
        if (v.color == Color.white) {
          v.predecessor = u;
          _dfsVisit(v);
        }
      }
    }

    _time++;
    u.finished = _time;
    u.color = Color.black;
  }

  void bfs(N s) {
    reset();

    final n = _getNodeByValue(s);

    if (n == null) {
      throw Exception('Node $s not found');
    } else {
      _bfs(n);
    }
  }

  void _bfs(Node<N> s) {
    final q = Queue<Node<N>>();
    q.add(s);

    s.color == Color.gray;
    s.distance = 0;

    while (q.isNotEmpty) {
      final v = q.removeFirst();

      final adjacent = _adjacent[v];

      if (adjacent == null) {
        throw Exception('No adjacent vertex for $v');
      } else {
        for (final w in adjacent) {
          if (w.color == Color.white) {
            w.color = Color.gray;
            w.distance = v.distance + 1;
            w.predecessor = v;

            q.add(w);
          }
        }
      }

      v.color = Color.black;
    }
  }
}
