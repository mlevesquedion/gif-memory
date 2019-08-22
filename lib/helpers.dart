import 'dart:math';

isPerfectSquare(int n) {
  int squareRoot = sqrt(n).round();
  return squareRoot * squareRoot == n;
}

List<List<T>> arrangeIntoSquare<T>(List<T> elements) {
  _assertCanBecomeSquare(elements);
  int dimension = sqrt(elements.length).round();
  List<List<T>> square = List.generate(dimension, (_) => new List());
  for (int i = 0; i < elements.length; i++) {
    int row = i ~/ dimension;
    square[row].add(elements[i]);
  }
  return square;
}

void _assertCanBecomeSquare(List elements) {
  if (!isPerfectSquare(elements.length)) {
    throw ArgumentError("${elements.length} is not a square");
  }
}

// If used on objects, duplicates will have same reference
List<T> duplicateElements<T>(List<T> elements) {
  return elements.expand((e) => [e, e]).toList();
}
