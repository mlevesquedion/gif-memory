import 'package:flash_memory/helpers.dart';
import "package:test/test.dart";

import 'test_helpers.dart';

void main() {
  group("countElements", () {
    test("given an empty list, returns an empty map", () {
      expect(countElements([]), equals({}));
    });

    test("given a list, returns a map of counts of its elements", () {
      List<int> elements = [1, 2, 2, 3, 2, 3];
      Map<int, int> expectedCounts = {1: 1, 2: 3, 3: 2};
      expect(countElements(elements), equals(expectedCounts));
    });
  });

  group("containsTwoOfEachElement", () {
    test("an empty list contains two of each element", () {
      expect(eachElementAppearsTwice([]), equals(true));
    });
    test("a list of duplicates contains two of each element", () {
      expect(
          eachElementAppearsTwice(duplicateElements([1, 2, 3])), equals(true));
    });
    test("a list of unique elements does not contain two of each element", () {
      expect(eachElementAppearsTwice([1, 2, 3]), equals(false));
    });
  });
}
