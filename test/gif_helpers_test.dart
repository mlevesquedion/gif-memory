import 'package:flash_memory/domain/gif_card.dart';
import 'package:flash_memory/network/gif_api.dart';
import 'package:giphy_client/giphy_client.dart';
import "package:test/test.dart";

import 'test_helpers.dart';

const int collectionSize = 3;
final List<String> urlsFromIndexes = ["0", "1", "2"];

final GiphyCollection collection =
    GiphyCollection(data: List.generate(collectionSize, _createGif));

GiphyGif _createGif(int urlIndex) {
  return GiphyGif(
      images:
          GiphyImages(fixedWidth: GiphyFullImage(url: urlIndex.toString())));
}

void main() {
  test("creates a list of cards from a GiphyCollection", () {
    List<GifCard> cards = gifCardsFromCollection(collection);
    expect(eachElementAppearsTwice(cards), equals(true));
  });

  // Assuming that the cards *are* shuffled, this test has roughly a 1% chance
  // of failing spuriously
  test("created cards are shuffled", () {
    List<GifCard> firstCards = gifCardsFromCollection(collection);
    List<GifCard> secondCards = gifCardsFromCollection(collection);
    expect(firstCards, isNot(equals(secondCards)));
  });
}
