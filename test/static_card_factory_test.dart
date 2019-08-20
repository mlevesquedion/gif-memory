import 'package:gif_memory/card.dart';
import 'package:gif_memory/static_card_factory.dart';
import "package:test/test.dart";

void main() {
  test("Creates dimension^2  cards", () {
    int dimension = 6;
    StaticImageCardFactory factory = new StaticImageCardFactory(dimension);
    expect(
        factory.createCards().map((row) => row.length).reduce((a, b) => a + b),
        equals(dimension * dimension));
  });

  test("Creates dimension^2 / 2 unique cards", () {
    int dimension = 4;
    StaticImageCardFactory factory = new StaticImageCardFactory(dimension);
    Set<Card> uniqueCards = flattenIntoSet(factory.createCards());
    expect(uniqueCards.length, equals(dimension * dimension ~/ 2));
  });

  test(
      "Throws an error when dimension is odd (square must be even to make pairs)",
      () {
    int invalidDimension = 3;
    expect(() => new StaticImageCardFactory(invalidDimension), throwsException);
  });
}

Set<Card> flattenIntoSet(List<List<Card>> cards) {
  Set<Card> uniqueCards = new Set();
  cards.forEach((row) => uniqueCards.addAll(row));
  return uniqueCards;
}
