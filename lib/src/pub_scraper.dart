import 'package:universal_html/html.dart';

import 'index.dart';

/// Parse html document into *List* of `PubPackage` from a selector.
List<PubPackage> getHomepagePackages(
  HtmlDocument html,
  String sectionSelector,
) {
  var flutterFavoriteItems = html.querySelectorAll(sectionSelector);
  var flutterFavorites = <PubPackage>[];
  for (var item in flutterFavoriteItems) {
    var name = item.querySelector(miniNameSelector)?.text;
    var url = item.querySelector(miniNameSelector)?.getAttribute('href');
    var description = item.querySelector(miniDescSelector)?.text;
    var publisher = item.querySelector(miniPubSelector)?.text;
    flutterFavorites.add(
      PubPackage(
        name: name,
        url: '$host$url',
        description: description,
        publisher: publisher,
      ),
    );
  }
  return flutterFavorites;
}
