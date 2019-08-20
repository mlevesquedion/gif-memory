import 'package:gif_memory/square_bit_matrix.dart';
import "package:test/test.dart";

const int DIMENSION = 10;

void main() {
  test("Starts with no bits set", () {
    final SquareBitMatrix matrix = SquareBitMatrix(DIMENSION);
    expect(matrix.setCount, equals(0));
  });
  test("Returns false when bit is not set", () {
    final SquareBitMatrix matrix = SquareBitMatrix(DIMENSION);
    expect(matrix.isSet(0), equals(false));
  });
  test("Set bit", () {
    final SquareBitMatrix matrix = SquareBitMatrix(DIMENSION);
    int index = 5;
    matrix.set(index);
    expect(matrix.isSet(index), equals(true));
  });
  test("Set count increase by one when bit is set", () {
    final SquareBitMatrix matrix = SquareBitMatrix(DIMENSION);
    matrix.set(1);
    expect(matrix.setCount, equals(1));
  });
  test("Size is dimension squared", () {
    int dimension = 5;
    int expectedSize = 25;
    final SquareBitMatrix matrix = SquareBitMatrix(dimension);
    expect(matrix.size(), equals(expectedSize));
  });
  test("Flipping an unset bit sets it", () {
    final SquareBitMatrix matrix = SquareBitMatrix(DIMENSION);
    int index = 22;
    matrix.flip(index);
    expect(matrix.isSet(index), equals(true));
  });
  test("Flipping a set bit unsets it", () {
    final SquareBitMatrix matrix = SquareBitMatrix(DIMENSION);
    int index = 22;
    matrix.set(index);
    matrix.flip(index);
    expect(matrix.isSet(index), equals(false));
  });
  test("Flipping is its own inverse", () {
    final SquareBitMatrix matrix = SquareBitMatrix(DIMENSION);
    int index = 22;
    matrix.flip(index);
    matrix.flip(index);
    expect(matrix.isSet(index), equals(false));
  });
  test("Flipping a bit does not change other bits", () {
    final SquareBitMatrix matrix = SquareBitMatrix(4);
    int index = 2;
    matrix.flip(index);
    expect(matrix.isSet(0), equals(false));
  });
}
