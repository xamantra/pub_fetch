import 'index.dart';

bool _listHasItems<T>(List<T> list) {
  return list != null && list.isNotEmpty;
}

/// This is used for internal testing but feel free to use this
/// in your own testing code.
bool validHomepage(PubHomepage homepage) {
  var hasFlutterFavorites = _listHasItems(homepage.flutterFavorites);
  var hasMostPopular = _listHasItems(homepage.mostPopularPackages);
  var hasTopFlutter = _listHasItems(homepage.topFlutterPackages);
  var hasTopDart = _listHasItems(homepage.topDartPackages);
  return hasFlutterFavorites && hasMostPopular && hasTopFlutter && hasTopDart;
}

/// This is used for internal testing but feel free to use this
/// in your own testing code.
bool validHomepagePackage(PubPackage package) {
  var notNull = package != null;
  var hasName = package.name != null && package.name.isNotEmpty;
  var hasDesc = package.description != null && package.description.isNotEmpty;
  var hasVerifiedValue = package.verified != null;
  return notNull && hasName && hasDesc && hasVerifiedValue;
}
