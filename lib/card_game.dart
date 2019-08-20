import 'package:gif_memory/card.dart';
import 'package:gif_memory/card_factory.dart';

class CardGame {
  List<Card> _pendingCards = new List();

  List<List<Card>> _cards;

  List<Card> get cards {
    List<Card> cards = new List();
    for (int i = 0; i < _cards.length; i++) {
      List<Card> row = _cards[i];
      cards.addAll(row);
    }
    return cards;
  }

  CardGame(CardFactory factory) {
    _cards = factory.createCards();
  }

  get _dimension => _cards.length;

  get pendingCardCount => _pendingCards.length;

  void revealAt(int index) {
    Card cardToReveal = _getCardAt(index);
    if (cardToReveal.isRevealed()) {
      return;
    }
    revealCard(cardToReveal);
    updatePendingCards();
  }

  void updatePendingCards() {
    if (_pendingCards.length < 2) {
      return;
    }
    if (_pendingCards[0] != _pendingCards[1]) {
      _pendingCards[0].hide();
      _pendingCards[1].hide();
    }
    _pendingCards.clear();
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
}
