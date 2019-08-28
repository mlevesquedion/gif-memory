import 'package:flash_memory/domain/gif_card.dart';
import "package:test/test.dart";

void main() {
  GifCard card;
  GifCard revealedCard;

  setUp(() {
    String url = "http://www.image.com/cat.gif";
    card = new GifCard(url);
    revealedCard = new GifCard(url);
    revealedCard.reveal();
  });

  test("Cards are hidden at first", () {
    expect(card.isHidden, equals(true));
  });

  test("A revealed card is not hidden", () {
    card.reveal();
    expect(card.isHidden, equals(false));
  });

  test("A hidden card is not revealed", () {
    card.hide();
    expect(card.isRevealed, equals(false));
  });

  test("Revealing a card makes it revealed", () {
    card.reveal();
    expect(card.isRevealed, equals(true));
  });

  test("Hiding a card makes it hidden", () {
    revealedCard.hide();
    expect(revealedCard.isHidden, equals(true));
  });
}
