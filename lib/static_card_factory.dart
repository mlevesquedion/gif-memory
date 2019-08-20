import 'package:gif_memory/card_factory.dart';

import 'card.dart';

class StaticImageCardFactory implements CardFactory {
  StaticImageCardFactory(this._dimension);

  final int _dimension;

  List<List<Card>> createCards() {
    List<Card> singles = createSingles();
    List<Card> pairs = createPairs(singles);
    pairs.shuffle();
    return arrangeIntoSquare(pairs);
  }

  List<Card> createSingles() {
    int singlesToGenerate = (_dimension * _dimension) ~/ 2;
    return List.generate(singlesToGenerate, (index) => Card(index.toString()));
  }

  List<Card> createPairs(List<Card> cards) {
    return cards.map((card) => card.clone()).followedBy(cards).toList();
  }

  List<List<Card>> arrangeIntoSquare(List<Card> cards) {
    List<List<Card>> square = List.generate(_dimension, (_) => new List());
    for (int i = 0; i < cards.length; i++) {
      square[i ~/ _dimension].add(cards[i]);
    }
    return square;
  }
}
