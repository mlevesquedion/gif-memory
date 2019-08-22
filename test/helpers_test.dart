import 'package:gif_memory/domain/gif_card.dart';
import "package:gif_memory/helpers.dart";
import "package:test/test.dart";

import 'test_helpers.dart';

void main() {
  group("isPerfectSquare", () {
    test("2 is not a perfect square", () {
      expect(isPerfectSquare(2), equals(false));
    });

    test("16 is a perfect square", () {
      expect(isPerfectSquare(16), equals(true));
    });
  });

  group("arrangeIntoSquare", () {
    test("throws error if elements cannot be made into a square", () {
      List<int> invalidList = [1, 2, 3];
      expect(() => arrangeIntoSquare(invalidList), throwsArgumentError);
    });
    test("transforms a list into a square matrix", () {
      List<int> validList = [1, 2, 3, 4];
      List<List<int>> expected = [
        [1, 2],
        [3, 4]
      ];
      expect(arrangeIntoSquare(validList), equals(expected));
    });
  });

  group("duplicateElements", () {
    test("given an empty list, returns an empty list", () {
      List<int> empty = [];
      expect(duplicateElements(empty), equals(empty));
    });
    test("given a list, returns a list where each element appears twice", () {
      List<int> elements = [1, 2, 3];
      Map<int, int> actualCounts = countElements(duplicateElements(elements));
      Map<int, int> expectedCounts = {1: 2, 2: 2, 3: 2};
      expect(actualCounts, equals(expectedCounts));
    });
  });
}
