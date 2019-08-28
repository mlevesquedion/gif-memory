import 'package:flash_memory/domain/gif_card.dart';

class GifCardCollection {
  List<GifCard> _cards;
  List<GifCard> _pendingCards = new List();

  GifCardCollection(this._cards);

  List<GifCard> get cards => _cards;

  isRevealedAt(index) => _getCardAt(index).isRevealed;

  void revealAt(int index) {
    GifCard cardToReveal = _getCardAt(index);
    _revealCard(cardToReveal);
  }

  faceAt(int index) {
    return _getCardAt(index).gifUrl;
  }

  bool get shouldHidePendingCards =>
      _hasTwoPendingCards() && _pendingCards[0] != _pendingCards[1];

  hidePendingCards() {
    _pendingCards.forEach((card) => card.hide());
    _pendingCards.clear();
  }

  bool isOver() {
    return cards.every((card) => card.isRevealed);
  }

  void reset() {
    cards.forEach((c) => c.hide());
  }

  void _revealCard(GifCard card) {
    if (_hasTwoPendingCards() || card.isRevealed) {
      return;
    }
    card.reveal();
    _pendingCards.add(card);
    if (_pendingCardsAreEqual()) {
      _pendingCards.clear();
    }
  }

  _getCardAt(index) {
    return _cards[index];
  }

  bool _hasTwoPendingCards() => _pendingCards.length == 2;

  bool _pendingCardsAreEqual() {
    return _hasTwoPendingCards() && _pendingCards[0] == _pendingCards[1];
  }

  void revealAll() {
    cards.forEach((c) => c.reveal());
  }

  void hideAll() {
    cards.forEach((c) => c.hide());
  }
}
