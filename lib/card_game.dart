import 'package:gif_memory/card.dart';
import 'package:gif_memory/card_factory.dart';

class CardGame {
  int secondsBeforeHiding;

  List<List<Card>> _cards;
  List<Card> _pendingCards = new List();

  CardGame(CardFactory factory) {
    _cards = factory.createCards();
  }

  List<Card> get cards {
    List<Card> cards = new List();
    for (int i = 0; i < _cards.length; i++) {
      List<Card> row = _cards[i];
      cards.addAll(row);
    }
    return cards;
  }

  get _dimension => _cards.length;

  get pendingCardCount => _pendingCards.length;

  void revealAt(int index) {
    if (_pendingCards.length >= 2) {
      return;
    }
    Card cardToReveal = _getCardAt(index);
    if (cardToReveal.isRevealed()) {
      return;
    }
    revealCard(cardToReveal);
  }

  void revealCard(Card card) {
    card.reveal();
    _pendingCards.add(card);
  }

  isRevealedAt(index) => _getCardAt(index).isRevealed();

  _getCardAt(index) {
    int row = index ~/ _dimension;
    int column = index % _dimension;
    return _cards[row][column];
  }

  faceAt(int index) {
    return _getCardAt(index).face;
  }

  void clearPending() {
    _pendingCards.clear();
  }

  bool shouldClearPending() {
    return _pendingCards.length == 2;
  }

  bool shouldHideCards() {
    return shouldClearPending() && _pendingCards[0] != _pendingCards[1];
  }

  hideAndClearPending() {
    _pendingCards.forEach((card) => card.hide());
    clearPending();
  }

  bool isOver() {
    return cards.every((card) => card.isRevealed());
  }

  void reset() {}

  void loadNewGifs() {}
}
