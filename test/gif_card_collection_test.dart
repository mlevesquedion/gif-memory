import 'package:flash_memory/domain/gif_card.dart';
import 'package:flash_memory/domain/gif_card_collection.dart';
import "package:test/test.dart";

import 'test_helpers.dart';

void main() {
  GifCardCollection cardGame;
  GifCardCollection equalCardsGame;
  GifCardCollection differentCardsGame;

  setUp(() {
    List<GifCard> pairedCards =
        generateIndexedCards(8) + generateIndexedCards(8);
    List<GifCard> allEqualCards = List.generate(10, (_) => GifCard("equal"));
    List<GifCard> allDifferentCards = generateIndexedCards(10);
    cardGame = new GifCardCollection(pairedCards);
    equalCardsGame = new GifCardCollection(allEqualCards);
    differentCardsGame = new GifCardCollection(allDifferentCards);
  });

  test("Before revealing a card, it is hidden", () {
    expect(cardGame.isRevealedAt(0), equals(false));
  });

  test("After revealing a card, it is revealed", () {
    cardGame.revealAt(0);
    expect(cardGame.isRevealedAt(0), equals(true));
  });

  test("When two unequal cards are pending, they should be hidden", () {
    differentCardsGame.revealAt(0);
    differentCardsGame.revealAt(1);
    expect(differentCardsGame.shouldHidePendingCards, equals(true));
  });

  test("Hiding pending cards makes them hidden", () {
    differentCardsGame.revealAt(0);
    differentCardsGame.hidePendingCards();
    expect(differentCardsGame.isRevealedAt(0), equals(false));
  });

  test(
      "When two equal cards are revealed, should be able to reveal a third card",
      () {
    equalCardsGame.revealAt(0);
    equalCardsGame.revealAt(1);
    equalCardsGame.revealAt(2);
    expect(equalCardsGame.isRevealedAt(2), equals(true));
  });

  test(
      "When two unequal cards are pending, should not be able to reveal a third card",
      () {
    differentCardsGame.revealAt(0);
    differentCardsGame.revealAt(1);
    differentCardsGame.revealAt(2);
    expect(differentCardsGame.isRevealedAt(2), equals(false));
  });
}
