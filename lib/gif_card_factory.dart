import 'package:gif_memory/card_factory.dart';

import 'card.dart';

class StaticImageCardFactory implements CardFactory {
  StaticImageCardFactory(this._dimension) {
    if (_dimension % 2 != 0) {
      throw new Exception(
          "Invalid dimension: $_dimension. Dimension must be an even number.");
    }
  }

  final int _dimension;

  List<List<Card>> createCards() {
    List<Card> singles = _createSingles();
    List<Card> pairs = _doubleEveryElement(singles);
    pairs.shuffle();
    return _arrangeIntoSquare(pairs);
  }

  List<Card> _createSingles() {
    int singlesToGenerate = (_dimension * _dimension) ~/ 2;
    return List.generate(singlesToGenerate, (index) => Card(index.toString()));
  }

  List<Card> _doubleEveryElement(List<Card> cards) {
    return cards.map((card) => card.clone()).followedBy(cards).toList();
  }

  List<List<Card>> _arrangeIntoSquare(List<Card> cards) {
    List<List<Card>> square = List.generate(_dimension, (_) => new List());
    for (int i = 0; i < cards.length; i++) {
      square[i ~/ _dimension].add(cards[i]);
    }
    return square;
  }
}
