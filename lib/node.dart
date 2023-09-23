/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:gwd/color.dart';

class Node<N> {
  final N n;

  Color color = Color.white;
  Node? predecessor;

  // BSF
  int distance = 0;

  // DSF
  int discovered = 0;
  int finished = 0;

  Node(this.n);

  @override
  int get hashCode {
    return n.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is Node<N> && other.n == n);
  }

  @override
  String toString() {
    return 'Node $n';
  }

  void reset() {
    color = Color.white;

    // BSF
    distance = 0;

    // DSF
    discovered = 0;
    finished = 0;
  }
}
