class SquareBitMatrix {
  SquareBitMatrix(this._dimension);

  int _matrix = 0;
  int _setCount = 0;
  final int _dimension;

  int get setCount => _setCount;

  bool isSet(int index) {
    return (_matrix & (1 << index)) != 0;
  }

  set(int index) {
    _matrix |= (1 << index);
    _setCount += 1;
  }

  int size() {
    return _dimension * _dimension;
  }

  void flip(int index) {
    _matrix ^= (1 << index);
    _setCount += 1;
  }
}
