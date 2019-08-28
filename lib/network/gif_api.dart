import 'package:flash_memory/constants.dart';
import 'package:flash_memory/secrets.dart';
import 'package:giphy_client/giphy_client.dart';

import '../domain/gif_card.dart';
import '../helpers.dart';

gifCardsFromCollection(GiphyCollection collection) {
  return _gifCardsFromUrls(_urlsOfGifsInCollection(collection));
}

List<String> _urlsOfGifsInCollection(GiphyCollection collection) {
  return collection.data.map((gif) => gif.images.fixedWidth.url).toList();
}

List<GifCard> _gifCardsFromUrls(List<String> urls) {
  List<String> urlPairs = duplicateElements(urls);
  List<GifCard> cards = urlPairs.map((u) => GifCard(u)).toList();
  cards.shuffle();
  return cards;
}

Future<List<GifCard>> get(String query, [int offset = 0]) {
  return GiphyClient(apiKey: GIPHY_API_KEY)
      .search(query, limit: NUMBER_OF_GIFS_TO_FETCH, offset: offset)
      .then((collection) {
    if (collection.data.length != NUMBER_OF_GIFS_TO_FETCH) {
      throw new GiphyClientError(404, "Could not fetch gifs.");
    }
    return gifCardsFromCollection(collection);
  });
}
