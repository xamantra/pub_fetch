import 'package:universal_html/html.dart';

import 'index.dart';

/// Parse html document into *List* of `PubHomepagePackage` from a selector.
List<PubHomepagePackage> getHomepagePackages(
  HtmlDocument html,
  String selector,
) {
  var flutterFavoriteItems = html.querySelectorAll(selector);
  var flutterFavorites = <PubHomepagePackage>[];
  for (var item in flutterFavoriteItems) {
    var name = item.querySelector(miniNameSelector)?.text;
    var url = item.querySelector(miniNameSelector)?.getAttribute('href');
    var description = item.querySelector(miniDescSelector)?.text;
    var publisher = item.querySelector(miniPubSelector)?.text;
    flutterFavorites.add(
      PubHomepagePackage(
        name: name,
        url: '$host$url',
        description: description,
        publisher: publisher,
      ),
    );
  }
  return flutterFavorites;
}

/// Total total count in search or in package listing.
int getPackagesCount(HtmlDocument html, String selector) {
  var count = html.querySelector(selector).text;
  return int.parse(count);
}

/// Parse html document into *List* of `PubPackage` from a selector.
List<PubPackage> getPackages(
  HtmlDocument html,
  String selector,
) {
  var packages = html.querySelectorAll(selector);
  var results = <PubPackage>[];
  for (var item in packages) {
    var name = item.querySelector(pkgTitle)?.text;
    var url = item.querySelector(pkgTitle)?.getAttribute('href');
    var description = item.querySelector(pkgDescription)?.text;
    var publisher = item.querySelector(pkgPublisher)?.text;
    var version = item.querySelector(pkgVersion)?.text;
    var published = item.querySelector(pkgPublished)?.text;
    var likes = int.parse(item.querySelector(pkgLikes)?.text);
    var pubPoints = int.parse(item.querySelector(pkgPoints)?.text);
    var popularity = int.parse(item.querySelector(pkgPopularity)?.text);
    var isFlutterFavorite = item.querySelector(pkgFlutterFavorite) != null;
    var tags = item.querySelectorAll(pkgTags);
    var pubTags = <String>[];
    for (var tag in tags) {
      pubTags.add(tag.text.toUpperCase());
    }
    results.add(PubPackage(
      name: name,
      url: '$host$url',
      description: description,
      publisher: publisher,
      version: version,
      published: published,
      likes: likes,
      pubPoints: pubPoints,
      popularity: popularity,
      isFlutterFavorite: isFlutterFavorite,
      pubTags: pubTags,
    ));
  }
  return results;
}
