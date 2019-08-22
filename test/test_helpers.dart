Map<T, int> countElements<T>(List<T> elements) {
  Map<T, int> counts = {};
  elements.forEach((e) {
    counts.putIfAbsent(e, () => 0);
    counts[e]++;
  });
  return counts;
}

bool eachElementAppearsTwice<T>(List<T> elements) {
  return countElements(elements).values.toSet().every((e) => e == 2);
}
