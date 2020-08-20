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

  Future<PubPackageList> _browse(
    String searchQuery, {
    int page,
    PackageType packageType,
    List<FlutterPlatform> platforms,
    List<DartRuntime> dartRuntimes,
    PackageSort sortBy,
  }) async {
    _initService();
    var html = await _service.browsePackages(
      query: searchQuery,
      page: page ?? 1,
      packageType: packageType,
      flutterPlatforms: platforms,
      dartRuntimes: dartRuntimes,
      sortBy: sortBy,
    );
    var packages = getPackages(html, pkgItem);
    var totalPackagesCount = getPackagesCount(html, packageListingTotalItems);
    var result = PubPackageList(
      searchQuery: searchQuery,
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
    var result = await _browse(
      currentPackageList.searchQuery,
      page: page,
      packageType: params.packageType,
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
    var result = await _browse(query, sortBy: sortBy);
    return result;
  }

  Future<PubPackageList> browseFlutterPackages({
    String search,
    List<FlutterPlatform> platforms,
    PackageSort sortBy,
  }) async {
    var result = await _browse(
      search,
      packageType: PackageType.flutter,
      platforms: platforms,
      sortBy: sortBy,
    );
    return result;
  }

  Future<PubPackageList> browseDartPackages({
    String search,
    List<DartRuntime> dartRuntimes,
    PackageSort sortBy,
  }) async {
    var result = await _browse(
      search,
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

  Future<PubPackageList> flutterFavorites({
    String search,
    int page = 1,
    PackageSort sortBy = PackageSort.relevance,
  }) async {
    _initService();
    var html = await _service.flutterFavorites(
      query: search,
      page: page ?? 1,
      sortBy: sortBy,
    );
    var packages = getPackages(html, pkgItem);
    var totalPackagesCount = getPackagesCount(html, packageListingTotalItems);
    return PubPackageList(
      searchQuery: search,
      currentPage: page ?? 1,
      totalPackagesCount: totalPackagesCount,
      packages: packages,
      params: PubPackageListParams(
        packageType: null,
        platforms: [],
        dartRuntimes: [],
        sortBy: sortBy,
      ),
    );
  }
}
