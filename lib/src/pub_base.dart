import 'index.dart';

final _service = PubHttp();

/// Get `pub.dev` homepage data. The homepage features popular packages.
Future<PubHomepage> homepage() async {
  var html = await _service.getHtml();
  var flutterFavorites = getHomepagePackages(html, flutterFavoritesSelector);
  var mostPopularPackages = getHomepagePackages(html, mostPopularSelector);
  var topFlutterPackages = getHomepagePackages(html, topFlutterSelector);
  var topDartPackages = getHomepagePackages(html, topDartSelector);
  return PubHomepage(
    flutterFavorites: flutterFavorites,
    mostPopularPackages: mostPopularPackages,
    topFlutterPackages: topFlutterPackages,
    topDartPackages: topDartPackages,
  );
}
