import 'package:gif_memory/domain/gif_card.dart';
import 'package:gif_memory/domain/gif_card_collection.dart';
import "package:test/test.dart";

void main() {
  int dimension = 4;
  int index = 1;
  int differentIndex = index + 1;
  GifCard card = new GifCard("An image");
  GifCardCollection cardGame;
  GifCardCollection cardGameWithAllDistinctCards;

  setUp(() {
    CardFactory cardFactory = new SameCardFactory(dimension, card);
    cardGame = new GifCardCollection(cardFactory);
    CardFactory distinctCardFactory = new DistinctCardFactory(dimension);
    cardGameWithAllDistinctCards = new GifCardCollection(distinctCardFactory);
  });

  test("Game starts with no pending cards", () {
    expect(cardGame.pendingCardCount, equals(0));
  });

  test("Revealing a card bumps count of pending cards to one", () {
    cardGame.revealAt(index);
    expect(cardGame.pendingCardCount, equals(1));
  });

  test("When two equal cards are revealed simultaneously, they stay revealed",
      () {
    cardGame.revealAt(index);
    cardGame.revealAt(differentIndex);
    expect(cardGame.isRevealedAt(index), equals(true));
    expect(cardGame.isRevealedAt(differentIndex), equals(true));
  });

  test("When two unequal cards are revealed simultaneously, they are hidden",
      () {
    cardGameWithAllDistinctCards.revealAt(index);
    cardGameWithAllDistinctCards.revealAt(differentIndex);
    expect(cardGameWithAllDistinctCards.isRevealedAt(index), equals(false));
    expect(cardGameWithAllDistinctCards.isRevealedAt(differentIndex),
        equals(false));
  });
}
