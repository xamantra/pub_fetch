import 'index.dart';

bool _listHasItems<T>(List<T> list) {
  return list != null && list.isNotEmpty;
}

bool _allTrue(List<bool> values) {
  return values.where((x) => x == false).isEmpty;
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
bool validHomepagePackage(PubHomepagePackage package) {
  var notNull = package != null;
  var hasName = package.name != null && package.name.isNotEmpty;
  var hasDesc = package.description != null && package.description.isNotEmpty;
  var validUrl = Uri.parse(package.url).isAbsolute;
  var hasVerifiedValue = package.verified != null;
  return notNull && hasName && hasDesc && hasVerifiedValue && validUrl;
}

/// This is used for internal testing but feel free to use this
/// in your own testing code.
bool validPackageList(PubPackageList packageList) {
  var isOnPage = packageList.currentPage != null;
  var hasTotalPackagesCount = packageList.totalPackagesCount != null;
  var hasTotalPageCount = packageList.totalPageCount >= 0;
  var hasItem = packageList.packages != null && packageList.packages.isNotEmpty;
  return isOnPage && hasTotalPackagesCount && hasTotalPageCount && hasItem;
}

/// This is used for internal testing but feel free to use this
/// in your own testing code.
bool validPackage(PubPackage pkg) {
  var hasName = pkg.name != null && pkg.name.isNotEmpty;
  var hasUrl = pkg.url != null && pkg.url.isNotEmpty;
  var validUrl = Uri.parse(pkg.url).isAbsolute;
  var hasDescription = pkg.description != null && pkg.description.isNotEmpty;
  var hasVersion = pkg.version != null && pkg.version.isNotEmpty;
  var hasPublished = pkg.published != null && pkg.published.isNotEmpty;
  var likesNotNull = pkg.likes != null && pkg.likes >= 0;
  var pubPointsNotNull = pkg.pubPoints != null && pkg.pubPoints >= 0;
  var popularityNotNull = pkg.popularity != null && pkg.popularity >= 0;
  var isFlutterFavoriteNull = pkg.isFlutterFavorite != null;
  var pubTagsHasItem = pkg.pubTags != null && pkg.pubTags.isNotEmpty;
  return _allTrue([
    hasName,
    hasUrl,
    validUrl,
    hasDescription,
    hasVersion,
    hasPublished,
    likesNotNull,
    pubPointsNotNull,
    popularityNotNull,
    isFlutterFavoriteNull,
    pubTagsHasItem,
  ]);
}
