enum CardState { HIDDEN, REVEALED }

class Card {
  final String face;
  CardState state = CardState.HIDDEN;

  Card(this.face);

  isHidden() => state == CardState.HIDDEN;

  isRevealed() => state == CardState.REVEALED;

  void reveal() {
    state = CardState.REVEALED;
  }

  void hide() {
    state = CardState.HIDDEN;
  }

  Card clone() {
    Card clone = new Card(face);
    if (isRevealed()) {
      clone.state = CardState.REVEALED;
    }
    return clone;
  }

  bool operator ==(other) {
    return other is Card && hashCode == other.hashCode;
  }

  int get hashCode => face.hashCode;
}
