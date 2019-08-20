import 'package:gif_memory/card.dart';
import 'package:gif_memory/card_factory.dart';
import 'package:gif_memory/card_game.dart';
import "package:test/test.dart";

void main() {
  int dimension = 4;
  int index = 1;
  int differentIndex = index + 1;
  Card card = new Card("An image");
  CardGame cardGame;
  CardGame cardGameWithAllDistinctCards;

  setUp(() {
    CardFactory cardFactory = new SameCardFactory(dimension, card);
    cardGame = new CardGame(cardFactory);
    CardFactory distinctCardFactory = new DistinctCardFactory(dimension);
    cardGameWithAllDistinctCards = new CardGame(distinctCardFactory);
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

class SameCardFactory implements CardFactory {
  SameCardFactory(this.dimension, this.card);

  final int dimension;
  final Card card;

  List<List<Card>> createCards() {
    List<List<Card>> rows = new List();
    for (int i = 0; i < dimension; i++) {
      List<Card> row = new List();
      for (int i = 0; i < dimension; i++) {
        row.add(card.clone());
      }
      rows.add(row);
    }
    return rows;
  }
}

class DistinctCardFactory implements CardFactory {
  DistinctCardFactory(this.dimension);

  final int dimension;

  List<List<Card>> createCards() {
    List<List<Card>> rows = new List();
    for (int i = 0; i < dimension; i++) {
      List<Card> row = new List();
      for (int j = 0; j < dimension; j++) {
        row.add(new Card(i.toString() + j.toString()));
      }
      rows.add(row);
    }
    return rows;
  }
}
