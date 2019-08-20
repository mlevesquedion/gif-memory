import "package:gif_memory/card.dart";
import "package:test/test.dart";

const String AN_IMAGE = "An image of a cat";

void main() {
  Card newCard;
  Card revealedCard;

  setUp(() {
    newCard = new Card(AN_IMAGE);
    revealedCard = new Card(AN_IMAGE);
    revealedCard.reveal();
  });

  test("Cards start hidden", () {
    Card card = new Card(AN_IMAGE);
    expect(card.isHidden(), equals(true));
  });

  test("Revealing a card makes it no longer hidden", () {
    newCard.reveal();
    expect(newCard.isHidden(), equals(false));
  });

  test("Revealing a card makes it revealed", () {
    newCard.reveal();
    expect(newCard.isRevealed(), equals(true));
  });

  test("Hiding a card makes it hidden", () {
    revealedCard.hide();
    expect(revealedCard.isHidden(), equals(true));
  });
}
