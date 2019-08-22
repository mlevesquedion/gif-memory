import 'package:gif_memory/domain/gif_card.dart';

class GifCardCollection {
  int secondsBeforeHiding;

  List<GifCard> _cards;
  List<GifCard> _pendingCards = new List();

  GifCardCollection(this._cards);

  List<GifCard> get cards => _cards;

  get pendingCardCount => _pendingCards.length;

  void revealAt(int index) {
    if (_pendingCards.length >= 2) {
      return;
    }
    GifCard cardToReveal = _getCardAt(index);
    if (cardToReveal.isRevealed) {
      return;
    }
    revealCard(cardToReveal);
  }

  void revealCard(GifCard card) {
    card.reveal();
    _pendingCards.add(card);
  }

  isRevealedAt(index) => _getCardAt(index).isRevealed;

  _getCardAt(index) {
    return _cards[index];
  }

  faceAt(int index) {
    return _getCardAt(index).gifUrl;
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
    return cards.every((card) => card.isRevealed);
  }

  void reset() {
    cards.forEach((c) => c.hide());
  }
}
