import 'index.dart';

/// The wrapper for pub.dev scraper methods.
class PubAPI extends PubAPIDocs {
  /// The wrapper for pub.dev scraper methods.
  PubAPI({
    this.connectTimeout,
    this.receiveTimeout,
    this.sendTimeout,
  });

  final int connectTimeout;
  final int receiveTimeout;
  final int sendTimeout;

  PubHttp _service;

  void _initService() {
    if (_service != null) return;
    _service = PubHttp(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );
  }

  Future<PubHomepage> homepage() async {
    _initService();
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

  Future<PubPackageList> _search(
    String query, {
    int page,
    PackageType packageType,
    List<FlutterPlatform> platforms,
    List<DartRuntime> dartRuntimes,
    PackageSort sortBy,
  }) async {
    _initService();
    var html = await _service.searchPackage(
      query: query,
      page: page ?? 1,
      packageType: packageType,
      flutterPlatforms: platforms,
      dartRuntimes: dartRuntimes,
      sortBy: sortBy,
    );
    var packages = getPackages(html, pkgItem);
    var totalPackagesCount = getPackagesCount(html, packageListingTotalItems);
    var result = PubPackageList(
      searchQuery: query,
      currentPage: page ?? 1,
      totalPackagesCount: totalPackagesCount,
      packages: packages,
      params: PubPackageListParams(
        packageType: packageType,
        platforms: platforms ?? [],
        dartRuntimes: dartRuntimes ?? [],
        sortBy: sortBy,
      ),
    );
    return result;
  }

  Future<PubPackageList> _jumpToPage(
    PubPackageList currentPackageList,
    int page,
  ) async {
    var params = currentPackageList.params;
    var result = await _search(
      currentPackageList.searchQuery,
      page: page,
      packageType: PackageType.dart,
      dartRuntimes: params.dartRuntimes,
      platforms: params.platforms,
      sortBy: params.sortBy,
    );
    return result;
  }

  Future<PubPackageList> search(
    String query, {
    PackageSort sortBy,
  }) async {
    var result = await _search(query, sortBy: sortBy);
    return result;
  }

  Future<PubPackageList> searchFlutter(
    String query, {
    List<FlutterPlatform> platforms,
    PackageSort sortBy,
  }) async {
    var result = await _search(
      query,
      packageType: PackageType.flutter,
      platforms: platforms,
      sortBy: sortBy,
    );
    return result;
  }

  Future<PubPackageList> searchDart(
    String query, {
    List<DartRuntime> dartRuntimes,
    PackageSort sortBy,
  }) async {
    var result = await _search(
      query,
      packageType: PackageType.dart,
      dartRuntimes: dartRuntimes,
      sortBy: sortBy,
    );
    return result;
  }

  Future<PubPackageList> nextPage(PubPackageList current) async {
    var result = await _jumpToPage(current, current.getNextPageNumber());
    return result;
  }

  Future<PubPackageList> prevPage(PubPackageList current) async {
    var result = await _jumpToPage(current, current.getPrevPageNumber());
    return result;
  }
}
