enum CardState { HIDDEN, REVEALED }

class GifCard {
  final String gifUrl;
  CardState state = CardState.HIDDEN;

  GifCard(this.gifUrl);

  get isHidden => state == CardState.HIDDEN;

  get isRevealed => state == CardState.REVEALED;

  void reveal() {
    state = CardState.REVEALED;
  }

  void hide() {
    state = CardState.HIDDEN;
  }

  bool operator ==(other) {
    return other is GifCard && hashCode == other.hashCode;
  }

  int get hashCode => gifUrl.hashCode;
}
